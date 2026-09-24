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
 * Read the page's sessionStorage.
 *
 * Playwright's `storageState()` captures cookies + localStorage ONLY —
 * sessionStorage is never included. SPAs that park their auth state there
 * (DIGIT Studio keeps 9 keys, including `Digit.initData` and `Digit.User`)
 * therefore look logged out the moment that state is replayed into a fresh
 * context. Capturing it here is what makes `contextStrategy: 'reuse'` work
 * for those sites.
 *
 * @param {import('playwright').Page} page
 * @returns {Promise<Record<string,string>>} empty if unreadable
 */
export async function captureSessionStorage(page) {
  try {
    return await page.evaluate(() => {
      const out = {};
      for (let i = 0; i < sessionStorage.length; i++) {
        const k = sessionStorage.key(i);
        out[k] = sessionStorage.getItem(k);
      }
      return out;
    });
  } catch {
    // Non-same-origin, page closed, or storage blocked — never fail auth over it.
    return {};
  }
}

/**
 * Replay sessionStorage into a context, for every page and every navigation.
 *
 * Must be an init script rather than a one-off `evaluate`: sessionStorage is
 * per-origin-per-tab and is wiped on cross-document navigation, so the values
 * have to be re-seeded before the app's own scripts run on each load.
 *
 * Note this re-seeds the captured values on every navigation, so an app that
 * rewrites these keys mid-session will see them reset. That is the right
 * trade-off for a scanner (it keeps the session alive across a crawl) but it
 * is not general-purpose session emulation.
 *
 * @param {import('playwright').BrowserContext} context
 * @param {Record<string,string>} [entries]
 */
export async function applySessionStorage(context, entries) {
  if (!entries || Object.keys(entries).length === 0) return;

  await context.addInitScript((json) => {
    try {
      for (const [k, v] of Object.entries(JSON.parse(json))) {
        sessionStorage.setItem(k, v);
      }
    } catch {
      // about:blank and opaque origins have no usable sessionStorage.
    }
  }, JSON.stringify(entries));
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
