# Day 6 — Functional UI: scan form, progress page, report (top sections)

Day 5 shipped the API and an empty UI shell. Day 6 makes the tool usable from the browser end-to-end.

## What ships today

### New pages

- **Home (`/`) — rewritten.** Hero + URL input + optional auth panel + "what gets checked" footer. The API status pill moved to a small corner indicator so it doesn't dominate the page anymore.
- **Scan progress (`/scan/:scanId`) — new.** Polls `GET /api/scan/:id` every second, shows a live status badge, elapsed time, and a phase hint heuristic. Auto-navigates to the report 1.2s after completion. Handles failures, missing scans, and reconnect on transient network errors.
- **Scan report (`/scan/:scanId/report`) — new.** Renders the first three sections of the FriendlyReport:
  1. **ScoreBanner** — large score, status label, key summary, severity counts
  2. **StandardsBreakdown** — four cards (WCAG / GIGW / SesMag / ADA) with compliance %, rules passed/failed, progress bar
  3. **StartHere** — top 3 critical/serious issues with why-it-matters, what-you-can-do, affected users, and standards refs

  Day 7 will append the full issue list with bbox overlay on screenshot + PDF/JSON export.

### New components

| File | Purpose |
|---|---|
| `components/ScanForm.jsx` | URL input + auth panel + submit handling |
| `components/AuthConfigPanel.jsx` | Form/token radio + conditional fields + live validation |
| `components/FieldRows.jsx` | Repeating selector→value editor with presets (Username/Password/Email) |
| `components/StatusBadge.jsx` | Queued/running/complete/failed badge — reused across pages |
| `components/ScoreBanner.jsx` | Score + status + severity counts |
| `components/StandardsBreakdown.jsx` | Four-up standards cards |
| `components/StartHere.jsx` | Top-N priority issue cards |

### New library code

| File | Purpose |
|---|---|
| `lib/severity.js` | Severity → Tailwind class mapping (literal lookups; JIT-safe) |
| `lib/usePollingScan.js` | Polling hook with terminal-status detection and reconnect handling |

### API change (small)

`GET /api/scan/:scanId` now includes a redacted `request` field so the UI can display the target URL. **Auth credentials are stripped** — only `auth.type` and `contextStrategy` survive the round trip. Passwords, tokens, fields map, success selectors, etc. are removed before sending.

A new test file `packages/api/tests/routes-redaction.test.js` asserts the security property (4 tests).

## How to verify

1. Overlay this zip onto your existing `digit-a11y-agent` folder (it replaces a few files and adds many new ones).
2. **No new dependencies** — you should not need `pnpm install`.
3. Run `pnpm test`. Expected: **~180 tests passing** (Day 5: 159, plus 4 new API tests + ~22 new UI tests = ~185).
4. Run `pnpm dev`. Open http://localhost:5173:
   - Paste a URL (e.g. `https://www.saucedemo.com/inventory.html`)
   - Optionally expand "Add authentication" and configure form-auth
   - Click "Start scan" → lands on `/scan/scn_...` with a live status badge
   - When the scan completes (~25-50s) the page auto-navigates to the report

## Tested flows

- ✅ Public scan (no auth) — paste `https://www.saucedemo.com` and submit
- ✅ Form-authenticated scan — `https://www.saucedemo.com/inventory.html` with the standard_user/secret_sauce form auth
- ✅ DIGIT health-demo — full form-auth config (verified through the API yesterday)
- ✅ Studio UAT — same config + `contextStrategy: 'single'`
- ⏸️ Report rendering against a real failed scan — covered by tests; live spot-check tomorrow

## What's deferred to Day 7

- Full issue list (beyond top 3) with expand/collapse
- Bounding-box overlay on the page screenshot
- PDF / JSON export buttons
- API-key warning UI (when API requires a key)

## File checklist (this delta)

```
packages/ui/src/App.jsx                              (replaces Day 5)
packages/ui/src/pages/Home.jsx                       (replaces Day 5)
packages/ui/src/pages/ScanProgress.jsx               (new)
packages/ui/src/pages/ScanReport.jsx                 (new)
packages/ui/src/components/ScanForm.jsx              (new)
packages/ui/src/components/AuthConfigPanel.jsx       (new)
packages/ui/src/components/FieldRows.jsx             (new)
packages/ui/src/components/StatusBadge.jsx           (new)
packages/ui/src/components/ScoreBanner.jsx           (new)
packages/ui/src/components/StandardsBreakdown.jsx    (new)
packages/ui/src/components/StartHere.jsx             (new)
packages/ui/src/lib/severity.js                      (new)
packages/ui/src/lib/usePollingScan.js                (new)
packages/ui/tests/Home.test.jsx                      (replaces Day 5)
packages/ui/tests/ScanForm.test.jsx                  (new)
packages/ui/tests/AuthConfigPanel.test.jsx           (new)
packages/ui/tests/ScoreBanner.test.jsx               (new)
packages/ui/tests/StandardsBreakdown.test.jsx        (new)
packages/ui/tests/StartHere.test.jsx                 (new)
packages/ui/tests/usePollingScan.test.jsx            (new)
packages/api/src/routes/scan.js                      (replaces Day 5 — adds request echo + redaction)
packages/api/tests/routes-redaction.test.js          (new)
```
