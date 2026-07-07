/**
 * Site (multi-page) scan routes — the explorer's HTTP surface.
 *
 *   POST /api/site                      → enqueue a whole-site exploration; returns siteId
 *   GET  /api/site/:siteId              → poll status / live progress / scored site report
 *   GET  /api/site/:siteId/export.json  → download the site report as JSON
 *
 * Reuses the same in-memory job store as single-page scans (site jobs are
 * tagged with kind:'site' so the two never get confused); the runner is the
 * multi-page one (site-runner.js).
 *
 * NOTE: this path runs server-side and headless, so auth must be AUTOMATED
 * (credentials in the request body — e.g. a 'form' auth with contextStrategy
 * 'single' for DIGIT Studio). The CLI's manual-login flow does not apply here.
 *
 * Auth (API key): protected by the API-key middleware mounted at the parent.
 */

import { Router } from 'express';
import { promises as fs, createReadStream } from 'node:fs';
import path from 'node:path';
import { validateBody } from '../middleware/validate.js';
import { createSiteScanSchema } from '../schemas.js';
import { jobStore } from '../store/jobs.js';
import { readSiteReport } from '../store/site-report-cache.js';
import { startSiteJobInBackground } from '../scanner-bridge/site-runner.js';
import { NotFound, BadRequest, Internal } from '../errors.js';

export const siteRouter = Router();

/* ─────────── POST /api/site ─────────── */
siteRouter.post('/', validateBody(createSiteScanSchema), (req, res) => {
  const job = jobStore.create({ kind: 'site', ...req.body });
  startSiteJobInBackground(jobStore, job);

  res.status(202).json({
    siteId:    job.id,
    status:    job.status,
    statusUrl: `/api/site/${job.id}`,
  });
});

/* ─────────── GET /api/site/:siteId ─────────── */
siteRouter.get('/:siteId', (req, res, next) => {
  const job = siteJobOr404(req.params.siteId, next);
  if (!job) return;

  res.json({
    siteId:      job.id,
    status:      job.status,
    createdAt:   job.createdAt,
    updatedAt:   job.updatedAt,
    ...(job.startedAt  ? { startedAt:  job.startedAt  } : {}),
    ...(job.finishedAt ? { finishedAt: job.finishedAt } : {}),
    ...(job.progress   ? { progress:   job.progress   } : {}),
    ...(job.request    ? { request:    redactSiteRequest(job.request) } : {}),
    ...(job.report     ? { report:     job.report     } : {}),
    ...(job.error      ? { error:      job.error      } : {}),
  });
});

/* ─────────── GET /api/site/:siteId/export.json ─────────── */
siteRouter.get('/:siteId/export.json', async (req, res, next) => {
  const data = await loadSiteExport(req.params.siteId);
  if (!data) {
    return next(NotFound('SITE_SCAN_NOT_FOUND', `No site scan found with id "${req.params.siteId}".`));
  }

  const filename = `${req.params.siteId}-site-report.json`;
  res.setHeader('Content-Type', 'application/json; charset=utf-8');
  res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
  res.send(JSON.stringify(data, null, 2));
});

/* ─────────── GET /api/site/:siteId/export.pdf ─────────── */
//
// Consolidated PDF: overall score + standards + per-page summary table +
// priority fixes + the full site-wide issue list. Heavy (boots Chromium), so
// it's request-scoped and not cached — same trade-off as the single-page PDF.
siteRouter.get('/:siteId/export.pdf', async (req, res, next) => {
  const data = await loadSiteExport(req.params.siteId);
  if (!data) {
    return next(NotFound('SITE_SCAN_NOT_FOUND', `No site scan found with id "${req.params.siteId}".`));
  }

  try {
    const { renderSiteReportPdf } = await import('../scanner-bridge/site-pdf.js');
    const pdfBuffer = await renderSiteReportPdf({
      siteId:  data.siteId ?? req.params.siteId,
      request: data.request,
      report:  data.report,
    });

    const filename = `${req.params.siteId}-site-report.pdf`;
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', `attachment; filename="${filename}"`);
    res.setHeader('Content-Length', String(pdfBuffer.length));
    res.send(pdfBuffer);
  } catch (err) {
    return next(Internal('PDF_GENERATION_FAILED',
      `Could not generate the site PDF for ${req.params.siteId}: ${err.message}`));
  }
});

