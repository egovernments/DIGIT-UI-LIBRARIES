# DIGIT Accessibility Agent — Phase 1 Architecture

**Status:** Draft for review
**Phase:** 1 of 3
**Estimated implementation:** 30–40 hrs once approved

---

## 1. Overview

Phase 1 delivers a **single-page accessibility scanner** aimed at Indian government web applications, particularly DIGIT-based portals. Goal: prove the architecture works end-to-end on one URL before adding crawler, exports, or dynamic interaction testing.

### Phase 1 deliverables

- Web UI to submit a URL (with optional auth config) and view results
- REST API to submit scans programmatically
- Playwright + axe-core scanner that handles SPAs, auth, dynamic content
- Friendly reporter with 90-rule mapping and GIGW / SesMag / ADA / WCAG standards refs
- PDF + JSON export of scan results

### Phase 1 success criteria

- Scan a real DIGIT-based portal (e.g., `mseva.lgpunjab.gov.in` or an eGov demo site) successfully
- Scan completes in under 60 seconds for a single page
- Report shows all axe-core violations with friendly text + correct standards mapping
- Auth flow works for at least form-based login
- API returns identical JSON to what the UI renders
- Self-host deployable via `docker-compose up`

### Out of scope for phase 1 (deferred)

| Capability | Phase |
|---|---|
| Multi-page crawling | 2 |
| Scan history / persistence | 2 |
| Dynamic interaction testing (clicking tabs to discover routes) | 3 |
| Manual keyboard test framework | 3 |
| OAuth / SAML auth flows | 3+ |
| MFA / OTP handling | 3+ |
| Embedded widget for DIGIT dashboards | 3 |
| Webhook delivery | 3 |

---

## 2. Tech stack

| Layer | Choice | Why |
|---|---|---|
| Language | **JavaScript** (Node 20 LTS) | Per user preference; no build step needed |
| Type hints | **JSDoc** + `@typedef` blocks | Recovers read-time editor safety without TS toolchain |
| Server framework | **Express 4** | Familiar, mature, large ecosystem |
| Browser automation | **Playwright** (latest) | SPA support, modern API, official axe adapter, used for both scanning AND PDF generation |
| Scanner engine | **axe-core 4.11.x** via `@axe-core/playwright` | Industry standard, ~89 active rules |
| UI framework | **React 18 + Vite** | Fast dev loop, no SSR needed |
| UI styling | **Tailwind CSS** | Quick iteration, low custom-CSS surface |
| Server state | **TanStack Query** (React Query) | Caching, loading states, retries |
| Logging | **pino** | Fast structured JSON logs |
| Validation | **zod** | Runtime schema validation at API boundary |
| Testing | **Vitest** (unit) + **Playwright** (e2e) | Vitest matches Vite; Playwright we already use |
| Package manager | **pnpm** | Faster, stricter, monorepo support |
| Container | **Docker + docker-compose** | Single-command self-hosting |

**Dependencies kept deliberately small.** Every package above is on the critical path. No state managers we don't need, no UI kits we won't customize.

---

## 3. Repo structure

