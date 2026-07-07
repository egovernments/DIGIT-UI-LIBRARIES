/**
 * The explorer engine.
 *
 * Reuses @digit-a11y/scanner's primitives (browser, auth, axe) so it produces
 * exactly the same raw shape the reporter already understands. For each URL in
 * the sitemap it:
 *   1. loads the URL fresh (with a retry — SPA pages sometimes need a beat to
 *      bootstrap; a first-load race used to look like an empty page)
 *   2. checks the page actually cold-loaded with real content (not a redirect
 *      to login, not a chrome-only shell)
 *   3. scans the base page with axe
 *   4. clicks each clickable (small groups: all members; large groups: a sample)
 *      and, when a click opens a real dynamic state (a dialog, or the DOM grew),
 *      scans that state with axe — deduping identical states across the whole run
 *
 * It NEVER follows click-navigation: if a click changes the URL, that's recorded
 * as 'navigate' and we reset back to the sitemap URL. The sitemap is the only
 * thing that moves between pages. Danger elements (delete / logout / …) are
 * skipped by accessible name.
 *
 * Output is intentionally raw — per-state axe results in RawScanResult shape.
 * Turning that into a scored report is the reporter's job (buildSiteReport).
 */

import { randomUUID } from 'node:crypto';
import {
  launchBrowser,
  createContext,
  closeContext,
  closeBrowser,
  captureAuth,
  runAuthInContext,
  runAxe,
  waitForReady,
  captureScreenshot,
  computeBoundingBoxes,
} from '@digit-a11y/scanner';
import { collectInPage, probeState } from './page-scripts.js';

const DEFAULTS = {
  maxClicksPerPage: 40,
  smallGroup: 8,        // <= this many same-signature elements => click all (action rows)
  sampleLarge: 2,       // larger groups (grids/lists) => click this many
  growThreshold: 12,    // min new body nodes for a same-URL change to count as a state
  settleMs: 900,
  loadRetries: 3,
  headless: true,
  axeTags: undefined,
  captureScreenshots: false, // when true (+ scanId), capture a base-state screenshot + bboxes per page
  artifactsDir: './artifacts',
  concurrency: 1, // 1 = sequential (default). >1 runs K isolated logged-in contexts in parallel.
  dangerPattern: /\b(delete|remove|logout|log\s?out|sign\s?out|signout|deactivate|deregister|revoke)\b/i,
};

const CHROME_RE = /digit-topbar|employeeSidebar|digit-sidebar|home-footer|digit-header|digit-logo/;
const isChromeSig = (sig) => CHROME_RE.test(sig);
const pathOf = (u) => { try { return new URL(u).pathname.toLowerCase(); } catch { return String(u).toLowerCase(); } };

function makeMeta(url, finalUrl, axe) {
  return {
    scanId: `exp_${randomUUID().replace(/-/g, '').slice(0, 16)}`,
    url,
    finalUrl,
    scannedAt: new Date().toISOString(),
    durationMs: axe?.durationMs ?? 0,
    axeCoreVersion: axe?.axeCoreVersion ?? 'unknown',
    warnings: [],
  };
}

/**
 * Establish ONE authenticated session and return its { context, page }.
 * For 'single' strategy (DIGIT Studio) auth + all scanning must share one
 * context, so we keep using this page for every URL.
 */
async function establishSession(browser, { auth, manualLogin, waitForEnter }) {
  let context, page;

  if (manualLogin) {
    context = await createContext(browser);
    page = await context.newPage();
    if (auth?.loginUrl) await page.goto(auth.loginUrl, { waitUntil: 'domcontentloaded' }).catch(() => {});
    if (waitForEnter) await waitForEnter('\n>>> Log in by hand in the browser, then press ENTER (I will visit the URLs)...\n');
    return { context, page };
  }

  const strategy = auth?.contextStrategy ?? 'reuse';
  if (auth && strategy === 'single') {
    context = await createContext(browser);
    page = await context.newPage();
    await runAuthInContext(page, context, auth);
    return { context, page };
  }

  let storageState;
  if (auth) storageState = await captureAuth(browser, auth);
  context = await createContext(browser, storageState ? { storageState } : {});
  page = await context.newPage();
  return { context, page };
}

