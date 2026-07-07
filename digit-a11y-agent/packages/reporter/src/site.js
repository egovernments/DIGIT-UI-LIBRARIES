/**
 * Site-level aggregation for multi-state / multi-page scans (the explorer).
 *
 * The explorer produces many raw scans — a base scan per page plus one per
 * dynamic state. axe re-reports the whole page each time, so naive addition
 * double-counts. This module merges them honestly:
 *
 *   - violations are merged by RULE (one entry per rule id), and within a rule
 *     the element targets are unioned (deduped by selector). So a rule that
 *     fails on many states/elements is one issue with all its instances.
 *   - the merged violation set is fed back through buildFriendlyReport(), so the
 *     site score, friendly issues, and standards breakdown use the exact same
 *     logic as a single-page report — counted one-per-rule, just like the rest
 *     of the tool.
 *
 * Produces an overall report plus a per-page rollup.
 *
 * @see ./index.js buildFriendlyReport
 */

import { buildFriendlyReport } from './index.js';
import { getStatus } from './scoring.js';

// Map the friendly severity label → short table label, PDF pill tone, and a
// worst-first sort rank. Used to build the top-of-report "most common issues"
// summary table consumed by both the UI and the PDF.
const SEVERITY_SHORT = {
  'Needs Immediate Fix': { short: 'Critical', tone: 'crit', rank: 0 },
  'Important':           { short: 'Serious',  tone: 'ser',  rank: 1 },
  'Can Improve':         { short: 'Moderate', tone: 'mod',  rank: 2 },
  'Minor':               { short: 'Minor',    tone: 'min',  rank: 3 },
};

const SITE_STATUS_PHRASE = {
  'Good to go':             'This site is accessible',
  'Needs some improvement': 'This site needs minor improvements',
  'Needs attention':        'This site needs attention',
  'Needs major fixes':      'This site needs major fixes',
};

/**
 * Site-level one-sentence summary, derived from the AVERAGED score band and the
 * union severity counts. Mirrors scoring.js getSummaryText but speaks about the
 * whole site rather than a single page — so the headline number, status, and
 * this prose all agree.
 * @param {number} score - the averaged overall score
 * @param {{critical?:number,serious?:number,moderate?:number,minor?:number}} counts
 * @returns {string}
 */
function siteSummaryText(score, counts = {}) {
  const critical = counts.critical ?? 0;
  const serious  = counts.serious ?? 0;
  const moderate = counts.moderate ?? 0;
  const minor    = counts.minor ?? 0;
  const total    = critical + serious + moderate + minor;

  if (total === 0) {
    return 'Great news — no accessibility issues were found across the scanned pages.';
  }
  if (critical > 0) {
    const rest = total - critical;
    return (
      `This site has ${critical} critical ${critical === 1 ? 'issue' : 'issues'} that block some users entirely. ` +
      `Fix these first, then the other ${rest} ${rest === 1 ? 'issue' : 'issues'}.`
    );
  }
  if (serious > 0) {
    const n = Math.min(serious, 3);
    return (
      `This site has some important issues that make it hard to use for people with disabilities. ` +
      `Fixing the top ${n} ${n === 1 ? 'issue' : 'issues'} will make a big difference.`
    );
  }
  if (score >= 70) {
    return (
      `This site is mostly accessible. There ${moderate === 1 ? 'is' : 'are'} ${moderate} smaller ` +
      `${moderate === 1 ? 'issue' : 'issues'} worth addressing to make it work well for everyone.`
    );
  }
  return (
    `This site needs some work to be fully accessible. ` +
    `Addressing the ${total} issues found will make it usable for more people.`
  );
}

/**
 * Site-level key summary line ("This site needs attention due to X and Y.").
 * Uses the averaged-score status band and the two most severe rules.
 * @param {string} status
 * @param {import('./types.js').FriendlyIssue[]} issues
 * @returns {string}
 */
function siteKeySummary(status, issues) {
  if (!issues || issues.length === 0) {
    return 'This site is fully accessible with no issues found.';
  }
  const phrase = SITE_STATUS_PHRASE[status] ?? 'This site has accessibility issues';
  const top = issues.slice(0, 2).map((i) => (i.title || '').toLowerCase());
  const due = top.length === 1 ? top[0] : `${top[0]} and ${top[1]}`;
  return `${phrase} due to ${due}.`;
}

/**
 * Merge violation arrays by rule id; union node targets within each rule.
 * @param {Array<import('./types.js').AxeViolation[]>} violationArrays
 * @returns {import('./types.js').AxeViolation[]}
 */
function mergeViolations(violationArrays) {
  const byRule = new Map();
  for (const violations of violationArrays) {
    for (const v of violations ?? []) {
      if (!byRule.has(v.id)) {
        byRule.set(v.id, { ...v, nodes: [...(v.nodes ?? [])] });
      } else {
        const existing = byRule.get(v.id);
        const seen = new Set(existing.nodes.map((n) => (n.target && n.target[0]) || ''));
        for (const n of v.nodes ?? []) {
          const sel = (n.target && n.target[0]) || '';
          if (!seen.has(sel)) { existing.nodes.push(n); seen.add(sel); }
        }
      }
    }
  }
  return Array.from(byRule.values());
}

