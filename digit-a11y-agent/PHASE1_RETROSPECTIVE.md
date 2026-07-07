# Phase 1 Retrospective

> *Notes for the next person picking this up — whether that's me in 3 months, a teammate, or a Phase 2 contributor.*

---

## What we built

A working accessibility scanner for DIGIT (and any other) portals. End-to-end in eight days:

- Single-page scans (public or authenticated)
- Four standards in parallel (WCAG, GIGW, SesMag, ADA)
- Calibrated scoring and severity classification
- Plain-English issue explanations
- Full-page screenshots with bounding-box overlays
- PDF + JSON export
- REST API + React UI
- Docker deployment

**Validated against:** saucedemo, DIGIT health-demo, DIGIT Studio UAT.

---

## Day-by-day arc (for context)

| Day | Focus |
|---|---|
| 1 | Scanner core — axe-core wiring, Playwright launch |
| 2 | Reporter — score, severity, plain-English messages |
| 3 | Standards — WCAG/GIGW/SesMag/ADA mapping |
| 4 | Auth — form login + token injection + context strategies |
| 5 | API — Express server, job store, schema validation |
| 6 | UI — scan form, progress, report (top-3 issues) |
| 7 | Full issue list, bbox overlay, PDF/JSON export |
| 8 | Polish, validation, docs, deployment verification |

The most surprising day was **Day 6**, where I caught a real bug in a real DIGIT page (silent redirect-to-login producing a misleading 100/100 score). The fix and the visibility around it ended up shaping Day 7 too (warnings banner, strict-mode wait).

---

## Decisions worth knowing (and why)

### "Two context strategies" — Reuse vs Single

DIGIT Studio UAT binds sessions to browser context. The default flow (auth → capture state → fresh context → replay state) gets rejected by Studio. We added a `contextStrategy: 'single'` mode that uses one context end-to-end.

This is the **#1 thing that trips up new users.** If a DIGIT scan keeps redirecting to login, the answer is almost always "switch to Single."

### "Strict wait-for-selector"

In `packages/scanner/src/wait.js`, when the user passes a `waitForSelector` option, we treat its absence as a hard failure (`PAGE_NOT_READY`). Earlier the scanner warned and continued — which caused silent partial scans.

**Why this matters:** without this, you can get a beautiful-looking 100/100 report against a page that was actually scanned as a loading screen.

### "Conditional spread for screenshot in FriendlyReport"

The reporter forwards `screenshot` from the raw scan result conditionally — present when captured, absent when the screenshot step failed. The UI's bbox section uses the presence/absence as a render gate.

The conditional spread is important. If we always set `screenshot: undefined`, the UI's `report.screenshot?.width` check would still work, but the JSON export would include `"screenshot": null` for failed-screenshot scans, which is noise.

### "API key is optional"

The API runs without auth by default — fine for local dev and behind-firewall demos. For internet-facing deployments, set `API_KEY=<value>`. This matches how most internal tools are deployed.

### "In-memory job store"

Scans live in process memory. Restart = lose history. This is **fine for Phase 1** (single-user, single-process, demo-grade). Phase 2 should move to SQLite — design is already there (the job store has a clean interface; just swap the implementation).

### "Two-tier severity"

Axe-core's `critical/serious/moderate/minor` maps to our `Needs Immediate Fix / Important / Can Improve / Minor`. We use the friendlier strings in the UI but keep axe's terminology in the data layer. Translation lives in `packages/reporter/src/index.js → IMPACT_TO_SEVERITY`.

### "Top 3 in Start Here"

We deliberately surface only Critical+Serious in "Start here," capped at 3. The full list is below. This was a UX decision — overwhelming users with 30 issues is worse than focusing them on 3.

---

## Things that didn't go to plan

### The placeholder-as-default UX bug

I designed the auth form with placeholders that looked like defaults (`placeholder="/dashboard"`). A real user (me, on Day 6, at 4 AM) filled in `/dashboard` as the success URL match — because it *looked* like the default. Took an hour to diagnose. Fix: prefix every placeholder with "e.g."

**Lesson:** placeholder text in HTML inputs is fundamentally ambiguous. Either don't use it, or make it visually unmistakable.