/**
 * Load a URL fresh and collect its clickables, with readiness checking.
 *
 * If `readySelector` is given, we use the scanner's waitForReady() with that
 * selector as the authoritative "this page loaded" signal — exactly the rigor
 * the single-page scanner uses, applied per page (fails over to a retry if the
 * selector never appears). If no selector is given, we fall back to the generic
 * heuristic: wait for the app frame to paint (>3 interactive els), then require
 * >=2 non-chrome clickables.
 *
 * @returns {Promise<{ cands: object[], confirmed: boolean }>} confirmed = a
 *   ready selector matched (an authoritative load), so the caller can skip the
 *   heuristic "enough content" gate.
 */
async function loadAndCollect(page, url, opts, readySelector) {
  let cands = [];
  for (let attempt = 1; attempt <= opts.loadRetries; attempt++) {
    await page.goto(url, { waitUntil: 'networkidle', timeout: 30_000 }).catch(() => {});
    await page.waitForTimeout(opts.settleMs);

    if (readySelector) {
      let confirmed = false;
      try {
        await waitForReady(page, { waitForSelector: readySelector });
        confirmed = true;
      } catch {
        confirmed = false; // selector never appeared this attempt — retry
      }
      await page.waitForTimeout(300);
      cands = await page.evaluate(collectInPage);
      if (confirmed) return { cands, confirmed: true };
      await page.waitForTimeout(1_500);
      continue;
    }

    await page
      .waitForFunction(() => document.querySelectorAll('a,button,[role=button],[role=link]').length > 3, { timeout: 6_000 })
      .catch(() => {});
    await page.waitForTimeout(300);
    cands = await page.evaluate(collectInPage);
    if (cands.filter((c) => !isChromeSig(c.sig)).length >= 2) return { cands, confirmed: false };
    await page.waitForTimeout(1_500);
  }
  return { cands, confirmed: false };
}

async function returnToBase(page, url, opts) {
  await page.keyboard.press('Escape').catch(() => {});
  await page.waitForTimeout(350);
  const urlChanged = page.url() !== url;
  const stuck = await page.evaluate(
    () => !!document.querySelector('[role=dialog],[aria-modal=true],[class*="modal" i],[class*="popup" i]'),
  );
  if (urlChanged || stuck) {
    await page.goto(url, { waitUntil: 'networkidle', timeout: 20_000 }).catch(() => {});
    await page.waitForTimeout(opts.settleMs);
  }
}

