import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { createServer } from 'node:http';
import { captureAuth, AuthError } from '../../src/auth/index.js';
import { launchBrowser, closeBrowser } from '../../src/browser.js';

// ─── Unit tests: config validation (no browser) ──────────────────────────────

describe('captureAuth() — form config validation', () => {
  it('rejects null/undefined config', async () => {
    await expect(captureAuth(null, null)).rejects.toMatchObject({
      name: 'AuthError', code: 'INVALID_AUTH_CONFIG',
    });
  });

  it('rejects missing type', async () => {
    await expect(captureAuth(null, { loginUrl: 'https://e.com' }))
      .rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });

  it('rejects unknown auth types', async () => {
    await expect(captureAuth(null, { type: 'magic-link', loginUrl: 'https://e.com' }))
      .rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });

  it('rejects form config missing fields', async () => {
    await expect(captureAuth(null, {
      type: 'form', loginUrl: 'https://e.com/login',
      submitSelector: '#submit', successSelector: '#done',
    })).rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });

  it('rejects form config missing submitSelector', async () => {
    await expect(captureAuth(null, {
      type: 'form', loginUrl: 'https://e.com/login',
      fields: { '#u': 'x' }, successSelector: '#done',
    })).rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });

  it('rejects form config missing both success indicators', async () => {
    await expect(captureAuth(null, {
      type: 'form', loginUrl: 'https://e.com/login',
      fields: { '#u': 'x' }, submitSelector: '#submit',
    })).rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });

  it('rejects form config with non-array dismissSelectors', async () => {
    await expect(captureAuth(null, {
      type: 'form', loginUrl: 'https://e.com/login',
      fields: { '#u': 'x' }, submitSelector: '#submit',
      successSelector: '#done',
      dismissSelectors: 'not-an-array',
    })).rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });

  it('oauth reports not-yet-implemented (Phase 3)', async () => {
    await expect(captureAuth(null, {
      type: 'oauth', loginUrl: 'https://e.com',
    })).rejects.toMatchObject({ code: 'NOT_IMPLEMENTED' });
  });
});

describe('AuthError', () => {
  it('is a real Error subclass with a code property', () => {
    const err = new AuthError('SOME_CODE', 'message');
    expect(err).toBeInstanceOf(Error);
    expect(err.name).toBe('AuthError');
    expect(err.code).toBe('SOME_CODE');
  });
});

// ─── Real-browser tests ──────────────────────────────────────────────────────

const fixtureLoginPage = `<!DOCTYPE html>
<html>
<head><title>Test Login</title></head>
<body>
  <h1>Sign in</h1>
  <form id="login">
    <input id="username" type="text" />
    <input id="password" type="password" />
    <button id="submit" type="button">Sign in</button>
  </form>
  <div id="dashboard" style="display:none">
    <h2>Welcome to your dashboard</h2>
  </div>
  <script>
    document.getElementById('submit').addEventListener('click', () => {
      const u = document.getElementById('username').value;
      const p = document.getElementById('password').value;
      if (u && p) {
        localStorage.setItem('auth_token', 'session_' + u + '_' + Date.now());
        localStorage.setItem('user_role', 'employee');
        document.getElementById('login').style.display     = 'none';
        document.getElementById('dashboard').style.display = 'block';
      }
    });
  </script>
</body>
</html>`;

// Variant of the fixture that opens with a popup blocking the login form.
// User must dismiss it before the form is clickable.
const fixtureWithPopup = `<!DOCTYPE html>
<html>
<head>
  <title>Test Login With Popup</title>
  <style>
    .modal {
      position: fixed; top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(0,0,0,0.7); z-index: 1000;
      display: flex; align-items: center; justify-content: center;
    }
    .modal-content {
      background: white; padding: 20px;
    }
  </style>
</head>
<body>
  <div id="cookie-banner" class="modal">
    <div class="modal-content">
      <h2>We use cookies</h2>
      <button id="cookie-accept" type="button">Accept all cookies</button>
    </div>
  </div>
  <form id="login">
    <input id="username" type="text" />
    <input id="password" type="password" />
    <button id="submit" type="button">Sign in</button>
  </form>
  <div id="dashboard" style="display:none">Welcome</div>
  <script>
    document.getElementById('cookie-accept').addEventListener('click', () => {
      document.getElementById('cookie-banner').style.display = 'none';
    });
    document.getElementById('submit').addEventListener('click', () => {
      const u = document.getElementById('username').value;
      const p = document.getElementById('password').value;
      if (u && p) {
        localStorage.setItem('auth_token', 'session_' + u);
        document.getElementById('dashboard').style.display = 'block';
      }
    });
  </script>
</body>
</html>`;

