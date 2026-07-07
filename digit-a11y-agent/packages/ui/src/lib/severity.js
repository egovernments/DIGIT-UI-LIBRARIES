/**
 * Severity helpers.
 *
 * The reporter assigns each issue a `SeverityLabel`:
 *   'Needs Immediate Fix' | 'Important' | 'Can Improve' | 'Minor'
 *
 * The UI maps those to a colour vocabulary defined in `tailwind.config.js`.
 * Centralising the mapping here means one source of truth.
 *
 * IMPORTANT: Tailwind's JIT scans for *literal* class strings, so all
 * helpers return literals from a static lookup — no template strings.
 */

/**
 * @typedef {'Needs Immediate Fix'|'Important'|'Can Improve'|'Minor'} SeverityLabel
 */

const SEVERITY_TONE = {
  'Needs Immediate Fix': 'critical',
  'Important':           'serious',
  'Can Improve':         'moderate',
  'Minor':               'minor',
};

const PILL_CLASS = {
  critical: 'pill-critical',
  serious:  'pill-serious',
  moderate: 'pill-moderate',
  minor:    'pill-minor',
};

const DOT_CLASS = {
  critical: 'bg-critical-dot',
  serious:  'bg-serious-dot',
  moderate: 'bg-moderate-dot',
  minor:    'bg-minor-dot',
};

const TEXT_CLASS = {
  critical: 'text-critical-text',
  serious:  'text-serious-text',
  moderate: 'text-moderate-text',
  minor:    'text-minor-text',
};

/** Tailwind class bundle for a severity pill. */
export function pillClasses(severity) {
  const tone = SEVERITY_TONE[severity] ?? 'minor';
  return PILL_CLASS[tone];
}

/** A single accent color for things like dots, borders, severity icons. */
export function dotClass(severity) {
  const tone = SEVERITY_TONE[severity] ?? 'minor';
  return DOT_CLASS[tone];
}

/** The text colour matching a severity tone. */
export function textClass(severity) {
  const tone = SEVERITY_TONE[severity] ?? 'minor';
  return TEXT_CLASS[tone];
}

/** Generic status-traffic-light for the overall score badge. */
export function scoreTone(score) {
  if (score >= 90) return { label: 'ok',   dot: 'bg-statusOk',   text: 'text-statusOk',   ring: 'ring-green-200' };
  if (score >= 70) return { label: 'warn', dot: 'bg-statusWarn', text: 'text-statusWarn', ring: 'ring-amber-200' };
  return            { label: 'bad',  dot: 'bg-statusBad',  text: 'text-statusBad',  ring: 'ring-red-200'   };
}

/** Standards-breakdown card tone based on compliance %. */
export function complianceTone(percent) {
  if (percent >= 95) return 'ok';
  if (percent >= 85) return 'warn';
  return 'bad';
}