async function explorePage(page, url, opts, seenStates, readySelector, pageIndex = 0) {
  const states = [];
  let screenshot;
  const { cands, confirmed } = await loadAndCollect(page, url, opts, readySelector);
  const landed = page.url();
  const content = cands.filter((c) => !isChromeSig(c.sig));
  const redirected = pathOf(landed) !== pathOf(url);

  // A matched ready selector is authoritative — trust it over the content
  // heuristic (a confirmed page with few clickables is still a real page).
  if (redirected || (!confirmed && content.length < 2)) {
    return {
      url,
      loadStatus: redirected ? 'redirected' : 'degraded',
      landed,
      candidates: cands.length,
      states,
    };
  }

  // base page
  const baseProbe = await page.evaluate(probeState);
  if (!seenStates.has(baseProbe.fp)) {
    seenStates.add(baseProbe.fp);
    const axe = await runAxe(page, { tags: opts.axeTags });
    states.push({
      label: 'BASE PAGE',
      outcome: 'base',
      raw: { violations: axe.violations, incomplete: axe.incomplete, meta: makeMeta(url, landed, axe) },
    });

    // Optional: a base-state screenshot + bounding boxes for the base
    // violations (the only state we screenshot). computeBoundingBoxes mutates
    // the same violation objects we just stored above, so target.boundingBox
    // flows through the reporter for base-visible elements. Non-fatal.
    if (opts.captureScreenshots && opts.scanId) {
      try {
        if (axe.violations.length > 0) {
          await computeBoundingBoxes(page, axe.violations);
        }
        screenshot = await captureScreenshot(page, {
          scanId: `${opts.scanId}-p${pageIndex}`,
          artifactsDir: opts.artifactsDir,
          fullPage: true,
        });
      } catch {
        screenshot = undefined; // screenshot failures must not fail the scan
      }
    }
  }

  // group clickables by structure-only signature
  const groups = new Map();
  for (const c of cands) {
    if (!groups.has(c.sig)) groups.set(c.sig, []);
    groups.get(c.sig).push(c);
  }
  const groupList = Array.from(groups.values())
    .map((m) => ({ sig: m[0].sig, members: m, count: m.length }))
    .sort((a, b) => b.count - a.count);

  let budget = opts.maxClicksPerPage;
  for (const g of groupList) {
    if (budget <= 0) break;
    const members = g.count <= opts.smallGroup ? g.members : g.members.slice(0, opts.sampleLarge);
    for (const m of members) {
      if (budget <= 0) break;
      if (opts.dangerPattern.test(m.name)) {
        states.push({ clicked: m.text || m.sig, outcome: 'skipped-danger' });
        continue;
      }
      budget--;

      await returnToBase(page, url, opts);
      const fresh = await page.evaluate(collectInPage);
      const cand = fresh.find((c) => c.sig === m.sig && c.text === m.text) || fresh.find((c) => c.sig === m.sig);
      if (!cand) { states.push({ clicked: m.text || m.sig, outcome: 'not-found' }); continue; }

      const before = page.url();
      const dom0 = await page.evaluate(probeState);
      try {
        await page.click(`[data-spike-id="${cand.id}"]`, { timeout: 2_500 });
      } catch {
        states.push({ clicked: m.text || m.sig, outcome: 'click-failed' });
        continue;
      }
      await page.waitForTimeout(opts.settleMs);

      const after = page.url();
      if (after !== before) {
        states.push({ clicked: m.text || m.sig, outcome: 'navigate', to: after });
        continue; // never follow click-navigation
      }

      const dom1 = await page.evaluate(probeState);
      const opened = dom1.dialog && !dom0.dialog;
      const grew = dom1.nodes - dom0.nodes >= opts.growThreshold;
      if (!opened && !grew) { states.push({ clicked: m.text || m.sig, outcome: 'no-op' }); continue; }
      if (seenStates.has(dom1.fp)) { states.push({ clicked: m.text || m.sig, outcome: 'dynamic-duplicate' }); continue; }

      seenStates.add(dom1.fp);
      const axe = await runAxe(page, { tags: opts.axeTags });
      states.push({
        clicked: m.text || m.sig,
        outcome: 'dynamic-scanned',
        raw: { violations: axe.violations, incomplete: axe.incomplete, meta: makeMeta(url, page.url(), axe) },
      });
    }
  }

  return { url, loadStatus: 'ok', landed, candidates: cands.length, classes: groupList.length, states, ...(screenshot ? { screenshot } : {}) };
}

/**
 * @typedef {Object} ExploreRequest
 * @property {(string | { url: string, ready?: string })[]} urls - the sitemap; the only source of navigation. Each entry is a URL string, or { url, ready } where `ready` is a per-page selector confirming that page finished loading.
 * @property {import('@digit-a11y/scanner').AuthConfig} [auth] - reuse scanner auth (use contextStrategy 'single' for DIGIT Studio)
 * @property {boolean} [manualLogin=false] - pause for a human to log in instead of using auth credentials
 * @property {(msg:string)=>Promise<void>} [waitForEnter] - required when manualLogin is true
 * @property {(evt: object) => void} [onProgress] - progress callback. Events: { phase:'session-ready', total, concurrency }; { phase:'page-start', pageIndex, url, completed, total }; { phase:'page-done', pageIndex, url, loadStatus, pageStates, completed, total, statesScanned }
 * @property {string} [scanId] - base id; when set with options.captureScreenshots, each page writes a base-state screenshot to {artifactsDir}/{scanId}-p{index}/
 * @property {Partial<typeof DEFAULTS>} [options]
 */

/**
 * Run the sitemap-anchored dynamic exploration.
 * @param {ExploreRequest} request
 * @returns {Promise<{ pages: object[], meta: object }>} raw per-state results
 */
