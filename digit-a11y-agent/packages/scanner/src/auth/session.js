/**
 * Saved-session authentication.
 *
 * The flow-agnostic option: a human logs in once by hand — through whatever
 * the site demands (two-step forms, OTP, SSO, captcha) — and the whole browser
 * session is snapshotted to a file. Every later scan replays that file.
 *
 * This exists because `form` auth can only drive one shape of login: one page,
 * fill every field, click once. Anything multi-step or human-gated is out of
 * reach for it, and always will be. Rather than grow a config language that
 * tries to describe every login flow in existence, we let the human do the
 * part only a human can do, once.
 *
 * Capture side: `bin/capture-session.mjs`.
 *
 * A session file is:
 *   {
 *     cookies: [...],                  // Playwright storageState
 *     origins: [{ origin, localStorage: [...] }],
 *     _sessionStorage: { key: value }, // storageState can't carry this
 *     _capturedAt: "2026-09-24T…",     // for staleness warnings
 *     _capturedFrom: "https://…"
 *   }
 *
 * SECURITY: the file holds live session credentials. Anyone with it is logged
 * in as that user, with no password and no MFA. Treat it like a password.
 *
 * @see ./index.js  — the dispatcher
 * @see ./form.js   — automated single-page login
 * @see ./token.js  — hand-assembled token/cookie injection
 */

import { readFileSync } from 'node:fs';
import { AuthError } from './index.js';
import { applySessionStorage } from './_shared.js';

/** Warn when a session file is older than this. Most tokens die well inside a day. */
const STALE_AFTER_MS = 12 * 60 * 60 * 1000;

/**
 * Load and normalise a saved session.
 *
 * @param {import('./index.js').AuthConfig} authConfig
 * @returns {import('playwright').BrowserContextOptions['storageState']}
 */
export function loadSessionState(authConfig) {
  let parsed;

  if (authConfig.state && typeof authConfig.state === 'object') {
    parsed = authConfig.state;
  } else if (authConfig.sessionPath) {
    let raw;
    try {
      raw = readFileSync(authConfig.sessionPath, 'utf8');
    } catch (err) {
      throw new AuthError('SESSION_FILE_UNREADABLE',
        `Could not read session file "${authConfig.sessionPath}": ${err.message}. ` +
        `Create one with: node packages/scanner/bin/capture-session.mjs --url <site> --out <file>`);
    }
    try {
      parsed = JSON.parse(raw);
    } catch (err) {
      throw new AuthError('SESSION_FILE_INVALID',
        `Session file "${authConfig.sessionPath}" is not valid JSON: ${err.message}`);
    }
  } else {
    throw new AuthError('INVALID_AUTH_CONFIG',
      'Session auth requires either authConfig.sessionPath or authConfig.state.');
  }

  if (!parsed || typeof parsed !== 'object') {
    throw new AuthError('SESSION_FILE_INVALID', 'Session state must be an object.');
  }

  const cookies = Array.isArray(parsed.cookies) ? parsed.cookies : [];
  const origins = Array.isArray(parsed.origins) ? parsed.origins : [];
  // Accept either key — `_sessionStorage` is what our own capture writes,
  // `sessionStorage` is the friendlier name a hand-written file would use.
  const session = parsed._sessionStorage ?? parsed.sessionStorage ?? {};

  const localCount = origins.reduce((n, o) => n + (o.localStorage?.length ?? 0), 0);
  if (cookies.length === 0 && localCount === 0 && Object.keys(session).length === 0) {
    throw new AuthError('SESSION_FILE_INVALID',
      'Session file carries no cookies, no localStorage and no sessionStorage — ' +
      'it holds nothing that could authenticate a request. Re-capture it, and ' +
      'make sure you were actually logged in before pressing ENTER.');
  }

  return {
    cookies,
    origins,
    _sessionStorage: session,
    _authMeta: {
      type:         'session',
      capturedAt:   parsed._capturedAt ?? null,
      capturedFrom: parsed._capturedFrom ?? null,
      ageMs:        sessionAgeMs(parsed._capturedAt),
      stale:        isStale(parsed._capturedAt),
      cookieCount:  cookies.length,
      localKeys:    localCount,
      sessionKeys:  Object.keys(session).length,
    },
  };
}

/** @returns {number|null} */
export function sessionAgeMs(capturedAt) {
  if (!capturedAt) return null;
  const t = Date.parse(capturedAt);
  return Number.isNaN(t) ? null : Date.now() - t;
}

/** @returns {boolean} */
export function isStale(capturedAt, staleAfterMs = STALE_AFTER_MS) {
  const age = sessionAgeMs(capturedAt);
  return age !== null && age > staleAfterMs;
}

/**
 * Capture-side entry for the dispatcher. No browser work needed — the session
 * was captured out-of-band, so this just loads and validates it. The browser
 * argument exists to match the other handlers' signature.
 *
 * @returns {Promise<import('playwright').BrowserContextOptions['storageState']>}
 */
export async function captureSessionAuth(_browser, authConfig) {
  return loadSessionState(authConfig);
}

/**
 * Single-context equivalent: replay a saved session into an existing context.
 *
 * Only needed for sites that reject a round-tripped session outright. If you
 * are reaching for this, confirm the site really is server-side bound first —
 * see PHASE1_RETROSPECTIVE.md, where that diagnosis was wrong once already.
 */
export async function runSessionAuthInPage(page, context, authConfig) {
  const state = loadSessionState(authConfig);

  if (state.cookies.length) {
    try {
      await context.addCookies(state.cookies);
    } catch (err) {
      throw new AuthError('AUTH_COOKIE_INJECTION_FAILED',
        `Could not set cookies from session: ${err.message}`);
    }
  }

  // Must be registered before the navigation that needs it.
  await applySessionStorage(context, state._sessionStorage);

  const target = authConfig.loginUrl ?? state._authMeta?.capturedFrom;
  if (!target) {
    throw new AuthError('INVALID_AUTH_CONFIG',
      'Session auth in single-context mode needs authConfig.loginUrl (any URL ' +
      'on the target origin) so localStorage can be written same-origin.');
  }

  try {
    await page.goto(target, {
      waitUntil: 'domcontentloaded',
      timeout: authConfig.timeouts?.navigation ?? 30_000,
    });
  } catch (err) {
    throw new AuthError('AUTH_PAGE_UNREACHABLE',
      `Could not load ${target}: ${err.message}`);
  }

  const localEntries = {};
  for (const origin of state.origins) {
    for (const { name, value } of origin.localStorage ?? []) localEntries[name] = value;
  }
  if (Object.keys(localEntries).length) {
    try {
      await page.evaluate((kv) => {
        for (const [k, v] of Object.entries(kv)) localStorage.setItem(k, v);
      }, localEntries);
    } catch (err) {
      throw new AuthError('AUTH_TOKEN_INJECTION_FAILED',
        `Could not write session localStorage: ${err.message}`);
    }
  }
}
