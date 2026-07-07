/**
 * Thin typed wrapper around fetch for talking to the scanner API.
 *
 * Centralised here so:
 *   - error handling is uniform (throws ApiClientError with code + message)
 *   - the API-key header is added in one place
 *   - upgrading to a different transport later is a single change
 *
 * Day 7 additions:
 *   - getScreenshotUrl(scanId) — returns the URL for the scan's screenshot
 *     so React can use it directly as an `<img src>`. Not fetched here;
 *     the browser handles loading + caching.
 *   - getExportUrl(scanId, format) — same idea for JSON / PDF downloads.
 *     These are GET endpoints the browser follows for downloads.
 */

const DEFAULT_HEADERS = { 'content-type': 'application/json' };

/**
 * Provide an API key by setting localStorage.A11Y_API_KEY before any call,
 * or by passing it in via the apiKey arg. Falls back to no auth.
 */
function getApiKey(apiKey) {
  if (apiKey) return apiKey;
  try {
    return window.localStorage.getItem('A11Y_API_KEY') ?? '';
  } catch {
    return '';
  }
}

async function request(path, { method = 'GET', body, apiKey } = {}) {
  const headers = { ...DEFAULT_HEADERS };
  const k = getApiKey(apiKey);
  if (k) headers['x-api-key'] = k;

  const res = await fetch(path, {
    method,
    headers,
    ...(body ? { body: JSON.stringify(body) } : {}),
  });

  let json;
  try {
    json = await res.json();
  } catch {
    throw new ApiClientError('INVALID_RESPONSE', `Non-JSON response from ${path} (HTTP ${res.status}).`);
  }

  if (!res.ok) {
    throw new ApiClientError(
      json.code ?? 'API_ERROR',
      json.message ?? `Request to ${path} failed.`,
      json.details,
    );
  }
  return json;
}

export class ApiClientError extends Error {
  constructor(code, message, details) {
    super(message);
    this.name    = 'ApiClientError';
    this.code    = code;
    this.details = details;
  }
}

/** @returns {Promise<object>} HealthResponse */
export const getHealth = () => request('/api/health');

/**
 * Enqueue a new scan.
 * @param {object} scanRequest - { url, auth?, options? }
 * @param {object} [opts]
 * @param {string} [opts.apiKey]
 * @returns {Promise<{ scanId: string, status: string, statusUrl: string }>}
 */
export const createScan = (scanRequest, opts) =>
  request('/api/scan', { method: 'POST', body: scanRequest, ...opts });

/**
 * Poll for a scan's current status / result.
 * @param {string} scanId
 * @param {object} [opts]
 * @param {string} [opts.apiKey]
 */
export const getScan = (scanId, opts) =>
  request(`/api/scan/${encodeURIComponent(scanId)}`, opts);

/**
 * URL for fetching the screenshot of a scan. Used as <img src>; the browser
 * handles loading + caching. Returns a relative URL — assumes the Vite proxy
 * (or production routing) forwards /api/* to the API server.
 *
 * @param {string} scanId
 * @returns {string} URL string
 */
export const getScreenshotUrl = (scanId) =>
  `/api/scan/${encodeURIComponent(scanId)}/screenshot`;

/**
 * URL for downloading the report in a given format.
 * @param {string} scanId
 * @param {'json'|'pdf'} format
 * @returns {string} URL string
 */
export const getExportUrl = (scanId, format) =>
  `/api/scan/${encodeURIComponent(scanId)}/export.${format}`;

/* ───────────────────────── Site (multi-page) ───────────────────────────── */

/**
 * Enqueue a whole-site (multi-page) scan.
 * @param {object} siteRequest - { urls, auth?, options? }
 * @param {object} [opts]
 * @param {string} [opts.apiKey]
 * @returns {Promise<{ siteId: string, status: string, statusUrl: string }>}
 */
export const createSiteScan = (siteRequest, opts) =>
  request('/api/site', { method: 'POST', body: siteRequest, ...opts });

/**
 * Poll a site scan's status / live progress / scored report.
 * @param {string} siteId
 * @param {object} [opts]
 * @param {string} [opts.apiKey]
 */
export const getSiteScan = (siteId, opts) =>
  request(`/api/site/${encodeURIComponent(siteId)}`, opts);

/**
 * URL for downloading the site report as JSON. Used as an <a href download>.
 * @param {string} siteId
 * @returns {string}
 */
export const getSiteExportUrl = (siteId) =>
  `/api/site/${encodeURIComponent(siteId)}/export.json`;

/**
 * URL for downloading the consolidated site report as a PDF.
 * @param {string} siteId
 * @returns {string}
 */
export const getSitePdfUrl = (siteId) =>
  `/api/site/${encodeURIComponent(siteId)}/export.pdf`;

/**
 * URL for a page's base-state screenshot within a site scan (an <img src>).
 * @param {string} siteId
 * @param {number} pageIndex
 * @returns {string}
 */
export const getSiteScreenshotUrl = (siteId, pageIndex) =>
  `/api/site/${encodeURIComponent(siteId)}/screenshot/${pageIndex}`;
