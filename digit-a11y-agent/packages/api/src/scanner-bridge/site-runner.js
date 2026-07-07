/**
 * Runs a queued SITE (multi-page) job in the background, updating the store as
 * it progresses. The multi-page analogue of runner.js.
 *
 * Same fire-and-forget design: POST returns the id immediately, the work runs
 * here, clients poll GET /api/site/:siteId. While running, the explorer's
 * progress events are written onto the job (job.progress) so the UI can show
 * "Page N of M".
 */

import { logger } from '../logger.js';
import { executeExploration, ExploreTimeoutError } from './explore-execute.js';
import { writeSiteReport } from '../store/site-report-cache.js';

/**
 * Kick off a background site exploration. Returns immediately; the work runs
 * via the returned Promise (deliberately not awaited — callers poll the store).
 *
 * @param {import('../store/jobs.js').InMemoryJobStore} store
 * @param {import('../types.js').Job} job
 * @returns {Promise<void>} resolves when the job reaches a final status.
 */
export function startSiteJobInBackground(store, job) {
  return _runSiteJob(store, job).catch((err) => {
    logger.error({ err, jobId: job.id }, 'Site job runner caught an escaping error');
  });
}

async function _runSiteJob(store, job) {
  const urls = Array.isArray(job.request?.urls) ? job.request.urls : [];
  const urlCount = urls.length;
  logger.info({ jobId: job.id, urlCount }, 'Site job starting');

  // Live per-page progress. We accumulate a row per sitemap URL
  // (queued → scanning → scanned/failed) rather than storing only the latest
  // event — under parallel concurrency several pages are in flight at once, so a
  // single "current page" is meaningless. Scores are NOT shown live; they appear
  // on the final report.
  const progress = {
    total: urlCount,
    completed: 0,
    statesScanned: 0,
    pages: urls.map((u) => ({ url: typeof u === 'string' ? u : u.url, status: 'queued', states: 0 })),
  };

  // store.get() only shallow-copies the job, so a nested live object would alias
  // and mutate under the client — push a fresh snapshot on every update.
  const snapshot = () => ({
    total: progress.total,
    completed: progress.completed,
    statesScanned: progress.statesScanned,
    pages: progress.pages.map((p) => ({ ...p })),
  });

  store.markRunning(job.id);
  store.update(job.id, { progress: snapshot() }); // seed: all rows queued

  const onProgress = (evt) => {
    const i = evt?.pageIndex;
    if (evt?.phase === 'page-start' && Number.isInteger(i) && progress.pages[i]) {
      progress.pages[i].status = 'scanning';
    } else if (evt?.phase === 'page-done' && Number.isInteger(i) && progress.pages[i]) {
      progress.pages[i].status = evt.loadStatus === 'ok' ? 'scanned' : (evt.loadStatus ?? 'error');
      progress.pages[i].states = evt.pageStates ?? 0;
      progress.completed = evt.completed ?? progress.completed;
      progress.statesScanned = evt.statesScanned ?? progress.statesScanned;
    } else {
      return; // session-ready or unrecognized — nothing per-row to render
    }
    store.update(job.id, { progress: snapshot() });
  };

  try {
    const report = await executeExploration(job.request, { scanId: job.id, onProgress });
    store.markComplete(job.id, report);
    // Cache the report to disk so the JSON/PDF/screenshot exports keep working
    // after an API restart or the in-memory eviction. No DB — one JSON file next
    // to the scan's screenshot artifacts. Best-effort; never blocks completion.
    await writeSiteReport(job.id, {
      siteId:      job.id,
      request:     { urls: (job.request?.urls ?? []).map((u) => (typeof u === 'string' ? u : u.url)) },
      completedAt: Date.now(),
      report,
    });
    logger.info(
      {
        jobId:        job.id,
        overallScore: report.overallScore,
        issues:       report.summary?.totalIssues,
        pages:        report.meta?.scannedPageCount,
      },
      'Site job complete',
    );
  } catch (err) {
    const errorPayload = {
      code:    err.code ?? 'SITE_SCAN_FAILED',
      message: err.message ?? 'Site exploration failed for an unknown reason.',
    };
    if (err instanceof ExploreTimeoutError) errorPayload.code = 'SITE_SCAN_TIMEOUT';
    store.markFailed(job.id, errorPayload);
    logger.warn({ jobId: job.id, error: errorPayload }, 'Site job failed');
  }
}
