/**
 * Event-driven wait strategy.
 *
 * Replaces the original tool's blunt `setTimeout(5000)` with a fall-through
 * chain of signals. Most modern govt portals are React/Angular SPAs that take
 * varying amounts of time to load; a fixed timer either waits too long (slow
 * scans) or too short (incomplete results). This module gives axe-core the
 * best chance of running against a fully-rendered DOM.
 *
 * Strategy:
 *   1. If `waitForSelector` is provided, wait for it. Most reliable for SPAs
 *      where the developer can tell us "wait until this element appears".
 *      Day-7 fix: this is now a HARD requirement — if the selector never
 *      appears, we throw `PAGE_NOT_READY` instead of warning and continuing.
 *      The silent-warn behaviour was masking the case where a protected page
 *      redirected back to its login screen (axe scanned the wrong page and
 *      reported a misleadingly perfect score).
 *   2. Otherwise, wait for `networkidle` (≤2 in-flight requests for 500ms)
 *      AND opportunistically watch for common SPA-ready signals. These
 *      remain non-throwing (best-effort).
 *   3. Always add a minimum paint buffer (500ms) for above-the-fold rendering.
 *
 * Total budget: 30s. Beyond that, return with a non-fatal warning rather than
 * throwing — the scan continues with whatever DOM exists, and the report flags
 * "page may not be fully loaded" so the user knows results could be partial.
 *
 * @see ./index.js
 */

/**
 * @typedef {Object} WaitOptions
 * @property {string} [waitForSelector] - CSS selector to wait for (hard requirement when set)
 * @property {number} [networkIdleTimeoutMs=10000] - How long to wait for networkidle
 * @property {number} [spaSignalTimeoutMs=5000] - How long to opportunistically watch SPA signals
 * @property {number} [overallTimeoutMs=30000] - Hard cap; beyond this we warn and return
 * @property {number} [paintBufferMs=500] - Final delay for above-the-fold rendering
 */

/**
 * @typedef {Object} WaitResult
 * @property {number} elapsedMs - Total time spent waiting
 * @property {string} strategy - Which strategy actually completed ('selector' | 'networkidle' | 'spa-signal' | 'timeout' | 'error')
 * @property {Warning[]} warnings - Non-fatal concerns (empty array if everything was clean)
 */

/**
 * @typedef {Object} Warning
 * @property {string} code
 * @property {string} message
 */

const DEFAULTS = {
  waitForSelector:        undefined,
  networkIdleTimeoutMs:   10_000,
  spaSignalTimeoutMs:     5_000,
  overallTimeoutMs:       30_000,
  paintBufferMs:          500,
};

/**
 * Wait for a page to be ready for accessibility scanning.
 *
 * Behaviour:
 *   - When `waitForSelector` is set: the selector MUST become visible within
 *     `overallTimeoutMs`. If it doesn't, this throws `WaitError('PAGE_NOT_READY')`.
 *     This is the only way the function throws.
 *   - When no selector is provided: networkidle / SPA signals race; timeouts
 *     become non-fatal warnings.
 *
 * @param {import('playwright').Page} page
 * @param {WaitOptions} [options]
 * @returns {Promise<WaitResult>}
 * @throws WaitError('PAGE_NOT_READY') when a required waitForSelector is missing.
 */
export async function waitForReady(page, options = {}) {
  const opts = { ...DEFAULTS, ...options };
  const startedAt = Date.now();
  const warnings = [];
  let strategy = 'unknown';

  if (opts.waitForSelector) {
    // STRICT path — user-provided ready signal is a hard gate.
    // If the selector never appears, throw so the caller can fail loudly
    // rather than silently scanning whatever DOM happens to be present.
    try {
      await page.waitForSelector(opts.waitForSelector, {
        timeout: opts.overallTimeoutMs,
        state:   'visible',
      });
      strategy = 'selector';
    } catch (err) {
      throw new WaitError(
        'PAGE_NOT_READY',
        `Required selector "${opts.waitForSelector}" did not appear within ` +
        `${opts.overallTimeoutMs}ms. The page either took too long to load, ` +
        `or it never reached the expected state (e.g. an authenticated route ` +
        `redirected back to login). Scan aborted to avoid reporting a result ` +
        `against the wrong page.`,
      );
    }

    // Paint buffer still applies after a successful selector match.
    await page.waitForTimeout(opts.paintBufferMs);

  } else {
    // LENIENT path — race networkidle + SPA signals; first one wins.
    // Timeouts here are non-fatal: warn and continue.
    try {
      const networkIdlePromise = page
        .waitForLoadState('networkidle', { timeout: opts.networkIdleTimeoutMs })
        .then(() => 'networkidle');

      const spaSignalPromise = waitForSpaReadySignal(page, opts.spaSignalTimeoutMs)
        .then(() => 'spa-signal');

      try {
        strategy = await Promise.race([networkIdlePromise, spaSignalPromise]);
      } catch {
        warnings.push({
          code:    'network-not-idle',
          message: `Page did not reach a quiet state within ${opts.networkIdleTimeoutMs}ms. Scan continues but results may include in-flight content.`,
        });
        strategy = 'timeout';
      }

      // Swallow any pending rejections from the loser of the race.
      networkIdlePromise.catch(() => {});
      spaSignalPromise.catch(() => {});

      await page.waitForTimeout(opts.paintBufferMs);

    } catch (err) {
      // Catch any unexpected failure (page closed, navigation away, etc.)
      warnings.push({
        code:    'page-may-not-be-fully-loaded',
        message: `Wait failed: ${err.message}. Scan continues against current DOM state.`,
      });
      strategy = 'error';
    }
  }

  return {
    elapsedMs: Date.now() - startedAt,
    strategy,
    warnings,
  };
}

/**
 * Watch for common SPA "I'm ready" signals. Returns when any one appears, or
 * rejects after timeout if none do.
 *
 * Conventions checked (any one of these means the page is ready):
 *   - `document.body.dataset.ready === 'true'`
 *   - `document.body.classList.contains('loaded')`
 *   - presence of any element with `[data-ready="true"]`
 *
 * @param {import('playwright').Page} page
 * @param {number} timeoutMs
 * @returns {Promise<void>}
 */
async function waitForSpaReadySignal(page, timeoutMs) {
  await page.waitForFunction(
    () => {
      const body = document.body;
      if (!body) return false;
      if (body.dataset && body.dataset.ready === 'true') return true;
      if (body.classList && body.classList.contains('loaded')) return true;
      if (document.querySelector('[data-ready="true"]')) return true;
      return false;
    },
    { timeout: timeoutMs },
  );
}

/**
 * Failure class for the strict-selector case. Distinct from generic Error so
 * callers (e.g. runScan) can recognise it and surface the diagnostic message
 * to the user verbatim.
 */
export class WaitError extends Error {
  constructor(code, message) {
    super(message);
    this.name = 'WaitError';
    this.code = code;
  }
}

/**
 * Exposed for tests so we can verify defaults haven't drifted.
 */
export const _defaults = { ...DEFAULTS };
