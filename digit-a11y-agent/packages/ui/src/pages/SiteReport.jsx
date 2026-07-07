/**
 * SiteReport page (/site/:siteId/report).
 *
 * The whole-site report. Reuses the single-page report components:
 *   - ScoreBanner       for the OVERALL score (averaged across pages)
 *   - StandardsBreakdown + StartHere + IssueList for the SITE-WIDE view
 *     (every distinct rule across all pages, one entry per rule)
 *
 * Adds a per-page section: a compact card per page (name, score, severity
 * counts) that expands to that page's own issue list. Pages that couldn't
 * be loaded (redirected / degraded) show as muted rows.
 *
 * There is no screenshot for a site scan, so IssueList runs with local
 * selection state only (no bounding-box overlay).
 */

import { useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { usePollingSite } from '../lib/usePollingSite.js';
import { getSiteExportUrl, getSitePdfUrl, getSiteScreenshotUrl } from '../lib/api.js';
import { ScoreBanner } from '../components/ScoreBanner.jsx';
import { StandardsBreakdown } from '../components/StandardsBreakdown.jsx';
import { StartHere } from '../components/StartHere.jsx';
import { IssueList } from '../components/IssueList.jsx';
import { ScreenshotWithBoxes } from '../components/ScreenshotWithBoxes.jsx';
import { scoreTone } from '../lib/severity.js';

const TOP_N = 3;

function pageName(u) {
  if (!u) return '';
  return String(u).split('/').pop().split('?')[0];
}

export function SiteReport() {
  const { siteId } = useParams();
  const { site, error } = usePollingSite(siteId);
  const [selectedIssue, setSelectedIssue] = useState(null);

  if (error) return <NotFoundCard siteId={siteId} />;
  if (!site) return <LoadingCard label="Loading report…" />;
  if (site.status === 'queued' || site.status === 'running')
    return <StillRunningCard siteId={siteId} status={site.status} />;
  if (site.status === 'failed')
    return <FailedCard siteId={siteId} error={site.error} />;

  const report = site.report;
  if (!report) return <LoadingCard label="Report not ready yet…" />;

  // Adapt the site overall into the shape ScoreBanner expects.
  const overall = {
    score:       report.overallScore,
    status:      report.overallStatus,
    keySummary:  report.keySummary,
    summaryText: report.summaryText,
    summary:     report.summary,
  };

  return (
    <div className="space-y-6">
      <ReportHeader site={site} siteId={siteId} report={report} />

      <ScoreBanner report={overall} />

      <HowToRead pageCount={report.meta?.urlCount ?? (report.pages?.length ?? 0)} />

      <StandardsBreakdown breakdown={report.standardsBreakdown} />

      <IssuesSummary issueSummary={report.issueSummary ?? []} summary={report.summary} />

      <PerPageSection pages={report.pages || []} siteId={siteId} />

      <StartHere issues={report.startHere?.slice(0, TOP_N) ?? []} />

      <IssueList
        issues={report.issues ?? []}
        selectedIssueId={selectedIssue?.id ?? null}
        onSelectIssue={(item) => setSelectedIssue((cur) => (cur?.id === item.id ? null : item))}
        onHoverIssue={() => {}}
      />
    </div>
  );
}

/* ─────────── header ─────────── */

function ReportHeader({ site, siteId, report }) {
  const m = report.meta || {};
  return (
    <header className="space-y-3">
      <div className="flex items-start justify-between gap-3">
        <div className="min-w-0">
          <p className="text-xs uppercase tracking-widest text-brand-500 font-semibold mb-1">
            Whole-site accessibility report
          </p>
          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900 tracking-tight">
            {m.scannedPageCount ?? 0} of {m.urlCount ?? 0} pages scanned
          </h1>
        </div>
      </div>
      <div className="flex flex-wrap items-center gap-x-4 gap-y-2 text-xs text-slate-500">
        <span>Scan <code className="font-mono text-slate-700">{site.siteId}</code></span>
        {site.finishedAt && <span>· Completed {new Date(site.finishedAt).toLocaleString()}</span>}
        {m.statesScanned != null && <span>· {m.statesScanned} states audited</span>}
        {report.summary?.totalIssues != null && <span>· {report.summary.totalIssues} distinct issue types</span>}
        {m.failedPageCount > 0 && (
          <span className="text-amber-700">· {m.failedPageCount} page{m.failedPageCount === 1 ? '' : 's'} couldn't load</span>
        )}
        <span className="ml-auto inline-flex items-center gap-3">
          <a href={getSiteExportUrl(siteId)} className="text-brand-500 hover:text-brand-600 font-medium inline-flex items-center gap-1" download>
            <DownloadIcon /> JSON
          </a>
          <a href={getSitePdfUrl(siteId)} className="text-brand-500 hover:text-brand-600 font-medium inline-flex items-center gap-1">
            <DownloadIcon /> PDF
          </a>
          <Link to="/" className="text-brand-500 hover:text-brand-600">New scan →</Link>
        </span>
      </div>
    </header>
  );
}

/* ─────────── how to read ─────────── */

function HowToRead({ pageCount }) {
  return (
    <section aria-labelledby="howto-heading" className="rounded-card border border-slate-200 bg-slate-50 p-4">
      <h3 id="howto-heading" className="text-sm font-semibold text-slate-900 mb-1.5">How to read this report</h3>
      <p className="text-xs text-slate-600 leading-relaxed">
        The score above is the average across all {pageCount} pages — 90+ is good, 70–89 minor work,
        50–69 needs attention, below 50 needs major fixes. Issues are grouped by severity:{' '}
        <span className="font-medium text-slate-700">critical</span> blocks some users entirely (fix first),{' '}
        <span className="font-medium text-slate-700">serious</span> makes pages hard to use, and{' '}
        <span className="font-medium text-slate-700">moderate</span>/<span className="font-medium text-slate-700">minor</span>{' '}
        are smaller improvements. Each page below shows its screenshot with on-load issues boxed; issues only
        reachable after a click are listed but not boxed. The full list at the bottom collects every distinct issue once.
      </p>
    </section>
  );
}

/* ─────────── most common issues (summary table) ─────────── */

const SUMMARY_PILL = {
  crit: 'pill-critical',
  ser:  'pill-serious',
  mod:  'pill-moderate',
  min:  'pill-minor',
};

function IssuesSummary({ issueSummary, summary }) {
  if (!issueSummary || issueSummary.length === 0) return null;
  return (
    <section aria-labelledby="summary-heading">
      <div className="flex items-baseline justify-between mb-3">
        <h3 id="summary-heading" className="text-sm font-semibold text-slate-900">Most common issues</h3>
        <span className="text-xs text-slate-500">
          {summary?.totalIssues ?? issueSummary.length} distinct types · sorted by severity
        </span>
      </div>
      <div className="rounded-card border border-slate-200 bg-white overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="text-left text-[11px] uppercase tracking-wide text-slate-500 border-b border-slate-200">
              <th className="font-medium px-4 py-2.5">Issue</th>
              <th className="font-medium px-3 py-2.5">Severity</th>
              <th className="font-medium px-3 py-2.5 text-right">Pages</th>
              <th className="font-medium px-4 py-2.5 text-right">Elements</th>
            </tr>
          </thead>
          <tbody>
            {issueSummary.map((it) => (
              <tr key={it.ruleId} className="border-b border-slate-100 last:border-0">
                <td className="px-4 py-2.5 text-slate-800">{it.title}</td>
                <td className="px-3 py-2.5">
                  <span className={SUMMARY_PILL[it.tone] ?? SUMMARY_PILL.min}>{it.severity}</span>
                </td>
                <td className="px-3 py-2.5 text-right tabular-nums text-slate-600">{it.pagesAffected}</td>
                <td className="px-4 py-2.5 text-right tabular-nums text-slate-600">{it.elements}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}

/* ─────────── per-page section ─────────── */

function PerPageSection({ pages, siteId }) {
  if (pages.length === 0) return null;
  return (
    <section aria-labelledby="per-page-heading">
      <div className="flex items-baseline justify-between mb-3">
        <h3 id="per-page-heading" className="text-sm font-semibold text-slate-900">Per-page results</h3>
        <span className="text-xs text-slate-500">{pages.length} page{pages.length === 1 ? '' : 's'} · click to expand</span>
      </div>
      <div className="space-y-2">
        {pages.map((page, i) => <PageCard key={`${page.url}-${i}`} page={page} index={i} siteId={siteId} />)}
      </div>
    </section>
  );
}

const COUNT_TONE = {
  critical: 'text-critical-text',
  serious:  'text-serious-text',
  moderate: 'text-moderate-text',
  minor:    'text-minor-text',
};

function Count({ n, label, tone }) {
  return (
    <span className={`tabular-nums ${n > 0 ? COUNT_TONE[tone] : 'text-slate-300'}`} title={`${n} ${tone}`}>
      {n}<span className="opacity-60">{label}</span>
    </span>
  );
}

function PageCard({ page, index, siteId }) {
  const [expanded, setExpanded] = useState(false);
  const [hoveredIssue, setHoveredIssue] = useState(null);
  const [selectedIssue, setSelectedIssue] = useState(null);
  const name = pageName(page.url);

  // Pages that didn't load cleanly: muted, non-expandable row.
  if (!page.summary) {
    return (
      <div className="rounded-card border border-slate-200 bg-slate-50/60 p-4">
        <div className="flex items-center justify-between gap-3">
          <p className="text-sm font-medium text-slate-700 break-all">{name}</p>
          <span className="text-xs font-medium text-amber-700 flex-shrink-0">Couldn't load ({page.loadStatus})</span>
        </div>
        {page.landed && page.landed !== page.url && (
          <p className="text-[11px] text-slate-500 mt-1 break-all font-mono">redirected to {page.landed}</p>
        )}
      </div>
    );
  }

  const tone = scoreTone(page.score);
  const s = page.summary;

  return (
    <div className="rounded-card border border-slate-200 bg-white overflow-hidden">
      <button
        type="button"
        onClick={() => setExpanded((v) => !v)}
        className="w-full flex items-center gap-4 p-4 text-left hover:bg-slate-50 transition-colors"
        aria-expanded={expanded}
      >
        <span className={`flex-shrink-0 inline-flex items-center justify-center h-12 w-12 rounded-full ring-4 ${tone.ring} ${tone.text} text-base font-bold tabular-nums`}>
          {page.score}
        </span>
        <span className="flex-1 min-w-0">
          <span className="block text-sm font-medium text-slate-900 break-all">{name}</span>
          <span className="block text-xs text-slate-500 mt-0.5">{page.status} · {s.totalIssues} issue{s.totalIssues === 1 ? '' : 's'}</span>
        </span>
        <span className="hidden sm:flex items-center gap-2.5 text-xs flex-shrink-0">
          <Count n={s.critical} label="C" tone="critical" />
          <Count n={s.serious}  label="S" tone="serious" />
          <Count n={s.moderate} label="M" tone="moderate" />
          <Count n={s.minor}    label="m" tone="minor" />
        </span>
        <svg
          className={`h-4 w-4 text-slate-400 flex-shrink-0 transition-transform ${expanded ? 'rotate-180' : ''}`}
          viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" aria-hidden="true"
        >
          <path d="M6 9l6 6 6-6" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
      </button>

      {expanded && (
        <div className="border-t border-slate-200 p-4 bg-slate-50/40 space-y-4">
          {Boolean(page.screenshot?.width && page.screenshot?.height) && (
            <ScreenshotWithBoxes
              screenshotUrl={getSiteScreenshotUrl(siteId, index)}
              nativeWidth={page.screenshot.width}
              nativeHeight={page.screenshot.height}
              issues={page.issues ?? []}
              hoveredIssue={hoveredIssue}
              selectedIssue={selectedIssue}
            />
          )}
          <IssueList
            issues={page.issues ?? []}
            selectedIssueId={selectedIssue?.id ?? null}
            onSelectIssue={(item) => setSelectedIssue((cur) => (cur?.id === item.id ? null : item))}
            onHoverIssue={setHoveredIssue}
          />
        </div>
      )}
    </div>
  );
}

function DownloadIcon() {
  return (
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" aria-hidden="true">
      <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4M7 10l5 5 5-5M12 15V3" strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  );
}

/* ─────────── state cards ─────────── */

function LoadingCard({ label }) {
  return (
    <div className="card animate-pulse text-center py-12">
      <div className="h-3 bg-slate-200 rounded w-48 mx-auto mb-2" />
      <p className="text-sm text-slate-500 mt-3">{label}</p>
    </div>
  );
}

function StillRunningCard({ siteId, status }) {
  return (
    <div className="card text-center py-10">
      <p className="text-3xl mb-3" aria-hidden="true">⏳</p>
      <h2 className="text-lg font-semibold text-slate-900">Scan still {status}</h2>
      <p className="text-sm text-slate-600 mt-1 mb-4">The report is not ready yet. We'll wait here while it finishes.</p>
      <Link to={`/site/${siteId}`} className="btn-secondary inline-flex">View progress</Link>
    </div>
  );
}

function FailedCard({ siteId, error }) {
  return (
    <div className="card text-center py-10">
      <p className="text-3xl mb-3" aria-hidden="true">⚠️</p>
      <h2 className="text-lg font-semibold text-slate-900">No report — scan failed</h2>
      <p className="text-sm text-slate-600 mt-1 mb-4 max-w-md mx-auto">
        {error?.message ?? 'The scan did not complete. Start a new scan and try again.'}
      </p>
      <div className="flex items-center justify-center gap-2">
        <Link to={`/site/${siteId}`} className="btn-secondary">View progress</Link>
        <Link to="/" className="btn-primary">Start a new scan</Link>
      </div>
    </div>
  );
}

function NotFoundCard({ siteId }) {
  return (
    <div className="card text-center py-12">
      <p className="text-3xl mb-3" aria-hidden="true">🔍</p>
      <h2 className="text-lg font-semibold text-slate-900">Site scan not found</h2>
      <p className="text-sm text-slate-600 mt-1 mb-4">
        No site scan with id <code className="font-mono">{siteId}</code> exists.
      </p>
      <Link to="/" className="btn-primary inline-flex">Start a new scan</Link>
    </div>
  );
}
