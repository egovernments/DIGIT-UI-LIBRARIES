import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { createServer } from 'node:http';
import { assertAuthenticated, looksLikeLoginUrl } from '../../src/auth/preflight.js';
import { launchBrowser, closeBrowser, createContext, closeContext } from '../../src/browser.js';

describe('looksLikeLoginUrl()', () => {
  it('matches common login paths', () => {
    for (const u of [
      'https://x.gov.in/employee/user/login',
      'https://x.gov.in/signin',
      'https://x.gov.in/sign-in/',
      'https://x.gov.in/session-expired',
    ]) expect(looksLikeLoginUrl(u)).toBe(true);
  });

  it('does not match authenticated routes that merely contain auth-ish words', () => {
    // A bare /auth/ segment appears in plenty of signed-in routes; matching it
    // would fail good scans.
    for (const u of [
      'https://x.gov.in/employee/servicedesigner/proceed-as',
      'https://x.gov.in/auth/profile',
      'https://x.gov.in/dashboard',
      'https://x.gov.in/logins-report',
    ]) expect(looksLikeLoginUrl(u)).toBe(false);
  });

  it('falls back to string matching for unparseable input', () => {
    expect(looksLikeLoginUrl('/user/login')).toBe(true);
    expect(looksLikeLoginUrl('garbage')).toBe(false);
  });
});

/* ── Real-browser preflight behaviour ─────────────────────────────────────── */

const LOGIN_HTML = `<!DOCTYPE html><html><body>
  <h1>Sign in</h1>
  <input type="text" name="username" />
  <input type="password" name="password" />
</body></html>`;

const APP_HTML = `<!DOCTYPE html><html><body>
  <h1>Dashboard</h1>
  <button id="logout">Log out</button>
  <p>Welcome back.</p>
</body></html>`;

let server, base, browser;

beforeAll(async () => {
  server = createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/html' });
    // /protected pretends the session died and bounces to the login screen.
    if (req.url.startsWith('/protected')) return res.end(LOGIN_HTML);
    if (req.url.startsWith('/user/login')) return res.end(LOGIN_HTML);
    return res.end(APP_HTML);
  });
  await new Promise((r) => server.listen(0, '127.0.0.1', r));
  base = `http://127.0.0.1:${server.address().port}`;
  browser = await launchBrowser();
}, 60_000);

afterAll(async () => {
  await closeBrowser(browser);
  await new Promise((r) => server.close(r));
});

async function withPage(fn) {
  const context = await createContext(browser);
  const page = await context.newPage();
  try { return await fn(page); } finally { await closeContext(context); }
}

describe('assertAuthenticated() [browser]', () => {
  it('passes on a signed-in page via the heuristic', async () => {
    await withPage(async (page) => {
      await page.goto(`${base}/dashboard`);
      const r = await assertAuthenticated(page, { type: 'form' }, `${base}/dashboard`);
      expect(r).toMatchObject({ checked: true, via: 'heuristic' });
    });
  }, 30_000);

  it('fails when the target shows a login form — the silent-false-pass case', async () => {
    await withPage(async (page) => {
      await page.goto(`${base}/protected`);
      await expect(
        assertAuthenticated(page, { type: 'form' }, `${base}/protected`),
      ).rejects.toMatchObject({
        name: 'AuthError',
        code: 'SESSION_NOT_AUTHENTICATED',
      });
    });
  }, 30_000);

  it('passes when authedSelector is present', async () => {
    await withPage(async (page) => {
      await page.goto(`${base}/dashboard`);
      const r = await assertAuthenticated(
        page, { type: 'form', authedSelector: '#logout' }, `${base}/dashboard`,
      );
      expect(r).toMatchObject({ checked: true, via: 'authedSelector' });
    });
  }, 30_000);

  it('fails when authedSelector never appears', async () => {
    await withPage(async (page) => {
      await page.goto(`${base}/protected`);
      await expect(
        assertAuthenticated(
          page, { type: 'form', authedSelector: '#logout' }, `${base}/protected`,
          { timeoutMs: 1_000 },
        ),
      ).rejects.toMatchObject({ code: 'SESSION_NOT_AUTHENTICATED' });
    });
  }, 30_000);

  it('does not fire when the scan target is itself a login page', async () => {
    // Auditing a login screen is legitimate — that page is where screen-reader
    // users get stuck, so it must remain scannable.
    await withPage(async (page) => {
      await page.goto(`${base}/user/login`);
      const r = await assertAuthenticated(page, { type: 'form' }, `${base}/user/login`);
      expect(r).toMatchObject({ checked: false, via: 'target-is-login-page' });
    });
  }, 30_000);

  it('honours skipPreflight', async () => {
    await withPage(async (page) => {
      await page.goto(`${base}/protected`);
      const r = await assertAuthenticated(
        page, { type: 'form', skipPreflight: true }, `${base}/protected`,
      );
      expect(r).toMatchObject({ checked: false, via: 'skipped' });
    });
  }, 30_000);

  it('is a no-op when no auth was requested', async () => {
    await withPage(async (page) => {
      await page.goto(`${base}/protected`);
      const r = await assertAuthenticated(page, null, `${base}/protected`);
      expect(r.checked).toBe(false);
    });
  }, 30_000);
});
