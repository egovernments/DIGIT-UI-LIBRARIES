/**
 * StartHere — the top 3 critical/serious issues to address first.
 *
 * Each issue gets a card with:
 *   - Severity icon + title
 *   - "Why it matters" paragraph
 *   - "What you can do" paragraph
 *   - Affected user groups (small chips)
 *   - Standards refs
 *   - A "Show N affected elements" disclosure (Day 7 wires up the
 *     bounding-box overlay; today this section just lists selectors)
 */

import { pillClasses } from '../lib/severity.js';

export function StartHere({ issues }) {
  if (!issues || issues.length === 0) {
    return (
      <section aria-labelledby="start-here-heading">
        <h3 id="start-here-heading" className="text-sm font-semibold text-slate-900 mb-3">
          Start here
        </h3>
        <div className="card text-center py-8">
          <p className="text-3xl mb-2" aria-hidden="true">✨</p>
          <p className="text-sm font-medium text-slate-900">No critical issues to address</p>
          <p className="text-xs text-slate-500 mt-1">This page passed all severity-critical checks.</p>
        </div>
      </section>
    );
  }

  return (
    <section aria-labelledby="start-here-heading">
      <div className="flex items-baseline justify-between mb-3">
        <h3 id="start-here-heading" className="text-sm font-semibold text-slate-900">
          Start here
        </h3>
        <span className="text-xs text-slate-500">
          {issues.length === 1 ? '1 priority issue' : `Top ${issues.length} priority issues`}
        </span>
      </div>

      <div className="space-y-3">
        {issues.map((issue, i) => (
          <IssueCard key={`${issue.ruleId}-${i}`} issue={issue} index={i + 1} />
        ))}
      </div>
    </section>
  );
}

function IssueCard({ issue, index }) {
  return (
    <article className="card hover:border-slate-300 transition-colors">
      <header className="flex items-start gap-3 mb-3">
        <span className="text-2xl leading-none mt-0.5" aria-hidden="true">{issue.icon}</span>
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1">
            <span className="text-[10px] uppercase tracking-wider text-slate-400">#{index}</span>
            <span className={pillClasses(issue.severity)}>{issue.severity}</span>
          </div>
          <h4 className="text-base font-semibold text-slate-900 leading-snug">{issue.title}</h4>
        </div>
      </header>

      <div className="space-y-3 ml-9">
        <Field label="Why it matters" body={issue.whyItMatters} />
        <Field label="What you can do" body={issue.whatYouCanDo} />

        {issue.affectedUsers?.length > 0 && (
          <div>
            <p className="text-[10px] uppercase tracking-wide text-slate-500 mb-1">Affects</p>
            <div className="flex flex-wrap gap-1.5">
              {issue.affectedUsers.map((u, i) => (
                <span
                  key={i}
                  className="inline-flex items-center gap-1 px-2 py-0.5 text-xs rounded-full bg-slate-100 text-slate-700"
                >
                  <span aria-hidden="true">{u.icon}</span>
                  <span>{u.label}</span>
                </span>
              ))}
            </div>
          </div>
        )}

        <StandardsRow standards={issue.standards} />

        {issue.targets?.length > 0 && (
          <TargetsDisclosure targets={issue.targets} />
        )}

        {issue.example && (
          <details className="group">
            <summary className="text-xs text-brand-500 hover:text-brand-600 cursor-pointer font-medium select-none">
              Show code example
            </summary>
            <pre className="mt-2 p-3 bg-slate-900 text-slate-100 text-xs font-mono rounded-md overflow-x-auto whitespace-pre">
              {issue.example}
            </pre>
          </details>
        )}
      </div>
    </article>
  );
}

function Field({ label, body }) {
  return (
    <div>
      <p className="text-[10px] uppercase tracking-wide text-slate-500 mb-1">{label}</p>
      <p className="text-sm text-slate-700 leading-relaxed">{body}</p>
    </div>
  );
}

function StandardsRow({ standards }) {
  if (!standards) return null;
  const groups = [
    { key: 'wcag',   label: 'WCAG'   },
    { key: 'gigw',   label: 'GIGW'   },
    { key: 'sesmag', label: 'SesMag' },
    { key: 'ada',    label: 'ADA'    },
  ].filter((g) => standards[g.key]?.length > 0);

  if (groups.length === 0) return null;

  return (
    <div>
      <p className="text-[10px] uppercase tracking-wide text-slate-500 mb-1">Standards</p>
      <div className="space-y-1">
        {groups.map((g) => (
          <p key={g.key} className="text-xs text-slate-600 leading-relaxed">
            <span className="font-semibold text-slate-700">{g.label}:</span>{' '}
            {standards[g.key].join(' · ')}
          </p>
        ))}
      </div>
    </div>
  );
}

function TargetsDisclosure({ targets }) {
  return (
    <details className="group">
      <summary className="text-xs text-brand-500 hover:text-brand-600 cursor-pointer font-medium select-none">
        Show {targets.length} affected {targets.length === 1 ? 'element' : 'elements'}
      </summary>
      <ul className="mt-2 space-y-1">
        {targets.slice(0, 10).map((t, i) => (
          <li key={i} className="text-xs font-mono text-slate-600 bg-slate-50 px-2 py-1 rounded break-all">
            {t.selector}
          </li>
        ))}
        {targets.length > 10 && (
          <li className="text-xs text-slate-500 italic">… and {targets.length - 10} more</li>
        )}
      </ul>
    </details>
  );
}
