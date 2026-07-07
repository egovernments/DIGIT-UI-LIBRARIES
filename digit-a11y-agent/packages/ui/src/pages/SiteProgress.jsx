/**
 * SiteProgress page (/site/:siteId).
 *
 * Polls the site-scan API and shows REAL per-page progress: a row per sitemap
 * URL that moves queued → scanning… → scanned ✓ / failed, plus an overall
 * rollup (bar + done/total + states audited). This works for both sequential
 * and parallel scans — under concurrency several rows are "scanning…" at once.
 *
 * Scores are NOT shown here; they appear on the report.
 *
 * On `complete` → auto-navigates to /site/:siteId/report after a brief beat.
 * On `failed` → stays so the error is readable.
 */

import { useEffect } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import { usePollingSite } from '../lib/usePollingSite.js';
import { StatusBadge } from '../components/StatusBadge.jsx';

function pageName(u) {
  if (!u) return '';
  return String(u).split('/').pop().split('?')[0];
}

function isFailish(status) {
  return status === 'error' || status === 'degraded' || status === 'redirected' || status === 'failed';
}

export function SiteProgress() {
  const { siteId } = useParams();
  const navigate   = useNavigate();
  const { site, error, reconnecting } = usePollingSite(siteId);

  useEffect(() => {
    if (site?.status === 'complete') {
      const id = setTimeout(() => navigate(`/site/${siteId}/report`, { replace: true }), 1200);
      return () => clearTimeout(id);
    }
    return undefined;
  }, [site?.status, siteId, navigate]);

  if (error)  return <NotFoundCard siteId={siteId} />;
  if (!site)  return <SkeletonCard />;

  const p = site.progress || {};
  // Prefer live per-page rows; fall back to the request URLs as "queued" on the
  // very first poll, before the runner has seeded progress.
  const rows = (Array.isArray(p.pages) && p.pages.length)
    ? p.pages
    : (site.request?.urls ?? []).map((u) => ({ url: typeof u === 'string' ? u : u.url, status: 'queued', states: 0 }));

  const total     = p.total ?? rows.length;
  const completed = p.completed ?? rows.filter((r) => r.status === 'scanned' || isFailish(r.status)).length;
  const pct       = total ? Math.min(100, Math.round((completed / total) * 100)) : 0;
  const isActive  = site.status === 'queued' || site.status === 'running';

  return (
    <div className="space-y-6">
      <header className="flex items-center justify-between gap-3">
        <div className="min-w-0">
          <p className="text-xs text-slate-500 mb-1">Whole-site scan</p>
          <h1 className="text-xl font-bold text-slate-900 font-mono truncate">{site.siteId}</h1>
        </div>
        <StatusBadge status={site.status} size="lg" />
      </header>

      <div className="card">
        <dl className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-6">
          <Stat label="Pages" value={total || '—'} />
          <Stat label="Done" value={total ? `${completed} / ${total}` : '—'} />
          <Stat label="States scanned" value={p.statesScanned ?? 0} />
          <Stat label="Status" value={site.status} />
        </dl>

        {isActive && (
          <div className="space-y-2 mb-5">
            <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
              <div
                className="h-full bg-brand-500 transition-all duration-500"
                style={{ width: `${pct}%` }}
                role="progressbar"
                aria-valuenow={pct}
                aria-valuemin={0}
                aria-valuemax={100}
                aria-label="Scan progress"
              />
            </div>
            <div className="flex items-center justify-between text-xs text-slate-500 tabular-nums">
              <span>{pct}%</span>
              {reconnecting && (
                <span className="text-amber-700 flex items-center gap-1.5">
                  <span className="inline-block h-1.5 w-1.5 rounded-full bg-amber-500 animate-pulse" />
                  Reconnecting…
                </span>
              )}
            </div>
          </div>
        )}

        <ul className="divide-y divide-slate-100 border border-slate-200 rounded-md overflow-hidden">
          {rows.map((r, i) => <PageRow key={`${r.url}-${i}`} row={r} />)}
        </ul>

        {site.status === 'complete' && (
          <div className="mt-6 flex items-center gap-3 p-4 rounded-md bg-green-50 border border-green-200">
            <span className="text-2xl" aria-hidden="true">✓</span>
            <div className="flex-1">
              <p className="text-sm font-medium text-green-900">Scan complete — opening report…</p>
              <p className="text-xs text-green-700 mt-0.5">
                Overall score {site.report?.overallScore} / 100 · {site.report?.summary?.totalIssues ?? 0} issues · {site.report?.meta?.scannedPageCount ?? 0} pages
              </p>
            </div>
            <Link to={`/site/${siteId}/report`} replace className="btn-secondary text-sm">Open now</Link>
          </div>
        )}

        {site.status === 'failed' && (
          <div className="mt-6 flex items-start gap-3 p-4 rounded-md bg-red-50 border border-red-200">
            <span className="text-xl" aria-hidden="true">⚠️</span>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium text-red-900">{site.error?.code ?? 'Scan failed'}</p>
              <p className="text-sm text-red-800 mt-0.5">
                {site.error?.message ?? 'The scan did not complete. Check the API logs for details.'}
              </p>
            </div>
          </div>
        )}
      </div>

      <div className="flex items-center justify-between">
        <Link to="/" className="text-sm text-brand-500 hover:text-brand-600">← Start a new scan</Link>
        {site.status === 'failed' && <Link to="/" className="btn-secondary text-sm">Try again</Link>}
      </div>
    </div>
  );
}

