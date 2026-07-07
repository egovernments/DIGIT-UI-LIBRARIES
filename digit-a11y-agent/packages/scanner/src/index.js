/**
 * @digit-a11y/scanner — public entry point.
 *
 * Day 1-3 capabilities still here. Day 4 additions:
 *   - Page navigation now retries on transient network failures
 *     (up to 3 attempts, exponential backoff)
 *   - Retry attempts surfaced in meta.navigationAttempts for diagnostics
 *   - AuthError instances pass through cleanly without being wrapped
 *
 * Day 7 additions:
 *   - WaitError from wait.js propagates with its code intact (no longer
 *     wrapped as SCAN_FAILED). Lets callers see PAGE_NOT_READY explicitly.
 *   - After the smart wait, we compare the final page URL against the
 *     requested URL. If they differ meaningfully (different origin or
 *     different pathname), a 'navigated-away' warning is attached so the
 *     report shows that a silent redirect happened during load. This catches
 *     the case where a protected page bounces back to its login screen
 *     and the scanner ends up auditing the wrong content.
 *
 * @see @digit-a11y/reporter
 */

import { randomUUID } from 'node:crypto';
import {
  launchBrowser,
  createContext,
  closeContext,
  closeBrowser,
} from './browser.js';
import { waitForReady, WaitError } from './wait.js';
import { runAxe } from './axe.js';
import { captureScreenshot } from './screenshot.js';
import { computeBoundingBoxes } from './bbox.js';
import { captureAuth, AuthError } from './auth/index.js';
import { retryWithBackoff, isTransientNetworkError } from './retry.js';

const DEFAULT_SCAN_OPTIONS = {
  timeoutMs: 60_000,
  captureScreenshot: true,
  computeBoundingBoxes: true,
  axeTags: undefined,
  waitForSelector: undefined,
  artifactsDir: './artifacts',
  navigationAttempts: 3,         // Day 4 addition
};

/**
 * @typedef {Object} ScanRequest
 * @property {string} url
 * @property {import('./auth/index.js').AuthConfig} [auth]
 * @property {Partial<typeof DEFAULT_SCAN_OPTIONS>} [options]
 */

/**
 * Run a single-page accessibility scan.
 *
 * @param {ScanRequest} scanRequest
 * @returns {Promise<import('./types.js').RawScanResult>}
 */
