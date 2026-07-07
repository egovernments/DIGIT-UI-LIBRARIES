/**
 * Scanner bridge: turns a ScanRequest into a FriendlyReport.
 *
 * Sits between the API's job system and the scanner+reporter packages.
 * Two reasons it exists as its own module rather than inline in the route:
 *
 *   1. Tests can stub it out easily — the route never needs to care about
 *      whether a real Chromium is involved.
 *   2. It centralises the timeout policy. If a scan exceeds the configured
 *      budget we abort cleanly with a known error code rather than letting
 *      the job hang in 'running' forever.
 *
 * The scanner already has its own internal timeouts; this is a belt-and-
 * braces outer bound that protects the API process.
 */

import { runScan } from '@digit-a11y/scanner';
import { buildFriendlyReport } from '@digit-a11y/reporter';
import { config } from '../config.js';

/**
 * @param {object} scanRequest
 * @param {object} [opts]
 * @param {number} [opts.timeoutMs]
 * @returns {Promise<object>} FriendlyReport
 */
export async function executeScan(scanRequest, opts = {}) {
  const timeoutMs = opts.timeoutMs ?? config.scanTimeoutMs;

  const scanPromise = (async () => {
    const raw = await runScan(scanRequest);
    return buildFriendlyReport(raw);
  })();

  let timeoutId;
  const timeoutPromise = new Promise((_, reject) => {
    timeoutId = setTimeout(
      () => reject(new ScanTimeoutError(timeoutMs)),
      timeoutMs,
    );
  });

  try {
    return await Promise.race([scanPromise, timeoutPromise]);
  } finally {
    clearTimeout(timeoutId);
  }
}

export class ScanTimeoutError extends Error {
  constructor(ms) {
    super(`Scan exceeded the configured budget of ${ms}ms.`);
    this.name = 'ScanTimeoutError';
    this.code = 'SCAN_TIMEOUT';
  }
}
