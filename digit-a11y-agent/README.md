# DIGIT Accessibility Scanner

> A browser-based accessibility audit tool for Indian government portals — built on Playwright + axe-core, with first-class support for authenticated pages, four standards, and visual reports.

**Phase 1 (v0.1.0).** Single-page scans with auth, structured reports, exports.
Phase 2 (history, comparison, crawling) is on the roadmap.

---

## What it does

- **Scan any URL** — public or protected (form login, token injection, or context-bound sessions).
- **Check against four standards in parallel**: WCAG 2.1, GIGW (Indian govt), SesMag (Section 508 / EN 301 549), ADA Title III.
- **Produce a calibrated 0–100 score** with per-standard compliance percentages.
- **Surface issues visually** — full-page screenshot with bounding boxes drawn over every violating element.
- **Explain issues in plain English** — why it matters, what to fix, which standards apply.
- **Export as PDF or JSON** for stakeholder distribution or programmatic use.

Tested working against `saucedemo.com`, `health-demo.digit.org`, and `unified-uat.digit.org` (Studio).

---

## Quick start (5 minutes)

### Prerequisites

- **Node.js 20+** (`node --version`)
- **pnpm 9+** (`corepack enable && corepack prepare pnpm@9.0.0 --activate`)

### Install + run

```bash
git clone <repo-url>
cd digit-a11y-agent
pnpm install                  # ~2 minutes, installs Chromium
pnpm dev                      # starts API on :3000 and UI on :5173
```

Open <http://127.0.0.1:5173>. Paste a URL, click **Start scan**, watch the progress page, see the report.

### First scan — saucedemo (no auth, ~25 seconds)

URL: `https://www.saucedemo.com` → Start scan → reports 88/100 with three Moderate issues.

### First authenticated scan — saucedemo with login (~40 seconds)

| Field | Value |
|---|---|
| URL | `https://www.saucedemo.com/inventory.html` |
| Auth → Form login → Login page URL | `https://www.saucedemo.com/` |
| Field 1 | `input[type="text"]` · `standard_user` |
| Field 2 | `input[type="password"]` · `secret_sauce` |
| Submit button | `#login-button` |
| Success — element selector | `.inventory_list` |

### DIGIT scans — use the preset

On the home page, next to the URL field, click **Use DIGIT preset** → choose **health-demo (HCM Console)** or **Studio UAT**. The form pre-fills selectors, the wait-for-element, and the context strategy. You only need to type credentials (we deliberately don't bake them in).

---

## Architecture

Four packages in a pnpm workspace:

```
packages/
├── scanner/    # The Playwright + axe-core engine.
│               # Knows nothing about HTTP — pure async function.
├── reporter/   # Pure transformation: raw axe → FriendlyReport.
│               # Computes scores, applies plain-English explanations,
│               # maps rules to four standards.
├── api/        # Express server. 3 endpoints + screenshot + exports.
│               # In-memory job store (Phase 2 will swap to SQLite).
└── ui/         # React + Vite + Tailwind. Single-page app.
                # Polls the API for scan status; renders the report.
```

The data flow for one scan:

```
[UI form] → POST /api/scan → [in-memory job store] → [scanner.runScan]
                                                          ↓
                                          screenshot.png to disk
                                                          ↓
                                          [reporter.buildFriendlyReport]
                                                          ↓
                                          stored back to job store
                                                          ↓
[UI report] ← GET /api/scan/:id (polled every 1s) ──────┘
```

For exports:

```
[Download JSON button]      → GET /api/scan/:id/export.json
[Download PDF button]       → GET /api/scan/:id/export.pdf
                              (server renders HTML, prints with Chromium)
[Screenshot in report]      → GET /api/scan/:id/screenshot
```

---

## Configuration

Environment variables (set them in `.env` or pass at runtime):

| Variable | Default | What it does |
|---|---|---|
| `API_PORT` | `3000` | HTTP port for the API |
| `API_HOST` | `127.0.0.1` | Bind address. Use `0.0.0.0` for Docker. |
| `API_KEY` | *(unset)* | If set, every request needs `x-api-key: <value>`. Leave unset for local/demo. |
| `CORS_ORIGINS` | `http://localhost:5173,http://127.0.0.1:5173` | Comma-separated allow-list for the UI's origin |
| `SCAN_TIMEOUT_MS` | `60000` | Per-scan upper bound. **Bump to `120000` for DIGIT scans.** |
| `LOG_LEVEL` | `info` | `info` \| `debug` \| `warn` \| `error` |

To use an API key from the UI, run this in the browser console once:

```js
localStorage.setItem('A11Y_API_KEY', '<your-key>');
```

Then refresh.

---

## Deployment with Docker

```bash
# Build and run both services in containers
docker compose up --build

# UI on http://localhost:5173, API on http://localhost:3000
```

Set `API_KEY=secret` in a `.env` file before `docker compose up` to enable auth.

---

## Troubleshooting

### `SCAN_TIMEOUT` after exactly 60 seconds

The default scan budget is 60s. DIGIT scans with auth + workbench loading need 90-150s. Two ways to fix:

- **Per-scan**: in the UI, expand **Advanced options** → set Scan timeout to 120 (or higher).
- **Globally**: stop `pnpm dev`, restart with `SCAN_TIMEOUT_MS=120000 pnpm dev`.

### `PAGE_NOT_READY` on a protected page

The "Wait for element on target page" selector didn't appear within 30 seconds. Most likely cause:

- **The page redirected back to login** (the session didn't carry through). For DIGIT Studio UAT, change **Context strategy** from Reuse to **Single**.
- **The selector text changed.** Run the debug script (`packages/scanner/debug-digit-*.mjs`) to see what's actually on the page.

### Misleading 100/100 score

You **shouldn't see this** — Day 6's strict-mode fix made silent partial scans fail loudly. If you see 100/100 with no issues at all on a complex page, file a bug. (Most likely the warnings banner is also showing — read it; it tells you what happened.)

### `AUTH_PAGE_UNREACHABLE`

The scanner couldn't load the login page in 30 seconds. Usually means the target is down or your network blipped. Open the URL directly in a browser; if it loads slowly, the target is just slow tonight.

### Studio UAT redirects back to login even after authenticating

You forgot to change Context strategy to **Single**. Studio UAT binds sessions to the browser fingerprint, so Reuse (the default) doesn't work — the fresh scan context gets rejected.

### PDF export errors with "browserType.launch: Executable doesn't exist"

The API package needs its own copy of Playwright's Chromium binary. Run:

```bash
pnpm --filter @digit-a11y/api exec playwright install chromium
```

---

## Development

### Run tests

```bash
pnpm test                      # full suite, no live DIGIT scans (~60s)
pnpm test:live                 # includes live DIGIT scans (~90s extra) — opt-in
```

### Project status

```
✓ Phase 1 (v0.1.0) — single-page scans, structured reports, exports
☐ Phase 2 — scan history, comparison, multi-page crawling, SQLite
☐ Phase 3 — OAuth flows (DigiLocker, Parichay), CI/CD presets
```

### Where to start exploring the code

- **`packages/scanner/src/index.js`** — the orchestrator. Most other scanner files exist to serve it.
- **`packages/reporter/src/index.js`** — pure function, takes scanner output, produces the report shape the UI renders.
- **`packages/api/src/routes/scan.js`** — the four endpoints. Reading this gives you the whole API surface in one file.
- **`packages/ui/src/pages/ScanReport.jsx`** — composition root for the report UI. The visual feature you'd want to extend.

---

## License

MIT. See [LICENSE](./LICENSE).
