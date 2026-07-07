/**
 * Explorer bridge: turns a site-scan request (a sitemap + auth) into a scored
 * site report. The multi-page analogue of execute.js.
 *
 * Runs @digit-a11y/explorer's runExploration() and feeds the raw result through
 * @digit-a11y/reporter's buildSiteReport(). An outer timeout protects the API
 * process from a run that hangs (the explorer has its own per-step timeouts;
 * this is the belt-and-braces bound for the whole exploration).
 *
 * IMPORTANT: this runs server-side and headless, so it uses AUTOMATED auth
 * (credentials in request.auth). The CLI's manual-login path is not available
 * here — there is no human at the server to log in.
 */

import { runExploration } from '@digit-a11y/explorer';
import { buildSiteReport } from '@digit-a11y/reporter';
import { config } from '../config.js';

/**
 * @param {object} siteRequest - { urls, auth?, options? }
 * @param {object} [opts]
 * @param {number} [opts.timeoutMs]
 * @param {string} [opts.scanId] - base id for per-page screenshot artifact dirs
 * @param {(evt: object) => void} [opts.onProgress]
 * @returns {Promise<object>} the site report (buildSiteReport output)
 */
export async function executeExploration(siteRequest, opts = {}) {
  const timeoutMs = opts.timeoutMs ?? config.siteScanTimeoutMs;

  const explorePromise = (async () => {
    const exploration = await runExploration({
      urls:       siteRequest.urls,
      auth:       siteRequest.auth,
      scanId:     opts.scanId,
      options:    {
        ...(siteRequest.options ?? {}),
        captureScreenshots: true,
        concurrency: siteRequest.options?.concurrency ?? config.siteConcurrency,
      },
      onProgress: opts.onProgress,
      // manualLogin is intentionally never set — the server has no human to log in.
    });
    return buildSiteReport(exploration, {
      auth: siteRequest.auth
        ? { type: siteRequest.auth.type, strategy: siteRequest.auth.contextStrategy ?? 'reuse' }
        : 'none',
    });
  })();

  let timeoutId;
  const timeoutPromise = new Promise((_, reject) => {
    timeoutId = setTimeout(() => reject(new ExploreTimeoutError(timeoutMs)), timeoutMs);
  });

  try {
    return await Promise.race([explorePromise, timeoutPromise]);
  } finally {
    clearTimeout(timeoutId);
  }
}

export class ExploreTimeoutError extends Error {
  constructor(ms) {
    super(`Site exploration exceeded the configured budget of ${ms}ms.`);
    this.name = 'ExploreTimeoutError';
    this.code = 'SITE_SCAN_TIMEOUT';
  }
}
