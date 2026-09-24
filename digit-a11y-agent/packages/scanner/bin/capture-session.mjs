#!/usr/bin/env node
/**
 * Capture a browser session by logging in manually.
 *
 * Opens a real browser window, hands it to you, and waits. Log in however the
 * site demands — two-step form, OTP, SSO redirect, captcha, role picker, all
 * of it. Press ENTER when you're through, and the whole session is written to
 * a file that `type: 'session'` scans replay.
 *
 * This is the answer to "every site's login flow is different." It doesn't try
 * to describe the flow at all. You perform it once.
 *
 * Usage:
 *   node packages/scanner/bin/capture-session.mjs --url <url> --out <file>
 *
 * Options:
 *   --url      <url>   page to open first (usually the login page)   [required]
 *   --out      <file>  where to write the session   [default: ./session.json]
 *   --headless         run without a window (only useful for testing)
 *
 * Then:
 *   runScan({ url, auth: { type: 'session', sessionPath: './session.json' } })
 *
 * SECURITY: the output file is a live credential — it logs in as you, with no
 * password and no MFA. Don't commit it, don't share it, re-capture rather than
 * pass it around.
 */

import { writeFileSync } from 'node:fs';
import { createInterface } from 'node:readline';
import { launchBrowser, closeBrowser, createContext, closeContext } from '../src/browser.js';
import { captureSessionStorage } from '../src/auth/_shared.js';

/* ── args ─────────────────────────────────────────────────────────────────── */

function parseArgs(argv) {
  const out = { url: null, outFile: './session.json', headless: false };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--url')            out.url = argv[++i];
    else if (a === '--out')       out.outFile = argv[++i];
    else if (a === '--headless')  out.headless = true;
    else if (a === '--help' || a === '-h') out.help = true;
    else {
      console.error(`Unknown argument: ${a}`);
      out.badArg = true;
    }
  }
  return out;
}

const args = parseArgs(process.argv.slice(2));

// Asking for help is a success; missing or bad arguments are not.
if (args.help || args.badArg || !args.url) {
  console.log(`
Capture a browser session by logging in manually.

  node packages/scanner/bin/capture-session.mjs --url <url> [--out <file>]

  --url   <url>   page to open first (usually the login page)   [required]
  --out   <file>  where to write the session   [default: ./session.json]
  --headless      run without a window (testing only — you cannot log in)
`);
  process.exit(args.help && !args.badArg ? 0 : 1);
}

/** Wait for the operator to press ENTER. */
function waitForEnter(prompt) {
  const rl = createInterface({ input: process.stdin, output: process.stdout });
  return new Promise((resolve) => rl.question(prompt, () => { rl.close(); resolve(); }));
}

/* ── capture ──────────────────────────────────────────────────────────────── */

const browser = await launchBrowser({ headless: args.headless });
let exitCode = 0;

try {
  const context = await createContext(browser);
  const page = await context.newPage();

  console.log(`\nOpening ${args.url} …`);
  await page.goto(args.url, { waitUntil: 'domcontentloaded', timeout: 90_000 });

  console.log(`
────────────────────────────────────────────────────────────
  Log in in the browser window. Take as long as you need —
  multi-step forms, OTP, SSO and captcha are all fine.

  Finish on a page that is definitely signed in, then come
  back here.
────────────────────────────────────────────────────────────`);

  await waitForEnter('\n  Press ENTER once you are logged in … ');

  // The login may have opened tabs (SSO popups); snapshot whichever is in front.
  const pages = context.pages();
  const active = pages[pages.length - 1] ?? page;

  const storageState = await context.storageState();
  // sessionStorage is per-origin and Playwright's storageState omits it
  // entirely, so it has to be read off the live page.
  const sessionStorage = await captureSessionStorage(active);

  const payload = {
    ...storageState,
    _sessionStorage: sessionStorage,
    _capturedAt:     new Date().toISOString(),
    _capturedFrom:   active.url(),
  };

  const localKeys = storageState.origins.reduce((n, o) => n + (o.localStorage?.length ?? 0), 0);
  const sessionKeys = Object.keys(sessionStorage).length;

  if (storageState.cookies.length === 0 && localKeys === 0 && sessionKeys === 0) {
    console.error(`
  ✗ Nothing was captured — no cookies, no localStorage, no sessionStorage.
    You were probably not logged in yet. Nothing written.`);
    exitCode = 1;
  } else {
    writeFileSync(args.outFile, JSON.stringify(payload, null, 2), 'utf8');

    console.log(`
  ✓ Session written to ${args.outFile}

    cookies:        ${storageState.cookies.length}
    localStorage:   ${localKeys}
    sessionStorage: ${sessionKeys}
    captured from:  ${active.url()}

  Use it:
    auth: { type: 'session', sessionPath: '${args.outFile}' }

  ! This file logs in as you, with no password and no MFA.
    Do not commit it. Re-capture when it expires.
`);

    if (sessionKeys === 0) {
      console.log(`  Note: no sessionStorage captured. Fine if the app doesn't use it —
    but if the replayed session turns out to be logged out, check whether
    you were on the app's own origin when you pressed ENTER.\n`);
    }
  }

  await closeContext(context);
} catch (err) {
  console.error(`\n  ✗ Capture failed: ${err.message.split('\n')[0]}`);
  exitCode = 1;
} finally {
  await closeBrowser(browser);
}

process.exit(exitCode);
