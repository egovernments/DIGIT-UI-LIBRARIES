/**
 * Diagnostic: WHY does contextStrategy 'reuse' fail on DIGIT Studio UAT?
 *
 * PHASE1_RETROSPECTIVE.md claims "Studio UAT binds sessions to browser context."
 * That was a conclusion, never a diagnosis. This script tests it.
 *
 * Note that createContext() hardcodes userAgent / viewport / locale / timezone,
 * so a fresh context is fingerprint-identical to the auth context. There is
 * nothing for the server to "bind" against. The only real difference between
 * 'single' and 'reuse' is what survives the storageState round-trip — and
 * Playwright's storageState carries cookies + localStorage ONLY. sessionStorage
 * and IndexedDB are dropped.
 *
 * Three experiments:
 *   A. Log in inside a live context ('single' equivalent). Dump every place
 *      browser-side auth state can hide.
 *   B. Round-trip that state into a fresh context ('reuse' equivalent).
 *      Expected to fail today.
 *   C. Same as B, but also replay sessionStorage via addInitScript.
 *
 * Reading the result:
 *   B fails + C passes  → sessionStorage is the root cause. Fingerprinting ruled
 *                         out. Fix = capture/restore sessionStorage centrally.
 *   B fails + C fails   → look at the IndexedDB names printed in A; if empty,
 *                         real session binding becomes plausible.
 *   B passes            → 'reuse' already works; the retrospective is stale.
 *
 * Token values are never printed — only key names, lengths, and a short prefix.
 *
 * Usage:  node packages/scanner/diagnose-session-roundtrip.mjs
 *         HEADED=1 node packages/scanner/diagnose-session-roundtrip.mjs
 *
 * Throwaway diagnostic — safe to delete once the question is settled.
 */

import { launchBrowser, closeBrowser } from './src/browser.js';
import { createContext, closeContext } from './src/browser.js';
import { runFormAuthInPage } from './src/auth/form.js';

const USERNAME = process.env.STUDIO_USER ?? 'STUDIOUAT';
const PASSWORD = process.env.STUDIO_PASS ?? 'eGov@123';

const LOGIN_URL  = 'https://unified-uat.digit.org/digit-studio/employee/user/login';
const TARGET_URL = 'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/proceed-as';

// Deliberately URL-based, not selector-based. Post-login copy on Studio has
// already changed once ("Design and Launch Public Services" is stale); a URL
// check survives redesigns and keeps this diagnostic honest.
const AUTH_CONFIG = {
  type: 'form',
  loginUrl: LOGIN_URL,
  // The privacy checkbox gates the Login button — it renders `disabled` until
  // this is ticked, so this is a prerequisite, not a cosmetic dismissal.
  dismissSelectors: ['#privacy-component-check'],
  fields: {
    'input[name="username"]': USERNAME,
    'input[name="password"]': PASSWORD,
  },
  submitSelector: 'button.digit-submit-bar',
  successUrl:     '/servicedesigner/',
  // This UAT host is genuinely slow and intermittently takes >60s to mount the
  // login form at all. Generous timeouts keep flakiness from masquerading as
  // an auth failure.
  timeouts: {
    navigation:  90_000,
    dismiss:     60_000,
    fieldFill:   60_000,
    submit:      30_000,
    successWait: 90_000,
  },
};

/** Redact a secret-ish value: never print it in full. */
const preview = (v) =>
  typeof v === 'string'
    ? `${v.length} chars, starts "${v.slice(0, 8)}…"`
    : typeof v;

/** Dump every browser-side store that could hold auth state. */
async function dumpState(page, context) {
  const session = await page.evaluate(() => {
    const out = {};
    for (let i = 0; i < sessionStorage.length; i++) {
      const k = sessionStorage.key(i);
      out[k] = sessionStorage.getItem(k);
    }
    return out;
  });

  const local = await page.evaluate(() => {
    const out = {};
    for (let i = 0; i < localStorage.length; i++) {
      const k = localStorage.key(i);
      out[k] = localStorage.getItem(k);
    }
    return out;
  });

  const idbNames = await page.evaluate(async () => {
    if (!indexedDB.databases) return ['(indexedDB.databases() unsupported)'];
    try {
      return (await indexedDB.databases()).map((d) => d.name);
    } catch (e) {
      return [`(error: ${e.message})`];
    }
  });

  const cookies = await context.cookies();

  return { session, local, idbNames, cookies };
}

/**
 * Is this page actually authenticated?
 *
 * Three signals, none of which depend on knowing the post-login copy:
 *   - did the SPA bounce us back to /user/login?
 *   - is a password field on screen? (the login form, whatever the URL says)
 *   - did any real content render? (guards against a blank error shell
 *     counting as "logged in" just because it isn't the login page)
 */
