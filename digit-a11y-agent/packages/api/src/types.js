/**
 * Type definitions for the API layer.
 *
 * These describe what flows over HTTP, not what flows inside the scanner.
 * The internal types (RawScanResult, FriendlyReport, etc.) live in
 * `@digit-a11y/reporter/src/types.js`.
 */

/**
 * @typedef {Object} CreateScanRequestBody
 * @property {string}   url        - Target URL to scan
 * @property {object}   [auth]     - Optional authentication config (passes through to scanner)
 * @property {object}   [options]  - Optional scan tuning (passes through to scanner)
 */

/**
 * @typedef {'queued'|'running'|'complete'|'failed'} JobStatus
 */

/**
 * @typedef {Object} Job
 * @property {string}   id           - Public job id (matches FriendlyReport.meta.scanId)
 * @property {JobStatus} status
 * @property {number}   createdAt    - epoch ms
 * @property {number}   updatedAt    - epoch ms
 * @property {number}   [startedAt]  - epoch ms when the scan actually began
 * @property {number}   [finishedAt] - epoch ms when the scan completed or failed
 * @property {object}   request      - The original ScanRequest (for re-runs and debugging)
 * @property {object}   [report]     - The FriendlyReport, present when status === 'complete'
 * @property {object}   [progress]   - Latest progress event for site jobs (see SiteProgress)
 * @property {Object}   [error]      - { code, message } when status === 'failed'
 */

/**
 * @typedef {Object} CreateScanResponse
 * @property {string}   scanId       - Polling key for GET /api/scan/:scanId
 * @property {JobStatus} status      - Initial status (always 'queued' in Phase 1)
 * @property {string}   statusUrl    - Convenience URL the client can poll
 */

/**
 * @typedef {Object} GetScanResponse
 * @property {string}   scanId
 * @property {JobStatus} status
 * @property {number}   createdAt
 * @property {number}   updatedAt
 * @property {number}   [startedAt]
 * @property {number}   [finishedAt]
 * @property {object}   [report]
 * @property {Object}   [error]
 */

/**
 * @typedef {Object} HealthResponse
 * @property {'ok'|'degraded'} status
 * @property {string}   version
 * @property {number}   uptimeSeconds
 * @property {string}   nodeVersion
 * @property {Object}   jobs
 * @property {number}   jobs.total
 * @property {number}   jobs.queued
 * @property {number}   jobs.running
 * @property {number}   jobs.complete
 * @property {number}   jobs.failed
 */

/**
 * @typedef {Object} ApiErrorBody
 * @property {string}   code         - Machine-readable, SCREAMING_SNAKE
 * @property {string}   message      - Human-readable
 * @property {object}   [details]    - Optional structured details (e.g. zod issues)
 */

/**
 * @typedef {Object} CreateSiteScanRequestBody
 * @property {(string | { url: string, ready?: string })[]} urls - sitemap; the only source of navigation. Each entry is a URL, or { url, ready } with a per-page "loaded" selector.
 * @property {object}   [auth]     - Automated auth config (no manual login server-side)
 * @property {object}   [options]  - Tuning passed through to the explorer
 */

/**
 * @typedef {Object} SiteProgress
 * @property {'session-ready'|'page-start'|'page-done'} phase
 * @property {number}   [index]         - 1-based page index currently being processed
 * @property {number}   [total]         - total pages in the sitemap
 * @property {string}   [url]
 * @property {string}   [loadStatus]    - 'ok' | 'degraded' | 'redirected' (on page-done)
 * @property {number}   [statesScanned] - cumulative states scanned so far
 */

export {};
