/**
 * Shared helpers used by both form-auth and token-auth flows.
 *
 * Internal module — not re-exported from `auth/index.js`. Filename starts with
 * underscore by convention to signal "implementation detail."
 *
 * @see ./form.js
 * @see ./token.js
 */

/**
 * Wait for a post-login success indicator. Two flavours supported:
 *   - `successSelector` — CSS selector that only appears once logged in
 *                         (most reliable for SPAs)
 *   - `successUrl`      — substring the final URL must contain
 *                         (works for sites that redirect after login)
 *
 * If both are supplied, we race them — whichever fires first wins.
 *
 * @param {import('playwright').Page} page
 * @param {import('./index.js').AuthConfig} cfg
 * @param {number} timeoutMs
 * @returns {Promise<'selector'|'url'>}
 */
export async function waitForSuccessIndicator(page, cfg, timeoutMs) {
  const waiters = [];

  if (cfg.successSelector) {
    waiters.push(
      page.waitForSelector(cfg.successSelector, {
        state:   'visible',
        timeout: timeoutMs,
      }).then(() => 'selector'),
    );
  }

  if (cfg.successUrl) {
    waiters.push(
      page.waitForURL(
        (url) => url.toString().includes(cfg.successUrl),
        { timeout: timeoutMs },
      ).then(() => 'url'),
    );
  }

  if (waiters.length === 0) {
    throw new Error('No success indicator configured (need successSelector or successUrl)');
  }

  return Promise.race(waiters);
}

/**
 * Best-effort dismissal of pre-login popups (cookie banners, announcement
 * modals, "what's new" overlays). Each selector is clicked if present and
 * ignored if not — never fails the auth flow on a missing dismiss target.
 *
 * Typical real-world use:
 *   dismissSelectors: [
 *     '.cookie-banner button.accept',
 *     '#announcement-modal .close-btn',
 *     'button[aria-label="Close"]',
 *   ]
 *
 * @param {import('playwright').Page} page
 * @param {string[]} [selectors]
 * @param {number} [timeoutMs=2000] per-selector wait. SPA login forms (e.g.
 *   DIGIT workbench-ui) mount a required consent checkbox a beat AFTER the page
 *   is otherwise "ready"; if we give up too early the checkbox never gets ticked
 *   and the (disabled) submit button then fails. Callers that dismiss such
 *   gating elements should pass a more forgiving value (see form.js).
 * @returns {Promise<{dismissed: string[], skipped: string[]}>}
 */
export async function dismissPrelogin(page, selectors, timeoutMs = 2_000) {
  const dismissed = [];
  const skipped   = [];

  for (const sel of selectors ?? []) {
    try {
      await page.click(sel, { timeout: timeoutMs });
      dismissed.push(sel);
      // Brief pause for the dismissal animation to settle before next action.
      await page.waitForTimeout(200);
    } catch {
      skipped.push(sel);
    }
  }

  return { dismissed, skipped };
}
