/**
 * Live session-capture store.
 *
 * Backs the "log in for me" flow: the UI asks the server to open a real
 * browser window, a human completes whatever login the site demands (two-step
 * form, OTP, SSO, captcha), and the resulting session is handed back to the
 * browser tab that asked for it.
 *
 * This is the piece that makes *any* login flow reachable from the UI. Form
 * auth can only drive one shape of login; a human can drive all of them.
 *
 * Constraints worth knowing:
 *   - The browser window opens on the machine running the API, not on the
 *     user's machine. Local dev and docker-compose-on-your-laptop are fine;
 *     a remote server is not, and headless hosts fail fast with a clear error
 *     pointing at the upload path instead.
 *   - Captures are held in memory only and never written to disk. They are
 *     live credentials.
 *   - Abandoned captures leave a browser process running, so every capture
 *     gets a hard TTL after which it is killed.
 *
 * @see ../routes/session.js
 * @see ../../../scanner/bin/capture-session.mjs — the CLI equivalent
 */

import { randomUUID } from 'node:crypto';
import {
  launchBrowser,
  closeBrowser,
  createContext,
  closeContext,
  captureSessionStorage,
  looksLikeLoginUrl,
} from '@digit-a11y/scanner';
import { logger } from '../logger.js';

/** Abandoned captures hold a browser process open; reap them. */
const DEFAULT_TTL_MS = 15 * 60 * 1000;

/** One human, one keyboard. More than a couple of windows at once is a mistake. */
const DEFAULT_MAX_CONCURRENT = 3;

export class SessionCaptureStore {
  constructor({ ttlMs = DEFAULT_TTL_MS, maxConcurrent = DEFAULT_MAX_CONCURRENT } = {}) {
    /** @type {Map<string, object>} */
    this._captures = new Map();
    this._ttlMs = ttlMs;
    this._maxConcurrent = maxConcurrent;
  }

