/**
 * IssueList — full list of all issues, sectioned by severity.
 *
 * The Day 6 "Start Here" component shows only the top 3. This component is
 * the comprehensive view: every issue, grouped into Critical / Serious /
 * Moderate / Minor sections. Each section collapses by default if it has
 * no issues; non-empty sections are expanded.
 *
 * Each issue is selectable. Selection lifts up via the `onSelectIssue`
 * callback — the parent (ScanReport) uses it to drive the bbox-overlay
 * on the screenshot. The currently-selected issue ID comes back in via
 * `selectedIssueId` so this component can apply a highlight ring.
 *
 * Day 9 fix: the ID we send up to ScanReport (which propagates to
 * ScreenshotWithBoxes) must use the GLOBAL position in `issues`, not the
 * position within a severity section. ScreenshotWithBoxes generates its
 * box IDs by iterating the full sorted `issues` array, so per-section
 * indices only happened to match for Critical issues (which sort first).
 * For Important / Can Improve / Minor sections, the indices diverged and
 * the hover-to-highlight chain silently broke. Tagging each issue with
 * its global index BEFORE we split into sections is the single fix.
 */

import { useState } from 'react';
import { pillClasses } from '../lib/severity.js';

const SECTIONS = [
  { key: 'critical', label: 'Needs Immediate Fix', tone: 'critical',
    match: (sev) => sev === 'Needs Immediate Fix' },
  { key: 'serious',  label: 'Important',           tone: 'serious',
    match: (sev) => sev === 'Important' },
  { key: 'moderate', label: 'Can Improve',         tone: 'moderate',
    match: (sev) => sev === 'Can Improve' },
  { key: 'minor',    label: 'Minor',               tone: 'minor',
    match: (sev) => sev === 'Minor' },
];

export function IssueList({ issues, selectedIssueId, onSelectIssue, onHoverIssue }) {
  if (!issues || issues.length === 0) {
    return (
      <section aria-labelledby="all-issues-heading">
        <h3 id="all-issues-heading" className="text-sm font-semibold text-slate-900 mb-3">
          All issues
        </h3>
        <div className="card text-center py-8">
          <p className="text-3xl mb-2" aria-hidden="true">✨</p>
          <p className="text-sm font-medium text-slate-900">No accessibility issues found</p>
          <p className="text-xs text-slate-500 mt-1">This page passed every rule the scanner checked.</p>
        </div>
      </section>
    );
  }

  // Tag every issue with its position in the global sorted array BEFORE we
  // split into severity sections. ScreenshotWithBoxes uses the same global
  // index when building its box IDs, so this keeps hover/select highlights
  // working across all severities (previously only Critical worked because
  // its section-index happened to equal its global-index).
  const issuesWithIndex = issues.map((iss, _globalIndex) => ({ ...iss, _globalIndex }));

  const sections = SECTIONS.map((s) => ({
    ...s,
    items: issuesWithIndex.filter((iss) => s.match(iss.severity)),
  })).filter((s) => s.items.length > 0);

  return (
    <section aria-labelledby="all-issues-heading">
      <div className="flex items-baseline justify-between mb-3">
        <h3 id="all-issues-heading" className="text-sm font-semibold text-slate-900">
          All issues
        </h3>
        <span className="text-xs text-slate-500">
          {issues.length} total · sorted by severity
        </span>
      </div>

      <div className="space-y-4">
        {sections.map((section) => (
          <SeveritySection
            key={section.key}
            section={section}
            selectedIssueId={selectedIssueId}
            onSelectIssue={onSelectIssue}
            onHoverIssue={onHoverIssue}
          />
        ))}
      </div>
    </section>
  );
}

