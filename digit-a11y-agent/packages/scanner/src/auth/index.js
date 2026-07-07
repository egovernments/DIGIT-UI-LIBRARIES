/**
 * Authentication dispatcher.
 *
 * Single entry point for authenticated scans. Routes to the right handler
 * based on `authConfig.type`:
 *
 *   type: 'form'  → ./form.js   (Day 3 — fully implemented)
 *   type: 'token' → ./token.js  (Day 4 — fully implemented)
 *   type: 'oauth' → ./oauth.js  (Phase 3 / Day 16)
 *
 * Returns a Playwright `storageState` — cookies + localStorage + sessionStorage
 * that subsequent page contexts can re-hydrate to appear logged in.
 *
 * @see ./form.js
 * @see ./token.js
 */

import { captureFormAuth }  from './form.js';
import { captureTokenAuth } from './token.js';

/**
 * @typedef {Object} AuthConfig
 * @property {'form'|'token'|'oauth'} type
 * @property {string} loginUrl - URL to load (form: the login page; token: any URL on the target origin)
 * @property {Record<string,string>} [fields]         - form auth: selector → value
 * @property {string}   [submitSelector]               - form auth
 * @property {string[]} [dismissSelectors]             - form auth: pre-login popups/banners to dismiss
 * @property {string}   [successSelector]              - both: CSS selector visible only when authed
 * @property {string}   [successUrl]                   - both: URL substring after auth
 * @property {string}   [token]                        - token auth: the JWT/Bearer/API key value
 * @property {string}   [tokenStorageKey]              - token auth: localStorage key to write to
 * @property {Array<{name:string, value:string, domain?:string, url?:string, path?:string, expires?:number}>} [cookies]
 * @property {'reuse'|'single'} [contextStrategy='reuse'] - 'reuse': capture state, re-inject into a fresh context for scanning (default, fast for multi-page). 'single': keep auth and scan in one context (needed for sites that bind sessions to browser fingerprint, e.g. DIGIT Studio UAT).                                                      both: cookies to inject into the context
 * @property {Object}   [timeouts]                     - per-step millisecond timeouts (see DEFAULT_TIMEOUTS in each handler)
 */

/**
 * Capture authentication state. Caller passes the captured state back into
 * `createContext({ storageState })` when scanning the protected target.
 *
 * @param {import('playwright').Browser} browser
 * @param {AuthConfig} authConfig
 * @returns {Promise<import('playwright').BrowserContextOptions['storageState']>}
 *
 * @throws AuthError with codes:
 *   - INVALID_AUTH_CONFIG
 *   - AUTH_PAGE_UNREACHABLE
 *   - AUTH_FIELD_NOT_FOUND        (form)
 *   - AUTH_SUBMIT_FAILED           (form)
 *   - AUTH_SUCCESS_TIMEOUT         (form, or token with verification)
 *   - AUTH_TOKEN_INJECTION_FAILED  (token)
 *   - AUTH_COOKIE_INJECTION_FAILED (token)
 *   - AUTH_TOKEN_VERIFY_FAILED     (token)
 *   - NOT_IMPLEMENTED              (oauth, until Phase 3)
 */
export async function captureAuth(browser, authConfig) {
  validateAuthConfig(authConfig);

  switch (authConfig.type) {
    case 'form':
      return captureFormAuth(browser, authConfig);

    case 'token':
      return captureTokenAuth(browser, authConfig);

    case 'oauth':
      throw new AuthError('NOT_IMPLEMENTED',
        'OAuth flows (DigiLocker, Parichay) ship in Phase 3 (Day 16).');

    default:
      throw new AuthError('INVALID_AUTH_CONFIG',
        `Unknown auth type: ${authConfig.type}. ` +
        `Supported: 'form', 'token'. Coming in Phase 3: 'oauth'.`);
  }
}

/**
 * @param {AuthConfig} cfg
 */
function validateAuthConfig(cfg) {
  if (!cfg || typeof cfg !== 'object') {
    throw new AuthError('INVALID_AUTH_CONFIG', 'authConfig must be an object');
  }
  if (!cfg.type) {
    throw new AuthError('INVALID_AUTH_CONFIG', 'authConfig.type is required');
  }
  if (!cfg.loginUrl || typeof cfg.loginUrl !== 'string') {
    throw new AuthError('INVALID_AUTH_CONFIG',
      'authConfig.loginUrl must be a non-empty string');
  }

  if (cfg.type === 'form') {
    if (!cfg.fields || Object.keys(cfg.fields).length === 0) {
      throw new AuthError('INVALID_AUTH_CONFIG',
        'Form auth requires authConfig.fields (selector → value).');
    }
    if (!cfg.submitSelector) {
      throw new AuthError('INVALID_AUTH_CONFIG',
        'Form auth requires authConfig.submitSelector.');
    }
    if (!cfg.successSelector && !cfg.successUrl) {
      throw new AuthError('INVALID_AUTH_CONFIG',
        'Form auth requires either authConfig.successSelector or authConfig.successUrl.');
    }
    if (cfg.dismissSelectors && !Array.isArray(cfg.dismissSelectors)) {
      throw new AuthError('INVALID_AUTH_CONFIG',
        'authConfig.dismissSelectors must be an array of CSS selectors.');
    }
  }

  // Token-specific fields validated inside token.js (more nuanced — needs
  // either localStorage OR cookies, not necessarily both).
}

/**
 * Run auth in an existing browser context (single-context strategy).
 * Used by runScan() when `auth.contextStrategy === 'single'`.
 *
 * Unlike captureAuth(), this doesn't open or close any context — it works
 * inside the caller's existing page so the scan runs against the same
 * authenticated session, with the same browser fingerprint. Required for
 * sites that bind sessions to context (DIGIT Studio UAT).
 *
 * @param {import('playwright').Page} page
 * @param {import('playwright').BrowserContext} context
 * @param {AuthConfig} authConfig
 * @returns {Promise<void>}
 */
export async function runAuthInContext(page, context, authConfig) {
  validateAuthConfig(authConfig);

  switch (authConfig.type) {
    case 'form': {
      const { runFormAuthInPage } = await import('./form.js');
      return runFormAuthInPage(page, authConfig);
    }
    case 'token': {
      const { runTokenAuthInPage } = await import('./token.js');
      return runTokenAuthInPage(page, context, authConfig);
    }
    case 'oauth':
      throw new AuthError('NOT_IMPLEMENTED',
        'OAuth flows ship in Phase 3 (Day 16).');
    default:
      throw new AuthError('INVALID_AUTH_CONFIG',
        `Unknown auth type: ${authConfig.type}`);
  }
}

/**
 * Auth-specific error class.
 */
export class AuthError extends Error {
  constructor(code, message) {
    super(message);
    this.name = 'AuthError';
    this.code = code;
  }
}
