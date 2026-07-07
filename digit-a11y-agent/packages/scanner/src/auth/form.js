/**
 * Form-based authentication.
 *
 * Day 3 (happy path):
 *   - Open login page, fill fields, submit, wait for success, capture state
 *
 * Day 4 additions (real-world robustness):
 *   - `dismissSelectors` config to clear cookie banners / announcement
 *     modals before attempting to fill the login form
 *   - Per-step timeouts overridable via authConfig.timeouts
 *   - Richer error messages — every failure mentions which selector was
 *     attempted and on which URL
 *   - Logs `_authMeta` on the resulting storageState so callers can see
 *     what happened (which dismiss selectors fired, total elapsed, etc.)
 *
 * @see ./_shared.js — waitForSuccessIndicator + dismissPrelogin live there
 * @see ./token.js  — the JWT-injection alternative
 */

import { createContext, closeContext } from '../browser.js';
import { waitForReady } from '../wait.js';
import { AuthError } from './index.js';
import { waitForSuccessIndicator, dismissPrelogin } from './_shared.js';

const DEFAULT_TIMEOUTS = {
  navigation:  30_000,
  fieldFill:   10_000,
  submit:      10_000,
  successWait: 30_000,
  // Per pre-login dismiss selector. Generous because DIGIT SPA login forms
  // mount consent checkboxes late; a short window silently skips a required
  // tick and leaves the submit button disabled. Overridable via timeouts.dismiss.
  dismiss:     10_000,
};

/**
 * Run a form-based login and return the captured storage state.
 *
 * @param {import('playwright').Browser} browser
 * @param {import('./index.js').AuthConfig} authConfig
 * @returns {Promise<import('playwright').BrowserContextOptions['storageState']>}
 */
export async function captureFormAuth(browser, authConfig) {
  const timeouts = { ...DEFAULT_TIMEOUTS, ...(authConfig.timeouts ?? {}) };
  const startedAt = Date.now();

  const context = await createContext(browser);
  const page    = await context.newPage();

  try {
    // ── 1. Navigate to login page ─────────────────────────────────────────
    try {
      await page.goto(authConfig.loginUrl, {
        waitUntil: 'domcontentloaded',
        timeout:   timeouts.navigation,
      });
    } catch (err) {
      throw new AuthError('AUTH_PAGE_UNREACHABLE',
        `Could not load login page ${authConfig.loginUrl}: ${err.message}`);
    }

    // Smart wait for SPA login pages that mount fields after initial load.
    await waitForReady(page);

    // ── 2. Dismiss any pre-login popups (cookie banners, modals, etc.) ───
    const dismissResult = await dismissPrelogin(page, authConfig.dismissSelectors, timeouts.dismiss);

    // ── 3. Fill each field ────────────────────────────────────────────────
    for (const [selector, value] of Object.entries(authConfig.fields)) {
      try {
        await page.fill(selector, value, { timeout: timeouts.fieldFill });
      } catch (err) {
        throw new AuthError('AUTH_FIELD_NOT_FOUND',
          `Could not fill field "${selector}" on ${authConfig.loginUrl}: ${err.message}. ` +
          `Verify the selector matches an input element. If a modal/popup is ` +
          `covering the form, add it to authConfig.dismissSelectors.`);
      }
    }

    // ── 4. Submit ─────────────────────────────────────────────────────────
    try {
      await page.click(authConfig.submitSelector, { timeout: timeouts.submit });
    } catch (err) {
      throw new AuthError('AUTH_SUBMIT_FAILED',
        `Could not click submit button "${authConfig.submitSelector}": ${err.message}. ` +
        `The button may be disabled (check if all required fields were filled) ` +
        `or hidden behind another element.`);
    }

    // ── 5. Wait for success indicator ─────────────────────────────────────
    try {
      await waitForSuccessIndicator(page, authConfig, timeouts.successWait);
    } catch (err) {
      throw new AuthError('AUTH_SUCCESS_TIMEOUT',
        `Login submitted, but success indicator did not appear within ` +
        `${timeouts.successWait}ms. Likely causes: (1) wrong credentials, ` +
        `(2) wrong success selector/URL "${authConfig.successSelector ?? authConfig.successUrl}", ` +
        `(3) MFA/captcha required, (4) the site responded with an error message ` +
        `(check the auth flow manually in a browser to see what's shown).`);
    }

    // ── 6. Capture session state, augment with diagnostic metadata ──────
    const state = await context.storageState();
    // Stash a small diagnostic block — non-standard, ignored by Playwright
    // when re-hydrating, but useful for the API server's debug logs.
    state._authMeta = {
      type:           'form',
      elapsedMs:      Date.now() - startedAt,
      dismissed:      dismissResult.dismissed,
      skipped:        dismissResult.skipped,
    };
    return state;

  } finally {
    await closeContext(context);
  }
}

/**
 * Run the form-fill auth flow against an EXISTING page. Used by single-context
 * scans where we don't capture/restore state — we just log in and stay logged in.
 *
 * @param {import('playwright').Page} page
 * @param {import('./index.js').AuthConfig} authConfig
 * @returns {Promise<void>}
 */
export async function runFormAuthInPage(page, authConfig) {
  const timeouts = { ...DEFAULT_TIMEOUTS, ...(authConfig.timeouts ?? {}) };

  try {
    await page.goto(authConfig.loginUrl, {
      waitUntil: 'domcontentloaded',
      timeout:   timeouts.navigation,
    });
  } catch (err) {
    throw new AuthError('AUTH_PAGE_UNREACHABLE',
      `Could not load login page ${authConfig.loginUrl}: ${err.message}`);
  }

  await waitForReady(page);
  await dismissPrelogin(page, authConfig.dismissSelectors, timeouts.dismiss);

  for (const [selector, value] of Object.entries(authConfig.fields)) {
    try {
      await page.fill(selector, value, { timeout: timeouts.fieldFill });
    } catch (err) {
      throw new AuthError('AUTH_FIELD_NOT_FOUND',
        `Could not fill field "${selector}" on ${authConfig.loginUrl}: ${err.message}.`);
    }
  }

  try {
    await page.click(authConfig.submitSelector, { timeout: timeouts.submit });
  } catch (err) {
    throw new AuthError('AUTH_SUBMIT_FAILED',
      `Could not click submit button "${authConfig.submitSelector}": ${err.message}.`);
  }

  try {
    await waitForSuccessIndicator(page, authConfig, timeouts.successWait);
  } catch (err) {
    throw new AuthError('AUTH_SUCCESS_TIMEOUT',
      `Login submitted, but success indicator did not appear within ${timeouts.successWait}ms.`);
  }
}

/**
 * Exposed for tests.
 */
export const _defaults = { timeouts: DEFAULT_TIMEOUTS };