/* ─────────── GET /api/site/:siteId/screenshot/:pageIndex ─────────── */
//
// Streams a page's base-state screenshot PNG. The path comes from the job's
// own report (written by our scanner, not the user), but we validate the index
// and confirm the file is readable before streaming. Pages with only dynamic
// issues — or where capture failed — have no screenshot and return 404.
siteRouter.get('/:siteId/screenshot/:pageIndex', async (req, res, next) => {
  const data = await loadSiteExport(req.params.siteId);
  if (!data) {
    return next(NotFound('SITE_SCAN_NOT_FOUND', `No site scan found with id "${req.params.siteId}".`));
  }

  const idx  = Number.parseInt(req.params.pageIndex, 10);
  const page = data.report?.pages?.[idx];
  if (!Number.isInteger(idx) || !page) {
    return next(NotFound('PAGE_NOT_FOUND',
      `Site scan ${req.params.siteId} has no page at index ${req.params.pageIndex}.`));
  }
  if (!page.screenshot?.path) {
    return next(NotFound('SCREENSHOT_NOT_AVAILABLE',
      `Page ${idx} of ${req.params.siteId} has no screenshot.`));
  }

  const shotPath = path.resolve(page.screenshot.path);
  try {
    await fs.access(shotPath, fs.constants.R_OK);
  } catch {
    return next(Internal('SCREENSHOT_FILE_MISSING',
      `Screenshot for page ${idx} of ${req.params.siteId} is missing from disk.`));
  }

  res.setHeader('Content-Type', 'image/png');
  res.setHeader('Cache-Control', 'private, max-age=86400');
  res.setHeader('X-Image-Width',  String(page.screenshot.width  ?? ''));
  res.setHeader('X-Image-Height', String(page.screenshot.height ?? ''));
  createReadStream(shotPath).pipe(res);
});

/* ─────────── helpers ─────────── */

/**
 * Load a completed site export ({ siteId, request, completedAt, report }) for the
 * download routes. Prefers the in-memory job; falls back to the on-disk cache so
 * downloads survive an API restart or the 30-min in-memory eviction. The cache
 * file lives under the scan's own artifacts dir, so it's inherently site-scoped.
 * Returns null if neither source has a report.
 */
async function loadSiteExport(id) {
  const job = jobStore.get(id);
  if (job && job.request?.kind === 'site' && job.report) {
    return {
      siteId:      id,
      request:     redactSiteRequest(job.request),
      completedAt: job.finishedAt,
      report:      job.report,
    };
  }
  const cached = await readSiteReport(id);
  if (cached?.report) return cached;
  return null;
}

/**
 * Look up a job and ensure it's a site job. Calls next(NotFound) and returns
 * null on miss, so single-page scan ids can't be read through this route.
 */
function siteJobOr404(id, next) {
  const job = jobStore.get(id);
  if (!job || job.request?.kind !== 'site') {
    next(NotFound('SITE_SCAN_NOT_FOUND', `No site scan found with id "${id}".`));
    return null;
  }
  return job;
}

/**
 * Strip credentials before exposing the request to GET callers. The sitemap
 * URLs and auth strategy are visible (the siteId is unguessable); passwords and
 * tokens never are.
 */
function redactSiteRequest(req) {
  if (!req) return req;
  const out = {
    urls: (req.urls ?? []).map((u) => (typeof u === 'string' ? u : u.url)),
  };
  if (req.auth?.type) {
    out.auth = { type: req.auth.type };
    if (req.auth.contextStrategy) out.auth.contextStrategy = req.auth.contextStrategy;
  }
  return out;
}
