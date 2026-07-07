/**
 * API server entry point.
 *
 * Run via:
 *   - `pnpm --filter @digit-a11y/api dev`    (auto-restarts on file change)
 *   - `pnpm --filter @digit-a11y/api start`  (production)
 */

import { config, assertConfigValid } from './config.js';
import { logger } from './logger.js';
import { createApp } from './app.js';

assertConfigValid();

const app = createApp();

const server = app.listen(config.port, config.host, () => {
  logger.info(
    {
      port:          config.port,
      host:          config.host,
      env:           config.nodeEnv,
      apiKeyEnabled: config.apiKeyEnabled,
      corsOrigins:   config.corsOrigins,
    },
    `DIGIT Accessibility Scanner API listening on http://${config.host}:${config.port}`,
  );
});

/* Graceful shutdown so Ctrl-C / Docker SIGTERM closes cleanly. */
const shutdown = (signal) => {
  logger.info({ signal }, 'Shutdown signal received, closing server');
  server.close((err) => {
    if (err) {
      logger.error({ err }, 'Error during shutdown');
      process.exit(1);
    }
    process.exit(0);
  });
  // Force exit after 10s if graceful shutdown stalls.
  setTimeout(() => process.exit(1), 10_000).unref();
};

process.on('SIGTERM', () => shutdown('SIGTERM'));
process.on('SIGINT',  () => shutdown('SIGINT'));