  /**
   * Open a browser window at `url` and wait for a human.
   *
   * @param {string} url
   * @returns {Promise<{id: string, status: string, url: string, expiresAt: number}>}
   * @throws {Error} with .code CAPTURE_UNAVAILABLE when no display is available
   */
  async start(url) {
    this._reapExpired();

    if (this._activeCount() >= this._maxConcurrent) {
      const err = new Error(
        `Too many login windows open at once (${this._maxConcurrent}). ` +
        `Finish or cancel one before starting another.`);
      err.code = 'CAPTURE_LIMIT_REACHED';
      throw err;
    }

    let browser, context, page;
    try {
      browser = await launchBrowser({ headless: false });
      context = await createContext(browser);
      page = await context.newPage();
      await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 90_000 });
    } catch (cause) {
      // Best-effort teardown; the launch may have half-succeeded.
      await closeContext(context).catch(() => {});
      await closeBrowser(browser).catch(() => {});

      const err = new Error(
        `Could not open a browser window on the server: ${cause.message.split('\n')[0]}. ` +
        `This flow needs a desktop session — it cannot work on a headless or ` +
        `remote host. Capture the session on your own machine instead:\n` +
        `  node packages/scanner/bin/capture-session.mjs --url ${url} --out session.json\n` +
        `then upload that file.`);
      err.code = 'CAPTURE_UNAVAILABLE';
      throw err;
    }

    const id = `cap_${randomUUID().replace(/-/g, '').slice(0, 16)}`;
    const now = Date.now();
    const capture = {
      id,
      status:    'waiting',
      url,
      createdAt: now,
      expiresAt: now + this._ttlMs,
      _browser:  browser,
      _context:  context,
      _page:     page,
    };
    this._captures.set(id, capture);

    // If the operator wanders off, don't leak a browser process forever.
    capture._timer = setTimeout(() => {
      logger.warn({ captureId: id }, 'Session capture expired; closing browser.');
      this.cancel(id, 'expired').catch(() => {});
    }, this._ttlMs);
    capture._timer.unref?.();

    return this._public(capture);
  }

  /** @returns {object|null} */
  get(id) {
    this._reapExpired();
    const c = this._captures.get(id);
    return c ? this._public(c) : null;
  }

  /**
   * Snapshot the logged-in session and close the browser.
   *
   * @param {string} id
   * @returns {Promise<object>} a session object, same shape the CLI writes
   */
  async finish(id) {
    const capture = this._captures.get(id);
    if (!capture) {
      const err = new Error('No such capture, or it already finished/expired.');
      err.code = 'CAPTURE_NOT_FOUND';
      throw err;
    }
    if (capture.status !== 'waiting') {
      const err = new Error(`Capture is ${capture.status}, not waiting.`);
      err.code = 'CAPTURE_NOT_WAITING';
      throw err;
    }

    try {
      // Login may have opened tabs (SSO popups); snapshot whichever is in front.
      const pages = capture._context.pages();
      const active = pages[pages.length - 1] ?? capture._page;

      const storageState = await capture._context.storageState();
      // storageState carries cookies + localStorage only; sessionStorage has
      // to be read off the live page or SPAs that use it come back logged out.
      const sessionStorage = await captureSessionStorage(active);

      const localKeys = storageState.origins
        .reduce((n, o) => n + (o.localStorage?.length ?? 0), 0);
      const sessionKeys = Object.keys(sessionStorage).length;

      if (storageState.cookies.length === 0 && localKeys === 0 && sessionKeys === 0) {
        const err = new Error(
          'Nothing was captured — no cookies, no localStorage, no sessionStorage. ' +
          'You were probably not signed in yet. Log in, then try again.');
        err.code = 'CAPTURE_EMPTY';
        throw err;
      }

      // "Not empty" is a weak signal for "logged in": a login page alone sets
      // analytics cookies and app-shell storage. Measured against Studio UAT,
      // a capture taken before signing in still carried 16 cookies, 4
      // localStorage keys and 6 sessionStorage keys. So check the page too.
      const warning = await this._notLoggedInWarning(active);

      const session = {
        ...storageState,
        _sessionStorage: sessionStorage,
        _capturedAt:     new Date().toISOString(),
        _capturedFrom:   active.url(),
      };

      capture.status = 'complete';
      await this._teardown(capture);
      this._captures.delete(id);

      logger.info(
        { captureId: id, cookies: storageState.cookies.length, localKeys, sessionKeys,
          suspectedNotLoggedIn: Boolean(warning) },
        'Session captured.');

      return {
        session,
        summary: {
          cookies:        storageState.cookies.length,
          localStorage:   localKeys,
          sessionStorage: sessionKeys,
          capturedFrom:   active.url(),
          ...(warning ? { warning } : {}),
        },
      };
    } catch (err) {
      // An empty capture is recoverable — keep the window open so the operator
      // can finish logging in and retry. Anything else, tear down.
      if (err.code !== 'CAPTURE_EMPTY') {
        capture.status = 'failed';
        await this._teardown(capture);
        this._captures.delete(id);
      }
      throw err;
    }
  }

  /**
   * Close a capture's browser without snapshotting.
   * @param {string} id
   * @param {string} [reason]
   */
  async cancel(id, reason = 'cancelled') {
    const capture = this._captures.get(id);
    if (!capture) return false;
    capture.status = reason;
    await this._teardown(capture);
    this._captures.delete(id);
    return true;
  }

  /** Close every open capture. Called on shutdown. */
  async closeAll() {
    const ids = [...this._captures.keys()];
    await Promise.all(ids.map((id) => this.cancel(id, 'shutdown')));
  }

  /**
   * Does the page we're snapshotting still look like a login screen?
   *
   * Returned as a warning, not an error: some apps keep a password field
   * mounted after sign-in, and wrongly rejecting a good capture is worse than
   * flagging a doubtful one. The scan-time preflight is the real gate.
   *
   * @returns {Promise<string|null>}
   */
  async _notLoggedInWarning(page) {
    try {
      const onLoginUrl = looksLikeLoginUrl(page.url());
      const passwordVisible = await page
        .locator('input[type="password"]').first().isVisible().catch(() => false);

      if (!onLoginUrl && !passwordVisible) return null;

      return 'This still looks like a login page' +
        (onLoginUrl ? ' (the URL is a login route)' : ' (a password field is visible)') +
        '. The session was saved, but it may not be signed in. Set a signed-in ' +
        'element selector so scans fail loudly instead of auditing the login screen.';
    } catch {
      return null;
    }
  }

  /** @returns {number} */
  _activeCount() {
    let n = 0;
    for (const c of this._captures.values()) if (c.status === 'waiting') n++;
    return n;
  }

  async _teardown(capture) {
    clearTimeout(capture._timer);
    await closeContext(capture._context).catch(() => {});
    await closeBrowser(capture._browser).catch(() => {});
    capture._browser = capture._context = capture._page = null;
  }

  _reapExpired() {
    const now = Date.now();
    for (const [id, c] of this._captures) {
      if (c.expiresAt < now) this.cancel(id, 'expired').catch(() => {});
    }
  }

  /** Strip browser handles — never serialise those to a response. */
  _public(c) {
    return {
      id:        c.id,
      status:    c.status,
      url:       c.url,
      createdAt: c.createdAt,
      expiresAt: c.expiresAt,
    };
  }

  /** Test-only. */
  async _clear() {
    await this.closeAll();
    this._captures.clear();
  }
}

/** Module-level singleton used by the running server. Tests create their own. */
export const sessionCaptureStore = new SessionCaptureStore();
