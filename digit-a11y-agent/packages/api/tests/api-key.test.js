/**
 * Tests for the API-key middleware.
 *
 * We isolate the middleware by setting API_KEY in the environment, then
 * re-importing the config module fresh. vitest's vi.resetModules() lets
 * each test get a clean module graph.
 */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import request from 'supertest';
import express from 'express';

describe('apiKeyMiddleware', () => {
  beforeEach(() => {
    vi.resetModules();
    delete process.env.API_KEY;
    delete process.env.NODE_ENV;
  });

  async function buildAppWith({ apiKey, nodeEnv }) {
    if (apiKey) process.env.API_KEY = apiKey;
    if (nodeEnv) process.env.NODE_ENV = nodeEnv;
    const { apiKeyMiddleware } = await import('../src/middleware/api-key.js');
    const { errorHandler } = await import('../src/middleware/error-handler.js');
    const app = express();
    app.get('/protected', apiKeyMiddleware, (_req, res) => res.json({ ok: true }));
    app.use(errorHandler);
    return app;
  }

  it('passes through when API_KEY is not set (dev mode)', async () => {
    const app = await buildAppWith({ nodeEnv: 'development' });
    const res = await request(app).get('/protected');
    expect(res.status).toBe(200);
    expect(res.body.ok).toBe(true);
  });

  it('rejects requests without the header when API_KEY is set', async () => {
    const app = await buildAppWith({ apiKey: 'test-key-123' });
    const res = await request(app).get('/protected');
    expect(res.status).toBe(401);
    expect(res.body.code).toBe('API_KEY_INVALID');
  });

  it('rejects requests with the wrong header value', async () => {
    const app = await buildAppWith({ apiKey: 'test-key-123' });
    const res = await request(app)
      .get('/protected')
      .set('x-api-key', 'wrong-key');
    expect(res.status).toBe(401);
    expect(res.body.code).toBe('API_KEY_INVALID');
  });

  it('passes through with the correct header value', async () => {
    const app = await buildAppWith({ apiKey: 'test-key-123' });
    const res = await request(app)
      .get('/protected')
      .set('x-api-key', 'test-key-123');
    expect(res.status).toBe(200);
    expect(res.body.ok).toBe(true);
  });
});
