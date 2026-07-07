# Day 7 — Full issue list, bounding-box overlay, PDF/JSON export

Day 6 shipped a usable end-to-end flow with the top-3 issues. Day 7 makes the report comprehensive — every issue, visualised on the screenshot, exportable as PDF or JSON.

## What ships today

### New: Full issue list (`components/IssueList.jsx`)
Sectioned by severity (Needs Immediate Fix / Important / Can Improve / Minor). Top two sections expanded by default; lower severities collapse. Each issue has a per-row "Details" toggle that reveals what-you-can-do, standards refs, and the full selector list. Clicking an issue selects it (drives the screenshot bbox highlight); hovering previews.

### New: Bounding-box overlay (`components/ScreenshotWithBoxes.jsx`)
Full-page screenshot rendered with every issue's bounding box drawn as an SVG `<rect>`. Boxes are severity-coloured (critical-red, serious-orange, moderate-amber, minor-grey). Hover an issue in the list → its box highlights (thicker stroke + fill). Click to lock the highlight. Coordinate math: a `ResizeObserver` tracks the rendered width and scales bbox coords from native (e.g. 1280×4000px) to whatever the card actually renders at.

### New: Exports (PDF + JSON)
- `GET /api/scan/:id/export.json` — full FriendlyReport wrapped with `scanId`, redacted `request`, and `durationMs`. Browser downloads as `{scanId}-report.json`.
- `GET /api/scan/:id/export.pdf` — server-side rendered HTML printed to PDF via Chromium. Includes score, standards, warnings, all issues, and the embedded screenshot. Heavier (~5-10s per call) — Phase 2 will pool the browser.

### Updated: Report page (`pages/ScanReport.jsx`)
Now renders ScoreBanner + StandardsBreakdown + StartHere + **ScreenshotWithBoxes** + **IssueList** (in that order). Header gets two new download links (JSON, PDF) alongside the existing "Start a new scan" link.

### Updated: API client (`lib/api.js`)
Two new helpers: `getScreenshotUrl(scanId)` and `getExportUrl(scanId, format)`. Both return relative URLs that the browser follows directly (`<img src>`, `<a href>`), no JSON deserialisation needed.

### Updated: API scan route (`routes/scan.js`)
Adds:
- `GET /:scanId/screenshot` — streams the PNG with `Content-Type: image/png`, includes `X-Image-Width` / `X-Image-Height` headers for debug. Path safety: the screenshot path is taken from the job's report (written by the scanner), never from user input.
- `GET /:scanId/export.json` — described above.
- `GET /:scanId/export.pdf` — described above.

### Polish: Warnings banner + finalUrl indicator
When `meta.warnings` is non-empty (e.g. `navigated-away`, `network-not-idle`, `bounding-boxes-partial`), the report shows an amber banner at the top with each warning's code + message. If the scanner's `meta.finalUrl` differs from the requested URL, the banner highlights the redirect specifically. Closes the loop on the Day 6 redirect-detection fix — users now *see* the warning rather than just having it in the API response.

### Polish: Placeholder UX fix in AuthConfigPanel
All placeholder strings now prefixed with "e.g. " so they're obviously examples rather than defaults. The "Success — URL match" placeholder also notes "(leave blank if using selector)" to prevent the trap that bit us with the workbench scan.

## Dependency change

Added `playwright` to `packages/api/package.json` dependencies. The scanner package already pulls it in, but the API now imports `playwright` directly (for PDF generation via `chromium.launch()`), so it must be declared at this level to be reliably resolved in a strict pnpm workspace.

After overlaying this snapshot, **run `pnpm install`** before `pnpm test` or `pnpm dev`.

## Tests added

- `packages/ui/tests/IssueList.test.jsx` — 9 tests (empty state, sectioning, default-open behaviour, expand/collapse, hover/select callbacks, count display, details toggle)
- `packages/ui/tests/ScreenshotWithBoxes.test.jsx` — 5 tests (empty/error states, header counts, hovered-issue display, image element wiring)
- `packages/api/tests/routes-export.test.js` — 9 tests (404s for unknown scans, 400 for not-ready, PNG streaming with correct headers, JSON export shape + redaction, PDF mocked)

Total: **+23 tests**. Expected suite after install: **~220 passing**.

## Manual verification checklist

1. `pnpm install` — picks up the new playwright dep at the API level
2. `pnpm test` — all green
3. `pnpm dev` — both servers boot
4. Run a saucedemo scan — visit the report, confirm:
   - Score banner intact
   - Standards cards intact
   - Top-3 issues intact
   - **NEW**: Screenshot section appears below "Start here" with bbox overlays
   - **NEW**: Hovering an issue in the "All issues" list highlights its box on the screenshot
   - **NEW**: "JSON" and "PDF" download links in the header work
5. Run a DIGIT scan with `text=My Campaigns` in the wait-for-element field — the warnings banner appears if anything weird happened

## Carried into Day 8

- Integration tests against live DIGIT
- Docker build verification
- README with screenshots
- Per-scan timeout exposure in the UI
- "Docs" link in Layout pointed at the real repo
- Optional: DIGIT auth-config preset button
