/**
 * StartHere tests — renders 0/n issue cards.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import { StartHere } from '../src/components/StartHere.jsx';

const makeIssue = (overrides = {}) => ({
  ruleId:        'color-contrast',
  title:         'Text is hard to read',
  severity:      'Needs Immediate Fix',
  icon:          '👁',
  whyItMatters:  'Low-contrast text fails users with low vision and bright sunlight.',
  whatYouCanDo:  'Increase the contrast ratio to at least 4.5:1.',
  affectedUsers: [{ icon: '👁', label: 'Low vision' }],
  targets:       [{ selector: '#header h1', boundingBox: { x: 0, y: 0, w: 100, h: 30 } }],
  standards:     {
    wcag:   ['1.4.3'],
    gigw:   ['4.2'],
    ada:    ['§ 36.303'],
    sesmag: [],
  },
  ...overrides,
});

describe('<StartHere />', () => {
  it('renders the empty state when issues is undefined', () => {
    render(<StartHere issues={undefined} />);
    expect(screen.getByText(/No critical issues to address/i)).toBeInTheDocument();
  });

  it('renders the empty state when issues is an empty array', () => {
    render(<StartHere issues={[]} />);
    expect(screen.getByText(/No critical issues to address/i)).toBeInTheDocument();
  });

  it('renders each issue with title, why and what fields', () => {
    render(<StartHere issues={[makeIssue()]} />);
    expect(screen.getByText('Text is hard to read')).toBeInTheDocument();
    expect(screen.getByText(/Low-contrast text fails users/i)).toBeInTheDocument();
    expect(screen.getByText(/Increase the contrast ratio/i)).toBeInTheDocument();
  });

  it('renders standards refs grouped by standard', () => {
    render(<StartHere issues={[makeIssue()]} />);
    expect(screen.getByText(/WCAG:/i)).toBeInTheDocument();
    expect(screen.getByText(/1\.4\.3/)).toBeInTheDocument();
    expect(screen.getByText(/GIGW:/i)).toBeInTheDocument();
  });

  it('shows the count when multiple issues are given', () => {
    render(<StartHere issues={[makeIssue(), makeIssue({ ruleId: 'label' }), makeIssue({ ruleId: 'aria' })]} />);
    expect(screen.getByText(/Top 3 priority issues/i)).toBeInTheDocument();
  });
});
