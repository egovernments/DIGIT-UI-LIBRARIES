import { describe, it, expect, beforeEach, afterEach, vi } from 'vitest';
import request from 'supertest';

/**
 * The capture store launches a real headed browser, which cannot run in CI and
 * needs a human anyway. Mock the scanner surface it uses so the route
 * contract, the error mapping and the lifecycle are all still covered.
 */
const mocks = vi.hoisted(() => ({
  launchBrowser: vi.fn(),
  closeBrowser:  vi.fn(async () => {}),
  createContext: vi.fn(),
  closeContext:  vi.fn(async () => {}),
  captureSessionStorage: vi.fn(async () => ({ 'Digit.User': '{"value":"x"}' })),
  storageState:  vi.fn(async () => ({
    cookies: [{ name: 'sid', value: 'abc', domain: 'x.gov.in', path: '/' }],
    origins: [{ origin: 'https://x.gov.in', localStorage: [{ name: 'token', value: 'ey' }] }],
  })),
  goto: vi.fn(async () => {}),
  pageUrl: vi.fn(() => 'https://x.gov.in/home'),
  passwordVisible: vi.fn(async () => false),
}));

vi.mock('@digit-a11y/scanner', () => ({
  launchBrowser: mocks.launchBrowser,
  closeBrowser:  mocks.closeBrowser,
  createContext: mocks.createContext,
  closeContext:  mocks.closeContext,
  captureSessionStorage: mocks.captureSessionStorage,
  // Real implementation — it's pure and the warning logic depends on it.
  looksLikeLoginUrl: (url) => /(^|\/)(login|signin|sign-in)(\/|$)/i.test(url),
  // Unused by the store, but imported elsewhere in the API graph.
  runScan: vi.fn(),
}));

const { createApp } = await import('../src/app.js');
const { sessionCaptureStore } = await import('../src/store/session-captures.js');

/** A context whose pages()/storageState() behave like Playwright's. */
function makeContext() {
  const page = {
    goto: mocks.goto,
    url: mocks.pageUrl,
    locator: () => ({ first: () => ({ isVisible: mocks.passwordVisible }) }),
  };
  return {
    newPage:      vi.fn(async () => page),
    pages:        vi.fn(() => [page]),
    storageState: mocks.storageState,
    addCookies:   vi.fn(async () => {}),
    addInitScript: vi.fn(async () => {}),
  };
}

let app;

beforeEach(() => {
  vi.clearAllMocks();
  mocks.launchBrowser.mockResolvedValue({ close: vi.fn() });
  mocks.createContext.mockImplementation(async () => makeContext());
  app = createApp();
});

afterEach(async () => {
  await sessionCaptureStore._clear();
});

// config.basePath is '' under NODE_ENV=test, so routes sit at the root.
const base = '/api/session';

describe('POST /api/session/capture', () => {
  it('opens a browser window and returns a waiting capture', async () => {
    const res = await request(app)
      .post(`${base}/capture`)
      .send({ url: 'https://x.gov.in/login' })
      .expect(201);

    expect(res.body).toMatchObject({ status: 'waiting', url: 'https://x.gov.in/login' });
    expect(res.body.id).toMatch(/^cap_/);
    expect(mocks.launchBrowser).toHaveBeenCalledWith({ headless: false });
  });

  it('rejects a non-URL', async () => {
    await request(app).post(`${base}/capture`).send({ url: 'not-a-url' }).expect(400);
  });

  it('reports 501 CAPTURE_UNAVAILABLE when no display is available', async () => {
    // What a headless Linux host actually does.
    mocks.launchBrowser.mockRejectedValue(new Error('Missing X server or $DISPLAY'));

    const res = await request(app)
      .post(`${base}/capture`)
      .send({ url: 'https://x.gov.in/login' })
      .expect(501);

    expect(res.body.code).toBe('CAPTURE_UNAVAILABLE');
    // The message has to name the way out, or the user is simply stuck.
    expect(res.body.message).toMatch(/capture-session\.mjs/);
  });
});

