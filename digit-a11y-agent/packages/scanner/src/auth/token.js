/**
 * Token-based authentication.
 *
 * For sites that use JWT tokens / API keys / session tokens already obtained
 * out-of-band. Common pattern with modern govt SPAs that authenticate via a
 * separate identity service (DigiLocker, Parichay, Aadhaar-OTP) and store
 * the resulting token in localStorage or a cookie.
 *
 * Flow:
 *   1. Open a fresh browser context
 *   2. Navigate to any page on the target origin (so we have a same-origin
 *      context where storage writes work)
 *   3. Inject the token into localStorage at the configured key
 *   4. (Optional) Inject cookies for sites that use HttpOnly session cookies
 *   5. (Optional) Verify by reloading and looking for a success indicator
 *   6. Capture the resulting storageState — caller re-hydrates for the scan
 *
 * Why a separate browser context for token auth, since there's no form to fill?
 *   Same reason as form auth: produces a clean storageState that's reusable
 *   across many scans of the same site without re-injecting each time.
 *
 * @see ./index.js
 * @see ./form.js — the form-fill alternative
 */

import { createContext, closeContext } from '../browser.js';
import { AuthError } from './index.js';
import { waitForSuccessIndicator } from './_shared.js';

const DEFAULT_TIMEOUTS = {
  navigation: 30_000,
  verification: 30_000,
};

/**
 * Capture token-based auth state.
 *
 * @param {import('playwright').Browser} browser
 * @param {import('./index.js').AuthConfig} authConfig
 * @returns {Promise<import('playwright').BrowserContextOptions['storageState']>}
 */
export async function captureTokenAuth(browser, authConfig) {
  validateTokenConfig(authConfig);

  const context = await createContext(browser);
  const page = await context.newPage();

  try {
    // ── 1. Land on the target origin so storage APIs work ────────────────
    try {
      await page.goto(authConfig.loginUrl, {
        waitUntil: 'domcontentloaded',
        timeout: authConfig.timeouts?.navigation ?? DEFAULT_TIMEOUTS.navigation,
      });
    } catch (err) {
      throw new AuthError('AUTH_PAGE_UNREACHABLE',
        `Could not load ${authConfig.loginUrl}: ${err.message}`);
    }

    // ── 2. Inject token into localStorage ─────────────────────────────────
    // Day 4.1 — support multiple localStorage entries (DIGIT needs ~8 keys, not 1).
    // Accepts either:
    //   - authConfig.localStorage: { key1: val1, key2: val2, ... }  ← new, preferred
    //   - authConfig.token + tokenStorageKey                        ← backward compat
    const entries = {
      ...(authConfig.localStorage ?? {}),
    };
    if (authConfig.token && authConfig.tokenStorageKey) {
      entries[authConfig.tokenStorageKey] = authConfig.token;
    }
    if (Object.keys(entries).length > 0) {
      try {
        await page.evaluate((kv) => {
          for (const [k, v] of Object.entries(kv)) localStorage.setItem(k, v);
        }, entries);
      } catch (err) {
        throw new AuthError('AUTH_TOKEN_INJECTION_FAILED',
          `Could not write to localStorage on ${authConfig.loginUrl}: ${err.message}`);
      }
    }

    // ── 3. Inject cookies (optional — for HttpOnly session cookies) ──────
    if (authConfig.cookies?.length) {
      try {
        await context.addCookies(authConfig.cookies);
      } catch (err) {
        throw new AuthError('AUTH_COOKIE_INJECTION_FAILED',
          `Could not set cookies: ${err.message}`);
      }
    }

    // ── 4. Optional verification step ─────────────────────────────────────
    // If caller supplied a success indicator, reload and confirm the token
    // actually unlocks the protected area. Otherwise we just trust the
    // injection succeeded.
    if (authConfig.successSelector || authConfig.successUrl) {
      try {
        await page.reload({
          waitUntil: 'domcontentloaded',
          timeout: authConfig.timeouts?.verification ?? DEFAULT_TIMEOUTS.verification,
        });
        await waitForSuccessIndicator(page, authConfig, DEFAULT_TIMEOUTS.verification);
      } catch (err) {
        if (err instanceof AuthError) throw err;
        throw new AuthError('AUTH_TOKEN_VERIFY_FAILED',
          `Token was injected but verification failed: ${err.message}. ` +
          `The token may be expired, malformed, or stored under the wrong key.`);
      }
    }

    // ── 5. Capture state ──────────────────────────────────────────────────
    return await context.storageState();

  } finally {
    await closeContext(context);
  }
}