describe('captureAuth() — [browser] form auth end-to-end', () => {
  let server;
  let baseUrl;

  beforeAll(async () => {
    server = createServer((req, res) => {
      res.setHeader('Content-Type', 'text/html; charset=utf-8');
      // Switch fixture based on URL path
      if (req.url === '/with-popup') {
        res.end(fixtureWithPopup);
      } else {
        res.end(fixtureLoginPage);
      }
    });
    await new Promise((resolve) => server.listen(0, '127.0.0.1', resolve));
    baseUrl = `http://127.0.0.1:${server.address().port}`;
  });

  afterAll(async () => {
    if (server) {
      await new Promise((resolve) => server.close(resolve));
    }
  });

  it('fills login form, submits, waits for success, captures storage state', async () => {
    const browser = await launchBrowser();
    try {
      const state = await captureAuth(browser, {
        type:            'form',
        loginUrl:        baseUrl + '/login',
        fields:          { '#username': 'piyus', '#password': 'secret123' },
        submitSelector:  '#submit',
        successSelector: '#dashboard',
      });

      expect(state).toBeDefined();
      const ls = state.origins.flatMap((o) => o.localStorage ?? []);
      expect(ls.find((kv) => kv.name === 'auth_token')?.value).toMatch(/^session_piyus_/);
      expect(ls.find((kv) => kv.name === 'user_role')?.value).toBe('employee');

      // Day 4 addition: storageState should carry _authMeta
      expect(state._authMeta).toBeDefined();
      expect(state._authMeta.type).toBe('form');
      expect(state._authMeta.elapsedMs).toBeGreaterThan(0);
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);

  it('dismisses pre-login popup before filling the form', async () => {
    const browser = await launchBrowser();
    try {
      const state = await captureAuth(browser, {
        type:             'form',
        loginUrl:         baseUrl + '/with-popup',
        dismissSelectors: ['#cookie-accept'],   // Day 4 feature
        fields:           { '#username': 'piyus', '#password': 'secret' },
        submitSelector:   '#submit',
        successSelector:  '#dashboard',
      });

      expect(state._authMeta.dismissed).toContain('#cookie-accept');
      const ls = state.origins.flatMap((o) => o.localStorage ?? []);
      expect(ls.find((kv) => kv.name === 'auth_token')?.value).toBe('session_piyus');
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);

  it('skips dismissal cleanly when the selector is not present', async () => {
    const browser = await launchBrowser();
    try {
      const state = await captureAuth(browser, {
        type:             'form',
        loginUrl:         baseUrl + '/login',
        dismissSelectors: ['#nonexistent-cookie-banner'],  // not on this page
        fields:           { '#username': 'piyus', '#password': 'secret' },
        submitSelector:   '#submit',
        successSelector:  '#dashboard',
      });

      // Should still succeed — missing dismiss selectors are non-fatal
      expect(state._authMeta.skipped).toContain('#nonexistent-cookie-banner');
      expect(state._authMeta.dismissed).toEqual([]);
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);

  it('error message mentions the failing field selector', async () => {
    const browser = await launchBrowser();
    try {
      try {
        await captureAuth(browser, {
          type:            'form',
          loginUrl:        baseUrl + '/login',
          fields:          { '#username': 'piyus', '#does-not-exist': 'x' },
          submitSelector:  '#submit',
          successSelector: '#dashboard',
        });
        throw new Error('Should have thrown');
      } catch (err) {
        expect(err).toBeInstanceOf(AuthError);
        expect(err.code).toBe('AUTH_FIELD_NOT_FOUND');
        // Day 4: error message should include the failing selector and URL
        expect(err.message).toMatch(/#does-not-exist/);
        expect(err.message).toMatch(/login/);
      }
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);

  it('reports AUTH_SUCCESS_TIMEOUT when login fails silently', async () => {
    const browser = await launchBrowser();
    try {
      await expect(captureAuth(browser, {
        type:            'form',
        loginUrl:        baseUrl + '/login',
        fields:          { '#username': '', '#password': '' },
        submitSelector:  '#submit',
        successSelector: '#dashboard',
        timeouts:        { successWait: 3_000 },  // shorten — Day 4 feature
      })).rejects.toMatchObject({
        name: 'AuthError', code: 'AUTH_SUCCESS_TIMEOUT',
      });
    } finally {
      await closeBrowser(browser);
    }
  }, 60_000);
});
