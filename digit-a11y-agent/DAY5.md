# Day 5 — API server + UI scaffolding

Phase 1, Day 5 of 16. Adds the HTTP API layer and the UI shell.

## What's new

### `@digit-a11y/api` — Express HTTP server

Wraps the scanner+reporter behind a small REST surface so the UI (and any
external automation) can drive scans without writing Node.

| Endpoint | Method | Purpose |
|---|---|---|
| `/api/health` | GET | Liveness check; returns version, uptime, job stats |
| `/api/scan` | POST | Enqueue a scan; returns 202 + `scanId` immediately |
| `/api/scan/:scanId` | GET | Poll for status (`queued`/`running`/`complete`/`failed`) |

Features:

- **zod request validation** — bad inputs get 400s with structured `details.issues`, never crashes
- **API-key auth** — required in prod (`API_KEY` env), disabled in dev for convenience
- **CORS** — allows the UI's dev origin out of the box
- **pino logging** — pretty in dev, JSON in prod; secrets redacted
- **In-memory job store** — Phase 1; SQLite swap in Phase 2 is a single-file change
- **Scan timeout enforcement** — 60s default, configurable via `SCAN_TIMEOUT_MS`
- **Graceful shutdown** — Ctrl-C/SIGTERM closes the HTTP listener cleanly

### `@digit-a11y/ui` — Vite + React + Tailwind shell

The empty stage for Days 6-7. What's working today:

- Vite dev server with hot reload on `:5173`
- `/api` proxy to the local API server (no CORS friction)
- Tailwind + design tokens (brand orange + severity palette)
- React Router routing skeleton
- Home page with **live API health indicator** (calls `/api/health`)
- A roadmap card for each upcoming Day so anyone opening the page sees the trajectory

The Home page is intentionally light — Day 6 brings the scan form, Day 7 the report view.

## How to verify

From the repo root:

```bash
pnpm install            # picks up new @digit-a11y/api and @digit-a11y/ui packages
pnpm test               # runs all tests across the monorepo
pnpm dev                # starts both API (:3000) and UI (:5173) in parallel
```

Once `pnpm dev` is running:

```bash
# API liveness
curl http://localhost:3000/api/health

# Enqueue a scan (no auth needed in dev)
curl -X POST http://localhost:3000/api/scan \
  -H "content-type: application/json" \
  -d '{"url":"https://www.saucedemo.com"}'

# → { "scanId": "scn_...", "status": "queued", "statusUrl": "/api/scan/scn_..." }

# Poll for the result (substitute the scanId from above)
curl http://localhost:3000/api/scan/scn_abc123
```

And open **http://localhost:5173** in a browser. You should see:

- The DIGIT Accessibility Scanner branded header
- A hero card explaining what the tool does
- An **API server connection** card showing "Connected · v0.1.0 · uptime"
- Three "Coming soon" cards for Days 6, 7, and 8

## Test coverage

| Package | New tests | Total |
|---|---|---|
| `reporter` (unchanged) | — | 41 |
| `scanner` (unchanged) | — | 77 |
| `api` (new) | 30 | 30 |
| `ui` (new) | 11 | 11 |
| **Total** | **41 new** | **159** |

Day 4 ended at 118 tests; Day 5 ships 159.

## Things to know

- **Dev mode skips the API key** (`NODE_ENV !== 'production'` ⇒ auth off). When you containerize for staging, set `API_KEY=<something>` and the middleware turns on automatically.
- **Jobs evaporate on restart** in Phase 1 (in-memory only). Phase 2 swaps in SQLite — design intentional, swap surface intentionally narrow.
- **Scans still launch a real browser**, just from inside the API process now. If you don't have Playwright's Chromium installed yet, run `pnpm exec playwright install chromium` once.

## What's next — Day 6

The UI gets functional:

- URL input form with optional auth-config builder (form / token mode)
- "Start scan" submits to `POST /api/scan`, navigates to a progress page
- Progress page polls `GET /api/scan/:scanId` every second and shows a live status indicator
- ScoreBanner + StandardsBreakdown + StartHere sections render the first chunks of the report when complete

By end of Day 6, your team can paste a URL into the browser and watch a real scan run.