```
digit-a11y/
├── README.md
├── docker-compose.yml
├── Dockerfile
├── pnpm-workspace.yaml
├── package.json                  # root, scripts only
│
├── packages/
│   ├── api/                      # Express server
│   │   ├── src/
│   │   │   ├── index.js          # entry point
│   │   │   ├── routes/
│   │   │   │   ├── scan.js       # POST /scan, GET /scan/:id
│   │   │   │   └── health.js
│   │   │   ├── middleware/
│   │   │   │   ├── error.js
│   │   │   │   ├── validate.js   # zod schema validation
│   │   │   │   └── logging.js    # pino + secret redaction
│   │   │   └── lib/
│   │   │       └── jobs.js       # in-memory job store (phase 1)
│   │   ├── tests/
│   │   └── package.json
│   │
│   ├── scanner/                  # Playwright + axe orchestration
│   │   ├── src/
│   │   │   ├── index.js          # main entry: runScan(config) → RawScanResult
│   │   │   ├── browser.js        # launch + context management
│   │   │   ├── auth/
│   │   │   │   ├── form.js       # form-based login flow
│   │   │   │   ├── token.js      # JWT / Bearer token capture
│   │   │   │   └── storage.js    # storageState persist/restore
│   │   │   ├── wait.js           # event-driven wait strategy
│   │   │   ├── axe.js            # axe-core injection wrapper
│   │   │   └── screenshot.js     # full-page capture + element bounds
│   │   ├── tests/
│   │   └── package.json
│   │
│   ├── reporter/                 # Translation + scoring
│   │   ├── src/
│   │   │   ├── index.js          # buildFriendlyReport(rawResult)
│   │   │   ├── messages.js       # 90-rule mapping (ported from old)
│   │   │   ├── scoring.js        # score + status computation
│   │   │   ├── standards.js      # WCAG/GIGW/SesMag/ADA aggregation
│   │   │   └── types.js          # JSDoc typedefs (single source of truth)
│   │   ├── tests/
│   │   └── package.json
│   │
│   ├── ui/                       # React frontend
│   │   ├── src/
│   │   │   ├── main.jsx
│   │   │   ├── App.jsx
│   │   │   ├── pages/
│   │   │   │   ├── Home.jsx
│   │   │   │   ├── ScanProgress.jsx
│   │   │   │   └── Report.jsx
│   │   │   ├── components/
│   │   │   │   ├── ScoreBanner.jsx
│   │   │   │   ├── IssueCard.jsx
│   │   │   │   ├── StartHere.jsx
│   │   │   │   ├── StandardsBreakdown.jsx
│   │   │   │   ├── BoundingBoxOverlay.jsx
│   │   │   │   └── AuthConfig.jsx
│   │   │   └── lib/
│   │   │       └── api.js        # API client
│   │   ├── vite.config.js
│   │   ├── tailwind.config.js
│   │   └── package.json
│   │
│   └── exporter/                 # PDF/JSON export
│       └── src/
│           ├── index.js
│           ├── pdf.js            # uses Playwright's page.pdf()
│           ├── json.js
│           └── templates/
│               └── report.html   # printable HTML, fed to page.pdf()
│
└── docs/
    ├── ARCHITECTURE.md           # this doc
    ├── API.md                    # endpoint reference
    └── DEPLOYMENT.md
```

Monorepo via **pnpm workspaces**. Each package is independently testable and has its own `package.json`. Shared JSDoc typedefs live in `reporter/src/types.js` and are referenced from other packages — keeping the canonical report shape in one place.

**Why monorepo:** the scanner + reporter + api + ui all share types and are deployed as one unit. Splitting them into separate repos adds friction without isolation benefit. If any one ever needs to be extracted (e.g. publish reporter as an npm package), it's already package-scoped.

---

## 4. Canonical data shapes

Defined once in `packages/reporter/src/types.js`. Everything in the system speaks this language.

```js
/**
 * @typedef {Object} ScanRequest
 * @property {string} url - Target URL to scan
 * @property {AuthConfig} [auth] - Optional authentication config
 * @property {ScanOptions} [options]
 */

/**
 * @typedef {Object} AuthConfig
 * @property {'form'|'token'} type
 * @property {string} loginUrl
 * @property {Record<string,string>} fields - CSS selector → value
 * @property {string} submitSelector
 * @property {string} successSelector - CSS selector indicating login worked
 * @property {string} [tokenStorageKey] - localStorage key (for token auth)
 */

/**
 * @typedef {Object} ScanOptions
 * @property {number} [timeoutMs=30000]
 * @property {string[]} [axeTags]
 * @property {boolean} [captureScreenshot=true]
 * @property {string} [waitForSelector] - Optional ready signal
 */

/**
 * @typedef {Object} RawScanResult
 * @property {AxeViolation[]} violations
 * @property {AxeViolation[]} incomplete
 * @property {string} screenshotPath
 * @property {ScanMetadata} meta
 */

/**
 * @typedef {Object} FriendlyReport
 * @property {number} score - 0..100
 * @property {ScoreStatus} status
 * @property {string} summaryText - One-sentence summary
 * @property {string} keySummary - "Top issues" phrase
 * @property {SeveritySummary} summary - Counts by severity
 * @property {FriendlyIssue[]} startHere - Top 3 critical/serious
 * @property {FriendlyIssue[]} issues - All issues sorted by severity
 * @property {StandardsBreakdown} standardsBreakdown
 * @property {ScanMetadata} meta
 */

/**
 * @typedef {'Good to go'|'Needs some improvement'|'Needs attention'|'Needs major fixes'} ScoreStatus
 */

/**
 * @typedef {Object} FriendlyIssue
 * @property {string} ruleId - axe rule ID
 * @property {string} title - human-friendly title from messages.js
 * @property {Severity} severity
 * @property {string} icon - severity icon
 * @property {string} whyItMatters
 * @property {string} whatYouCanDo
 * @property {string} [example]
 * @property {AffectedUser[]} affectedUsers
 * @property {ViolationTarget[]} targets - CSS selectors + bounding boxes
 * @property {Standards} standards
 * @property {string[]} sections - Detected page regions affected
 */

/**
 * @typedef {'Needs Immediate Fix'|'Important'|'Can Improve'|'Minor'} Severity
 */

/**
 * @typedef {Object} StandardsBreakdown
 * @property {StandardScore} wcag
 * @property {StandardScore} gigw
 * @property {StandardScore} sesmag
 * @property {StandardScore} ada
 */

/**
 * @typedef {Object} StandardScore
 * @property {number} totalRulesChecked
 * @property {number} rulesPassed
 * @property {number} rulesFailed
 * @property {number} compliancePercent - 0..100
 */

/**
 * @typedef {Object} ScanMetadata
 * @property {string} scanId
 * @property {string} url
 * @property {string} scannedAt - ISO 8601
 * @property {number} durationMs
 * @property {string} axeCoreVersion
 * @property {Warning[]} warnings - Non-fatal issues (e.g. "page may not be fully loaded")
 */
```

