import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { createServer } from 'node:http';
import { captureAuth, AuthError } from '../../src/auth/index.js';
import { launchBrowser, closeBrowser } from '../../src/browser.js';

// ─── Unit tests: config validation (no browser) ──────────────────────────────

describe('captureAuth() — token config validation', () => {
  it('rejects token config with neither token nor cookies', async () => {
    await expect(captureAuth(null, {
      type: 'token',
      loginUrl: 'https://example.gov.in',
    })).rejects.toMatchObject({
      name: 'AuthError',
      code: 'INVALID_AUTH_CONFIG',
    });
  });

  it('rejects token without tokenStorageKey', async () => {
    await expect(captureAuth(null, {
      type: 'token',
      loginUrl: 'https://example.gov.in',
      token: 'eyJhbGc...',
    })).rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });

  it('rejects malformed cookies', async () => {
    await expect(captureAuth(null, {
      type: 'token',
      loginUrl: 'https://example.gov.in',
      cookies: [{ name: 'session' /* no value, no domain */ }],
    })).rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });
});

// ─── Real-browser tests: full token-injection flow ───────────────────────────

const fixturePage = `<!DOCTYPE html>
<html>
<head><title>Token Auth Test Page</title></head>
<body>
  <h1 id="header">Welcome</h1>
  <div id="protected" style="display:none">
    <h2>Protected content visible only when token is present</h2>
  </div>
  <script>
    // Show "protected" div if there's a valid-looking token
    const token = localStorage.getItem('jwt_token');
    if (token && token.startsWith('eyJ')) {
      document.getElementById('protected').style.display = 'block';
    }
  </script>
</body>
</html>`;

describe('captureAuth() — [browser] token auth end-to-end', () => {
  let server;
  let baseUrl;

  beforeAll(async () => {
    server = createServer((_req, res) => {
      res.setHeader('Content-Type', 'text/html; charset=utf-8');
      res.end(fixturePage);
    });
    await new Promise((resolve) => server.listen(0, '127.0.0.1', resolve));
    baseUrl = `http://127.0.0.1:${server.address().port}`;
  });

  afterAll(async () => {
    if (server) {
      await new Promise((resolve) => server.close(resolve));
    }
  });

  it('injects token into localStorage and captures storage state', async () => {
    const browser = await launchBrowser();
    try {
      const fakeJwt = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ0ZXN0In0.signature';
      const state = await captureAuth(browser, {
        type: 'token',
        loginUrl: baseUrl + '/',
        token: fakeJwt,
        tokenStorageKey: 'jwt_token',
      });

      expect(state).toBeDefined();
      const allLocalStorage = state.origins.flatMap((o) => o.localStorage ?? []);
      const tokenEntry = allLocalStorage.find((kv) => kv.name === 'jwt_token');
      expect(tokenEntry).toBeDefined();
      expect(tokenEntry.value).toBe(fakeJwt);
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);

  it('injects token AND verifies via successSelector after reload', async () => {
    const browser = await launchBrowser();
    try {
      const fakeJwt = 'eyJhbGc.payload.signature';
      const state = await captureAuth(browser, {
        type: 'token',
        loginUrl: baseUrl + '/',
        token: fakeJwt,
        tokenStorageKey: 'jwt_token',
        successSelector: '#protected',  // visible after reload if token took effect
      });

      expect(state).toBeDefined();
      const ls = state.origins.flatMap((o) => o.localStorage ?? []);
      expect(ls.find((kv) => kv.name === 'jwt_token')?.value).toBe(fakeJwt);
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);

  it('reports AUTH_TOKEN_VERIFY_FAILED when token does not unlock the success indicator', async () => {
    const browser = await launchBrowser();
    try {
      // Token doesn't start with 'eyJ' — fixture won't reveal the protected div
      await expect(captureAuth(browser, {
        type: 'token',
        loginUrl: baseUrl + '/',
        token: 'bogus-token-format',
        tokenStorageKey: 'jwt_token',
        successSelector: '#protected',
        timeouts: { verification: 3_000 },  // shorten to keep test fast
      })).rejects.toMatchObject({
        name: 'AuthError',
        code: 'AUTH_TOKEN_VERIFY_FAILED',
      });
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);

  it('injects cookies into the context', async () => {
    const browser = await launchBrowser();
    try {
      const state = await captureAuth(browser, {
        type: 'token',
        loginUrl: baseUrl + '/',
        cookies: [
          { name: 'session_id', value: 'abc123', url: baseUrl + '/' },
          { name: 'user_role', value: 'auditor', url: baseUrl + '/' },
        ],
      });

      const cookieMap = Object.fromEntries(state.cookies.map((c) => [c.name, c.value]));
      expect(cookieMap.session_id).toBe('abc123');
      expect(cookieMap.user_role).toBe('auditor');
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);
});