export async function runExploration(request = {}) {
  const { urls = [], auth, manualLogin = false, waitForEnter, onProgress, scanId } = request;
  const opts = { ...DEFAULTS, ...(request.options ?? {}) };
  opts.scanId = scanId ?? null; // base id for per-page screenshot artifact dirs
  if (!Array.isArray(urls) || urls.length === 0) {
    throw new Error('runExploration: request.urls must be a non-empty array');
  }

  // A sitemap entry is either a plain URL string or { url, ready } where `ready`
  // is a per-page selector confirming that page finished loading (see
  // loadAndCollect). Plain strings keep working unchanged.
  const sitemap = urls.map((u) => (typeof u === 'string' ? { url: u } : u));

  // Optional progress hook (used by the API to drive a live UI). A bad callback
  // must never break the run.
  const emit = (evt) => { try { onProgress?.(evt); } catch { /* ignore */ } };

  // Concurrency: manual login can't be parallelized (one human at the keyboard),
  // so it forces sequential. Otherwise cap at the number of URLs.
  let concurrency = Math.max(1, Math.floor(Number(opts.concurrency ?? 1)));
  if (manualLogin) concurrency = 1;
  concurrency = Math.min(concurrency, sitemap.length);

  // TEMP diagnostic — remove once parallelism is confirmed.
  console.log(`[explorer] concurrency=${concurrency} (opts.concurrency=${opts.concurrency}, urls=${sitemap.length}, manualLogin=${manualLogin})`);

  const browser = await launchBrowser({ headless: opts.headless });
  const results = new Array(sitemap.length); // keep sitemap order regardless of finish order
  let completed = 0;
  let statesScanned = 0;

  emit({ phase: 'session-ready', total: sitemap.length, concurrency });

  const recordDone = (i, entry, pageResult) => {
    const pageStates = (pageResult.states ?? []).filter((s) => s.raw).length;
    statesScanned += pageStates;
    completed += 1;
    results[i] = pageResult;
    emit({
      phase: 'page-done',
      pageIndex: i,
      url: entry.url,
      loadStatus: pageResult.loadStatus,
      pageStates,
      completed,
      total: sitemap.length,
      statesScanned,
    });
  };

  try {
    if (concurrency === 1) {
      // Sequential: one context, one login, walk the sitemap in order.
      let context = null;
      try {
        const session = await establishSession(browser, { auth, manualLogin, waitForEnter });
        context = session.context;
        const { page } = session;
        const seen = new Set();
        for (let i = 0; i < sitemap.length; i++) {
          const entry = sitemap[i];
          emit({ phase: 'page-start', pageIndex: i, url: entry.url, completed, total: sitemap.length });
          const pageResult = await explorePage(page, entry.url, opts, seen, entry.ready, i);
          recordDone(i, entry, pageResult);
        }
      } finally {
        await closeContext(context);
      }
    } else {
      // Parallel: K isolated contexts, each logs in independently (concurrent
      // sessions for the same user are allowed), each drains a shared queue.
      // A worker that can't log in returns quietly; survivors drain the rest.
      let next = 0;
      const claim = () => (next < sitemap.length ? next++ : -1);

      const worker = async (wid) => {
        let context = null;
        try {
          let session;
          try {
            session = await establishSession(browser, { auth, manualLogin: false, waitForEnter });
            console.log(`[explorer] worker #${wid} logged in OK`);
          } catch (err) {
            console.error(`[explorer] worker #${wid} login FAILED:`, err?.message ?? err); // TEMP diagnostic
            return; // this worker couldn't establish a session; others cover the queue
          }
          context = session.context;
          const { page } = session;
          const seen = new Set(); // per-worker dedup (the report merges by rule anyway)
          for (let i = claim(); i !== -1; i = claim()) {
            const entry = sitemap[i];
            console.log(`[explorer] worker #${wid} → page ${i} (${entry.url})`); // TEMP diagnostic
            emit({ phase: 'page-start', pageIndex: i, url: entry.url, completed, total: sitemap.length });
            let pageResult;
            try {
              pageResult = await explorePage(page, entry.url, opts, seen, entry.ready, i);
            } catch (err) {
              pageResult = { url: entry.url, loadStatus: 'error', candidates: 0, states: [], error: String(err?.message ?? err) };
            }
            recordDone(i, entry, pageResult);
          }
        } finally {
          await closeContext(context);
        }
      };

      await Promise.all(Array.from({ length: concurrency }, (_, wid) => worker(wid)));
    }
  } finally {
    await closeBrowser(browser);
  }

  const pages = results.filter(Boolean);
  if (pages.length === 0 && sitemap.length > 0) {
    throw new Error('Exploration produced no pages — every worker failed to start (check auth/credentials).');
  }

  return {
    pages,
    meta: { urls: sitemap.map((e) => e.url), startedAt: new Date().toISOString(), statesSeen: statesScanned, concurrency },
  };
}