function Stat({ label, value }) {
  return (
    <div>
      <dt className="text-[10px] uppercase tracking-wide text-slate-500">{label}</dt>
      <dd className="text-sm text-slate-900 mt-1 tabular-nums">{value}</dd>
    </div>
  );
}

function PageRow({ row }) {
  const name = pageName(row.url);
  const status = row.status || 'queued';
  return (
    <li className="flex items-center gap-3 px-3 py-2.5 bg-white">
      <StatusDot status={status} />
      <span className="flex-1 min-w-0 text-sm text-slate-800 truncate" title={row.url}>{name}</span>
      <StatusText row={row} />
    </li>
  );
}

function StatusDot({ status }) {
  if (status === 'scanning') {
    return (
      <svg className="animate-spin h-4 w-4 text-brand-500 flex-shrink-0" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" aria-hidden="true">
        <circle cx="12" cy="12" r="10" opacity="0.25" />
        <path d="M22 12a10 10 0 01-10 10" strokeLinecap="round" />
      </svg>
    );
  }
  if (status === 'scanned') {
    return (
      <span className="flex-shrink-0 h-4 w-4 rounded-full bg-green-100 text-green-700 flex items-center justify-center text-[11px] font-bold" aria-hidden="true">✓</span>
    );
  }
  if (isFailish(status)) {
    return (
      <span className="flex-shrink-0 h-4 w-4 rounded-full bg-amber-100 text-amber-700 flex items-center justify-center text-[11px] font-bold" aria-hidden="true">!</span>
    );
  }
  return <span className="flex-shrink-0 h-2 w-2 rounded-full bg-slate-300 mx-1" aria-hidden="true" />;
}

function StatusText({ row }) {
  const s = row.status || 'queued';
  const n = row.states ?? 0;
  if (s === 'scanning') return <span className="text-xs text-brand-600 flex-shrink-0">Scanning…</span>;
  if (s === 'scanned')  return <span className="text-xs text-slate-500 flex-shrink-0 tabular-nums">Scanned · {n} state{n === 1 ? '' : 's'}</span>;
  if (isFailish(s))     return <span className="text-xs text-amber-700 flex-shrink-0">{s}</span>;
  return <span className="text-xs text-slate-400 flex-shrink-0">Queued</span>;
}

function SkeletonCard() {
  return (
    <div className="card animate-pulse">
      <div className="h-4 bg-slate-200 rounded w-40 mb-4" />
      <div className="h-3 bg-slate-100 rounded w-64 mb-2" />
      <div className="h-3 bg-slate-100 rounded w-48" />
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
        In Phase 1 scans live in memory and don't survive an API restart.
      </p>
      <Link to="/" className="btn-primary inline-flex">Start a new scan</Link>
    </div>
  );
}