**Key principle:** the JSON the UI receives, the JSON the API returns, and the JSON the PDF is rendered from are the *same* shape. No per-channel transforms.

---

## 5. Scanner architecture

The scanner is a pure async function:

```
runScan(ScanRequest) → Promise<RawScanResult>
```

### 5.1 Page lifecycle

```
1. launchBrowser()                       // playwright.chromium.launch()
2. (if auth) executeAuthFlow()           // get storageState
3. createContext({ storageState })       // fresh, isolated context
4. page = context.newPage()
5. page.goto(url, { waitUntil: 'domcontentloaded' })
6. waitForReady(page)                    // see 5.4
7. results = await runAxe(page)
8. screenshot = await page.screenshot({ fullPage: true })
9. compute bounding boxes per violation
10. close context, close browser
11. return { violations, incomplete, screenshotPath, meta }
```

### 5.2 Auth — form-based

1. Open a separate page in the auth context
2. Navigate to `loginUrl`
3. For each `[selector, value]` in `auth.fields`: `await page.fill(selector, value)`
4. Click `auth.submitSelector` (default `button[type=submit]`)
5. Wait for `auth.successSelector` to appear *or* URL to match a success pattern
6. Capture `storageState` (cookies + localStorage)
7. Close auth page; storageState is passed to the scan context

Failure: if successSelector doesn't appear within 15s → throw `AuthFailedError` with the last URL seen and a screenshot.

### 5.3 Auth — token-based

1. Execute form login as above
2. After success, read the token from `localStorage[auth.tokenStorageKey]`
3. Persist both `storageState` AND the raw token
4. For the scan context: pre-populate localStorage with the token before any navigation (via `context.addInitScript`)

### 5.4 Wait strategy (event-driven, not timer-based)

The biggest single flaw in the existing tool: blunt `setTimeout(5000)` waits. Replaced by a fall-through chain:

1. **If `waitForSelector` is provided** — wait for that selector to appear (most reliable for SPAs)
2. **Else** — wait for `networkidle` (≤2 in-flight requests for 500ms)
3. **AND** — check for common SPA "ready" signals: `data-ready="true"` on body, body class containing `loaded`, presence of `#root [data-ready]`
4. **PLUS** a minimum 500ms buffer for paint

Total timeout: 30s. On timeout, the scan continues but attaches a warning to the report: `"Page may not have fully loaded — results could be incomplete."` Not a fatal error.

### 5.5 axe-core integration

```js
const { AxeBuilder } = require('@axe-core/playwright');

const results = await new AxeBuilder({ page })
  .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa', 'best-practice'])
  .analyze();
```

