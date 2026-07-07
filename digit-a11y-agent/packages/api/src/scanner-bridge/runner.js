/**
 * Runs a queued job in the background and updates the store as it progresses.
 *
 * Design: fire-and-forget. The HTTP request that creates a scan returns the
 * scanId immediately; the actual scan runs asynchronously via this runner.
 * Clients poll GET /api/scan/:scanId to check progress.
 *
 * Phase 1 keeps this dead-simple (start a Promise, let it run, update on
 * completion). Phase 2 will introduce a proper queue with concurrency limits,
 * cancellation, and SQLite-backed persistence.
 */

import { logger } from '../logger.js';
import { executeScan, ScanTimeoutError } from './execute.js';

/**
 * Kick off a background scan run. Returns immediately; the actual work runs
 * via the returned Promise (which we deliberately don't await — callers
 * should poll the store).
 *
 * @param {import('../store/jobs.js').InMemoryJobStore} store
 * @param {import('../types.js').Job} job
 * @returns {Promise<void>} - Resolves when the job reaches a final status.
 */
export function startJobInBackground(store, job) {
  return _runJob(store, job).catch((err) => {
    // Defensive: _runJob has its own try/catch but anything that escapes
    // shouldn't crash the server. Log loudly so we notice in dev.
    logger.error({ err, jobId: job.id }, 'Job runner caught an escaping error');
  });
}

async function _runJob(store, job) {
  logger.info({ jobId: job.id, url: job.request.url }, 'Job starting');
  store.markRunning(job.id);

  try {
    const report = await executeScan(job.request);
    store.markComplete(job.id, report);
    logger.info(
      { jobId: job.id, score: report.score, issues: report.summary?.totalIssues },
      'Job complete',
    );
  } catch (err) {
    const errorPayload = {
      code:    err.code ?? 'SCAN_FAILED',
      message: err.message ?? 'Scan failed for an unknown reason.',
    };
    if (err instanceof ScanTimeoutError) {
      errorPayload.code = 'SCAN_TIMEOUT';
    }
    store.markFailed(job.id, errorPayload);
    logger.warn({ jobId: job.id, error: errorPayload }, 'Job failed');
  }
}
