import { describe, it, expect } from 'vitest';
import { buildStandardsBreakdown, _getTotalMappedRules } from '../src/standards.js';

describe('standards.js — buildStandardsBreakdown()', () => {
  it('returns a breakdown with all four standards', () => {
    const breakdown = buildStandardsBreakdown([]);
    expect(breakdown).toHaveProperty('wcag');
    expect(breakdown).toHaveProperty('gigw');
    expect(breakdown).toHaveProperty('sesmag');
    expect(breakdown).toHaveProperty('ada');
  });

  it('reports 100% compliance when no rules fail', () => {
    const breakdown = buildStandardsBreakdown([]);
    expect(breakdown.wcag.compliancePercent).toBe(100);
    expect(breakdown.wcag.rulesFailed).toBe(0);
    expect(breakdown.wcag.rulesPassed).toBe(breakdown.wcag.totalRulesChecked);
  });

  it('decreases compliance percentage when rules fail', () => {
    const clean      = buildStandardsBreakdown([]);
    const oneFailed  = buildStandardsBreakdown(['image-alt']);
    expect(oneFailed.wcag.compliancePercent).toBeLessThan(clean.wcag.compliancePercent);
    expect(oneFailed.wcag.rulesFailed).toBe(1);
  });

  it('counts failures correctly across multiple rules', () => {
    const breakdown = buildStandardsBreakdown(['image-alt', 'color-contrast', 'label']);
    expect(breakdown.wcag.rulesFailed).toBe(3);
  });

  it('rulesPassed + rulesFailed equals totalRulesChecked', () => {
    const breakdown = buildStandardsBreakdown(['image-alt', 'color-contrast']);
    for (const std of ['wcag', 'gigw', 'sesmag', 'ada']) {
      expect(
        breakdown[std].rulesPassed + breakdown[std].rulesFailed,
      ).toBe(breakdown[std].totalRulesChecked);
    }
  });

  it('ignores unknown rule IDs', () => {
    const breakdown = buildStandardsBreakdown(['this-rule-does-not-exist']);
    expect(breakdown.wcag.rulesFailed).toBe(0);
  });

  it('compliance percentages are reasonable (0..100)', () => {
    const breakdown = buildStandardsBreakdown(['image-alt']);
    for (const std of ['wcag', 'gigw', 'sesmag', 'ada']) {
      expect(breakdown[std].compliancePercent).toBeGreaterThanOrEqual(0);
      expect(breakdown[std].compliancePercent).toBeLessThanOrEqual(100);
    }
  });

  it('compliance percentages have at most one decimal place', () => {
    const breakdown = buildStandardsBreakdown(['image-alt']);
    for (const std of ['wcag', 'gigw', 'sesmag', 'ada']) {
      const pct = breakdown[std].compliancePercent;
      const decimals = (pct.toString().split('.')[1] ?? '').length;
      expect(decimals).toBeLessThanOrEqual(1);
    }
  });
});

describe('standards.js — _getTotalMappedRules() sanity check', () => {
  const totals = _getTotalMappedRules();

  it('WCAG covers the majority of the 90 rules', () => {
    expect(totals.wcag).toBeGreaterThan(50);
    expect(totals.wcag).toBeLessThanOrEqual(90);
  });

  it('all standards have some rules mapped', () => {
    expect(totals.wcag).toBeGreaterThan(0);
    expect(totals.gigw).toBeGreaterThan(0);
    expect(totals.sesmag).toBeGreaterThan(0);
    expect(totals.ada).toBeGreaterThan(0);
  });
});
