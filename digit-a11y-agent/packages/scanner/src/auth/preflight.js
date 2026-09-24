/**
 * Post-navigation authentication check.
 *
 * The worst failure this scanner can produce is not a crash — it's a clean
 * report. When a session is expired or incomplete, the SPA quietly redirects
 * to its login screen, axe audits that instead, and the run comes back
 * "authenticated" with a flattering score. Nothing errors. Nobody notices.
 *
 * So: whenever auth was requested, we check the page we actually landed on
 * before scanning it, and fail loudly if it looks like a login screen.
 *
 * Escape hatch: `auth.skipPreflight: true` — for the rare case of deliberately
 * scanning a login page while authenticated.
 *
 * @see ./index.js
 */

import { AuthError } from './index.js';

/**
 * Path segments that mean "you are not logged in". Deliberately narrow:
 * a bare /auth/ appears in plenty of legitimate authenticated routes, so
 * matching it would fail good scans.
 */
const LOGIN_PATH = /(^|\/)(login|signin|sign-in|logout|session-expired)(\/|$)/i;

/**
 * Assert the current page is an authenticated one.
 *
 * Order of preference:
 *   1. `auth.authedSelector` — an element present on any signed-in page
 *      (avatar, logout link, app sidebar). Explicit and reliable; use it.
 *   2. Otherwise a zero-config heuristic: a visible password field, or a
 *      login-shaped URL we did not ask for.
 *
 * @param {import('playwright').Page} page
 * @param {import('./index.js').AuthConfig} auth
 * @param {string} requestedUrl - the URL the scan asked for
 * @param {{timeoutMs?: number}} [opts]
 * @returns {Promise<{checked: boolean, via: string, finalUrl: string}>}
 * @throws {AuthError} SESSION_NOT_AUTHENTICATED
 */
export async function assertAuthenticated(page, auth, requestedUrl, opts = {}) {
  const finalUrl = page.url();

  if (!auth || auth.skipPreflight) {
    return { checked: false, via: 'skipped', finalUrl };
  }

  // ── 1. Explicit signal ───────────────────────────────────────────────────
  if (auth.authedSelector) {
    try {
      await page.waitForSelector(auth.authedSelector, {
        state: 'visible',
        timeout: opts.timeoutMs ?? 15_000,
      });
      return { checked: true, via: 'authedSelector', finalUrl: page.url() };
    } catch {
      throw new AuthError('SESSION_NOT_AUTHENTICATED',
        `Signed-in marker "${auth.authedSelector}" never appeared on ${page.url()}. ` +
        `The session is probably expired or incomplete — re-capture it. ` +
        `Refusing to scan, because an unauthenticated page would score as if it passed.`);
    }
  }

  // ── 2. Heuristic ─────────────────────────────────────────────────────────
  // Skipped when the scan target itself is a login page: auditing a login
  // screen on purpose is legitimate, and auth may be incidental.
  if (looksLikeLoginUrl(requestedUrl)) {
    return { checked: false, via: 'target-is-login-page', finalUrl };
  }

  const redirectedToLogin = looksLikeLoginUrl(finalUrl);

  const passwordVisible = await page
    .locator('input[type="password"]')
    .first()
    .isVisible()
    .catch(() => false);

  if (redirectedToLogin || passwordVisible) {
    const why = redirectedToLogin
      ? `it redirected to ${finalUrl}`
      : `a password field is visible on ${finalUrl}`;
    throw new AuthError('SESSION_NOT_AUTHENTICATED',
      `Scan target ${requestedUrl} is not authenticated — ${why}. ` +
      `Likely causes: the session expired, the saved session file is stale, or ` +
      `the site keeps auth state this tool did not capture. ` +
      `Refusing to scan: a login page would produce a clean, misleading report. ` +
      `If you meant to scan this page, set auth.skipPreflight = true.`);
  }

  return { checked: true, via: 'heuristic', finalUrl };
}

/**
 * @param {string} url
 * @returns {boolean}
 */
export function looksLikeLoginUrl(url) {
  try {
    return LOGIN_PATH.test(new URL(url).pathname);
  } catch {
    // Not a parseable URL — fall back to matching the raw string.
    return LOGIN_PATH.test(String(url));
  }
}
