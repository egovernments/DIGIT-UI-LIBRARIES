/**
 * Centralized configuration for the API server.
 *
 * Everything env-driven lives here. Other modules read from this object
 * instead of touching process.env directly — makes testing easy (just
 * stub the import) and keeps env-name typos in one file.
 *
 * Defaults are chosen for safe local development. Production deployments
 * should override via environment variables (see docker-compose.yml).
 */

const env = process.env;

/**
 * @typedef {Object} ApiConfig
 * @property {string}  nodeEnv           - 'development' | 'production' | 'test'
 * @property {number}  port              - HTTP port to bind
 * @property {string}  host              - Bind host (0.0.0.0 in Docker, 127.0.0.1 locally)
 * @property {string|null} apiKey        - Required API key for /api/* endpoints; null = disabled
 * @property {boolean} apiKeyEnabled     - True when an api key is set
 * @property {number}  jobMaxAgeMs       - Drop completed jobs from memory after this long
 * @property {number}  scanTimeoutMs     - Hard timeout for a single scan run
 * @property {number}  siteScanTimeoutMs - Hard timeout for a whole-site exploration
 * @property {number}  siteConcurrency   - Parallel pages per whole-site exploration (isolated logged-in contexts)
 * @property {string}  logLevel          - pino log level
 * @property {boolean} prettyLogs        - Use pino-pretty? Auto-true in development.
 * @property {string[]} corsOrigins      - Allowed origins for browser requests
 */

const isProd = env.NODE_ENV === 'production';

/** @type {ApiConfig} */
export const config = {
  nodeEnv: env.NODE_ENV ?? 'development',

  port: Number(env.API_PORT ?? 3000),
  host: env.API_HOST ?? (isProd ? '0.0.0.0' : '127.0.0.1'),

  // API key required in prod, optional in dev — matches the locked decision from planning.
  apiKey:        env.API_KEY ?? null,
  apiKeyEnabled: Boolean(env.API_KEY) || isProd,

  // 30 min of memory; jobs older than this get evicted on next access.
  jobMaxAgeMs: Number(env.JOB_MAX_AGE_MS ?? 30 * 60 * 1000),

  // 60s default scan budget — matches the Day-4 timeout decision.
  scanTimeoutMs: Number(env.SCAN_TIMEOUT_MS ?? 60_000),

  // Multi-page exploration is much heavier (many pages × many clicks per page).
  // Default 15 min; override with SITE_SCAN_TIMEOUT_MS.
  siteScanTimeoutMs: Number(env.SITE_SCAN_TIMEOUT_MS ?? 30 * 60 * 1000),

  // How many pages a whole-site scan explores in parallel (each an isolated,
  // independently-logged-in context). axe is CPU-bound, so keep this near the
  // host's core count. Default 3; override with SITE_CONCURRENCY.
  siteConcurrency: Number(env.SITE_CONCURRENCY ?? 8),

  logLevel:   env.LOG_LEVEL ?? (isProd ? 'info' : 'debug'),
  prettyLogs: !isProd,

  corsOrigins: (env.CORS_ORIGINS ?? 'http://localhost:5173,http://127.0.0.1:5173')
    .split(',')
    .map((s) => s.trim())
    .filter(Boolean),
};

/**
 * Throw early if the runtime config is internally inconsistent.
 * Called from src/index.js on boot so misconfigurations fail loudly.
 */
export function assertConfigValid() {
  if (config.apiKeyEnabled && !config.apiKey) {
    throw new Error(
      'API_KEY must be set when running in production. ' +
      'Set the API_KEY environment variable, or use NODE_ENV=development to disable auth.',
    );
  }
  if (!Number.isFinite(config.port) || config.port < 1 || config.port > 65535) {
    throw new Error(`Invalid API_PORT: ${config.port}`);
  }
  if (config.scanTimeoutMs < 5_000) {
    throw new Error(`SCAN_TIMEOUT_MS too low (${config.scanTimeoutMs}); minimum 5000.`);
  }
}