### The vi.mock + module-level const trap (twice)

Two test files imported a class at the module level and referenced it inside `vi.mock`. The mock was hoisted above the import, so the class was undefined when the factory ran. Fixed with `vi.hoisted()` in Day 6.

Then I built Day 7 from a stale base and lost the fix. Had to apply it again.

**Lesson:** Snapshots should be built from the latest known-good source, not the snapshot I happen to remember. Going forward: always start from the live working directory, not an in-memory model.

### Fake timers + testing-library

`vi.useFakeTimers()` breaks `waitFor` from `@testing-library`. The interaction isn't documented anywhere obvious. Fixed by removing fake timers and using real timers with 20ms intervals.

**Lesson:** for hooks that just need "happens within a small time window," real timers + small interval > fake timers + manual advancing.

### My reporter rewrite that broke saucedemo

Day 7 Day-of: I needed to add one line to the reporter (forward the screenshot field). I rewrote the whole file. The rewrite called `computeScore(violations)` when the existing API was `computeScore(summary)`. Saucedemo scans broke with "Cannot read properties of undefined."

**Lesson:** for surgical fixes, edit the file. Don't rewrite it from memory.

---

## Things I'd do differently next time

### Move to TypeScript earlier

JSDoc + plain JS is sufficient but not actively *helpful* in the way TypeScript is. Several of the bugs above would have been caught at compile time (the `computeScore` signature mismatch most obviously).

For Phase 2: migrate the reporter and scanner packages to TypeScript first. They're the most stable surfaces.

### Write integration tests sooner

Phase 1 had a lot of unit tests and one mid-effort manual test against real DIGIT (the visual debug scripts). A proper integration test layer (live + recorded) would catch end-to-end regressions like the Day-7 screenshot-not-passing bug *automatically*.

For Phase 2: add a `packages/integration` package or similar that runs against saucedemo + DIGIT and asserts the full report shape.

### Visual regression testing for the UI

The bbox overlay only "looks right" if the coordinate scaling is correct. We have no automated test that catches "the boxes drifted by 10 pixels." This would need a tool like Playwright's screenshot comparison.

For Phase 2: at minimum, snapshot tests of the rendered HTML for the report page with known inputs.

---

## What's deferred and why

| Feature | Phase | Why deferred |
|---|---|---|
| Scan history | 2 | In-memory store is "fine" for single-user demos. Persistence needs SQLite + migrations + concurrency model. |
| Scan comparison | 2 | Depends on history. Probably 2-3 days once history is in. |
| Multi-page crawling | 2 | A scan currently = one URL. Crawling is a different mental model (sitemap, frontier, dedup, robots.txt). Worth its own design phase. |
| OAuth flows (DigiLocker, Parichay) | 3 | Form + token covers ~90% of DIGIT instances. OAuth needs callback handling, refresh tokens, and per-portal idiosyncrasies. |
| CI/CD preset templates | 3 | API supports headless usage. Templates would be example workflows for GitHub Actions / GitLab CI. Quality-of-life, not core. |
| TypeScript migration | 2 | Quality-of-development improvement. Doesn't unlock features but reduces bugs. |
| Browser pool for PDF | 2 | Current ~8s PDF generation is acceptable for v1. A pool would bring it to <1s but adds complexity. |

---

## Where to start for Phase 2

If I were picking this up cold, my order:

1. **Read the README** (it's now actually good)
2. **Run `pnpm test`** and `pnpm dev`, scan saucedemo, look at the report
3. **Read `packages/scanner/src/index.js`** end to end — it's the spine
4. **Read `packages/reporter/src/index.js`** — most of the "interesting" logic
5. **Skim `packages/api/src/routes/scan.js`** — 4 endpoints, a few hundred lines
6. **Run the live DIGIT integration test** (`DIGIT_LIVE_TESTS=1 pnpm test`) — proves end-to-end
7. **Then start Phase 2 work** — SQLite for scan history is the cleanest first task

---

## Credits

Built across eight focused days. Tested against three real targets. Diagnosed and fixed at least one real bug that would have caused misleading reports. Calibrated against actual govt portal behaviour, not just static fixtures.

Phase 1 closes here. Phase 2 begins when someone decides to start it.
