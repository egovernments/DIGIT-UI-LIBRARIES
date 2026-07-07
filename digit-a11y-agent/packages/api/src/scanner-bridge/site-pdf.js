/**
 * Site (multi-page) PDF report generator.
 *
 * Mirrors the on-screen site report layout (minus the hover interaction, which
 * a PDF can't do):
 *   1. overall score (averaged)
 *   2. per-page results — each page: header (score + counts) + base-state
 *      screenshot + that page's full issue list
 *   3. standards compliance
 *   4. priority fixes ("Start here")
 *   5. the full site-wide issue list (every distinct rule across all pages)
 *
 * Reuses pdf.js's building blocks (score block, standards, start-here, issue
 * cards, styles, screenshot embedding) so it looks identical to the single-page
 * report. Each per-page block starts on its own PDF page.
 *
 * @see ../routes/site.js
 */

import { chromium } from 'playwright';
import {
  escapeHtml,
  baseStyles,
  renderScoreBlock,
  renderStandards,
  renderStartHere,
  renderIssue,
  embedAsDataUri,
} from './pdf.js';

/**
 * @param {object} input
 * @param {string} input.siteId
 * @param {object} input.request - the (redacted) site request: { urls, auth? }
 * @param {object} input.report  - the site report (buildSiteReport output)
 * @returns {Promise<Buffer>} the PDF bytes
 */
export async function renderSiteReportPdf({ siteId, request, report }) {
  const html = renderSiteHtml({ siteId, request, report });

  const browser = await chromium.launch();
  try {
    const context = await browser.newContext();
    const page = await context.newPage();
    await page.setContent(html, { waitUntil: 'domcontentloaded' });
    await page.waitForTimeout(250);

    const pdf = await page.pdf({
      format: 'A4',
      printBackground: true,
      margin: { top: '18mm', bottom: '18mm', left: '15mm', right: '15mm' },
      preferCSSPageSize: false,
    });
    return pdf;
  } finally {
    await browser.close();
  }
}

/* ─────────── HTML composition ─────────── */

function renderSiteHtml({ siteId, request, report }) {
  const m = report.meta || {};
  const pages = report.pages || [];

  // Adapt the site overall into the shape renderScoreBlock expects.
  const overall = {
    score:       report.overallScore,
    status:      report.overallStatus,
    keySummary:  report.keySummary,
    summaryText: report.summaryText,
    summary:     report.summary,
  };

  return `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Whole-site accessibility report — ${escapeHtml(siteId)}</title>
<style>
  ${baseStyles()}
  ${siteStyles()}
</style>
</head>
<body>
  <header class="hdr">
    <p class="eyebrow">DIGIT Accessibility Scanner — Whole-site report</p>
    <h1 class="target">${m.scannedPageCount ?? 0} of ${m.urlCount ?? 0} pages scanned</h1>
    <p class="meta">
      Scan <code>${escapeHtml(siteId)}</code>
      ${m.statesScanned != null ? ` &nbsp;·&nbsp; ${m.statesScanned} states audited` : ''}
      ${report.summary?.totalIssues != null ? ` &nbsp;·&nbsp; ${report.summary.totalIssues} distinct issue types across the app` : ''}
      ${m.failedPageCount ? ` &nbsp;·&nbsp; ${m.failedPageCount} page(s) could not load` : ''}
    </p>
  </header>

  <section class="score-card">
    ${renderScoreBlock(overall)}
  </section>

  ${renderHowToRead(m.urlCount ?? pages.length)}

  ${renderStandards(report.standardsBreakdown)}

  ${renderSummaryTable(report.issueSummary, report.summary)}

  ${renderPerPageSections(pages)}

  ${renderStartHere(report.startHere)}

  ${renderSiteWideIssues(report.issues, report.summary)}

  <footer class="ftr">
    DIGIT Accessibility Scanner — Phase 1 · Built on Playwright + axe-core
  </footer>
</body>
</html>`;
}

function pageName(u) {
  if (!u) return '';
  return String(u).split('/').pop().split('?')[0];
}

function scoreToneClass(score) {
  return score >= 90 ? 'ok' : score >= 70 ? 'warn' : 'bad';
}

