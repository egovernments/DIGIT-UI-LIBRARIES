/**
 * @digit-a11y/explorer — public entry.
 *
 *   runExploration(request)  → raw per-state results (RawScanResult shape)
 *   exploreAndReport(request) → { exploration, report } where report is the
 *                               scored site report from @digit-a11y/reporter
 */

import { runExploration } from './explore.js';
import { buildSiteReport } from '@digit-a11y/reporter';

export { runExploration } from './explore.js';

/**
 * Convenience: explore the sitemap and build the scored site report in one call.
 * @param {import('./explore.js').ExploreRequest} request
 * @returns {Promise<{ exploration: object, report: object }>}
 */
export async function exploreAndReport(request) {
  const exploration = await runExploration(request);
  const report = buildSiteReport(exploration, {
    auth: request.auth ? { type: request.auth.type, strategy: request.auth.contextStrategy ?? 'reuse' } : 'none',
  });
  return { exploration, report };
}