async function checkAuthed(page, label) {
  await page.goto(TARGET_URL, { waitUntil: 'domcontentloaded', timeout: 60_000 });
  // The SPA bootstraps, reads its token, and only then decides to redirect.
  await page.waitForTimeout(6_000);

  const finalUrl = page.url();
  const redirectedToLogin = /\/user\/login/i.test(finalUrl);

  const passwordVisible = await page
    .locator('input[type="password"]')
    .first()
    .isVisible()
    .catch(() => false);

  const bodyChars = await page
    .evaluate(() => document.body?.innerText?.trim().length ?? 0)
    .catch(() => 0);

  const authed = !redirectedToLogin && !passwordVisible && bodyChars > 50;
  console.log(`  [${label}] final URL:           ${finalUrl}`);
  console.log(`  [${label}] redirected to login: ${redirectedToLogin}`);
  console.log(`  [${label}] password field shown: ${passwordVisible}`);
  console.log(`  [${label}] rendered text chars:  ${bodyChars}`);
  console.log(`  [${label}] → AUTHENTICATED:      ${authed ? 'YES' : 'NO'}`);
  return authed;
}

const headless = process.env.HEADED !== '1';
const browser = await launchBrowser({ headless });
let resultB = null;
let resultC = null;
let snapshot = null;

try {
  /* ── A. Log in inside one live context ('single' equivalent) ─────────── */
  console.log('\n══ A. Live login, then dump all browser-side state ══\n');

  const authCtx  = await createContext(browser);
  const authPage = await authCtx.newPage();
  await runFormAuthInPage(authPage, AUTH_CONFIG);
  console.log('  ✓ Form login succeeded');

  const state = await dumpState(authPage, authCtx);
  snapshot = state;

  console.log(`\n  sessionStorage — ${Object.keys(state.session).length} key(s):`);
  for (const [k, v] of Object.entries(state.session)) {
    console.log(`    - ${k}: ${preview(v)}`);
  }
  if (!Object.keys(state.session).length) console.log('    (empty)');

  console.log(`\n  localStorage — ${Object.keys(state.local).length} key(s):`);
  for (const k of Object.keys(state.local)) console.log(`    - ${k}`);
  if (!Object.keys(state.local).length) console.log('    (empty)');

  console.log(`\n  IndexedDB databases: ${JSON.stringify(state.idbNames)}`);

  console.log(`\n  Cookies — ${state.cookies.length}:`);
  for (const c of state.cookies) {
    console.log(`    - ${c.name} (domain=${c.domain} httpOnly=${c.httpOnly} sameSite=${c.sameSite})`);
  }

  // What Playwright will actually carry across.
  const storageState = await authCtx.storageState();
  const carriedLocal = storageState.origins.flatMap((o) => o.localStorage ?? []).length;
  console.log(`\n  storageState carries: ${storageState.cookies.length} cookie(s), ${carriedLocal} localStorage entr(ies)`);
  console.log(`  storageState DROPS:   ${Object.keys(state.session).length} sessionStorage key(s)`);

  await closeContext(authCtx);

  /* ── B. Round-trip into a fresh context ('reuse' equivalent) ─────────── */
  console.log('\n══ B. Fresh context + storageState only  (today\'s "reuse") ══\n');

  const ctxB  = await createContext(browser, { storageState });
  const pageB = await ctxB.newPage();
  resultB = await checkAuthed(pageB, 'B');
  await closeContext(ctxB);

  /* ── C. Same, but replay sessionStorage too (the proposed fix) ────────── */
  console.log('\n══ C. Fresh context + storageState + sessionStorage replay ══\n');

  const ctxC = await createContext(browser, { storageState });
  await ctxC.addInitScript((json) => {
    try {
      for (const [k, v] of Object.entries(JSON.parse(json))) {
        sessionStorage.setItem(k, v);
      }
    } catch { /* about:blank etc. — sessionStorage may be unavailable */ }
  }, JSON.stringify(state.session));

  const pageC = await ctxC.newPage();
  resultC = await checkAuthed(pageC, 'C');
  await closeContext(ctxC);

} catch (err) {
  console.log('\n✗ Diagnostic aborted');
  console.log('  ', err.code ?? err.name, '—', err.message.split('\n')[0]);
} finally {
  await closeBrowser(browser);
}

/* ── Verdict ───────────────────────────────────────────────────────────── */
console.log('\n══ VERDICT ══\n');
const sessionKeys = snapshot ? Object.keys(snapshot.session).length : 0;

if (resultB === true) {
  console.log('  "reuse" already works. The retrospective is stale — no session');
  console.log('  binding, no missing state. Re-test the Studio preset.');
} else if (resultB === false && resultC === true) {
  console.log('  ROOT CAUSE CONFIRMED: sessionStorage.');
  console.log(`  Studio keeps ${sessionKeys} key(s) there; storageState drops them.`);
  console.log('  NOT fingerprint binding. Fix = capture + replay sessionStorage,');
  console.log('  then "single" stops being needed for this site.');
} else if (resultB === false && resultC === false) {
  console.log('  sessionStorage alone does NOT explain it.');
  console.log(`  Check the IndexedDB names above (found: ${snapshot ? JSON.stringify(snapshot.idbNames) : 'n/a'}).`);
  console.log('  If non-empty, retry with storageState({ indexedDB: true }) — Playwright 1.60 supports it.');
  console.log('  If empty, real server-side session binding becomes plausible.');
} else {
  console.log('  Inconclusive — the run aborted before both experiments finished.');
}
console.log();
