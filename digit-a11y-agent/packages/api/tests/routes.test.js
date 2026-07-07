/**
 * API integration tests using supertest.
 *
 * These tests boot a real Express app (no port binding — supertest injects
 * the request directly into the handler) and exercise the full middleware
 * chain: parsing, validation, auth, routing, error handling.
 *
 * The scanner-bridge module is mocked so tests don't launch a real browser.
 */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import request from 'supertest';

// Mock the scanner bridge BEFORE importing the app, so the route handlers
// resolve to our fake instead of pulling in Playwright.
vi.mock('@digit-a11y/scanner', () => ({
  runScan: vi.fn(async (req) => ({
    violations: [],
    incomplete: [],
    meta: {
      scanId:         'scn_fake_0000000000000000',
      url:            req.url,
      scannedAt:      new Date().toISOString(),
      durationMs:     100,
      axeCoreVersion: '4.11.4',
      warnings:       [],
    },
  })),
}));

vi.mock('@digit-a11y/reporter', () => ({
  buildFriendlyReport: vi.fn((raw) => ({
    score:       100,
    status:      'Good to go',
    summaryText: 'Mocked report',
    keySummary:  'Mocked report',
    summary:     { totalIssues: 0, critical: 0, serious: 0, moderate: 0, minor: 0 },
    startHere:   [],
    issues:      [],
    standardsBreakdown: {
      wcag:   { totalRulesChecked: 0, rulesFailed: 0, rulesPassed: 0, compliancePercent: 100 },
      gigw:   { totalRulesChecked: 0, rulesFailed: 0, rulesPassed: 0, compliancePercent: 100 },
      sesmag: { totalRulesChecked: 0, rulesFailed: 0, rulesPassed: 0, compliancePercent: 100 },
      ada:    { totalRulesChecked: 0, rulesFailed: 0, rulesPassed: 0, compliancePercent: 100 },
    },
    meta: raw.meta,
  })),
}));

// Now safe to import.
const { createApp } = await import('../src/app.js');
const { jobStore } = await import('../src/store/jobs.js');

/* Small helper: wait until a job reaches a final status. */
async function waitForFinal(scanId, app, { tries = 20, delayMs = 50 } = {}) {
  for (let i = 0; i < tries; i++) {
    const res = await request(app).get(`/api/scan/${scanId}`);
    if (res.body.status === 'complete' || res.body.status === 'failed') {
      return res.body;
    }
    await new Promise((r) => setTimeout(r, delayMs));
  }
  throw new Error(`Job ${scanId} did not finish in ${tries * delayMs}ms`);
}

describe('API integration', () => {
  let app;

  beforeEach(() => {
    jobStore._clear();
    app = createApp();
  });

  describe('GET /api/health', () => {
    it('returns 200 with status and version', async () => {
      const res = await request(app).get('/api/health');
      expect(res.status).toBe(200);
      expect(res.body.status).toBe('ok');
      expect(res.body.version).toBeTypeOf('string');
      expect(res.body.uptimeSeconds).toBeTypeOf('number');
      expect(res.body.jobs).toBeDefined();
    });
  });

  describe('POST /api/scan', () => {
    it('returns 202 with a scanId for a valid request', async () => {
      const res = await request(app)
        .post('/api/scan')
        .send({ url: 'https://example.gov.in' });

      expect(res.status).toBe(202);
      expect(res.body.scanId).toMatch(/^scn_/);
      expect(res.body.status).toBe('queued');
      expect(res.body.statusUrl).toContain(res.body.scanId);
    });

    it('returns 400 with zod issues for an invalid body', async () => {
      const res = await request(app)
        .post('/api/scan')
        .send({ url: 'not-a-url' });

      expect(res.status).toBe(400);
      expect(res.body.code).toBe('INVALID_REQUEST_BODY');
      expect(res.body.details.issues).toBeInstanceOf(Array);
    });

    it('returns 400 when body is empty', async () => {
      const res = await request(app).post('/api/scan').send({});
      expect(res.status).toBe(400);
      expect(res.body.code).toBe('INVALID_REQUEST_BODY');
    });
  });

  describe('GET /api/scan/:scanId', () => {
    it('returns 404 for unknown scanId', async () => {
      const res = await request(app).get('/api/scan/scn_does_not_exist');
      expect(res.status).toBe(404);
      expect(res.body.code).toBe('SCAN_NOT_FOUND');
    });

    it('returns the job status for a known scanId', async () => {
      const created = await request(app)
        .post('/api/scan')
        .send({ url: 'https://example.gov.in' });

      const res = await request(app).get(`/api/scan/${created.body.scanId}`);
      expect(res.status).toBe(200);
      expect(res.body.scanId).toBe(created.body.scanId);
      expect(['queued', 'running', 'complete']).toContain(res.body.status);
    });

    it('eventually includes a report when the scan completes', async () => {
      const created = await request(app)
        .post('/api/scan')
        .send({ url: 'https://example.gov.in' });

      const final = await waitForFinal(created.body.scanId, app);
      expect(final.status).toBe('complete');
      expect(final.report).toBeDefined();
      expect(final.report.score).toBe(100);
    });
  });

  describe('Unmatched API routes', () => {
    it('returns 404 ROUTE_NOT_FOUND', async () => {
      const res = await request(app).get('/api/does-not-exist');
      expect(res.status).toBe(404);
      expect(res.body.code).toBe('ROUTE_NOT_FOUND');
    });
  });
});
