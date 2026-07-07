/**
 * ScreenshotWithBoxes — full-page screenshot with bounding-box overlays.
 *
 * Day 7  : drew every issue's bbox at all times (faint default, bold on hover).
 * Day 8  : default stroke bumped to width=2 / opacity=0.75 for readability.
 * Day 9  : OPTION A — default state shows NO boxes. Hovering an issue in the
 *          list (or clicking to lock) reveals only that issue's boxes, bold.
 *          Rationale: on dense pages (DIGIT workbench has ~35 violating
 *          elements), drawing everything by default was visually chaotic
 *          without conveying actionable info. The score and severity counts
 *          already communicate "this page has problems". The screenshot is
 *          now a *map* you query, not a heatmap.
 *
 * Coordinate math (unchanged):
 *   The screenshot is at native page resolution (e.g. 1280 × 4000+ px).
 *   In the browser we render it at some smaller width (the card width).
 *   Bounding boxes from axe are in CSS pixels at native size, so we
 *   scale them by (rendered-width / native-width). We recompute on
 *   resize so the boxes stay aligned.
 *
 * Props:
 *   - screenshotUrl: string — the /api/scan/:id/screenshot endpoint
 *   - nativeWidth, nativeHeight: number — the screenshot's native dimensions
 *   - issues: FriendlyIssue[] — full issue list (used to map IDs → boxes)
 *   - hoveredIssue, selectedIssue: { id, issue } | null — drives the reveal
 */

import { useEffect, useRef, useState } from 'react';

const SEVERITY_COLORS = {
  'Needs Immediate Fix': { stroke: '#b91c1c', fill: 'rgba(220, 38, 38, 0.15)' },
  'Important':           { stroke: '#c2410c', fill: 'rgba(234, 88, 12, 0.15)' },
  'Can Improve':         { stroke: '#a16207', fill: 'rgba(202, 138, 4, 0.15)' },
  'Minor':               { stroke: '#64748b', fill: 'rgba(100, 116, 139, 0.15)' },
};

export function ScreenshotWithBoxes({
  screenshotUrl,
  nativeWidth,
  nativeHeight,
  issues,
  hoveredIssue,
  selectedIssue,
}) {
  const containerRef = useRef(null);
  const [renderedWidth, setRenderedWidth] = useState(0);
  const [imgLoaded, setImgLoaded] = useState(false);
  const [imgError, setImgError] = useState(false);

  // Track rendered width — bbox coords need scaling from native to render size.
  useEffect(() => {
    if (!containerRef.current) return undefined;
    const el = containerRef.current;
    const measure = () => setRenderedWidth(el.clientWidth);
    measure();

    // ResizeObserver isn't guaranteed in every env (older jsdom, IE in theory).
    // Fall back to a one-shot measurement on mount if absent.
    if (typeof ResizeObserver === 'undefined') return undefined;

    const ro = new ResizeObserver(measure);
    ro.observe(el);
    return () => ro.disconnect();
  }, []);

  if (imgError) {
    return (
      <div className="card text-center py-10">
        <p className="text-3xl mb-2" aria-hidden="true">📷</p>
        <p className="text-sm font-medium text-slate-900">Screenshot not available</p>
        <p className="text-xs text-slate-500 mt-1">
          The scan completed but the screenshot file could not be loaded.
        </p>
      </div>
    );
  }

  if (!screenshotUrl || !nativeWidth || !nativeHeight) {
    return (
      <div className="card text-center py-10">
        <p className="text-sm text-slate-500">Screenshot not captured for this scan.</p>
      </div>
    );
  }

  // Which issue's boxes (if any) to reveal. Hover wins over click — if the
  // user is currently hovering something else after locking a selection, we
  // honour the hover so they can preview before committing.
  const highlightId = hoveredIssue?.id ?? selectedIssue?.id ?? null;
  const currentIssue = (hoveredIssue ?? selectedIssue)?.issue ?? null;

  // Build the full box list once so we can both filter to highlight AND
  // report total bbox count in the header (useful context: "67 elements
  // affected across all issues").
  const allBoxes = issues.flatMap((iss, i) =>
    (iss.targets ?? [])
      .filter((t) => t.boundingBox)
      .map((t, j) => ({
        id:       `${iss.ruleId}-${i}-target-${j}`,
        issueId:  `${iss.ruleId}-${i}`,
        severity: iss.severity,
        bbox:     t.boundingBox,
        selector: t.selector,
      })),
  );

  const visibleBoxes = highlightId ? allBoxes.filter((b) => b.issueId === highlightId) : [];

  return (
    <div className="card p-0 overflow-hidden">
      <div className="px-4 py-3 border-b border-slate-200 bg-slate-50 flex items-center justify-between gap-4">
        <div className="min-w-0">
          <h3 className="text-sm font-semibold text-slate-900">Page screenshot</h3>
          <p className="text-xs text-slate-500 mt-0.5">
            {currentIssue ? (
              <>
                <span className="text-brand-500 font-medium">{currentIssue.title}</span>
                {visibleBoxes.length > 0 && (
                  <>
                    {' '}— {visibleBoxes.length}{' '}
                    {visibleBoxes.length === 1 ? 'element highlighted' : 'elements highlighted'}
                  </>
                )}
              </>
            ) : (
              <>
                {issues.length} {issues.length === 1 ? 'issue' : 'issues'} on this page —{' '}
                <span className="text-slate-700 font-medium">
                  hover an issue below to see its location
                </span>
              </>
            )}
          </p>
        </div>
        <ScaleNote nativeWidth={nativeWidth} renderedWidth={renderedWidth} />
      </div>

      <div
        ref={containerRef}
        className="relative bg-slate-100 overflow-hidden"
        style={{ height: renderedWidth > 0 ? nativeHeight * (renderedWidth / nativeWidth) : 'auto', minHeight: 200 }}
      >
        <img
          src={screenshotUrl}
          alt="Full-page screenshot of the scanned URL"
          className="block w-full h-auto"
          onLoad={() => setImgLoaded(true)}
          onError={() => setImgError(true)}
        />
        {imgLoaded && renderedWidth > 0 && visibleBoxes.length > 0 && (
          <svg
            viewBox={`0 0 ${nativeWidth} ${nativeHeight}`}
            preserveAspectRatio="xMinYMin meet"
            className="absolute inset-0 w-full h-full pointer-events-none"
            aria-hidden="true"
          >
            {visibleBoxes.map((box) => {
              const colors = SEVERITY_COLORS[box.severity] ?? SEVERITY_COLORS.Minor;
              return (
                <rect
                  key={box.id}
                  x={box.bbox.x}
                  y={box.bbox.y}
                  width={box.bbox.width}
                  height={box.bbox.height}
                  stroke={colors.stroke}
                  strokeWidth={4}
                  strokeOpacity={1}
                  fill={colors.fill}
                  className="transition-all"
                />
              );
            })}
          </svg>
        )}
        {!imgLoaded && (
          <div className="absolute inset-0 flex items-center justify-center bg-slate-100">
            <p className="text-sm text-slate-500 animate-pulse">Loading screenshot…</p>
          </div>
        )}
      </div>
    </div>
  );
}

function ScaleNote({ nativeWidth, renderedWidth }) {
  if (!renderedWidth) return null;
  const pct = Math.round((renderedWidth / nativeWidth) * 100);
  return (
    <div className="text-[10px] text-slate-500 font-mono whitespace-nowrap flex-shrink-0">
      {nativeWidth}px → {Math.round(renderedWidth)}px ({pct}%)
    </div>
  );
}
