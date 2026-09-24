# DIGIT Accessibility Scanner

> A browser-based accessibility audit tool for Indian government portals — built on Playwright + axe-core, with first-class support for authenticated pages, four standards, and visual reports.

**Phase 1 (v0.1.0).** Single-page scans with auth, structured reports, exports.
Phase 2 (history, comparison, crawling) is on the roadmap.

---

## What it does

- **Scan any URL** — public or protected. Automated form login, token injection, or [a session you captured by hand](#authenticating-against-any-login-flow) (which works for *any* login flow, including OTP and SSO).
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

## Authenticating against any login flow

Automated `form` auth drives exactly one shape of login: open a page, fill every field, click once. That covers a lot of portals and none of the awkward ones — two-step forms where the password lives on a second page, OTP, SSO redirects, captcha.

Rather than grow a config language that tries to describe every login flow in existence, a human performs the login once and the session is reused.

### From the UI

1. Enter your URL (or paste a list in **Whole site** mode).
2. **Add authentication** → **Log in manually**.
3. Type the login page URL → **Open a browser and log in**.
4. A browser window opens **on the machine running the scanner**. Do whatever the site needs — mobile number, OTP, SSO, captcha, role picker.
5. Back in the UI, click **I'm logged in — capture**.
6. Fill in **Signed-in element selector** (see below), then scan.

The session is held in that browser tab and sent with the scan. It is never written to disk or to localStorage.

If the scanner runs somewhere without a desktop (Docker, a remote box), step 4 can't work — the API answers `CAPTURE_UNAVAILABLE` and the panel offers a file upload instead. Capture on your own machine with the CLI below, then upload the file.

### From the CLI

```bash
node packages/scanner/bin/capture-session.mjs \
  --url https://your-portal.gov.in/login \
  --out session.json
```

A browser window opens. Log in however the site demands — take as long as you need. Press ENTER, and the whole session (cookies, localStorage, sessionStorage) is written to `session.json`. Then scan with no credentials at all:

```js
await runScan({
  url:  'https://your-portal.gov.in/protected/page',
  auth: {
    type:           'session',
    sessionPath:    './session.json',
    authedSelector: '#user-menu',   // strongly recommended — see below
  },
});
```

This is flow-agnostic because the tool never performs the login. You do, once.

**Trade-off:** sessions expire. Re-run the capture when they do — it's one command. For unattended CI against a portal you control, calling its auth API directly is the better path.

> ⚠️ `session.json` is a live credential. It signs in as you with no password and no MFA. It's gitignored by default — keep it that way, and re-capture rather than sharing one.

### Always set the signed-in element selector

Point it at something only signed-in pages have (avatar, logout button, app sidebar). Before scanning, the run confirms that element is present and **fails with `SESSION_NOT_AUTHENTICATED`** if it isn't.

Without it, a fallback heuristic looks for a login-shaped URL or a visible password field. That catches the common case, but a slow or blank page slips through it — the report then says `authVerified: false` and carries an `auth-unverified` warning.

This matters more than it sounds, and "the capture looked fine" is not reassurance. Capturing the Studio UAT login page **without signing in at all** still yields 9 cookies and 4 sessionStorage keys, because the login page itself sets analytics cookies and app-shell storage. Capture-time checks can only warn; the scan-time check is the real gate.

An expired or never-signed-in session doesn't produce an error on its own: the app redirects to its login screen, axe audits *that*, and a clean, flattering, completely wrong report comes back.

To audit a login page deliberately, set `skipPreflight: true`.

On multi-page (**Whole site**) scans the same check runs per page. A page that comes back unauthenticated is marked `loadStatus: 'unauthenticated'` with an `authReason`, left unscored, and counted in `meta.failedPageCount` — one expired session mid-crawl doesn't discard the whole run.

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

On an authenticated scan, check `meta.authVerified` first. If it's `false`, the run never confirmed you were signed in and may have audited a login page. Set `auth.authedSelector` and run it again.

### `AUTH_PAGE_UNREACHABLE`

The scanner couldn't load the login page in 30 seconds. Usually means the target is down or your network blipped. Open the URL directly in a browser; if it loads slowly, the target is just slow tonight.

### A protected page redirects back to login even after authenticating

Almost always: the site keeps auth state somewhere that didn't survive being replayed into the scan context.

Playwright's `storageState` carries cookies and localStorage **only**. `sessionStorage` and IndexedDB are not included. The auth flows now capture and replay sessionStorage (this is what Studio UAT needed — it keeps 9 auth keys there), but an app storing credentials in IndexedDB would still fall out.

Diagnose it rather than guessing:

```bash
node packages/scanner/diagnose-session-roundtrip.mjs
```

It logs in, dumps every browser-side store, then tests replay with and without sessionStorage, and tells you which one the site actually needs. Re-point the URLs at whatever site you're debugging.

Only after ruling that out should you reach for `contextStrategy: 'single'`, which skips the round-trip entirely. It's the right answer for sites that genuinely bind a session server-side (IP/UA/TLS fingerprint, DPoP), but that's rare — and it was the wrong answer for Studio for most of Phase 1. See `PHASE1_RETROSPECTIVE.md`.

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
