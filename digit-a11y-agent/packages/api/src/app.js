/**
 * Express application factory.
 *
 * Why a factory: tests can spin up isolated app instances without listening
 * on a port, and the boot script (index.js) calls listen() on the result.
 *
 * Middleware order (matters!):
 *   1. CORS (must come first to handle preflight before anything else)
 *   2. JSON body parser
 *   3. pino-http request logging
 *   4. Public routes (health) — no API key required
 *   5. API-key middleware
 *   6. Protected routes (scan, site)
 *   7. 404 fallback (any unmatched /api/* path)
 *   8. Central error handler (must be last)
 */

import express from 'express';
import cors from 'cors';
import pinoHttp from 'pino-http';
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
      ignore: (req) => req.url === '/api/health',
    },
  }));

  // Public — no auth.
  app.use('/api/health', healthRouter);

  // Protected.
  app.use('/api/scan', apiKeyMiddleware, scanRouter);
  app.use('/api/site', apiKeyMiddleware, siteRouter);

  // 404 for any unmatched /api/* path
  app.use('/api', (req, _res, next) => {
    next(NotFound('ROUTE_NOT_FOUND', `No route handles ${req.method} ${req.path}.`));
  });

  app.use(errorHandler);

  return app;
}
