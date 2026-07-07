# @digit-a11y/explorer

Sitemap-anchored dynamic explorer. You give it a fixed list of URLs (the
"sitemap"); for each one it loads the page, exercises the page's dynamic
states (modals, panels) by clicking, and scans every distinct state with
axe-core. It **never follows click-navigation** — the sitemap is the only
thing that moves between pages — and it skips danger elements
(delete / logout / …).

It reuses `@digit-a11y/scanner` for the browser, auth, and axe, so the raw
output is the same shape the rest of the tool already understands, and
`@digit-a11y/reporter`'s `buildSiteReport` turns it into one scored report
(counted one-issue-per-rule, like every other report).

## Use it as a library

```js
import { exploreAndReport } from '@digit-a11y/explorer';

const { exploration, report } = await exploreAndReport({
  urls: [ /* your sitemap */ ],
  auth: { type: 'form', loginUrl: '…', contextStrategy: 'single', /* … */ },
  options: { headless: true },
});
// report.overallScore, report.pages[], report.issues[] …
```

Or `runExploration(request)` for just the raw per-state results.

## Run against Studio UAT

```bash
pnpm install
pnpm exec playwright install chromium    # one-time
node packages/explorer/run-studio.mjs
```

Default is **manual login** (a browser opens; log in by hand, press ENTER).
Automated login (reuses the scanner's form auth):

```bash
AUTO_LOGIN=1 STUDIO_USER=STUDIOUAT STUDIO_PASS=eGov@123 node packages/explorer/run-studio.mjs
```

Writes `site-report.json` (scored) and `exploration-raw.json` (raw per-state).

## Scope (v1)

- Depth 1: scans a page and the states one click opens — not states inside
  those states (no deep nesting).
- Coverage is the sitemap you provide; it does not discover new pages.
- Danger elements are matched by accessible name; UAT + dummy creds keep
  residual risk low.
