/**
 * ScanProgress page (/scan/:scanId).
 *
 * Polls the API every second. Renders a stateful progress card with:
 *   - Status badge (queued / running / complete / failed)
 *   - Elapsed time
 *   - Phase hint ("Loading page…" / "Running checks…" — heuristic based on time)
 *   - Reconnecting indicator when the API blips
 *
 * On `complete` → auto-navigates to /scan/:scanId/report after a brief
 * delay so the success state is visible. On `failed` → keeps the user
 * on the page so they can read the error message.
 */

import { useEffect, useMemo, useState } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import { usePollingScan } from '../lib/usePollingScan.js';
import { StatusBadge } from '../components/StatusBadge.jsx';

// Rough phase-hint timeline. Just for user feedback — not authoritative.
const PHASES = [
  { atSec:  0, label: 'Initialising scan'           },
  { atSec:  3, label: 'Loading page'                },
  { atSec:  8, label: 'Authenticating'              },
  { atSec: 20, label: 'Running accessibility checks' },
  { atSec: 35, label: 'Capturing screenshot'        },
  { atSec: 50, label: 'Building report'             },
];

function getPhase(elapsedSec, status) {
  if (status === 'queued')   return 'Waiting in queue';
  if (status === 'complete') return 'Done';
  if (status === 'failed')   return 'Failed';
  // running: pick the latest phase whose atSec we've passed
  let cur = PHASES[0].label;
  for (const p of PHASES) if (elapsedSec >= p.atSec) cur = p.label;
  return cur;
}

export function ScanProgress() {
  const { scanId } = useParams();
  const navigate   = useNavigate();
  const { scan, error, reconnecting } = usePollingScan(scanId);

  // Tick once a second so the elapsed counter and phase hint update
  // even between polls.
  const [, setNowTick] = useState(0);
  useEffect(() => {
    const id = setInterval(() => setNowTick((t) => t + 1), 1000);
    return () => clearInterval(id);
  }, []);

  // Auto-navigate to report 1.2s after complete (so the green state is visible).
  useEffect(() => {
    if (scan?.status === 'complete') {
      const id = setTimeout(() => navigate(`/scan/${scanId}/report`, { replace: true }), 1200);
      return () => clearTimeout(id);
    }
    return undefined;
  }, [scan?.status, scanId, navigate]);

  const elapsedSec = useMemo(() => {
    if (!scan) return 0;
    const start = scan.startedAt ?? scan.createdAt;
    const end   = scan.finishedAt ?? Date.now();
    return Math.max(0, Math.round((end - start) / 1000));
  }, [scan]);

  if (error) return <NotFoundCard scanId={scanId} />;

  if (!scan) return <SkeletonCard />;

  return (
    <div className="space-y-6">
      <header className="flex items-center justify-between gap-3">
        <div className="min-w-0">
          <p className="text-xs text-slate-500 mb-1">Scan</p>
          <h1 className="text-xl font-bold text-slate-900 font-mono truncate">{scan.scanId}</h1>
        </div>
        <StatusBadge status={scan.status} size="lg" />
      </header>

      <div className="card">
        <dl className="grid grid-cols-2 sm:grid-cols-4 gap-4 mb-6">
          <Stat label="Target URL"  value={truncateUrl(scan.request?.url)} mono />
          <Stat label="Started"     value={scan.startedAt ? new Date(scan.startedAt).toLocaleTimeString() : '—'} />
          <Stat label="Elapsed"     value={`${elapsedSec}s`} />
          <Stat label="Status"      value={scan.status} />
        </dl>

        <Phase
          phase={getPhase(elapsedSec, scan.status)}
          status={scan.status}
          reconnecting={reconnecting}
        />

        {scan.status === 'complete' && (
          <div className="mt-6 flex items-center gap-3 p-4 rounded-md bg-green-50 border border-green-200">
            <span className="text-2xl" aria-hidden="true">✓</span>
            <div className="flex-1">
              <p className="text-sm font-medium text-green-900">Scan complete — opening report…</p>
              <p className="text-xs text-green-700 mt-0.5">
                Score {scan.report?.score} / 100 · {scan.report?.summary?.totalIssues ?? 0} issues found
              </p>
            </div>
            <Link to={`/scan/${scanId}/report`} replace className="btn-secondary text-sm">
              Open now
            </Link>
          </div>
        )}

        {scan.status === 'failed' && (
          <div className="mt-6 flex items-start gap-3 p-4 rounded-md bg-red-50 border border-red-200">
            <span className="text-xl" aria-hidden="true">⚠️</span>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-medium text-red-900">
                {scan.error?.code ?? 'Scan failed'}
              </p>
              <p className="text-sm text-red-800 mt-0.5">
                {scan.error?.message ?? 'The scan did not complete. Check the API logs for details.'}
              </p>
            </div>
          </div>
        )}
      </div>

      <div className="flex items-center justify-between">
        <Link to="/" className="text-sm text-brand-500 hover:text-brand-600">
          ← Start a new scan
        </Link>
        {scan.status === 'failed' && (
          <Link to="/" className="btn-secondary text-sm">
            Try again
          </Link>
        )}
      </div>
    </div>
  );
}

function Stat({ label, value, mono }) {
  return (
    <div>
      <dt className="text-[10px] uppercase tracking-wide text-slate-500">{label}</dt>
      <dd className={`text-sm text-slate-900 mt-1 ${mono ? 'font-mono break-all' : ''}`}>{value}</dd>
    </div>
  );
}

function Phase({ phase, status, reconnecting }) {
  const isActive = status === 'queued' || status === 'running';
  return (
    <div className="space-y-2">
      <div className="flex items-center gap-2">
        {isActive && (
          <svg className="animate-spin h-4 w-4 text-brand-500" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" aria-hidden="true">
            <circle cx="12" cy="12" r="10" opacity="0.25" />
            <path d="M22 12a10 10 0 01-10 10" strokeLinecap="round" />
          </svg>
        )}
        <p className="text-sm font-medium text-slate-900">{phase}</p>
      </div>
      {reconnecting && (
        <p className="text-xs text-amber-700 flex items-center gap-1.5">
          <span className="inline-block h-1.5 w-1.5 rounded-full bg-amber-500 animate-pulse" />
          Reconnecting to API…
        </p>
      )}
    </div>
  );
}

function SkeletonCard() {
  return (
    <div className="card animate-pulse">
      <div className="h-4 bg-slate-200 rounded w-32 mb-4" />
      <div className="h-3 bg-slate-100 rounded w-64 mb-2" />
      <div className="h-3 bg-slate-100 rounded w-48" />
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
        In Phase 1 scans live in memory and don't survive an API restart.
      </p>
      <Link to="/" className="btn-primary inline-flex">Start a new scan</Link>
    </div>
  );
}

function truncateUrl(u) {
  if (!u) return '—';
  if (u.length <= 50) return u;
  return u.slice(0, 47) + '…';
}