function reportFromViolations(violations, metaUrl) {
  return buildFriendlyReport({
    violations,
    incomplete: [],
    meta: {
      scanId: 'aggregate',
      url: metaUrl,
      scannedAt: new Date().toISOString(),
      durationMs: 0,
      axeCoreVersion: 'merged',
      warnings: [],
    },
  });
}

/**
 * Build a site report from explorer output.
 *
 * @param {{ pages: object[], meta?: object }} exploration - runExploration() output
 * @param {object} [siteMeta] - extra metadata to attach
 * @returns {object} site report
 */
export function buildSiteReport(exploration, siteMeta = {}) {
  const pages = exploration?.pages ?? [];
  const allViolationArrays = [];
  const pageReports = [];

  for (const p of pages) {
    const pageViolationArrays = [];
    const stateSummaries = [];

    for (const s of p.states ?? []) {
      if (s.raw?.violations) {
        pageViolationArrays.push(s.raw.violations);
        allViolationArrays.push(s.raw.violations);
        const r = buildFriendlyReport(s.raw);
        stateSummaries.push({
          label: s.label || s.clicked || '(state)',
          outcome: s.outcome,
          score: r.score,
          totalIssues: r.summary.totalIssues,
        });
      } else {
        stateSummaries.push({
          label: s.label || s.clicked || '(state)',
          outcome: s.outcome,
          ...(s.to ? { to: s.to } : {}),
        });
      }
    }

    if (p.loadStatus === 'ok' && pageViolationArrays.length) {
      const merged = mergeViolations(pageViolationArrays);
      const report = reportFromViolations(merged, p.url);
      pageReports.push({
        url: p.url,
        loadStatus: p.loadStatus,
        score: report.score,
        status: report.status,
        summary: report.summary,
        startHere: report.startHere,
        issues: report.issues,
        standardsBreakdown: report.standardsBreakdown,
        ...(p.screenshot ? { screenshot: p.screenshot } : {}),
        states: stateSummaries,
      });
    } else {
      pageReports.push({
        url: p.url,
        loadStatus: p.loadStatus,
        ...(p.landed ? { landed: p.landed } : {}),
        states: stateSummaries,
      });
    }
  }

  // The site-wide ISSUE LIST is the union of every distinct rule across all
  // pages and states (one entry per rule, targets merged). That list — and its
  // severity counts — is the useful "everything wrong across the app" view.
  const overall = reportFromViolations(mergeViolations(allViolationArrays), '(site)');

  // The headline SCORE, however, is the AVERAGE of the per-page scores, not the
  // union score. Scoring the union as if it were one page pins almost any real
  // multi-page site at ~10-15 (the per-severity caps fill immediately), so it
  // can't discriminate. The average of page scores tracks real health and moves
  // over time. The union score stays available as meta.combinedScore.
  const scoredPages = pageReports.filter(
    (p) => p.loadStatus === 'ok' && p.summary && typeof p.score === 'number',
  );
  const overallScore = scoredPages.length
    ? Math.round(scoredPages.reduce((sum, p) => sum + p.score, 0) / scoredPages.length)
    : overall.score;
  const overallStatus = getStatus(overallScore);

  // Compact "most common issues" summary for the TOP of the report: one row per
  // distinct rule, with how many scanned PAGES it appears on and the total
  // element count across the whole site. Sorted worst-first (severity, then
  // element count). Consumed by both the UI and the PDF opening summary.
  const pageCountByRule = new Map();
  for (const pr of pageReports) {
    for (const iss of pr.issues ?? []) {
      pageCountByRule.set(iss.ruleId, (pageCountByRule.get(iss.ruleId) ?? 0) + 1);
    }
  }
  const issueSummary = (overall.issues ?? [])
    .map((iss) => {
      const sev = SEVERITY_SHORT[iss.severity] ?? SEVERITY_SHORT.Minor;
      return {
        ruleId:        iss.ruleId,
        title:         iss.title,
        severity:      sev.short,
        tone:          sev.tone,
        severityRank:  sev.rank,
        pagesAffected: pageCountByRule.get(iss.ruleId) ?? 0,
        elements:      (iss.targets ?? []).length,
      };
    })
    .sort((a, b) => (a.severityRank - b.severityRank) || (b.elements - a.elements));

  return {
    overallScore,
    overallStatus,
    // Site-level copy derived from the AVERAGE-score band and the union counts,
    // so the headline number, status, and prose all agree (and say "this site",
    // not "this page"). Previously these borrowed the union report's text, whose
    // ~8/100 score contradicted the averaged headline.
    summaryText: siteSummaryText(overallScore, overall.summary),
    keySummary:  siteKeySummary(overallStatus, overall.issues),
    summary:     overall.summary,             // one-per-rule across the whole site
    issueSummary,                             // compact top-of-report overview
    startHere:   overall.startHere,
    issues:      overall.issues,              // site-wide issues (one per rule, merged targets)
    standardsBreakdown: overall.standardsBreakdown,
    pages: pageReports,
    meta: {
      urlCount: pages.length,
      scannedPageCount: scoredPages.length,
      failedPageCount: pageReports.filter((p) => p.loadStatus !== 'ok').length,
      statesScanned: allViolationArrays.length,
      scoringMethod: 'average-of-page-scores',
      combinedScore: overall.score,           // union of all rules scored as one page (kept for reference; no longer shown)
      ...siteMeta,
    },
  };
}