/**
 * Validate that a token auth config has the required fields.
 * @param {import('./index.js').AuthConfig} cfg
 */
function validateTokenConfig(cfg) {
  const hasToken = cfg.token && cfg.tokenStorageKey;
  const hasLocalStore = cfg.localStorage && Object.keys(cfg.localStorage).length > 0;
  const hasCookies = cfg.cookies && cfg.cookies.length > 0;

  if (!hasToken && !hasLocalStore && !hasCookies) {
    throw new AuthError('INVALID_AUTH_CONFIG',
      'Token auth requires either (token + tokenStorageKey) for localStorage, ' +
      'or cookies[] for cookie-based session tokens, or both.');
  }

  if (cfg.token && !cfg.tokenStorageKey) {
    throw new AuthError('INVALID_AUTH_CONFIG',
      'authConfig.tokenStorageKey is required when authConfig.token is provided.');
  }

  if (cfg.cookies) {
    for (const c of cfg.cookies) {
      if (!c.name || !c.value) {
        throw new AuthError('INVALID_AUTH_CONFIG',
          'Each cookie must have a name and value.');
      }
      const hasUrl = Boolean(c.url);
      const hasDomainAndPath = Boolean(c.domain && c.path);
      if (!hasUrl && !hasDomainAndPath) {
        throw new AuthError('INVALID_AUTH_CONFIG',
          'Each cookie must have either url, or both domain and path. ' +
          'Passing both url and path is also rejected by Playwright.');
      }
    }
  }
}

/**
 * Run token injection against an EXISTING page. Single-context equivalent
 * of captureTokenAuth — injects token + cookies, optionally verifies.
 */
export async function runTokenAuthInPage(page, context, authConfig) {
  validateTokenConfig(authConfig);

  try {
    await page.goto(authConfig.loginUrl, {
      waitUntil: 'domcontentloaded',
      timeout:   authConfig.timeouts?.navigation ?? 30_000,
    });
  } catch (err) {
    throw new AuthError('AUTH_PAGE_UNREACHABLE',
      `Could not load ${authConfig.loginUrl}: ${err.message}`);
  }

  const entries = { ...(authConfig.localStorage ?? {}) };
  if (authConfig.token && authConfig.tokenStorageKey) {
    entries[authConfig.tokenStorageKey] = authConfig.token;
  }
  if (Object.keys(entries).length > 0) {
    try {
      await page.evaluate((kv) => {
        for (const [k, v] of Object.entries(kv)) localStorage.setItem(k, v);
      }, entries);
    } catch (err) {
      throw new AuthError('AUTH_TOKEN_INJECTION_FAILED',
        `Could not write to localStorage: ${err.message}`);
    }
  }

  if (authConfig.cookies?.length) {
    try {
      await context.addCookies(authConfig.cookies);
    } catch (err) {
      throw new AuthError('AUTH_COOKIE_INJECTION_FAILED',
        `Could not set cookies: ${err.message}`);
    }
  }

  if (authConfig.successSelector || authConfig.successUrl) {
    try {
      await page.reload({
        waitUntil: 'domcontentloaded',
        timeout:   authConfig.timeouts?.verification ?? 30_000,
      });
      await waitForSuccessIndicator(page, authConfig,
        authConfig.timeouts?.verification ?? 30_000);
    } catch (err) {
      if (err instanceof AuthError) throw err;
      throw new AuthError('AUTH_TOKEN_VERIFY_FAILED',
        `Token was injected but verification failed: ${err.message}.`);
    }
  }
}
