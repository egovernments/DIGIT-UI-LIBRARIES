import { describe, it, expect } from 'vitest';
import { buildFriendlyReport } from '../src/index.js';

const FAKE_META = {
  scanId:          'scn_test_001',
  url:             'https://example.gov.in',
  scannedAt:       '2026-05-18T10:00:00Z',
  durationMs:      4500,
  axeCoreVersion:  '4.11.1',
  warnings:        [],
};

const fakeViolation = (id, impact = 'serious', selector = 'body') => ({
  id,
  impact,
  description: 'desc',
  help: 'help',
  helpUrl: 'https://dequeuniversity.com/rules/axe/4.11/' + id,
  nodes: [{ target: [selector], html: '<body>...</body>' }],
});

describe('reporter index.js — buildFriendlyReport() end-to-end', () => {
  it('produces a clean report when no violations exist', () => {
    const report = buildFriendlyReport({
      violations: [],
      incomplete: [],
      meta: FAKE_META,
    });

    expect(report.score).toBe(100);
    expect(report.status).toBe('Good to go');
    expect(report.summary.totalIssues).toBe(0);
    expect(report.startHere).toHaveLength(0);
    expect(report.issues).toHaveLength(0);
    expect(report.keySummary).toMatch(/fully accessible/i);
  });

  it('produces a report with all expected fields', () => {
    const report = buildFriendlyReport({
      violations: [fakeViolation('image-alt', 'critical')],
      incomplete: [],
      meta: FAKE_META,
    });

    // Required top-level fields
    expect(report).toHaveProperty('score');
    expect(report).toHaveProperty('status');
    expect(report).toHaveProperty('summaryText');
    expect(report).toHaveProperty('keySummary');
    expect(report).toHaveProperty('summary');
    expect(report).toHaveProperty('startHere');
    expect(report).toHaveProperty('issues');
    expect(report).toHaveProperty('standardsBreakdown');
    expect(report).toHaveProperty('meta');
  });

  it('translates axe rule IDs to friendly issues', () => {
    const report = buildFriendlyReport({
      violations: [fakeViolation('image-alt', 'critical', 'img.banner')],
      incomplete: [],
      meta: FAKE_META,
    });

    expect(report.issues).toHaveLength(1);
    const issue = report.issues[0];
    expect(issue.ruleId).toBe('image-alt');
    expect(issue.title).toBe('Images are missing descriptions');
    expect(issue.severity).toBe('Needs Immediate Fix');
    expect(issue.targets[0].selector).toBe('img.banner');
    expect(issue.standards.wcag.length).toBeGreaterThan(0);
  });

  it('sorts issues by severity (critical first, minor last)', () => {
    const report = buildFriendlyReport({
      violations: [
        fakeViolation('image-redundant-alt', 'minor'),
        fakeViolation('image-alt',           'critical'),
        fakeViolation('color-contrast',      'serious'),
      ],
      incomplete: [],
      meta: FAKE_META,
    });

    expect(report.issues[0].severity).toBe('Needs Immediate Fix');
    expect(report.issues[1].severity).toBe('Important');
    expect(report.issues[2].severity).toBe('Minor');
  });

  it('populates startHere with up to 3 critical/serious issues', () => {
    const report = buildFriendlyReport({
      violations: [
        fakeViolation('image-alt',          'critical'),
        fakeViolation('label',              'critical'),
        fakeViolation('button-name',        'critical'),
        fakeViolation('link-name',          'critical'),
        fakeViolation('color-contrast',     'serious'),
      ],
      incomplete: [],
      meta: FAKE_META,
    });

    expect(report.startHere).toHaveLength(3);
    expect(report.startHere.every((i) =>
      ['Needs Immediate Fix', 'Important'].includes(i.severity),
    )).toBe(true);
  });

  it('detects landmark sections from selectors', () => {
    const report = buildFriendlyReport({
      violations: [
        fakeViolation('color-contrast', 'serious', 'nav a.primary'),
        fakeViolation('label',          'critical', 'form#login input'),
      ],
      incomplete: [],
      meta: FAKE_META,
    });

    const allSections = report.issues.flatMap((i) => i.sections);
    expect(allSections).toContain('Navigation');
    expect(allSections).toContain('Form');
  });

  it('attaches scan metadata to the report', () => {
    const report = buildFriendlyReport({
      violations: [],
      incomplete: [],
      meta: FAKE_META,
    });
    expect(report.meta).toEqual(FAKE_META);
  });

  it('produces a sensible standardsBreakdown', () => {
    const report = buildFriendlyReport({
      violations: [fakeViolation('image-alt', 'critical')],
      incomplete: [],
      meta: FAKE_META,
    });
    expect(report.standardsBreakdown.wcag.rulesFailed).toBe(1);
    expect(report.standardsBreakdown.wcag.compliancePercent).toBeLessThan(100);
  });
});
