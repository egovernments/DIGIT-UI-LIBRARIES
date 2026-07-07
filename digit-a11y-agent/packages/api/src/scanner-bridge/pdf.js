/**
 * PDF report generator.
 *
 * Renders a print-friendly HTML version of the FriendlyReport, then uses
 * Playwright's Chromium to print-to-PDF. We don't reuse the UI's React
 * components — that'd require a running UI dev server. Instead this module
 * generates standalone HTML server-side using the same design vocabulary
 * (severity colours, layout) but optimised for paper.
 *
 * Heavy (~5-10s per call) because we boot a fresh browser. For Phase 2 we
 * could keep a long-running browser process pooled; for now, simplicity wins.
 *
 * @see ../routes/scan.js
 */

import { chromium } from 'playwright';
import { readFileSync } from 'node:fs';
import { extname } from 'node:path';

/**
 * @param {object} input
 * @param {string} input.scanId
 * @param {object} input.request - The (redacted) scan request
 * @param {object} input.report  - The FriendlyReport object
 * @param {string} [input.screenshotPath] - Absolute path to the screenshot PNG (embedded as data: URI)
 * @returns {Promise<Buffer>} - The PDF bytes
 */
export async function renderReportPdf({ scanId, request, report, screenshotPath }) {
  const html = renderHtml({ scanId, request, report, screenshotPath });

  const browser = await chromium.launch();
  try {
    const context = await browser.newContext();
    const page = await context.newPage();
    await page.setContent(html, { waitUntil: 'domcontentloaded' });
    // Allow web-fonts / images a brief moment to settle.
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

function renderHtml({ scanId, request, report, screenshotPath }) {
  const screenshotEmbed = screenshotPath ? embedAsDataUri(screenshotPath) : null;

  return `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Accessibility report — ${escapeHtml(request.url)}</title>
<style>
  ${baseStyles()}
</style>
</head>
<body>
  <header class="hdr">
    <p class="eyebrow">DIGIT Accessibility Scanner — Report</p>
    <h1 class="target">${escapeHtml(request.url)}</h1>
    <p class="meta">
      Scan <code>${escapeHtml(scanId)}</code>
      ${report.meta?.scannedAt ? ` &nbsp;·&nbsp; ${new Date(report.meta.scannedAt).toLocaleString()}` : ''}
      ${report.meta?.durationMs ? ` &nbsp;·&nbsp; Took ${Math.round(report.meta.durationMs / 1000)}s` : ''}
      ${report.meta?.authenticated ? ` &nbsp;·&nbsp; Authenticated scan` : ''}
    </p>
  </header>

  <section class="score-card">
    ${renderScoreBlock(report)}
  </section>

  ${renderStandards(report.standardsBreakdown)}

  ${renderWarnings(report.meta?.warnings)}

  ${renderStartHere(report.startHere)}

  ${renderIssueList(report.issues, report.summary)}

  ${screenshotEmbed ? `
  <section class="page-break">
    <h2>Page screenshot</h2>
    <p class="muted">Full-page capture taken at the time of scan.</p>
    <img class="screenshot" src="${screenshotEmbed}" alt="Page screenshot" />
  </section>` : ''}

  <footer class="ftr">
    DIGIT Accessibility Scanner — Phase 1 · Built on Playwright + axe-core
  </footer>
</body>
</html>`;
}

export function renderScoreBlock(report) {
  const score = report.score ?? 0;
  const tone  = score >= 90 ? 'ok' : score >= 70 ? 'warn' : 'bad';
  const s     = report.summary ?? {};

  return `
  <div class="score-row">
    <div class="score-circle score-${tone}">
      <span class="score-num">${score}</span>
      <span class="score-den">/ 100</span>
    </div>
    <div class="score-text">
      <p class="score-status score-${tone}">${escapeHtml(report.status ?? '')}</p>
      <h2 class="key-summary">${escapeHtml(report.keySummary ?? '')}</h2>
      <p class="summary-text">${escapeHtml(report.summaryText ?? '')}</p>
    </div>
  </div>

  <table class="severity-counts">
    <tr>
      <td><span class="label">Total</span><span class="num">${s.totalIssues ?? 0}</span></td>
      <td><span class="label">Critical</span><span class="num c-crit">${s.critical ?? 0}</span></td>
      <td><span class="label">Serious</span><span class="num c-ser">${s.serious ?? 0}</span></td>
      <td><span class="label">Moderate</span><span class="num c-mod">${s.moderate ?? 0}</span></td>
      <td><span class="label">Minor</span><span class="num c-min">${s.minor ?? 0}</span></td>
    </tr>
  </table>`;
}

export function renderStandards(breakdown) {
  if (!breakdown) return '';
  const cards = [
    { key: 'wcag',   name: 'WCAG 2.1',     blurb: 'W3C accessibility guidelines' },
    { key: 'gigw',   name: 'GIGW',         blurb: 'Indian Government Websites' },
    { key: 'sesmag', name: 'SesMag',       blurb: 'Section 508 / EN 301 549' },
    { key: 'ada',    name: 'ADA Title III', blurb: 'Americans with Disabilities Act' },
  ];

  return `
  <section>
    <h2>Standards compliance</h2>
    <div class="standards-grid">
      ${cards.map((c) => {
        const d = breakdown[c.key];
        if (!d) return `<div class="std-card muted"><p>${c.name}: no data</p></div>`;
        const pct  = Math.round(d.compliancePercent ?? 0);
        const tone = pct >= 95 ? 'ok' : pct >= 85 ? 'warn' : 'bad';
        return `
        <div class="std-card std-${tone}">
          <p class="std-name">${escapeHtml(c.name)}</p>
          <p class="std-blurb">${escapeHtml(c.blurb)}</p>
          <p class="std-pct">${pct}<span>%</span></p>
          <p class="std-count">${d.rulesPassed ?? 0} passed · ${d.rulesFailed ?? 0} failed · of ${d.totalRulesChecked ?? 0}</p>
        </div>`;
      }).join('')}
    </div>
  </section>`;
}

function renderWarnings(warnings) {
  if (!warnings || warnings.length === 0) return '';
  return `
  <section class="warnings-section">
    <h2>Scanner notes</h2>
    <ul>
      ${warnings.map((w) => `
        <li><strong>${escapeHtml(w.code)}:</strong> ${escapeHtml(w.message)}</li>
      `).join('')}
    </ul>
  </section>`;
}

export function renderStartHere(startHere) {
  if (!startHere || startHere.length === 0) return '';
  return `
  <section>
    <h2>Start here — priority issues</h2>
    ${startHere.map((iss, i) => renderIssue(iss, i + 1, true)).join('')}
  </section>`;
}

function renderIssueList(issues, summary) {
  if (!issues || issues.length === 0) {
    return `<section><h2>All issues</h2><p class="muted">No accessibility issues were found on this page.</p></section>`;
  }
  return `
  <section class="page-break">
    <h2>All issues (${summary?.totalIssues ?? issues.length})</h2>
    ${issues.map((iss, i) => renderIssue(iss, i + 1, false)).join('')}
  </section>`;
}

export function renderIssue(issue, idx, isPriority) {
  const tone = severityTone(issue.severity);
  const standards = renderStandardsForIssue(issue.standards);
  return `
  <article class="issue issue-${tone}">
    <header>
      <span class="pill pill-${tone}">${escapeHtml(issue.severity)}</span>
      ${isPriority ? `<span class="priority-idx">#${idx}</span>` : ''}
      <h3>${escapeHtml(issue.icon ?? '')} ${escapeHtml(issue.title ?? '')}</h3>
    </header>
    <div class="why-what">
      <p><strong>Why it matters:</strong> ${escapeHtml(issue.whyItMatters ?? '')}</p>
      <p><strong>What you can do:</strong> ${escapeHtml(issue.whatYouCanDo ?? '')}</p>
    </div>
    ${standards ? `<p class="standards-line">${standards}</p>` : ''}
    ${(issue.targets && issue.targets.length > 0) ? `
      <details>
        <summary>${issue.targets.length} affected element${issue.targets.length === 1 ? '' : 's'}</summary>
        <ul class="targets">
          ${issue.targets.slice(0, 20).map((t) => `<li><code>${escapeHtml(t.selector ?? '')}</code></li>`).join('')}
          ${issue.targets.length > 20 ? `<li class="muted">… and ${issue.targets.length - 20} more</li>` : ''}
        </ul>
      </details>` : ''}
  </article>`;
}

function renderStandardsForIssue(standards) {
  if (!standards) return '';
  const parts = [];
  for (const key of ['wcag', 'gigw', 'sesmag', 'ada']) {
    const refs = standards[key];
    if (refs && refs.length > 0) {
      parts.push(`<strong>${key.toUpperCase()}:</strong> ${escapeHtml(refs.join(' · '))}`);
    }
  }
  return parts.join(' &nbsp;·&nbsp; ');
}

function severityTone(severity) {
  switch (severity) {
    case 'Needs Immediate Fix': return 'crit';
    case 'Important':           return 'ser';
    case 'Can Improve':         return 'mod';
    case 'Minor':               return 'min';
    default:                    return 'min';
  }
}

/* ─────────── utilities ─────────── */

export function escapeHtml(s) {
  if (s == null) return '';
  return String(s)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

export function embedAsDataUri(filePath) {
  try {
    const bytes = readFileSync(filePath);
    const ext   = extname(filePath).toLowerCase();
    const mime  = ext === '.png' ? 'image/png' : ext === '.jpg' || ext === '.jpeg' ? 'image/jpeg' : 'application/octet-stream';
    return `data:${mime};base64,${bytes.toString('base64')}`;
  } catch {
    return null;
  }
}

/* ─────────── styles ─────────── */

export function baseStyles() {
  return `
    * { box-sizing: border-box; }
    body { font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; color: #1e293b; line-height: 1.5; padding: 0; margin: 0; font-size: 11pt; }
    code { font-family: 'IBM Plex Mono', Menlo, Consolas, monospace; font-size: 0.9em; }
    .muted { color: #64748b; }
    .page-break { page-break-before: always; }

    .hdr { border-bottom: 2px solid #c84c0e; padding-bottom: 12pt; margin-bottom: 16pt; }
    .eyebrow { color: #c84c0e; font-size: 9pt; font-weight: 600; text-transform: uppercase; letter-spacing: 0.1em; margin: 0 0 6pt 0; }
    .target { font-size: 18pt; margin: 0; word-break: break-all; line-height: 1.2; }
    .meta { color: #64748b; font-size: 9pt; margin-top: 6pt; }

    .score-card { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6pt; padding: 14pt; margin-bottom: 16pt; }
    .score-row { display: flex; gap: 16pt; align-items: flex-start; }
    .score-circle { flex: 0 0 auto; width: 80pt; height: 80pt; border-radius: 50%; border: 4pt solid; display: flex; flex-direction: column; align-items: center; justify-content: center; }
    .score-circle.score-ok { border-color: #16a34a; color: #16a34a; }
    .score-circle.score-warn { border-color: #eab308; color: #eab308; }
    .score-circle.score-bad { border-color: #dc2626; color: #dc2626; }
    .score-num { font-size: 24pt; font-weight: bold; line-height: 1; }
    .score-den { font-size: 7pt; color: #94a3b8; text-transform: uppercase; }
    .score-text { flex: 1; }
    .score-status { font-size: 10pt; font-weight: 600; margin: 0; text-transform: lowercase; }
    .score-status.score-ok { color: #16a34a; }
    .score-status.score-warn { color: #eab308; }
    .score-status.score-bad { color: #dc2626; }
    .key-summary { font-size: 13pt; margin: 4pt 0; line-height: 1.3; }
    .summary-text { font-size: 10pt; color: #475569; margin: 0; }
    .severity-counts { width: 100%; margin-top: 12pt; border-collapse: separate; border-spacing: 4pt 0; }
    .severity-counts td { background: #fff; border: 1px solid #e2e8f0; padding: 6pt 8pt; border-radius: 4pt; width: 20%; }
    .severity-counts .label { display: block; font-size: 7pt; text-transform: uppercase; color: #64748b; }
    .severity-counts .num { display: block; font-size: 18pt; font-weight: bold; margin-top: 2pt; }
    .severity-counts .c-crit { color: #b91c1c; } .severity-counts .c-ser { color: #c2410c; }
    .severity-counts .c-mod { color: #a16207; } .severity-counts .c-min { color: #475569; }

    h2 { font-size: 13pt; margin-top: 20pt; margin-bottom: 8pt; color: #0f172a; }

    .standards-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 8pt; }
    .std-card { background: #fff; border: 1px solid #e2e8f0; padding: 8pt; border-radius: 4pt; }
    .std-card.std-ok .std-pct { color: #16a34a; }
    .std-card.std-warn .std-pct { color: #eab308; }
    .std-card.std-bad .std-pct { color: #dc2626; }
    .std-name { font-weight: 600; margin: 0; font-size: 10pt; }
    .std-blurb { font-size: 8pt; color: #64748b; margin: 2pt 0 6pt; }
    .std-pct { font-size: 20pt; font-weight: bold; margin: 0; line-height: 1; }
    .std-pct span { font-size: 10pt; color: #94a3b8; font-weight: normal; }
    .std-count { font-size: 8pt; color: #64748b; margin: 4pt 0 0; }

    .warnings-section { background: #fffbeb; border: 1px solid #fde68a; border-radius: 4pt; padding: 10pt; margin-top: 14pt; }
    .warnings-section h2 { margin-top: 0; color: #92400e; }
    .warnings-section li { margin: 4pt 0; font-size: 9pt; }

    .issue { background: #fff; border: 1px solid #e2e8f0; border-left-width: 3pt; border-radius: 4pt; padding: 10pt 12pt; margin-bottom: 8pt; page-break-inside: avoid; }
    .issue-crit { border-left-color: #b91c1c; } .issue-ser { border-left-color: #c2410c; }
    .issue-mod { border-left-color: #a16207; } .issue-min { border-left-color: #94a3b8; }
    .issue h3 { font-size: 11pt; margin: 4pt 0; }
    .issue header { display: flex; align-items: center; gap: 6pt; flex-wrap: wrap; }
    .pill { display: inline-block; padding: 1pt 6pt; border-radius: 10pt; font-size: 7.5pt; font-weight: 600; }
    .pill-crit { background: #fee2e2; color: #b91c1c; }
    .pill-ser  { background: #ffedd5; color: #c2410c; }
    .pill-mod  { background: #fef3c7; color: #a16207; }
    .pill-min  { background: #e2e8f0; color: #475569; }
    .priority-idx { color: #94a3b8; font-size: 8pt; }
    .why-what p { font-size: 10pt; margin: 4pt 0; }
    .standards-line { font-size: 8.5pt; color: #475569; margin-top: 6pt; }
    .targets { padding-left: 16pt; font-size: 8.5pt; }
    .targets li { margin: 1pt 0; }
    details { margin-top: 6pt; font-size: 9pt; }
    summary { color: #c84c0e; cursor: pointer; }

    .screenshot { max-width: 100%; border: 1px solid #e2e8f0; border-radius: 4pt; margin-top: 8pt; }

    .ftr { margin-top: 20pt; padding-top: 10pt; border-top: 1px solid #e2e8f0; font-size: 8pt; color: #94a3b8; text-align: center; }
  `;
}
