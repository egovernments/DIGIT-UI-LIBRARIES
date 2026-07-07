/**
 * StandardsBreakdown — four cards showing compliance per standard.
 *
 * Each card has:
 *   - Standard name + description
 *   - Compliance percentage (large, colour-coded)
 *   - Rules-passed/rules-failed text
 *   - A small progress bar visualisation
 */

import { complianceTone } from '../lib/severity.js';

const STANDARDS = [
  {
    key:        'wcag',
    name:       'WCAG 2.1',
    blurb:      'Web Content Accessibility Guidelines',
    badgeText:  'W3C',
  },
  {
    key:        'gigw',
    name:       'GIGW',
    blurb:      'Guidelines for Indian Government Websites',
    badgeText:  'IN',
  },
  {
    key:        'sesmag',
    name:       'SesMag',
    blurb:      'Section 508 / EN 301 549 compatibility',
    badgeText:  'EU/US',
  },
  {
    key:        'ada',
    name:       'ADA Title III',
    blurb:      'Americans with Disabilities Act',
    badgeText:  'US',
  },
];

const TONE_CLASSES = {
  ok:   { bar: 'bg-statusOk',   text: 'text-statusOk',   ring: 'ring-green-200',  bg: 'bg-green-50' },
  warn: { bar: 'bg-statusWarn', text: 'text-statusWarn', ring: 'ring-amber-200',  bg: 'bg-amber-50' },
  bad:  { bar: 'bg-statusBad',  text: 'text-statusBad',  ring: 'ring-red-200',    bg: 'bg-red-50'   },
};

export function StandardsBreakdown({ breakdown }) {
  return (
    <section aria-labelledby="standards-heading">
      <div className="flex items-baseline justify-between mb-3">
        <h3 id="standards-heading" className="text-sm font-semibold text-slate-900">
          Standards compliance
        </h3>
        <span className="text-xs text-slate-500">By number of rules failed</span>
      </div>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-3">
        {STANDARDS.map((s) => {
          const data = breakdown?.[s.key];
          if (!data) return <StandardCard key={s.key} standard={s} data={null} />;
          return <StandardCard key={s.key} standard={s} data={data} />;
        })}
      </div>
    </section>
  );
}

function StandardCard({ standard, data }) {
  if (!data) {
    return (
      <div className="rounded-card bg-white p-4 border border-slate-200 shadow-card opacity-60">
        <p className="text-xs text-slate-500">No data for {standard.name}.</p>
      </div>
    );
  }

  const percent = Math.round(data.compliancePercent);
  const tone    = TONE_CLASSES[complianceTone(percent)];

  return (
    <div className="rounded-card bg-white p-4 border border-slate-200 shadow-card flex flex-col">
      <div className="flex items-center gap-1.5 mb-1">
        <span className={`inline-block text-[9px] px-1.5 py-0.5 rounded-sm font-bold tracking-wider ${tone.bg} ${tone.text}`}>
          {standard.badgeText}
        </span>
        <span className="text-sm font-semibold text-slate-900">{standard.name}</span>
      </div>
      <p className="text-xs text-slate-500 leading-tight mb-3">{standard.blurb}</p>

      <div className="flex items-baseline gap-1 mb-2">
        <span className={`text-3xl font-bold tabular-nums ${tone.text}`}>{percent}</span>
        <span className="text-sm text-slate-400">%</span>
      </div>

      <div className="h-1.5 bg-slate-100 rounded-full overflow-hidden mb-2">
        <div
          className={`h-full ${tone.bar} transition-all`}
          style={{ width: `${percent}%` }}
          role="progressbar"
          aria-valuenow={percent}
          aria-valuemin={0}
          aria-valuemax={100}
          aria-label={`${standard.name} compliance ${percent}%`}
        />
      </div>

      <p className="text-xs text-slate-500 tabular-nums mt-auto">
        <span className="font-medium text-slate-700">{data.rulesPassed}</span> passed
        <span className="mx-1">·</span>
        <span className={data.rulesFailed > 0 ? 'font-medium text-red-700' : 'text-slate-500'}>
          {data.rulesFailed}
        </span> failed
        <span className="mx-1">·</span>
        of {data.totalRulesChecked}
      </p>
    </div>
  );
}
