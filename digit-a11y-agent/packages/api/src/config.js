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

import path from 'node:path';
import { fileURLToPath } from 'node:url';

const env = process.env;
const __dirname = path.dirname(fileURLToPath(import.meta.url));

/**
 * Normalize a base path into the form Express/Vite expect internally:
 * a leading slash, no trailing slash, and '' for root.
 *   '/digit-a11y/'  → '/digit-a11y'
 *   'digit-a11y'    → '/digit-a11y'
 *   '/' | '' | null → ''  (served at root)
 */
function normalizeBasePath(raw) {
  if (!raw || raw.trim() === '' || raw.trim() === '/') return '';
  let p = raw.trim();
  if (!p.startsWith('/')) p = `/${p}`;
  return p.replace(/\/+$/, '');
}

/**
 * @typedef {Object} ApiConfig
 * @property {string}  nodeEnv           - 'development' | 'production' | 'test'
 * @property {number}  port              - HTTP port to bind
 * @property {string}  host              - Bind host (0.0.0.0 in Docker, 127.0.0.1 locally)
 * @property {string}  basePath          - URL prefix everything is served under ('' = root, e.g. '/digit-a11y')
 * @property {string}  uiDistDir         - Absolute path to the built UI (packages/ui/dist) served on the same port
 * @property {string|null} apiKey        - Optional API key for /api/* endpoints; null = auth disabled
 * @property {boolean} apiKeyEnabled     - True when an api key is set (auth is opt-in, any env)
 * @property {number}  jobMaxAgeMs       - Drop completed jobs from memory after this long
 * @property {number}  scanTimeoutMs     - Hard timeout for a single scan run
 * @property {number}  siteScanTimeoutMs - Hard timeout for a whole-site exploration
 * @property {number}  siteConcurrency   - Parallel pages per whole-site exploration (isolated logged-in contexts)
 * @property {string}  logLevel          - pino log level
 * @property {boolean} prettyLogs        - Use pino-pretty? Auto-true in development.
 * @property {string[]} corsOrigins      - Allowed origins for browser requests
 */

const isProd = env.NODE_ENV === 'production';
const isTest = env.NODE_ENV === 'test';

/** @type {ApiConfig} */
export const config = {
  nodeEnv: env.NODE_ENV ?? 'development',

  port: Number(env.API_PORT ?? 3000),
  host: env.API_HOST ?? (isProd ? '0.0.0.0' : '127.0.0.1'),

  // URL prefix everything (API + static UI) is served under. Defaults to
  // '/digit-a11y' so the app is never accidentally served at the domain root;
  // override with BASE_PATH. Tests run at root ('') so route paths stay simple.
  basePath: normalizeBasePath(env.BASE_PATH ?? (isTest ? '' : '/digit-a11y')),

  // The built UI (vite dist/) served by this same API process on one port.
  // Defaults to packages/ui/dist relative to this file; override with UI_DIST_DIR.
  uiDistDir: env.UI_DIST_DIR ?? path.resolve(__dirname, '../../ui/dist'),

  // Auth is OPT-IN: the API key is only enforced when API_KEY is set (in any
  // environment). With no key, /api/* is open — intended for public demos and
  // behind-firewall use. Set API_KEY to turn auth on.
  apiKey:        env.API_KEY ?? null,
  apiKeyEnabled: Boolean(env.API_KEY),

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
  // Auth is opt-in — no key required to boot. (apiKeyEnabled is derived from
  // apiKey, so an "enabled but empty" state can't occur; this stays as a guard.)
  if (config.apiKeyEnabled && !config.apiKey) {
    throw new Error('API_KEY is enabled but empty — set a non-empty API_KEY or unset it to disable auth.');
  }
  if (!Number.isFinite(config.port) || config.port < 1 || config.port > 65535) {
    throw new Error(`Invalid API_PORT: ${config.port}`);
  }
  if (config.scanTimeoutMs < 5_000) {
    throw new Error(`SCAN_TIMEOUT_MS too low (${config.scanTimeoutMs}); minimum 5000.`);
  }
}
