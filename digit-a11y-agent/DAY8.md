# Day 8 — Phase 1 closeout

Polish, validation, documentation. No new features that change the data model; everything here completes Phase 1 as a shippable thing.

## What ships today

### New: Per-scan timeout in the UI

In `components/ScanForm.jsx`, the previous "Wait for element on target page" field now lives inside an **Advanced options** expander alongside a new **Scan timeout (seconds)** field. Users can set a per-scan timeout without needing to restart the API with an env var. Useful for DIGIT scans that need 90-150s rather than the 60s default.

### New: DIGIT preset button

New component `components/DigitPresetButton.jsx`, positioned next to the URL input on the home page. Opens a small menu listing known DIGIT scan configurations (health-demo console, Studio UAT service designer). Clicking a preset pre-fills the URL, the wait-for-element, the scan timeout, and the entire auth panel — leaving only credentials for the user to type. Credentials are deliberately empty in the preset definitions for security.

Receiver-side: `AuthConfigPanel` now accepts a `preset` prop. A `useEffect` watches it and merges preset values into internal state when one is applied. Existing typed credentials for selectors in the preset are preserved (we don't blow them away on re-apply).

### New: Live DIGIT integration test (opt-in)

New file `packages/scanner/tests/digit-live.test.js`. Runs the full scanner pipeline against `health-demo.digit.org` — real network, real browser, real axe scan. Opt-in via env var:

```bash
DIGIT_LIVE_TESTS=1 pnpm test     # or
pnpm test:live                   # alias
```

Skipped by default so CI doesn't fail when DIGIT is moody. Confirms the public-page path works end-to-end.

### Polish: bbox readability

In `components/ScreenshotWithBoxes.jsx`, default bbox stroke went from `width=1.5 / opacity=0.5` to `width=2 / opacity=0.75`. Highlighted boxes (hovered/clicked) still get `width=4 / opacity=1`. The boxes now read clearly against light backgrounds without needing hover.

### Polish: header link

In `components/Layout.jsx`, the placeholder "Docs" link that pointed at `github.com` now reads "Repo" and points at the eGov repo. Also adds a small "Phase 1 · v0.1.0" version label so visitors know what they're looking at.

### Improved: Docker setup

- Added `.dockerignore` — excludes node_modules, .git, artifacts, dev notes, env files
- Bumped Playwright base image from `v1.44.0-jammy` to `v1.47.2-jammy` to match the playwright version in package.json (was previously mismatched, would have caused "executable not found" errors)
- `docker-compose.yml` now uses `vite preview` correctly (with the right flags) and adds a healthcheck on the API service so the UI waits for the API to be ready

### New: README

Full rewrite. "What it does" up top in plain language, then "Quick start (5 minutes)", architecture diagram, configuration table, deployment instructions, and a Troubleshooting section that captures the gotchas we hit during development (DIGIT timing, Studio UAT context strategy, SCAN_TIMEOUT, PAGE_NOT_READY).

### New: PHASE1_RETROSPECTIVE.md

Notes for whoever picks this up in Phase 2 — what we built, what we learned, decisions worth knowing, things that didn't go to plan, what's deferred. Honest, including the bugs and missteps.

## Tests added

- `packages/scanner/tests/digit-live.test.js` — 2 live tests + 1 always-runs meta test (3 total; 2 skipped in default mode)
- `packages/ui/tests/DigitPresetButton.test.jsx` — 6 tests (menu open/close, preset list, onApply callback, security check on no credentials, contract check on required preset fields)

**Total: +9 tests** (3 live, 6 unit). Expected suite default-mode count: **229 passing**, 2 live-tests skipped (visible).

## What's NOT here (deliberately)

- **TypeScript migration** — Phase 2 chore
- **Browser pool for PDF** — current 8s acceptable for v1
- **Per-page scan timeout from API endpoints** — already supported via `options.timeoutMs`; UI now exposes it (this day's work)
- **Visual regression tests for the report UI** — Phase 2 nice-to-have

## Verification checklist

1. `pnpm install` — picks up any minor dep changes
2. `pnpm test` — all green, 229 passing, 2 skipped
3. `pnpm test:live` (with internet + DIGIT reachable) — 231 passing
4. `pnpm dev` — both servers up
5. Home page — Repo link in header, "Use DIGIT preset" button next to URL field
6. Click preset → form fills, expanded auth panel shows the right config; type credentials and submit
7. Scan a public URL (saucedemo) → bbox overlay shows clearer boxes than Day 7
8. `docker compose up --build` — both services come up cleanly from a fresh checkout

## Phase 1 closes here

Phase 1 = the tool works against real DIGIT, has structured output, is deployable, is documented. All four are now true.

Phase 2 work (history, comparison, crawling, OAuth) waits for someone to start it. The retrospective doc has a "Where to start for Phase 2" section.