export async function runScan(scanRequest) {
  validateScanRequest(scanRequest);

  const opts = { ...DEFAULT_SCAN_OPTIONS, ...(scanRequest.options ?? {}) };
  const scanId = `scn_${randomUUID().replace(/-/g, '').slice(0, 16)}`;
  const startedAt = Date.now();
  const warnings = [];
  let navigationAttempts = 0;

  let browser = null;
  let context = null;

  try {
    browser = await launchBrowser();

    // ── 1+2. Authentication + context strategy ───────────────────────────
    // Two strategies:
    //   'reuse' (default) — auth in a throwaway context, capture state, re-inject
    //                       into a fresh scan context. Fast for multi-page crawls.
    //   'single'          — auth and scan share one context. Required for sites
    //                       that bind sessions to browser fingerprint (e.g. DIGIT
    //                       Studio UAT) where state re-injection gets rejected.
    const strategy = scanRequest.auth?.contextStrategy ?? 'reuse';
    let page;

    if (scanRequest.auth && strategy === 'single') {
      context = await createContext(browser);
      page = await context.newPage();
      const { runAuthInContext } = await import('./auth/index.js');
      await runAuthInContext(page, context, scanRequest.auth);
    } else {
      let storageState;
      if (scanRequest.auth) {
        storageState = await captureAuth(browser, scanRequest.auth);
      }
      context = await createContext(browser, { storageState });
      page = await context.newPage();
    }

    // ── 3. Navigate with retry on transient failures ─────────────────────
    try {
      await retryWithBackoff(
        async (attempt) => {
          navigationAttempts = attempt;
          await page.goto(scanRequest.url, {
            waitUntil: 'domcontentloaded',
            timeout: opts.timeoutMs,
          });
        },
        {
          maxAttempts: opts.navigationAttempts,
          baseDelayMs: 1_000,
          isTransient: isTransientNetworkError,
          onRetry: ({ attempt, delayMs, error }) => {
            warnings.push({
              code: 'navigation-retry',
              message: `Attempt ${attempt} to load ${scanRequest.url} failed ` +
                `(${error.message.split('\n')[0]}); retrying in ${delayMs}ms.`,
            });
          },
        },
      );
    } catch (err) {
      throw new ScanError('PAGE_NAVIGATION_FAILED',
        `Could not navigate to ${scanRequest.url} after ${navigationAttempts} ` +
        `attempt(s): ${err.message}`);
    }

    // ── 4. Smart wait ─────────────────────────────────────────────────────
    // When opts.waitForSelector is set, waitForReady throws WaitError if the
    // selector never appears. We let that bubble up so the caller sees a
    // PAGE_NOT_READY rather than a silent partial scan.
    const waitResult = await waitForReady(page, {
      waitForSelector: opts.waitForSelector,
    });
    warnings.push(...waitResult.warnings);

    // ── 4b. Final-URL drift check ────────────────────────────────────────
    // If the page navigated away from the requested URL during loading
    // (most commonly: a protected page bouncing back to its login), surface
    // it as a warning so the user can see what actually got scanned rather
    // than wondering why the score is suspiciously high.
    const finalUrl = page.url();
    if (urlPathDiffersMeaningfully(scanRequest.url, finalUrl)) {
      warnings.push({
        code: 'navigated-away',
        message: `Page navigated from ${scanRequest.url} to ${finalUrl} during ` +
          `loading. The report below is for the FINAL page. If this redirect ` +
          `was unexpected (e.g. an authenticated route falling back to a login ` +
          `screen), pass options.waitForSelector pointing to an element on the ` +
          `intended page — the scan will then fail loudly instead of auditing ` +
          `the wrong page.`,
      });
    }

    // ── 5. Run axe ────────────────────────────────────────────────────────
    const axeResult = await runAxe(page, { tags: opts.axeTags });

    // ── 6. Bounding boxes ─────────────────────────────────────────────────
    if (opts.computeBoundingBoxes && axeResult.violations.length > 0) {
      const bboxStats = await computeBoundingBoxes(page, axeResult.violations);
      if (bboxStats.missing > 0) {
        warnings.push({
          code: 'bounding-boxes-partial',
          message: `${bboxStats.missing} violating element(s) could not be located ` +
            `in the DOM (likely removed after axe scanned). Highlights will ` +
            `be missing for those issues in the report.`,
        });
      }
    }

    // ── 7. Screenshot ─────────────────────────────────────────────────────
    let screenshot;
    if (opts.captureScreenshot) {
      try {
        screenshot = await captureScreenshot(page, {
          scanId,
          artifactsDir: opts.artifactsDir,
        });
      } catch (err) {
        warnings.push({
          code: 'screenshot-failed',
          message: `Screenshot capture failed: ${err.message}.`,
        });
      }
    }

    return {
      violations: axeResult.violations,
      incomplete: axeResult.incomplete,
      ...(screenshot ? { screenshot } : {}),
      meta: {
        scanId,
        url: scanRequest.url,
        finalUrl,
        scannedAt: new Date(startedAt).toISOString(),
        durationMs: Date.now() - startedAt,
        axeCoreVersion: axeResult.axeCoreVersion,
        authenticated: Boolean(scanRequest.auth),
        navigationAttempts,
        warnings,
      },
    };

  } catch (err) {
    // AuthError, ScanError, WaitError pass through with their code intact.
    if (err instanceof AuthError || err instanceof ScanError || err instanceof WaitError) {
      throw err;
    }
    // Anything else gets wrapped so the API server can give a sensible response.
    throw new ScanError('SCAN_FAILED', err.message);
  } finally {
    await closeContext(context);
    await closeBrowser(browser);
  }
}

/**
 * Path-level URL comparison. Returns true if the two URLs differ by origin
 * or by pathname (trailing-slash insensitive). Query and hash are ignored
 * because plenty of SPAs add tracking params during load without it being
 * a redirect.
 *
 * @param {string} requested
 * @param {string} actual
 * @returns {boolean}
 */
function urlPathDiffersMeaningfully(requested, actual) {
  try {
    const a = new URL(requested);
    const b = new URL(actual);
    if (a.origin !== b.origin) return true;
    const pa = a.pathname.replace(/\/$/, '');
    const pb = b.pathname.replace(/\/$/, '');
    return pa !== pb;
  } catch {
    return false; // Couldn't parse; don't false-alarm.
  }
}

/**
 * @param {ScanRequest} req
 */
function validateScanRequest(req) {
  if (!req || typeof req !== 'object') {
    throw new ScanError('INVALID_REQUEST', 'scanRequest must be an object');
  }
  if (!req.url || typeof req.url !== 'string') {
    throw new ScanError('INVALID_URL', 'scanRequest.url must be a non-empty string');
  }
  try {
    const u = new URL(req.url);
    if (!['http:', 'https:', 'data:'].includes(u.protocol)) {
      throw new ScanError('INVALID_URL',
        `Only http/https/data URLs are supported; got ${u.protocol}`);
    }
  } catch (err) {
    if (err instanceof ScanError) throw err;
    throw new ScanError('INVALID_URL', `Not a valid URL: ${req.url}`);
  }
}

/**
 * Scan-specific error.
 */
export class ScanError extends Error {
  constructor(code, message) {
    super(message);
    this.name = 'ScanError';
    this.code = code;
  }
}

// Re-export pieces for tests and advanced callers.
export { launchBrowser, createContext, closeContext, closeBrowser } from './browser.js';
export { waitForReady, WaitError } from './wait.js';
export { runAxe } from './axe.js';
export { captureScreenshot } from './screenshot.js';
export { computeBoundingBoxes } from './bbox.js';
export { retryWithBackoff, isTransientNetworkError } from './retry.js';
export { captureAuth, runAuthInContext, AuthError } from './auth/index.js';
