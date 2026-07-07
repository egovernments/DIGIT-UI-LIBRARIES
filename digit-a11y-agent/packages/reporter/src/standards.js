/**
 * Standards aggregation — computes per-standard compliance percentages.
 *
 * For each standard (WCAG, GIGW, SesMag, ADA):
 *   1. Count rules in ruleMessages that map to this standard (non-empty array)
 *   2. Count rules that *failed* in this scan and map to this standard
 *   3. compliance% = ((total mapped - failed) / total mapped) × 100
 *
 * The output `StandardsBreakdown` powers the small bar chart at the top of
 * the report page, giving the user a quick read on "how compliant am I per
 * standard?"
 *
 * @see ./types.js for StandardsBreakdown, StandardScore typedefs.
 */

import { ruleMessages } from './messages.js';

const STANDARDS = ['wcag', 'gigw', 'sesmag', 'ada'];

/**
 * Precompute total rules mapped per standard. Runs once at module load.
 *
 * @returns {Record<string, number>} { wcag: 75, gigw: 35, ... }
 */
function countMappedRulesPerStandard() {
  const counts = { wcag: 0, gigw: 0, sesmag: 0, ada: 0 };
  for (const rule of Object.values(ruleMessages)) {
    for (const std of STANDARDS) {
      if (rule.standards[std] && rule.standards[std].length > 0) {
        counts[std]++;
      }
    }
  }
  return counts;
}

const TOTAL_MAPPED = countMappedRulesPerStandard();

/**
 * Count how many failed rules in this scan map to each standard.
 *
 * @param {string[]} failedRuleIds - axe rule IDs that produced violations
 * @returns {Record<string, number>}
 */
function countFailedPerStandard(failedRuleIds) {
  const counts = { wcag: 0, gigw: 0, sesmag: 0, ada: 0 };
  for (const id of failedRuleIds) {
    const rule = ruleMessages[id];
    if (!rule) continue;  // unknown rule — skip
    for (const std of STANDARDS) {
      if (rule.standards[std] && rule.standards[std].length > 0) {
        counts[std]++;
      }
    }
  }
  return counts;
}

/**
 * Build the StandardsBreakdown object for a scan.
 *
 * @param {string[]} failedRuleIds - axe rule IDs that produced violations
 * @returns {import('./types.js').StandardsBreakdown}
 */
export function buildStandardsBreakdown(failedRuleIds) {
  const failedCounts = countFailedPerStandard(failedRuleIds);
  const breakdown = {};

  for (const std of STANDARDS) {
    const totalMapped = TOTAL_MAPPED[std];
    const failed = failedCounts[std];
    const passed = totalMapped - failed;
    const compliancePercent = totalMapped === 0
      ? 100
      : Math.round((passed / totalMapped) * 1000) / 10;  // one decimal place

    breakdown[std] = {
      totalRulesChecked: totalMapped,
      rulesFailed:       failed,
      rulesPassed:       passed,
      compliancePercent,
    };
  }

  return breakdown;
}

/**
 * Exposed for tests — reveals what the static rule counts look like.
 * @returns {Record<string, number>}
 */
export function _getTotalMappedRules() {
  return { ...TOTAL_MAPPED };
}