function SeveritySection({ section, selectedIssueId, onSelectIssue, onHoverIssue }) {
  const [open, setOpen] = useState(section.key === 'critical' || section.key === 'serious');

  return (
    <div className="card overflow-hidden p-0">
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        className="w-full flex items-center justify-between gap-3 px-4 py-3 hover:bg-slate-50 transition-colors text-left"
        aria-expanded={open}
      >
        <div className="flex items-center gap-2.5">
          <span className={pillClasses(section.label)}>{section.label}</span>
          <span className="text-sm text-slate-700">
            {section.items.length} {section.items.length === 1 ? 'issue' : 'issues'}
          </span>
        </div>
        <span className={`text-slate-400 text-xs transition-transform ${open ? 'rotate-90' : ''}`}>
          ▶
        </span>
      </button>

      {open && (
        <div className="border-t border-slate-200 divide-y divide-slate-100">
          {section.items.map((iss) => {
            // iss._globalIndex was attached by IssueList before splitting into
            // sections. Use it (not the per-section position) so the ID we
            // emit matches the box IDs in ScreenshotWithBoxes.
            const id = `${iss.ruleId}-${iss._globalIndex}`;
            return (
              <IssueRow
                key={id}
                issue={iss}
                isSelected={selectedIssueId === id}
                onSelect={() => onSelectIssue?.({ id, issue: iss })}
                onHover={(entering) => onHoverIssue?.(entering ? { id, issue: iss } : null)}
              />
            );
          })}
        </div>
      )}
    </div>
  );
}

function IssueRow({ issue, isSelected, onSelect, onHover }) {
  const [expanded, setExpanded] = useState(false);

  return (
    <div
      className={`px-4 py-3 transition-colors cursor-pointer ${
        isSelected ? 'bg-brand-50' : 'hover:bg-slate-50'
      }`}
      onClick={onSelect}
      onMouseEnter={() => onHover(true)}
      onMouseLeave={() => onHover(false)}
    >
      <div className="flex items-start gap-3">
        <span className="text-lg leading-none mt-0.5" aria-hidden="true">{issue.icon}</span>
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 flex-wrap">
            <h4 className="text-sm font-semibold text-slate-900 leading-snug">{issue.title}</h4>
            {issue.targets?.length > 0 && (
              <span className="text-xs text-slate-500">
                {issue.targets.length} {issue.targets.length === 1 ? 'element' : 'elements'}
              </span>
            )}
          </div>
          <p className="text-xs text-slate-600 mt-1 leading-relaxed line-clamp-2">
            {issue.whyItMatters}
          </p>

          {expanded && (
            <div className="mt-3 space-y-2 text-xs text-slate-700">
              <p>
                <span className="font-semibold text-slate-900">What you can do: </span>
                {issue.whatYouCanDo}
              </p>
              {issue.standards && Object.entries(issue.standards).some(([_, refs]) => refs?.length > 0) && (
                <p className="text-slate-600">
                  <span className="font-semibold text-slate-900">Standards: </span>
                  {Object.entries(issue.standards)
                    .filter(([_, refs]) => refs?.length > 0)
                    .map(([k, refs]) => `${k.toUpperCase()} ${refs.join(', ')}`)
                    .join(' · ')}
                </p>
              )}
              {issue.targets?.length > 0 && (
                <div>
                  <p className="font-semibold text-slate-900 mb-1">Affected selectors:</p>
                  <ul className="space-y-0.5">
                    {issue.targets.slice(0, 8).map((t, i) => (
                      <li key={i} className="font-mono text-[11px] bg-slate-50 px-2 py-1 rounded break-all">
                        {t.selector}
                      </li>
                    ))}
                    {issue.targets.length > 8 && (
                      <li className="italic text-slate-500">… and {issue.targets.length - 8} more</li>
                    )}
                  </ul>
                </div>
              )}
            </div>
          )}
        </div>

        <button
          type="button"
          onClick={(e) => { e.stopPropagation(); setExpanded((v) => !v); }}
          className="text-xs text-brand-500 hover:text-brand-600 flex-shrink-0 mt-0.5"
          aria-label={expanded ? 'Show less' : 'Show more'}
        >
          {expanded ? 'Less' : 'Details'}
        </button>
      </div>
    </div>
  );
}
