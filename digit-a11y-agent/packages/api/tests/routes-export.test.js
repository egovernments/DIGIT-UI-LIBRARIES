/**
 * Day 7: GET /api/scan/:scanId/screenshot and /export.{json,pdf}
 *
 * The PDF route is mocked away to avoid booting Chromium in unit tests
 * (PDF generation is heavy and we'd be testing Playwright, not our wiring).
 */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import request from 'supertest';
import { promises as fs } from 'node:fs';
import path from 'node:path';
import os from 'node:os';

vi.mock('@digit-a11y/scanner', () => ({
  runScan: vi.fn(async () => ({
    violations: [], incomplete: [],
    meta: {
      scanId: 'scn_fake', url: 'x', scannedAt: new Date().toISOString(),
      durationMs: 1, axeCoreVersion: '4.11.4', warnings: [],
    },
  })),
}));

vi.mock('@digit-a11y/reporter', () => ({
  buildFriendlyReport: vi.fn(() => ({ score: 100, status: 'ok', summary: {}, meta: {} })),
}));

// Mock the PDF generator — we don't want to actually launch Chromium.
const pdfBufferMock = Buffer.from('%PDF-1.4 fake pdf bytes', 'utf-8');
vi.mock('../src/scanner-bridge/pdf.js', () => ({
  renderReportPdf: vi.fn(async () => pdfBufferMock),
}));

const { createApp } = await import('../src/app.js');
const { jobStore } = await import('../src/store/jobs.js');

describe('GET /api/scan/:scanId/screenshot (Day 7)', () => {
  let app;
  let screenshotPath;

  beforeEach(async () => {
    jobStore._clear();
    app = createApp();

    // Make a real temp PNG so the route's file-read succeeds.
    screenshotPath = path.join(os.tmpdir(), `test-screenshot-${Date.now()}.png`);
    // Tiny valid 1x1 PNG (just enough bytes to be a real file).
    const minPng = Buffer.from([
      0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a, 0x00, 0x00, 0x00, 0x0d,
      0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
      0x08, 0x06, 0x00, 0x00, 0x00, 0x1f, 0x15, 0xc4, 0x89,
    ]);
    await fs.writeFile(screenshotPath, minPng);
  });

  it('returns 404 for an unknown scanId', async () => {
    const res = await request(app).get('/api/scan/scn_nope/screenshot');
    expect(res.status).toBe(404);
    expect(res.body.code).toBe('SCAN_NOT_FOUND');
  });

  it('returns 404 when the scan has no screenshot in its report', async () => {
    const job = jobStore.create({ url: 'https://x.test/' });
    jobStore.markComplete(job.id, { meta: {} }); // no screenshot

    const res = await request(app).get(`/api/scan/${job.id}/screenshot`);
    expect(res.status).toBe(404);
    expect(res.body.code).toBe('SCREENSHOT_NOT_AVAILABLE');
  });

  it('streams the PNG with image/png Content-Type and the dimension headers', async () => {
    const job = jobStore.create({ url: 'https://x.test/' });
    jobStore.markComplete(job.id, {
      meta: {},
      screenshot: { path: screenshotPath, width: 1280, height: 2400 },
    });

    const res = await request(app).get(`/api/scan/${job.id}/screenshot`);
    expect(res.status).toBe(200);
    expect(res.headers['content-type']).toMatch(/image\/png/);
    expect(res.headers['x-image-width']).toBe('1280');
    expect(res.headers['x-image-height']).toBe('2400');
    expect(res.body.length).toBeGreaterThan(0);
  });
});

describe('GET /api/scan/:scanId/export.json (Day 7)', () => {
  let app;

  beforeEach(() => {
    jobStore._clear();
    app = createApp();
  });

  it('returns 404 for unknown scan', async () => {
    const res = await request(app).get('/api/scan/scn_nope/export.json');
    expect(res.status).toBe(404);
    expect(res.body.code).toBe('SCAN_NOT_FOUND');
  });

  it('returns 400 when the scan has no report yet', async () => {
    const job = jobStore.create({ url: 'https://x.test/' });
    // Don't mark complete — leave it queued
    const res = await request(app).get(`/api/scan/${job.id}/export.json`);
    expect(res.status).toBe(400);
    expect(res.body.code).toBe('REPORT_NOT_READY');
  });

  it('returns the report JSON wrapped with metadata and a download header', async () => {
    const job = jobStore.create({ url: 'https://x.test/' });
    jobStore.markComplete(job.id, {
      score: 92,
      status: 'mostly accessible',
      meta: { durationMs: 4321 },
    });

    const res = await request(app).get(`/api/scan/${job.id}/export.json`);
    expect(res.status).toBe(200);
    expect(res.headers['content-disposition']).toMatch(/attachment; filename=/);
    expect(res.headers['content-disposition']).toMatch(new RegExp(job.id));
    expect(res.body.scanId).toBe(job.id);
    expect(res.body.report.score).toBe(92);
    expect(res.body.durationMs).toBe(4321);
    // Ensures redaction is consistent here too:
    expect(JSON.stringify(res.body)).not.toContain('eGov@123');
  });
});

describe('GET /api/scan/:scanId/export.pdf (Day 7)', () => {
  let app;

  beforeEach(() => {
    jobStore._clear();
    app = createApp();
  });

  it('returns 404 for unknown scan', async () => {
    const res = await request(app).get('/api/scan/scn_nope/export.pdf');
    expect(res.status).toBe(404);
  });

  it('returns 400 when the scan has no report yet', async () => {
    const job = jobStore.create({ url: 'https://x.test/' });
    const res = await request(app).get(`/api/scan/${job.id}/export.pdf`);
    expect(res.status).toBe(400);
  });

  it('streams the generated PDF buffer with correct headers', async () => {
    const job = jobStore.create({ url: 'https://x.test/' });
    jobStore.markComplete(job.id, {
      score: 75,
      meta: {},
    });

    const res = await request(app).get(`/api/scan/${job.id}/export.pdf`);
    expect(res.status).toBe(200);
    expect(res.headers['content-type']).toMatch(/application\/pdf/);
    expect(res.headers['content-disposition']).toMatch(/attachment; filename=/);
    expect(res.body.toString()).toContain('PDF');
  });
});
