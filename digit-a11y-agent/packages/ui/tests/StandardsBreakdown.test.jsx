/**
 * StandardsBreakdown tests.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { StandardsBreakdown } from '../src/components/StandardsBreakdown.jsx';

const breakdown = {
  wcag:   { totalRulesChecked: 50, rulesFailed: 2, rulesPassed: 48, compliancePercent: 96 },
  gigw:   { totalRulesChecked: 30, rulesFailed: 1, rulesPassed: 29, compliancePercent: 96.7 },
  sesmag: { totalRulesChecked: 25, rulesFailed: 5, rulesPassed: 20, compliancePercent: 80 },
  ada:    { totalRulesChecked: 40, rulesFailed: 0, rulesPassed: 40, compliancePercent: 100 },
};

describe('<StandardsBreakdown />', () => {
  it('renders all four standards', () => {
    render(<StandardsBreakdown breakdown={breakdown} />);
    expect(screen.getByText('WCAG 2.1')).toBeInTheDocument();
    expect(screen.getByText('GIGW')).toBeInTheDocument();
    expect(screen.getByText('SesMag')).toBeInTheDocument();
    expect(screen.getByText('ADA Title III')).toBeInTheDocument();
  });

  it('shows compliance percentage rounded to nearest integer', () => {
    render(<StandardsBreakdown breakdown={breakdown} />);
    // GIGW: 96.7 → 97
    expect(screen.getByText('97')).toBeInTheDocument();
    // SesMag: 80
    expect(screen.getByText('80')).toBeInTheDocument();
    // ADA: 100
    expect(screen.getByText('100')).toBeInTheDocument();
  });

  it('renders passed/failed/total counts per card', () => {
    render(<StandardsBreakdown breakdown={breakdown} />);
    // WCAG: 48 passed, 2 failed, of 50
    expect(screen.getByText(/48/)).toBeInTheDocument();
    expect(screen.getByText(/of 50/)).toBeInTheDocument();
  });

  it('uses progress-bar role with aria-valuenow for accessibility', () => {
    render(<StandardsBreakdown breakdown={breakdown} />);
    const bars = screen.getAllByRole('progressbar');
    expect(bars).toHaveLength(4);
    // WCAG → 96
    const wcagBar = bars.find((b) => b.getAttribute('aria-label')?.includes('WCAG'));
    expect(wcagBar).toBeDefined();
    expect(wcagBar.getAttribute('aria-valuenow')).toBe('96');
  });

  it('does not crash if a standard is missing from the breakdown', () => {
    const partial = { wcag: breakdown.wcag }; // only WCAG provided
    render(<StandardsBreakdown breakdown={partial} />);
    expect(screen.getByText('WCAG 2.1')).toBeInTheDocument();
    expect(screen.getByText(/No data for GIGW/i)).toBeInTheDocument();
  });
});