/* ─────────── how to read (overview) ─────────── */

function renderHowToRead(pageCount) {
  return `
  <section class="howto">
    <h2>How to read this report</h2>
    <p>The score above is the average across all ${pageCount} pages — 90+ is good, 70–89 minor work, 50–69 needs attention, below 50 needs major fixes. Issues are grouped by severity: <strong>critical</strong> blocks some users entirely (fix first), <strong>serious</strong> makes pages hard to use, and <strong>moderate</strong> / <strong>minor</strong> are smaller improvements. Each page section below shows that page's screenshot with on-load issues boxed; issues only reachable after a click are listed but not boxed. <strong>All issues across the site</strong> at the end collects every distinct issue once, with a total element count across all pages. Every issue explains why it matters, what to do, and which standards it maps to (WCAG, GIGW, SesMag, ADA).</p>
  </section>`;
}

/* ─────────── most common issues (summary table) ─────────── */

function renderSummaryTable(issueSummary, summary) {
  if (!issueSummary || issueSummary.length === 0) return '';
  const s = summary || {};
  const rows = issueSummary.map((it) => `
    <tr>
      <td class="st-issue">${escapeHtml(it.title)}</td>
      <td><span class="pill pill-${it.tone}">${escapeHtml(it.severity)}</span></td>
      <td class="st-num">${it.pagesAffected}</td>
      <td class="st-num">${it.elements}</td>
    </tr>`).join('');
  return `
  <section class="summary-section">
    <h2>Most common issues</h2>
    <p class="muted">${s.totalIssues ?? issueSummary.length} distinct issue types, sorted by severity. "Pages" is how many scanned pages each appears on; "Elements" is the total across all pages.</p>
    <table class="summary-table">
      <thead>
        <tr><th>Issue</th><th>Severity</th><th class="st-num">Pages</th><th class="st-num">Elements</th></tr>
      </thead>
      <tbody>${rows}</tbody>
    </table>
  </section>`;
}

/* ─────────── per-page results: header + screenshot + that page's issues ─────────── */

function renderPerPageSections(pages) {
  if (!pages.length) return '';
  return `
  <section class="per-page-wrap">
    <h2>Per-page results</h2>
    ${pages.map((p, i) => renderPageBlock(p, i)).join('')}
  </section>`;
}

function renderPageBlock(p) {
  const name = pageName(p.url);

  // Page that couldn't load — muted, no screenshot/issues.
  if (!p.summary) {
    const where = (p.landed && p.landed !== p.url) ? ` → ${escapeHtml(p.landed)}` : '';
    return `
    <section class="page-block page-break">
      <div class="pb-head">
        <div class="pb-headtext">
          <h3 class="pb-title">${escapeHtml(name)}</h3>
          <p class="pb-url">${escapeHtml(p.url)}</p>
          <p class="pp-failed">Couldn't load (${escapeHtml(p.loadStatus ?? 'unknown')})${where}</p>
        </div>
      </div>
    </section>`;
  }

  const s = p.summary;
  const tone = scoreToneClass(p.score);
  const shot = p.screenshot?.path ? embedAsDataUri(p.screenshot.path) : null;

  return `
  <section class="page-block page-break">
    <div class="pb-head">
      <span class="pb-score score-${tone}">${p.score}</span>
      <div class="pb-headtext">
        <h3 class="pb-title">${escapeHtml(name)}</h3>
        <p class="pb-url">${escapeHtml(p.url)}</p>
        <p class="pb-counts">
          ${s.totalIssues ?? 0} issues —
          <span class="c-crit">${s.critical ?? 0} critical</span> ·
          <span class="c-ser">${s.serious ?? 0} serious</span> ·
          <span class="c-mod">${s.moderate ?? 0} moderate</span> ·
          <span class="c-min">${s.minor ?? 0} minor</span>
        </p>
      </div>
    </div>

    ${shot ? `
    <div class="pb-shot">
      <p class="pb-shot-label">Page screenshot — base state (as the page loads). Issues only reachable after a click are listed below but not marked here.</p>
      <img class="screenshot pb-screenshot" src="${shot}" alt="Base-state screenshot of ${escapeHtml(name)}" />
    </div>` : ''}

    <div class="pb-issues">
      <h4 class="pb-issues-title">Issues on this page (${s.totalIssues ?? 0})</h4>
      ${(p.issues ?? []).length
        ? p.issues.map((iss, j) => renderIssue(iss, j + 1, false)).join('')
        : '<p class="muted">No issues found on this page.</p>'}
    </div>
  </section>`;
}

