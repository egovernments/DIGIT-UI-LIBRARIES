/**
 * ScoreBanner — the headline of every report.
 *
 * Big number, status label, one-sentence summary, severity counts.
 * Consumed by ScanReport. Pure presentation — receives a FriendlyReport
 * and renders the top section.
 */

import { scoreTone } from '../lib/severity.js';

const SEVERITY_ORDER = [
  { key: 'critical', label: 'Critical', tone: 'critical' },
  { key: 'serious',  label: 'Serious',  tone: 'serious'  },
  { key: 'moderate', label: 'Moderate', tone: 'moderate' },
  { key: 'minor',    label: 'Minor',    tone: 'minor'    },
];

export function ScoreBanner({ report }) {
  const tone = scoreTone(report.score);
  const { summary } = report;

  return (
    <div className="card">
      <div className="grid sm:grid-cols-[auto,1fr] gap-6 items-start">
        {/* Big number */}
        <div className="flex flex-col items-center sm:items-start">
          <div className={`relative flex items-center justify-center h-28 w-28 rounded-full ring-8 ${tone.ring}`}>
            <span className={`text-5xl font-bold tabular-nums ${tone.text}`}>{report.score}</span>
            <span className="absolute bottom-1 text-[10px] uppercase tracking-wide text-slate-400">/ 100</span>
          </div>
          <span className={`mt-3 inline-flex items-center gap-1.5 text-sm font-medium ${tone.text}`}>
            <span className={`inline-block h-2 w-2 rounded-full ${tone.dot}`} />
            {report.status}
          </span>
        </div>

        {/* Summary + counts */}
        <div className="space-y-4 min-w-0">
          <div>
            <h2 className="text-lg font-semibold text-slate-900 leading-snug">{report.keySummary}</h2>
            <p className="text-sm text-slate-600 mt-1.5 leading-relaxed">{report.summaryText}</p>
          </div>

          <dl className="grid grid-cols-2 sm:grid-cols-4 gap-2">
            <SeverityCount label="Total" value={summary.totalIssues} accent="slate" />
            {SEVERITY_ORDER.map((s) => (
              <SeverityCount
                key={s.key}
                label={s.label}
                value={summary[s.key]}
                accent={s.tone}
              />
            ))}
          </dl>
        </div>
      </div>
    </div>
  );
}

/**
 * Tailwind's JIT only picks up literal class strings, so the severity →
 * class mapping must be a static lookup (no `bg-${accent}-bg` template).
 */
const COUNT_TILE = {
  slate:    { bg: 'bg-slate-100',    text: 'text-slate-900',   border: 'border-slate-200',   label: 'text-slate-500' },
  critical: { bg: 'bg-critical-bg',  text: 'text-critical-text', border: 'border-critical-border', label: 'text-critical-text' },
  serious:  { bg: 'bg-serious-bg',   text: 'text-serious-text',  border: 'border-serious-border',  label: 'text-serious-text'  },
  moderate: { bg: 'bg-moderate-bg',  text: 'text-moderate-text', border: 'border-moderate-border', label: 'text-moderate-text' },
  minor:    { bg: 'bg-minor-bg',     text: 'text-minor-text',    border: 'border-minor-border',    label: 'text-minor-text'    },
  muted:    { bg: 'bg-slate-50',     text: 'text-slate-400',     border: 'border-slate-200',       label: 'text-slate-400'     },
};

function SeverityCount({ label, value, accent }) {
  const isTotal = accent === 'slate';
  const cfg     = (value === 0 && !isTotal) ? COUNT_TILE.muted : COUNT_TILE[accent];

  return (
    <div className={`rounded-md border px-3 py-2 ${cfg.bg} ${cfg.border}`}>
      <dt className={`text-[10px] uppercase tracking-wide ${cfg.label}`}>{label}</dt>
      <dd className={`text-2xl font-bold tabular-nums mt-0.5 ${cfg.text}`}>{value}</dd>
    </div>
  );
}
