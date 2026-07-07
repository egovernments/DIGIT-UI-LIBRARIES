/**
 * ScanReport page (/scan/:scanId/report).
 *
 * Day 7 update — adds:
 *   - Warnings banner at the top when meta.warnings is non-empty
 *   - finalUrl indicator when it differs from the requested URL
 *   - Screenshot with bounding-box overlay (the headline visual feature)
 *   - Full issue list, sectioned by severity
 *   - Hover/click coordination between IssueList and ScreenshotWithBoxes
 *   - Export buttons (JSON, PDF) in the header
 */

import { useMemo, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { usePollingScan } from '../lib/usePollingScan.js';
import { getScreenshotUrl, getExportUrl } from '../lib/api.js';
import { StatusBadge } from '../components/StatusBadge.jsx';
import { ScoreBanner } from '../components/ScoreBanner.jsx';
import { StandardsBreakdown } from '../components/StandardsBreakdown.jsx';
import { StartHere } from '../components/StartHere.jsx';
import { IssueList } from '../components/IssueList.jsx';
import { ScreenshotWithBoxes } from '../components/ScreenshotWithBoxes.jsx';

const TOP_N = 3;

export function ScanReport() {
  const { scanId } = useParams();
  const { scan, error } = usePollingScan(scanId);

  // Hover / selection state — IssueList writes, ScreenshotWithBoxes reads.
  const [hoveredIssue, setHoveredIssue]   = useState(null);
  const [selectedIssue, setSelectedIssue] = useState(null);

  if (error)   return <NotFoundCard scanId={scanId} />;
  if (!scan)   return <LoadingCard label="Loading report…" />;
  if (scan.status === 'queued' || scan.status === 'running')
    return <StillRunningCard scanId={scanId} status={scan.status} />;
  if (scan.status === 'failed')
    return <FailedCard scanId={scanId} error={scan.error} />;

  const { report } = scan;
  if (!report) return <LoadingCard label="Report not ready yet…" />;

  const requestedUrl = scan.request?.url;
  const finalUrl     = report.meta?.finalUrl;
  const warnings     = report.meta?.warnings ?? [];

  const hasScreenshot = Boolean(report.screenshot?.width && report.screenshot?.height);

  return (
    <div className="space-y-6">
      <ReportHeader scan={scan} scanId={scanId} />

      <WarningsBanner warnings={warnings} requestedUrl={requestedUrl} finalUrl={finalUrl} />

      <ScoreBanner report={report} />

      <StandardsBreakdown breakdown={report.standardsBreakdown} />

      <StartHere issues={report.startHere?.slice(0, TOP_N) ?? []} />

      {hasScreenshot && (
        <ScreenshotWithBoxes
          screenshotUrl={getScreenshotUrl(scanId)}
          nativeWidth={report.screenshot.width}
          nativeHeight={report.screenshot.height}
          issues={report.issues ?? []}
          hoveredIssue={hoveredIssue}
          selectedIssue={selectedIssue}
        />
      )}

      <IssueList
        issues={report.issues ?? []}
        selectedIssueId={selectedIssue?.id ?? null}
        onSelectIssue={(item) => setSelectedIssue((cur) => (cur?.id === item.id ? null : item))}
        onHoverIssue={setHoveredIssue}
      />
    </div>
  );
}

/* ─────────── sub-views ─────────── */

function ReportHeader({ scan, scanId }) {
  return (
    <header className="space-y-3">
      <div className="flex items-start justify-between gap-3">
        <div className="min-w-0">
          <p className="text-xs uppercase tracking-widest text-brand-500 font-semibold mb-1">
            Accessibility report
          </p>
          <h1 className="text-2xl sm:text-3xl font-bold text-slate-900 tracking-tight break-all">
            {scan.request?.url}
          </h1>
        </div>
        <StatusBadge status={scan.status} size="lg" />
      </div>
      <div className="flex flex-wrap items-center gap-x-4 gap-y-2 text-xs text-slate-500">
        <span>Scan <code className="font-mono text-slate-700">{scan.scanId}</code></span>
        {scan.finishedAt && <span>· Completed {new Date(scan.finishedAt).toLocaleString()}</span>}
        {scan.report?.meta?.durationMs && (
          <span>· Took {Math.round(scan.report.meta.durationMs / 1000)}s</span>
        )}
        <span className="ml-auto inline-flex items-center gap-3">
          <a
            href={getExportUrl(scanId, 'json')}
            className="text-brand-500 hover:text-brand-600 font-medium inline-flex items-center gap-1"
            download
          >
            <DownloadIcon /> JSON
          </a>
          <a
            href={getExportUrl(scanId, 'pdf')}
            className="text-brand-500 hover:text-brand-600 font-medium inline-flex items-center gap-1"
          >
            <DownloadIcon /> PDF
          </a>
          <Link to="/" className="text-brand-500 hover:text-brand-600">New scan →</Link>
        </span>
      </div>
    </header>
  );
}

function WarningsBanner({ warnings, requestedUrl, finalUrl }) {
  const navigatedAway = finalUrl && requestedUrl && finalUrl !== requestedUrl;
  if (warnings.length === 0 && !navigatedAway) return null;

  const showFinalUrl = navigatedAway && finalUrl;

  return (
    <div className="card border-amber-200 bg-amber-50/60">
      <div className="flex items-start gap-3">
        <span className="text-xl leading-none mt-0.5" aria-hidden="true">⚠️</span>
        <div className="flex-1 min-w-0 space-y-2">
          <p className="text-sm font-semibold text-amber-900">
            Scanner notes — please review before trusting the score
          </p>

          {showFinalUrl && (
            <div className="text-sm text-amber-900">
              <p>The scan was redirected during loading:</p>
              <p className="text-xs font-mono mt-1 break-all">
                <span className="opacity-60">requested</span> {requestedUrl}<br />
                <span className="opacity-60">scanned</span>{'   '}{finalUrl}
              </p>
            </div>
          )}

          {warnings.length > 0 && (
            <ul className="space-y-1.5">
              {warnings.map((w, i) => (
                <li key={i} className="text-xs text-amber-900 leading-relaxed">
                  <span className="font-semibold font-mono text-amber-800">{w.code}:</span> {w.message}
                </li>
              ))}
            </ul>
          )}
        </div>
      </div>
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

function LoadingCard({ label }) {
  return (
    <div className="card animate-pulse text-center py-12">
      <div className="h-3 bg-slate-200 rounded w-48 mx-auto mb-2" />
      <p className="text-sm text-slate-500 mt-3">{label}</p>
    </div>
  );
}

function StillRunningCard({ scanId, status }) {
  return (
    <div className="card text-center py-10">
      <p className="text-3xl mb-3" aria-hidden="true">⏳</p>
      <h2 className="text-lg font-semibold text-slate-900">Scan still {status}</h2>
      <p className="text-sm text-slate-600 mt-1 mb-4">
        The report is not ready yet. We'll wait here while it finishes.
      </p>
      <Link to={`/scan/${scanId}`} className="btn-secondary inline-flex">View progress</Link>
    </div>
  );
}

function FailedCard({ scanId, error }) {
  return (
    <div className="card text-center py-10">
      <p className="text-3xl mb-3" aria-hidden="true">⚠️</p>
      <h2 className="text-lg font-semibold text-slate-900">No report — scan failed</h2>
      <p className="text-sm text-slate-600 mt-1 mb-4 max-w-md mx-auto">
        {error?.message ?? 'The scan did not complete. Start a new scan and try again.'}
      </p>
      <div className="flex items-center justify-center gap-2">
        <Link to={`/scan/${scanId}`} className="btn-secondary">View progress</Link>
        <Link to="/" className="btn-primary">Start a new scan</Link>
      </div>
    </div>
  );
}

function NotFoundCard({ scanId }) {
  return (
    <div className="card text-center py-12">
      <p className="text-3xl mb-3" aria-hidden="true">🔍</p>
      <h2 className="text-lg font-semibold text-slate-900">Scan not found</h2>
      <p className="text-sm text-slate-600 mt-1 mb-4">
        No scan with id <code className="font-mono">{scanId}</code> exists.
      </p>
      <Link to="/" className="btn-primary inline-flex">Start a new scan</Link>
    </div>
  );
}
