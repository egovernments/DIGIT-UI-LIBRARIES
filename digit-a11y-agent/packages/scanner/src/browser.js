/**
 * Browser lifecycle and context management.
 *
 * Encapsulates Playwright's browser/context creation so the rest of the scanner
 * doesn't import Playwright directly. Lets us swap Chromium for Firefox/WebKit
 * in tests if needed, and centralises common defaults (viewport, user agent,
 * timeouts).
 *
 * Phase 1 Day 2: launch + context creation + clean shutdown.
 * Phase 1 Day 3-4: storageState gets passed in for authenticated scans.
 *
 * @see ./index.js — the orchestrator that uses this.
 */

import { chromium } from 'playwright';

/**
 * Default Playwright launch options. Tuned for headless server-side scanning.
 *
 * - headless: true in production. Override to false for debugging.
 * - args: hardening / CI-friendly flags. --no-sandbox is required when running
 *   inside a Docker container as root (which is how our Dockerfile runs).
 */
const DEFAULT_LAUNCH_OPTIONS = {
  headless: true,
  args: [
    '--no-sandbox',
    '--disable-setuid-sandbox',
    '--disable-dev-shm-usage',
    '--disable-blink-features=AutomationControlled',
  ],
  timeout: 30_000,  // browser launch timeout
};

/**
 * Default context options. The viewport matches a common desktop size;
 * govt portals are designed for desktops first so this is the sensible default.
 * Mobile viewport testing comes in Phase 3.
 */
const DEFAULT_CONTEXT_OPTIONS = {
  viewport: { width: 1280, height: 800 },
  deviceScaleFactor: 1,
  ignoreHTTPSErrors: true,   // many govt UAT/staging hosts have self-signed certs
  locale: 'en-IN',
  timezoneId: 'Asia/Kolkata',
  // Identify scans as scanner traffic so server-side logs can correlate them.
  userAgent:
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 ' +
    '(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 ' +
    'DigitA11yScanner/0.1',
};

/**
 * Launch a fresh Chromium browser.
 *
 * @param {object} [options]
 * @param {boolean} [options.headless=true]
 * @param {number}  [options.timeout=30000]
 * @returns {Promise<import('playwright').Browser>}
 *
 * @throws {Error} if Chromium binaries are missing (`playwright install chromium`)
 */
export async function launchBrowser(options = {}) {
  const launchOptions = { ...DEFAULT_LAUNCH_OPTIONS, ...options };
  try {
    return await chromium.launch(launchOptions);
  } catch (err) {
    if (/Executable doesn't exist/.test(err.message)) {
      throw new Error(
        'Playwright Chromium is not installed. Run:\n' +
        '  pnpm exec playwright install chromium\n' +
        '(One-time setup, ~150MB download.)',
      );
    }
    throw err;
  }
}

/**
 * Create a fresh, isolated browser context. Each scan gets its own context
 * so cookies and localStorage never leak across scans.
 *
 * @param {import('playwright').Browser} browser
 * @param {object} [options]
 * @param {import('playwright').BrowserContextOptions['storageState']} [options.storageState]
 *   Optional auth state (cookies + localStorage) captured by the auth flow.
 *   Phase 1 Day 3-4 wires this up.
 * @returns {Promise<import('playwright').BrowserContext>}
 */
export async function createContext(browser, options = {}) {
  const contextOptions = { ...DEFAULT_CONTEXT_OPTIONS, ...options };
  const context = await browser.newContext(contextOptions);

  // Reasonable per-page default timeouts (scan-level overrides come from runScan)
  context.setDefaultTimeout(30_000);
  context.setDefaultNavigationTimeout(30_000);

  return context;
}

/**
 * Best-effort context close. Never throws — callers wrap in finally blocks
 * and we don't want cleanup errors masking the real scan error.
 *
 * @param {import('playwright').BrowserContext | null | undefined} context
 */
export async function closeContext(context) {
  if (!context) return;
  try {
    await context.close();
  } catch {
    // Already closed or browser crashed — ignore.
  }
}

/**
 * Best-effort browser close. Same rationale as closeContext.
 *
 * @param {import('playwright').Browser | null | undefined} browser
 */
export async function closeBrowser(browser) {
  if (!browser) return;
  try {
    await browser.close();
  } catch {
    // Already closed or process exited — ignore.
  }
}

/**
 * Exposed for tests to verify defaults haven't drifted.
 */
export const _defaults = {
  launch:  DEFAULT_LAUNCH_OPTIONS,
  context: DEFAULT_CONTEXT_OPTIONS,
};