Default tag set is configurable per scan. axe returns `{ violations, passes, incomplete, inapplicable }`. We capture `violations` (definite issues) and `incomplete` (axe couldn't determine — needs manual review). Both flow into the report under different sections.

### 5.6 Bounding boxes

For each violation node:

```js
for (const node of violation.nodes) {
  const locator = page.locator(node.target[0]);
  try {
    const box = await locator.boundingBox({ timeout: 1000 });
    node._bounds = box; // {x, y, width, height} or null if not visible
  } catch {
    node._bounds = null;
  }
}
```

Stored alongside the violation. UI renders red rectangles on the screenshot using these coordinates.

---

## 6. API surface

### POST /scan

**Request body:**
```json
{
  "url": "https://example.gov.in/services",
  "auth": {
    "type": "form",
    "loginUrl": "https://example.gov.in/login",
    "fields": {
      "#username": "auditor@example.gov.in",
      "#password": "<secret>"
    },
    "submitSelector": "button[type=submit]",
    "successSelector": ".dashboard-welcome"
  },
  "options": {
    "timeoutMs": 30000,
    "captureScreenshot": true
  }
}
```

**Response (phase 1 — synchronous):**
```json
{
  "scanId": "scn_01H8XK...",
  "status": "complete",
  "report": { /* FriendlyReport */ }
}
```

**Phase 2 (long scans will need async):** returns `{ scanId, status: "queued" }`; consumer polls `GET /scan/:id` until `status: "complete"`.

### GET /scan/:id

Returns current status + report (if complete). Phase 1 keeps reports in memory for 1 hour, then drops them.

### GET /scan/:id/export?format=pdf|json

Generates a download for the scan in the requested format.

### Error responses

All errors return:
```json
{ "error": { "code": "AUTH_FAILED", "message": "...", "details": {} } }
```

Codes: `INVALID_URL`, `AUTH_FAILED`, `PAGE_TIMEOUT`, `SCAN_ERROR`, `SCAN_NOT_FOUND`, `INTERNAL`.

### Auth on the API itself

Production: requires `X-API-Key` header. Configurable allowlist. Off by default in dev.

---

## 7. Reporter architecture

Pure function: `buildFriendlyReport(RawScanResult) → FriendlyReport`.

### Steps

1. For each violation, call `getMessage(rule.id)` from `messages.js` to get title, why, what, example, users, standards
2. Compute severity per violation from axe's `impact` field
3. Compute aggregate score via formula (§7.1)
4. Compute standards breakdown (§7.2)
5. Pick top 3 critical/serious issues for "Start here"
6. Generate one-sentence summary based on status + top 2 issue categories
7. Attach scan metadata, return `FriendlyReport`

### 7.1 Score formula (phase 1 starting values)

```
deductions =
    critical_count × 10 +
    serious_count  × 5 +
    moderate_count × 2 +
    minor_count    × 0.5

score = max(0, 100 - deductions)
```

Status thresholds:

| Score | Status |
|---|---|
| 90–100 | Good to go |
| 70–89 | Needs some improvement |
| 40–69 | Needs attention |
| 0–39 | Needs major fixes |

These are placeholders. Phase 2 includes a "calibrate scoring against real data" line item — we ship phase 1 with this formula and revise after seeing real scan distributions.

### 7.2 Standards breakdown

For each standard (`wcag`, `gigw`, `sesmag`, `ada`):

```
rulesMappedToStandard = count of axe rules whose messages.js entry has a non-empty standards.<name> array
rulesFailedInThisScan = count of violations whose messages.js entry maps to this standard
compliancePercent = ((rulesMappedToStandard - rulesFailedInThisScan) / rulesMappedToStandard) × 100
```

This gives outputs like "WCAG: 78% compliant, GIGW: 65% compliant" — useful for compliance dashboards.

---

## 8. Frontend architecture

React 18 + Vite + Tailwind. Three primary routes:

| Route | Component | Purpose |
|---|---|---|
| `/` | `Home` | URL input + optional `AuthConfig` accordion + scan button |
| `/scan/:id/progress` | `ScanProgress` | Live progress view (phase 1: simple loading state; phase 2: SSE) |
| `/scan/:id` | `Report` | Full report rendering |

### Component hierarchy (Report)

```
<Report>
  <ScoreBanner score, status, summaryText />
  <StandardsBreakdown breakdown />
  <StartHere issues={top3} />
  <IssueList issues groupBy="severity">
    <IssueCard issue>
      <BoundingBoxOverlay screenshot, target />
    </IssueCard>
  </IssueList>
  <ExportActions onExportPdf onExportJson />
</Report>
```

State: TanStack Query for the scan fetch + caching. Component-local state for UI toggles. No Redux at phase 1 — single-user, single-scan-at-a-time doesn't need it.

---

## 9. Auth & security

- Scan credentials (`auth.fields` values) held in memory only for scan duration, dropped after
- Request logger (pino) redacts: `auth.fields.*`, `X-API-Key` header, any `password`/`token`/`secret` key
- API key required in production for `/scan` endpoint
- HTTPS terminated at reverse proxy (nginx in docker-compose); app speaks HTTP internally
- CORS allowlist for UI domain only
- No persistence of credentials anywhere on disk

---

## 10. Observability

Phase 1 minimum:

- Structured JSON logs via pino
- Every scan logged with: `scanId`, `url`, `durationMs`, `violationCount`, `status`, `errorCode` (if any)
- Request logger redacts secrets per §9
- `GET /health` returns `{ status, version, axeCoreVersion, playwrightVersion, uptime }`

Phase 2:
- Prometheus metrics endpoint (scan counts, durations, error rates by code)
- Structured scan events log for audit trail

---

## 11. Testing strategy

| Layer | Framework | What we test |
|---|---|---|
| Reporter | Vitest | `getMessage()` returns correct shape for all 89 axe rules; scoring formula edge cases; standards breakdown math |
| Scanner | Vitest + Playwright fixtures | Auth flow against a local fixture login page; wait strategy with timed delay pages; axe integration smoke test |
| API | Vitest + supertest | Request validation, error codes, response shape |
| UI | Vitest + React Testing Library | Component rendering, score banner display logic, issue card expand/collapse |
| End-to-end | Playwright | Full flow: scan a fixture page, see report rendered |

CI runs all layers on every PR. The e2e suite uses a small local fixture site (in `tests/fixtures/`) with known violations so it's deterministic.

---

## 12. What gets ported from the old codebase

Verbatim (or near-verbatim) ports — keep the IP:

| Old file | New location | Conversion |
|---|---|---|
| `src/reporter/messages.ts` | `packages/reporter/src/messages.js` | TS → JS: strip type imports, add `@typedef` for `RuleMessage` shape at top |
| `src/reporter/types.ts` | `packages/reporter/src/types.js` | Convert TS interfaces to JSDoc typedefs |
| Severity icons & user-group definitions | inline in `messages.js` | Already done in expansion work |

Conceptually reused (logic ported, code rewritten):

- Severity tier model (4 levels)
- "Start here" pattern (top-3 critical/serious)
- Affected-user grouping concept

Rebuilt from scratch (old code not reused):

- Scanner orchestration — architecture mismatch
- Crawler — out of phase 1 scope entirely
- Express server — re-derive cleanly
- UI components — may reuse visual patterns, not code

---

## 13. Open questions requiring decision

1. **PDF generation** — proposed: reuse Playwright's `page.pdf()` (already have Chromium for scanning). Alternative: pdfkit (lighter but more manual templating). **Default: Playwright.**
2. **In-memory job storage at phase 1** — restarting the API drops in-flight scans. Acceptable for phase 1 (single-user dev tool)? Phase 2 adds SQLite. **Default: yes, acceptable.**
3. **API key auth on by default** — production: required. Local dev: off via env var. **Default: this split.**
4. **Default scan timeout** — proposed: 60s total, 30s per page lifecycle phase. Validate against real DIGIT portals. **Default: 60s.**
5. **Default axe tag set** — proposed: `wcag2a + wcag2aa + wcag21a + wcag21aa + best-practice`. Excludes WCAG 2.2 (separate line item). **OK?**
6. **DIGIT portal for live test** — need one specific URL to use as the phase 1 acceptance target. Suggest `mseva.lgpunjab.gov.in` (Punjab e-Gov) — open, public, no auth needed for landing pages. **OK or pick another?**

Tell me your call on each before we scaffold.

---

## 14. Phase 1 acceptance checklist

Phase 1 is done when:

- [ ] `pnpm install && pnpm dev` brings up UI + API locally with one command
- [ ] User can paste a URL, hit scan, and view a report
- [ ] Scan succeeds on a public DIGIT portal (no auth)
- [ ] Scan succeeds on a public DIGIT portal *with* form auth
- [ ] Report shows score, status, all violations with friendly text + standards refs
- [ ] All 89 active axe-core 4.11 rules produce non-fallback friendly messages
- [ ] PDF export downloads correctly and matches the on-screen report
- [ ] JSON export exactly matches `GET /scan/:id` response body
- [ ] `docker-compose up` brings up the full stack
- [ ] README has a 5-line "how to run locally" section
- [ ] Vitest + Playwright tests pass in CI

---

## 15. What I need from you before scaffolding

1. **Read this doc.** Push back on anything you disagree with — architecture, tech choices, scope.
2. **Answer the 6 open questions in §13.**
3. **Pick a name for the new repo.** Suggested: `digit-a11y-agent`. Or keep the current name?

Once those three are in, scaffolding begins.
