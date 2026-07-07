/**
 * StatusBadge — renders one of four scan statuses with appropriate styling.
 *
 *   queued    →  slate, neutral
 *   running   →  blue with a pulsing dot
 *   complete  →  green checkmark
 *   failed    →  red X
 *
 * Used on both the progress page and (eventually) a scan history view.
 */

const STATUS_CONFIG = {
  queued: {
    label:    'Queued',
    bg:       'bg-slate-100',
    text:     'text-slate-700',
    dot:      'bg-slate-400',
    pulse:    false,
    icon:     null,
  },
  running: {
    label:    'Running',
    bg:       'bg-blue-50',
    text:     'text-blue-800',
    dot:      'bg-blue-500',
    pulse:    true,
    icon:     null,
  },
  complete: {
    label:    'Complete',
    bg:       'bg-green-50',
    text:     'text-green-800',
    dot:      'bg-green-500',
    pulse:    false,
    icon:     '✓',
  },
  failed: {
    label:    'Failed',
    bg:       'bg-red-50',
    text:     'text-red-800',
    dot:      'bg-red-500',
    pulse:    false,
    icon:     '✗',
  },
};

export function StatusBadge({ status, size = 'md' }) {
  const cfg = STATUS_CONFIG[status] ?? STATUS_CONFIG.queued;
  const sizing = size === 'lg'
    ? 'px-3 py-1.5 text-sm'
    : 'px-2.5 py-1 text-xs';

  return (
    <span
      className={`inline-flex items-center gap-1.5 rounded-full font-medium ${sizing} ${cfg.bg} ${cfg.text}`}
      data-testid={`status-badge-${status}`}
    >
      {cfg.icon ? (
        <span className="font-bold">{cfg.icon}</span>
      ) : (
        <span className={`relative inline-block h-2 w-2 rounded-full ${cfg.dot}`}>
          {cfg.pulse && (
            <span className={`absolute inset-0 rounded-full ${cfg.dot} animate-ping opacity-75`} />
          )}
        </span>
      )}
      {cfg.label}
    </span>
  );
}
