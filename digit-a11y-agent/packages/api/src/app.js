/**
 * Express application factory.
 *
 * Why a factory: tests can spin up isolated app instances without listening
 * on a port, and the boot script (index.js) calls listen() on the result.
 *
 * Everything is served under config.basePath (default '/digit-a11y', '' = root):
 * the API at `${basePath}/api/*` and the built UI static files at `${basePath}/`
 * — one process, one port.
 *
 * Middleware order (matters!):
 *   1. CORS (must come first to handle preflight before anything else)
 *   2. JSON body parser
 *   3. pino-http request logging
 *   4. Public routes (health) — no API key required
 *   5. API-key middleware (only enforced when API_KEY is set)
 *   6. Protected routes (scan, site)
 *   7. 404 fallback (any unmatched ${basePath}/api/* path)
 *   8. Static UI + SPA fallback (everything else under basePath)
 *   9. Central error handler (must be last)
 */

import express from 'express';
import cors from 'cors';
import pinoHttp from 'pino-http';
import path from 'node:path';
import { existsSync } from 'node:fs';
import { config } from './config.js';
import { logger } from './logger.js';
import { apiKeyMiddleware } from './middleware/api-key.js';
import { errorHandler } from './middleware/error-handler.js';
import { healthRouter } from './routes/health.js';
import { scanRouter } from './routes/scan.js';
import { siteRouter } from './routes/site.js';
import { NotFound } from './errors.js';

export function createApp() {
  const app = express();
  const base = config.basePath; // '' (root) or e.g. '/digit-a11y'

  app.disable('x-powered-by');

  app.use(cors({
    origin:      config.corsOrigins,
    credentials: false,
  }));

  app.use(express.json({ limit: '1mb' }));

  app.use(pinoHttp({
    logger,
    // Quieter access logs for health checks (they happen constantly when
    // monitoring is on; don't drown the signal).
    autoLogging: {
      ignore: (req) => req.url === `${base}/api/health`,
    },
  }));

  // Convenience: bounce the bare domain root to the app's base path.
  if (base) {
    app.get('/', (_req, res) => res.redirect(`${base}/`));
  }

  // Public — no auth.
  app.use(`${base}/api/health`, healthRouter);

  // Protected (auth only enforced when API_KEY is set).
  app.use(`${base}/api/scan`, apiKeyMiddleware, scanRouter);
  app.use(`${base}/api/site`, apiKeyMiddleware, siteRouter);

  // 404 for any unmatched ${base}/api/* path
  app.use(`${base}/api`, (req, _res, next) => {
    next(NotFound('ROUTE_NOT_FOUND', `No route handles ${req.method} ${req.path}.`));
  });

  // ── Static UI on the same port ────────────────────────────────────────────
  // Serve the built vite bundle (JS/CSS/assets) under the base path, then fall
  // back to index.html for client-side routes (SPA). Skipped gracefully when
  // the dist hasn't been built (e.g. API-only local dev / tests).
  const uiDist = config.uiDistDir;
  const indexHtml = path.join(uiDist, 'index.html');
  if (existsSync(indexHtml)) {
    app.use(base || '/', express.static(uiDist));
    app.get(`${base}/*`, (_req, res) => res.sendFile(indexHtml));
  }

  app.use(errorHandler);

  return app;
}
