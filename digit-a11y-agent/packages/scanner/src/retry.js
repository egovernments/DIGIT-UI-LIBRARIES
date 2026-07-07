/**
 * Retry helper with exponential backoff.
 *
 * Used by:
 *   - The scanner's page navigation (DNS hiccups, flaky CDNs)
 *   - The auth flows (intermittent network failures on the login round-trip)
 *
 * Key design choices:
 *   1. Caller decides what's transient. We expose `isTransientNetworkError` as
 *      a sensible default, but auth/scan code may override (e.g. "wrong
 *      password" is permanent — never retry).
 *   2. Exponential backoff with a cap. 1s → 2s → 4s → 8s → 10s, then plateau.
 *   3. Optional `onRetry` callback so callers can log diagnostics or attach
 *      warnings to the eventual report.
 *
 * Why not use a library?
 *   - This is ~30 lines of code with zero dependencies; adding `p-retry`
 *     would bring 4 transitive packages and a CommonJS-vs-ESM headache for
 *     no real value. Keeping it inline.
 */

/**
 * @typedef {Object} RetryOptions
 * @property {number} [maxAttempts=3]
 * @property {number} [baseDelayMs=1000]
 * @property {number} [maxDelayMs=10000]
 * @property {(error: Error) => boolean} [isTransient] - Decide if an error is worth retrying
 * @property {(info: {attempt: number, error: Error, delayMs: number}) => void} [onRetry]
 */

/**
 * Retry an async function with exponential backoff.
 *
 * @template T
 * @param {(attempt: number) => Promise<T>} fn - Receives the 1-indexed attempt number
 * @param {RetryOptions} [options]
 * @returns {Promise<T>}
 */
export async function retryWithBackoff(fn, options = {}) {
  const {
    maxAttempts = 3,
    baseDelayMs = 1000,
    maxDelayMs  = 10_000,
    isTransient = () => true,
    onRetry,
  } = options;

  let lastError;
  for (let attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      return await fn(attempt);
    } catch (err) {
      lastError = err;
      const shouldRetry = isTransient(err) && attempt < maxAttempts;
      if (!shouldRetry) throw err;

      const delay = Math.min(
        baseDelayMs * Math.pow(2, attempt - 1),
        maxDelayMs,
      );
      onRetry?.({ attempt, error: err, delayMs: delay });
      await sleep(delay);
    }
  }
  // Unreachable in practice, but TypeScript-style safety.
  throw lastError;
}

/**
 * Best-effort detection of transient errors worth retrying.
 *
 * We pattern-match on error messages because Playwright wraps lots of
 * underlying Node errors and the error class is often just `Error` with
 * a descriptive message. Not perfect, but covers >90% of real cases.
 *
 * @param {Error} err
 * @returns {boolean}
 */
export function isTransientNetworkError(err) {
  if (!err) return false;
  const msg = String(err.message ?? '').toLowerCase();

  // Network-level failures — usually transient
  if (msg.includes('econnreset'))     return true;
  if (msg.includes('econnrefused'))   return true;
  if (msg.includes('etimedout'))      return true;
  if (msg.includes('ehostunreach'))   return true;
  if (msg.includes('enotfound'))      return true;
  if (msg.includes('socket hang up')) return true;

  // Playwright-specific transient signals
  if (msg.includes('net::err_connection_'))     return true;
  if (msg.includes('net::err_network_changed')) return true;
  if (msg.includes('net::err_internet_disconnected')) return true;
  if (msg.includes('navigation timeout'))       return true;

  // Generic timeout — usually transient. (Login-success-selector timeouts
  // override this in their own flow because those are most often credential
  // errors, not network errors.)
  if (msg.includes('timeout') && !msg.includes('not found')) return true;

  // 502/503/504 — server is overloaded, retry helps
  if (/\b50[234]\b/.test(msg)) return true;

  return false;
}

/**
 * Tiny sleep helper. Exposed for tests.
 * @param {number} ms
 */
export function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
