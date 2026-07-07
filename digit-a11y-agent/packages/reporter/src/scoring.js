/**
 * Scoring formula for FriendlyReport.
 *
 * Phase 1 starting values (calibrated in Phase 2 Day 12 against real data):
 *   • critical: -10 per issue, capped at -30
 *   • serious:   -7 per issue, capped at -30
 *   • moderate:  -4 per issue, capped at -30
 *   • minor:     -1 per issue, capped at -30
 *
 * Status thresholds:
 *   90-100  →  "Good to go"
 *   70-89   →  "Needs some improvement"
 *   50-69   →  "Needs attention"
 *    0-49   →  "Needs major fixes"
 *
 * @see ./types.js for SeveritySummary, ScoreStatus typedefs.
 */

/**
 * @typedef {Object} ScoreBreakdown
 * @property {number} score - 0..100
 * @property {import('./types.js').ScoreStatus} status
 * @property {string} summaryText - One-sentence summary
 */

/**
 * @typedef {Object} ViolationCounts
 * @property {number} critical
 * @property {number} serious
 * @property {number} moderate
 * @property {number} minor
 */

const PENALTY_PER_ISSUE = {
  critical: 10,
  serious:   7,
  moderate:  4,
  minor:     1,
};

const PENALTY_CAP_PER_SEVERITY = 30;

/**
 * Map a 0..100 score to its status band. Exported so multi-page rollups
 * (buildSiteReport) can label an averaged score with the same thresholds.
 * @param {number} score
 * @returns {import('./types.js').ScoreStatus}
 */
export function getStatus(score) {
  if (score >= 90) return 'Good to go';
  if (score >= 70) return 'Needs some improvement';
  if (score >= 50) return 'Needs attention';
  return 'Needs major fixes';
}

/**
 * @param {number} score
 * @param {ViolationCounts} counts
 * @returns {string}
 */
function getSummaryText(score, counts) {
  const total = counts.critical + counts.serious + counts.moderate + counts.minor;

  if (total === 0) {
    return 'Great news — no accessibility issues were found on this page. It is ready for all users.';
  }

  if (counts.critical > 0) {
    return (
      `This page has ${counts.critical} critical ${counts.critical === 1 ? 'issue' : 'issues'} that will block some users entirely. ` +
      `Fix these first before moving on to the other ${total - counts.critical} ${total - counts.critical === 1 ? 'issue' : 'issues'}.`
    );
  }

  if (counts.serious > 0) {
    return (
      `This page has some important issues that make it hard to use for people with disabilities. ` +
      `Fixing the top ${Math.min(counts.serious, 3)} ${counts.serious === 1 ? 'issue' : 'issues'} will make a big difference.`
    );
  }

  if (score >= 70) {
    return (
      `This page is mostly accessible. There ${counts.moderate === 1 ? 'is' : 'are'} ${counts.moderate} smaller ` +
      `${counts.moderate === 1 ? 'issue' : 'issues'} that are worth addressing to make it work well for everyone.`
    );
  }

  return (
    `This page needs some work to be fully accessible. ` +
    `Addressing the ${total} issues found here will make the page usable for more people.`
  );
}

/**
 * Compute the overall accessibility score and status from violation counts.
 *
 * @param {ViolationCounts} counts
 * @returns {ScoreBreakdown}
 */
export function computeScore(counts) {
  const cappedPenalty = (count, impact) =>
    Math.min(count * PENALTY_PER_ISSUE[impact], PENALTY_CAP_PER_SEVERITY);

  const totalPenalty =
    cappedPenalty(counts.critical, 'critical') +
    cappedPenalty(counts.serious,  'serious')  +
    cappedPenalty(counts.moderate, 'moderate') +
    cappedPenalty(counts.minor,    'minor');

  const score = Math.max(0, 100 - totalPenalty);

  return {
    score,
    status:      getStatus(score),
    summaryText: getSummaryText(score, counts),
  };
}