/* ─────────── site-wide issue list ─────────── */

function renderSiteWideIssues(issues, summary) {
  if (!issues || issues.length === 0) {
    return `<section class="page-break"><h2>All issues across the site</h2><p class="muted">No accessibility issues were found across the scanned pages.</p></section>`;
  }
  return `
  <section class="page-break">
    <h2>All issues across the site (${summary?.totalIssues ?? issues.length})</h2>
    <p class="muted">Every distinct issue across all pages, one entry per rule. Element counts span all pages and states.</p>
    ${issues.map((iss, i) => renderIssue(iss, i + 1, false)).join('')}
  </section>`;
}

/* ─────────── site-specific styles (added to baseStyles) ─────────── */

function siteStyles() {
  return `
    .per-page-wrap > h2 { margin-bottom: 4pt; }
    .page-block { margin-bottom: 18pt; }
    .pb-head { display: flex; gap: 12pt; align-items: flex-start; padding-bottom: 8pt; border-bottom: 1.5pt solid #e2e8f0; margin-bottom: 12pt; }
    .pb-score { flex: 0 0 auto; width: 42pt; height: 42pt; border-radius: 50%; border: 3pt solid; display: flex; align-items: center; justify-content: center; font-size: 15pt; font-weight: bold; }
    .pb-score.score-ok { border-color: #16a34a; color: #16a34a; }
    .pb-score.score-warn { border-color: #eab308; color: #eab308; }
    .pb-score.score-bad { border-color: #dc2626; color: #dc2626; }
    .pb-headtext { flex: 1; min-width: 0; }
    .pb-title { font-size: 13pt; margin: 0; word-break: break-all; line-height: 1.2; }
    .pb-url { font-size: 8pt; color: #94a3b8; margin: 2pt 0; word-break: break-all; }
    .pb-counts { font-size: 9.5pt; color: #475569; margin: 3pt 0 0; }
    .pb-counts .c-crit { color: #b91c1c; font-weight: 600; }
    .pb-counts .c-ser  { color: #c2410c; font-weight: 600; }
    .pb-counts .c-mod  { color: #a16207; font-weight: 600; }
    .pb-counts .c-min  { color: #64748b; font-weight: 600; }
    .pb-shot { margin-bottom: 14pt; text-align: center; }
    .pb-shot-label { font-size: 8.5pt; color: #64748b; margin: 0 0 5pt; text-align: left; }
    /* Fit each whole screenshot within roughly one page so the issues below
       flow cleanly (a width-only scale could make a tall page span/clip). */
    .pb-screenshot { max-height: 560pt; width: auto; max-width: 100%; height: auto; margin: 0 auto; display: block; }
    .pb-issues-title { font-size: 10.5pt; margin: 14pt 0 8pt; color: #0f172a; }
    .pp-failed { color: #b45309; font-style: italic; margin: 4pt 0 0; }

    .howto { background: #f1f5f9; border: 1px solid #e2e8f0; border-radius: 6pt; padding: 12pt 14pt; margin-top: 16pt; }
    .howto h2 { margin-top: 0; }
    .howto p { font-size: 9.5pt; color: #475569; margin: 0; line-height: 1.6; }

    .summary-table { width: 100%; border-collapse: collapse; margin-top: 8pt; font-size: 9.5pt; }
    .summary-table th { text-align: left; font-size: 8pt; text-transform: uppercase; letter-spacing: 0.04em; color: #64748b; border-bottom: 1.5pt solid #e2e8f0; padding: 0 6pt 5pt; font-weight: 600; }
    .summary-table th.st-num { text-align: right; }
    .summary-table td { padding: 6pt; border-bottom: 1px solid #eef2f7; vertical-align: middle; }
    .summary-table td.st-issue { width: 52%; }
    .summary-table td.st-num { text-align: right; white-space: nowrap; color: #475569; }
  `;
}
