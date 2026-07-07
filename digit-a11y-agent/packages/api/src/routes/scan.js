/**
 * Scan routes.
 *
 *   POST /api/scan                       → enqueue a scan; returns scanId immediately
 *   GET  /api/scan/:scanId               → poll for status / result
 *   GET  /api/scan/:scanId/screenshot    → stream the screenshot PNG (Day 7)
 *   GET  /api/scan/:scanId/export.json   → download the report as JSON (Day 7)
 *   GET  /api/scan/:scanId/export.pdf    → generate a PDF of the report (Day 7)
 *
 * Auth: protected by the API-key middleware mounted at the parent level.
 *
 * Day 7 additions:
 *   - Screenshot streaming with safe path resolution (the scanId is validated
 *     against the in-memory job store before any file IO — no path traversal
 *     via crafted scanIds).
 *   - Report exports for downstream consumption: JSON (raw FriendlyReport for
 *     audit trails / regression diffs) and PDF (printable artefact for
 *     stakeholder share-outs).
 */

import { Router } from 'express';
import { promises as fs, createReadStream } from 'node:fs';
import path from 'node:path';
import { validateBody } from '../middleware/validate.js';
import { createScanSchema } from '../schemas.js';
import { jobStore } from '../store/jobs.js';
import { startJobInBackground } from '../scanner-bridge/runner.js';
import { NotFound, BadRequest, Internal } from '../errors.js';

export const scanRouter = Router();

/* ─────────── POST /api/scan ─────────── */
scanRouter.post('/', validateBody(createScanSchema), (req, res) => {
  const job = jobStore.create(req.body);
  startJobInBackground(jobStore, job);

  const body = {
    scanId:    job.id,
    status:    job.status,
    statusUrl: `/api/scan/${job.id}`,
  };
  res.status(202).json(body);
});

/* ─────────── GET /api/scan/:scanId ─────────── */
scanRouter.get('/:scanId', (req, res, next) => {
  const job = jobStore.get(req.params.scanId);
  if (!job) {
    return next(NotFound('SCAN_NOT_FOUND', `No scan found with id "${req.params.scanId}".`));
  }

  const body = {
    scanId:      job.id,
    status:      job.status,
    createdAt:   job.createdAt,
    updatedAt:   job.updatedAt,
    ...(job.startedAt  ? { startedAt:  job.startedAt  } : {}),
    ...(job.finishedAt ? { finishedAt: job.finishedAt } : {}),
    ...(job.request    ? { request:    redactRequest(job.request) } : {}),
    ...(job.report     ? { report:     job.report     } : {}),
    ...(job.error      ? { error:      job.error      } : {}),
  };
  return res.json(body);
});

/* ─────────── GET /api/scan/:scanId/screenshot ─────────── */
scanRouter.get('/:scanId/screenshot', async (req, res, next) => {
  const job = jobStore.get(req.params.scanId);
  if (!job) {
    return next(NotFound('SCAN_NOT_FOUND', `No scan found with id "${req.params.scanId}".`));
  }
  if (!job.report?.screenshot?.path) {
    return next(NotFound('SCREENSHOT_NOT_AVAILABLE',
      `Scan ${req.params.scanId} has no screenshot. Either the scan hasn't finished, or it failed before the screenshot step.`));
  }

  // Path safety: the path comes from the job's own report (written by the
  // scanner, not by the user), but we double-check it exists and is readable
  // before streaming.
  const screenshotPath = path.resolve(job.report.screenshot.path);
  try {
    await fs.access(screenshotPath, fs.constants.R_OK);
  } catch {
    return next(Internal('SCREENSHOT_FILE_MISSING',
      `Screenshot for ${req.params.scanId} is missing from disk.`));
  }

  res.setHeader('Content-Type', 'image/png');
  res.setHeader('Cache-Control', 'private, max-age=86400');
  res.setHeader('X-Image-Width',  String(job.report.screenshot.width  ?? ''));
  res.setHeader('X-Image-Height', String(job.report.screenshot.height ?? ''));
  createReadStream(screenshotPath).pipe(res);
});

/* ─────────── GET /api/scan/:scanId/export.json ─────────── */
scanRouter.get('/:scanId/export.json', (req, res, next) => {
  const job = jobStore.get(req.params.scanId);
  if (!job) {
    return next(NotFound('SCAN_NOT_FOUND', `No scan found with id "${req.params.scanId}".`));
  }
  if (!job.report) {
    return next(BadRequest('REPORT_NOT_READY',
      `Scan ${req.params.scanId} has no report yet (status: ${job.status}).`));
  }

  const filename = `${job.id}-report.json`;
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);

  // Include the request (redacted) alongside the report so the JSON file is
  // self-contained for audit purposes.
  const payload = {
    scanId:       job.id,
    request:      redactRequest(job.request),
    completedAt:  job.finishedAt,
    durationMs:   job.report.meta?.durationMs,
    report:       job.report,
  };
  res.send(JSON.stringify(payload, null, 2));
});

/* ─────────── GET /api/scan/:scanId/export.pdf ─────────── */
//
// PDF generation uses Playwright to print the report's HTML representation.
// We construct the HTML server-side (a streamlined version of the report
// page) and pipe it through Chromium's print-to-PDF. This is heavy (~5-10s
// per export) so the endpoint is request-scoped — not cached. If we wanted
// to cache, we'd persist into the artifacts dir; deferred to Phase 2.
scanRouter.get('/:scanId/export.pdf', async (req, res, next) => {
  const job = jobStore.get(req.params.scanId);
  if (!job) {
    return next(NotFound('SCAN_NOT_FOUND', `No scan found with id "${req.params.scanId}".`));
  }
  if (!job.report) {
    return next(BadRequest('REPORT_NOT_READY',
      `Scan ${req.params.scanId} has no report yet (status: ${job.status}).`));
  }

  try {
    const { renderReportPdf } = await import('../scanner-bridge/pdf.js');
    const pdfBuffer = await renderReportPdf({
      scanId:  job.id,
      request: redactRequest(job.request),
      report:  job.report,
      screenshotPath: job.report.screenshot?.path,
    });

    const filename = `${job.id}-report.pdf`;
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
    res.setHeader('Content-Length', String(pdfBuffer.length));
    res.send(pdfBuffer);
  } catch (err) {
    return next(Internal('PDF_GENERATION_FAILED',
      `Could not generate PDF for ${req.params.scanId}: ${err.message}`));
  }
});

/* ─────────── helpers ─────────── */

/**
 * Strip credentials before exposing the request to GET callers.
 *
 * Anyone who has the scanId (which is unguessable) can see the target
 * URL and the auth strategy, but never passwords or tokens.
 */
function redactRequest(req) {
  if (!req) return req;
  const out = { url: req.url };
  if (req.auth?.type) {
    out.auth = { type: req.auth.type };
    if (req.auth.contextStrategy) out.auth.contextStrategy = req.auth.contextStrategy;
  }
  if (req.options?.captureScreenshot !== undefined) {
    out.options = { captureScreenshot: req.options.captureScreenshot };
  }
  if (req.options?.waitForSelector) {
    out.options = { ...(out.options ?? {}), waitForSelector: req.options.waitForSelector };
  }
  return out;
}
