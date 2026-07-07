/**
 * axe-core integration via the official `@axe-core/playwright` adapter.
 *
 * Thin wrapper that:
 *   1. Injects axe-core into the live page
 *   2. Runs the analysis with our default WCAG/best-practice tag set
 *   3. Returns the violations + incomplete items + the axe-core version
 *      (so the report can record exactly which engine produced the findings)
 *
 * We don't reinvent axe-core's rule engine — Deque has spent 10+ years on it.
 * Our job is to give axe the best chance of running against a real DOM (via
 * the scanner's wait strategy) and then translate its output for govt users
 * (via the reporter).
 *
 * @see https://github.com/dequelabs/axe-core-npm/tree/develop/packages/playwright
 */

import { AxeBuilder } from '@axe-core/playwright';

/**
 * Default tag set — matches `messages.js` coverage exactly so every reported
 * violation has a friendly translation. WCAG 2.2 is intentionally excluded;
 * it gets its own mapping pass in Phase 2.
 */
const DEFAULT_TAGS = [
  'wcag2a',          // WCAG 2.0 Level A
  'wcag2aa',         // WCAG 2.0 Level AA
  'wcag21a',         // WCAG 2.1 Level A
  'wcag21aa',        // WCAG 2.1 Level AA
  'best-practice',   // axe's curated best-practice rules
];

/**
 * @typedef {Object} AxeRunOptions
 * @property {string[]} [tags] - Override default tag set
 * @property {string[]} [include] - CSS selectors to scan (default: whole document)
 * @property {string[]} [exclude] - CSS selectors to skip
 */

/**
 * @typedef {Object} AxeRunResult
 * @property {import('./types-axe.js').AxeViolation[]} violations
 * @property {import('./types-axe.js').AxeViolation[]} incomplete - Items axe could not determine
 * @property {string} axeCoreVersion
 * @property {number} durationMs
 */

/**
 * Run axe-core against the current page. Page should already be loaded and
 * ready (i.e. waitForReady has resolved).
 *
 * @param {import('playwright').Page} page
 * @param {AxeRunOptions} [options]
 * @returns {Promise<AxeRunResult>}
 */
export async function runAxe(page, options = {}) {
  const startedAt = Date.now();

  let builder = new AxeBuilder({ page })
    .withTags(options.tags ?? DEFAULT_TAGS);

  if (options.include?.length) {
    builder = builder.include(options.include);
  }
  if (options.exclude?.length) {
    builder = builder.exclude(options.exclude);
  }

  const results = await builder.analyze();

  return {
    violations:     results.violations ?? [],
    incomplete:     results.incomplete ?? [],
    axeCoreVersion: results.testEngine?.version ?? 'unknown',
    durationMs:     Date.now() - startedAt,
  };
}

/**
 * Exposed for tests.
 */
export const _defaults = { tags: DEFAULT_TAGS };
