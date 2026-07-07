/**
 * @digit-a11y/reporter — main entry.
 *
 * `buildFriendlyReport(rawScanResult)` is the pure function that takes the
 * scanner's raw output and produces the canonical `FriendlyReport` consumed
 * by the API, UI, and PDF exporter alike.
 *
 * @see ./types.js for the FriendlyReport shape.
 */

import { getMessage, ruleMessages } from './messages.js';
import { computeScore } from './scoring.js';
import { buildStandardsBreakdown } from './standards.js';

const IMPACT_TO_SEVERITY = {
  critical: 'Needs Immediate Fix',
  serious:  'Important',
  moderate: 'Can Improve',
  minor:    'Minor',
};

const IMPACT_TO_ICON = {
  critical: '🚫',
  serious:  '⚠️',
  moderate: '🔧',
  minor:    '💡',
};

const SEVERITY_ORDER = {
  'Needs Immediate Fix': 0,
  'Important':           1,
  'Can Improve':         2,
  'Minor':               3,
};

// Detect which named landmark sections a violation lives in, based on the
// CSS selectors axe-core gives us. Light heuristic; refined in later phases.
const LANDMARK_MAP = {
  nav:     'Navigation',
  header:  'Header',
  main:    'Main Content',
  footer:  'Footer',
  form:    'Form',
  section: 'Content Section',
  article: 'Article',
  aside:   'Sidebar',
  table:   'Table',
  dialog:  'Dialog',
};

/**
 * Extract landmark section names from violation targets (deduplicated, in document order).
 * @param {import('./types.js').ViolationTarget[]} targets
 * @returns {string[]}
 */
function extractSections(targets) {
  const found = new Set();
  for (const t of targets) {
    const parts = t.selector.toLowerCase().split(/[\s>+~,]+/);
    for (const part of parts) {
      const tag = part.split(/[#.\[:]/)[0];
      if (tag && LANDMARK_MAP[tag]) {
        found.add(LANDMARK_MAP[tag]);
        break;
      }
    }
  }
  return Array.from(found);
}

/**
 * Convert a raw axe violation to a FriendlyIssue, applying friendly text and severity.
 * @param {import('./types.js').AxeViolation} v
 * @returns {import('./types.js').FriendlyIssue}
 */
function toFriendlyIssue(v) {
  const msg = getMessage(v.id);
  const targets = (v.nodes ?? []).map((n) => ({
    selector:    n.target[0] ?? '',
    boundingBox: n._bounds ?? null,
  }));

  return {
    ruleId:        v.id,
    title:         msg.title,
    severity:      IMPACT_TO_SEVERITY[v.impact] ?? 'Minor',
    icon:          IMPACT_TO_ICON[v.impact] ?? '💡',
    whyItMatters:  msg.whyItMatters,
    whatYouCanDo:  msg.whatYouCanDo,
    affectedUsers: msg.affectedUsers,
    targets,
    standards:     msg.standards,
    sections:      extractSections(targets),
    ...(msg.example ? { example: msg.example } : {}),
  };
}

const STATUS_PHRASE = {
  'Good to go':             'This page is accessible',
  'Needs some improvement': 'This page needs minor improvements',
  'Needs attention':        'This page needs attention',
  'Needs major fixes':      'This page needs major fixes',
};

// Short noun phrases per issue title — populated lazily on first build.
// Kept inline here since it's tightly coupled to messages.js titles.
// (See packages/reporter/src/_shortPhrases.js in a future phase if this grows.)
const ISSUE_SHORT_FALLBACK = (title) => title.toLowerCase();

/**
 * @param {import('./types.js').ScoreStatus} status
 * @param {import('./types.js').FriendlyIssue[]} issues
 * @returns {string}
 */
function buildKeySummary(status, issues) {
  if (issues.length === 0) {
    return 'This page is fully accessible with no issues found.';
  }
  const phrase = STATUS_PHRASE[status] ?? 'This page has accessibility issues';
  const top = issues.slice(0, 2).map((i) => ISSUE_SHORT_FALLBACK(i.title));
  const due = top.length === 1 ? top[0] : `${top[0]} and ${top[1]}`;
  return `${phrase} due to ${due}.`;
}

/**
 * Top-3 critical/serious issues to address first.
 * @param {import('./types.js').FriendlyIssue[]} issues
 * @returns {import('./types.js').FriendlyIssue[]}
 */
function pickStartHere(issues) {
  const critical = issues.filter((i) => i.severity === 'Needs Immediate Fix');
  const serious  = issues.filter((i) => i.severity === 'Important');
  return [...critical, ...serious].slice(0, 3);
}

/**
 * Build the canonical FriendlyReport from raw scanner output.
 *
 * @param {import('./types.js').RawScanResult} rawScanResult
 * @returns {import('./types.js').FriendlyReport}
 */
export function buildFriendlyReport(rawScanResult) {
  const violations = rawScanResult.violations ?? [];

  const summary = {
    totalIssues: violations.length,
    critical:    violations.filter((v) => v.impact === 'critical').length,
    serious:     violations.filter((v) => v.impact === 'serious').length,
    moderate:    violations.filter((v) => v.impact === 'moderate').length,
    minor:       violations.filter((v) => v.impact === 'minor').length,
  };

  const { score, status, summaryText } = computeScore(summary);

  const issues = violations
    .map(toFriendlyIssue)
    .sort((a, b) => (SEVERITY_ORDER[a.severity] ?? 99) - (SEVERITY_ORDER[b.severity] ?? 99));

  const standardsBreakdown = buildStandardsBreakdown(violations.map((v) => v.id));
  const startHere  = pickStartHere(issues);
  const keySummary = buildKeySummary(status, issues);

  return {
    score,
    status,
    summaryText,
    keySummary,
    summary,
    startHere,
    issues,
    standardsBreakdown,
    // Day-7 fix: forward the screenshot info so the UI's bbox overlay can
    // render and the GET /:scanId/screenshot route can find the file on
    // disk. Conditional spread keeps the field absent when the scan didn't
    // capture one (failed-screenshot case stays clean).
    ...(rawScanResult.screenshot ? { screenshot: rawScanResult.screenshot } : {}),
    meta: rawScanResult.meta,
  };
}

// Re-export the building blocks so callers (tests, exporter, etc.) can use them directly.
export { getMessage, ruleMessages, computeScore, buildStandardsBreakdown };
export { buildSiteReport } from './site.js';