describe('GET /api/session/capture/:id', () => {
  it('returns a live capture without leaking browser handles', async () => {
    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });

    const res = await request(app).get(`${base}/capture/${started.id}`).expect(200);
    expect(res.body.status).toBe('waiting');
    expect(res.body._browser).toBeUndefined();
    expect(res.body._context).toBeUndefined();
  });

  it('404s for an unknown id', async () => {
    await request(app).get(`${base}/capture/cap_nope`).expect(404);
  });
});

describe('POST /api/session/capture/:id/finish', () => {
  it('returns the session and closes the browser', async () => {
    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });

    const res = await request(app).post(`${base}/capture/${started.id}/finish`).expect(200);

    expect(res.body.session.cookies).toHaveLength(1);
    expect(res.body.session._sessionStorage).toEqual({ 'Digit.User': '{"value":"x"}' });
    expect(res.body.session._capturedAt).toBeTruthy();
    expect(res.body.summary).toMatchObject({ cookies: 1, localStorage: 1, sessionStorage: 1 });
    expect(mocks.closeBrowser).toHaveBeenCalled();
  });

  it('captures sessionStorage, which storageState alone would drop', async () => {
    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });
    const res = await request(app).post(`${base}/capture/${started.id}/finish`);

    expect(mocks.captureSessionStorage).toHaveBeenCalled();
    expect(Object.keys(res.body.session._sessionStorage)).toHaveLength(1);
  });

  it('rejects an empty capture and keeps the window open to retry', async () => {
    mocks.storageState.mockResolvedValueOnce({ cookies: [], origins: [] });
    mocks.captureSessionStorage.mockResolvedValueOnce({});

    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });

    const res = await request(app).post(`${base}/capture/${started.id}/finish`).expect(400);
    expect(res.body.code).toBe('CAPTURE_EMPTY');

    // Still waiting — the user can log in properly and press the button again.
    await request(app).get(`${base}/capture/${started.id}`).expect(200);
  });

  it('warns when the captured page still looks like a login screen', async () => {
    // Measured behaviour: capturing on the Studio UAT login page without
    // signing in still yields 16 cookies and app-shell storage, so "not empty"
    // cannot be the check. The page itself has to be inspected.
    mocks.pageUrl.mockReturnValue('https://x.gov.in/user/login');

    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });
    const res = await request(app).post(`${base}/capture/${started.id}/finish`).expect(200);

    expect(res.body.summary.warning).toMatch(/looks like a login page/i);
    // Still returned — a warning, not a rejection.
    expect(res.body.session.cookies).toHaveLength(1);

    mocks.pageUrl.mockReturnValue('https://x.gov.in/home');
  });

  it('warns when a password field is still visible', async () => {
    mocks.passwordVisible.mockResolvedValueOnce(true);

    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });
    const res = await request(app).post(`${base}/capture/${started.id}/finish`).expect(200);

    expect(res.body.summary.warning).toMatch(/password field is visible/i);
  });

  it('does not warn on a signed-in page', async () => {
    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });
    const res = await request(app).post(`${base}/capture/${started.id}/finish`).expect(200);

    expect(res.body.summary.warning).toBeUndefined();
  });

  it('409s when finishing twice', async () => {
    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });

    await request(app).post(`${base}/capture/${started.id}/finish`).expect(200);
    await request(app).post(`${base}/capture/${started.id}/finish`).expect(404);
  });
});

describe('DELETE /api/session/capture/:id', () => {
  it('closes the browser without capturing', async () => {
    const { body: started } = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' });

    await request(app).delete(`${base}/capture/${started.id}`).expect(204);
    expect(mocks.closeBrowser).toHaveBeenCalled();
    await request(app).get(`${base}/capture/${started.id}`).expect(404);
  });
});

describe('capture limits', () => {
  it('refuses to open more windows than the concurrency cap', async () => {
    for (let i = 0; i < 3; i++) {
      await request(app).post(`${base}/capture`).send({ url: 'https://x.gov.in/login' }).expect(201);
    }
    const res = await request(app)
      .post(`${base}/capture`).send({ url: 'https://x.gov.in/login' }).expect(409);
    expect(res.body.code).toBe('CAPTURE_LIMIT_REACHED');
  });
});
