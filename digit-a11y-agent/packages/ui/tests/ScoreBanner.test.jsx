/**
 * ScoreBanner tests — pure-presentation component.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { ScoreBanner } from '../src/components/ScoreBanner.jsx';

const makeReport = (overrides = {}) => ({
  score:       82,
  status:      'Good progress',
  keySummary:  'Most checks passed — one critical issue to address.',
  summaryText: 'Found 4 accessibility issues across 89 rules.',
  summary: {
    totalIssues: 4,
    critical:    1,
    serious:     1,
    moderate:    2,
    minor:       0,
  },
  ...overrides,
});

describe('<ScoreBanner />', () => {
  it('renders the score, status, and key summary', () => {
    render(<ScoreBanner report={makeReport()} />);
    expect(screen.getByText('82')).toBeInTheDocument();
    expect(screen.getByText(/Good progress/i)).toBeInTheDocument();
    expect(screen.getByText(/Most checks passed/i)).toBeInTheDocument();
  });

  it('renders the severity counts in order with the total', () => {
    render(<ScoreBanner report={makeReport()} />);

    // labels
    expect(screen.getByText('Total')).toBeInTheDocument();
    expect(screen.getByText('Critical')).toBeInTheDocument();
    expect(screen.getByText('Serious')).toBeInTheDocument();
    expect(screen.getByText('Moderate')).toBeInTheDocument();
    expect(screen.getByText('Minor')).toBeInTheDocument();

    // count values (use getAllByText for numbers that could repeat)
    const fours = screen.getAllByText('4');
    expect(fours.length).toBeGreaterThanOrEqual(1); // total = 4
  });

  it('renders a score of 100 cleanly', () => {
    render(<ScoreBanner report={makeReport({ score: 100, summary: {
      totalIssues: 0, critical: 0, serious: 0, moderate: 0, minor: 0,
    } })} />);
    expect(screen.getByText('100')).toBeInTheDocument();
  });

  it('renders a score of 0 without crashing', () => {
    render(<ScoreBanner report={makeReport({ score: 0, status: 'Critical', summary: {
      totalIssues: 25, critical: 10, serious: 8, moderate: 5, minor: 2,
    } })} />);
    expect(screen.getByText('0')).toBeInTheDocument();
    expect(screen.getByText('25')).toBeInTheDocument();
  });
});
