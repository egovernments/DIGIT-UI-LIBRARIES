/**
 * IssueList tests.
 *
 * Day 9 addition: regression tests for the hover/select ID mapping bug.
 * Previously the per-section index was used to build the issue ID, which
 * silently broke hover-highlighting for everything below the Critical
 * section (Critical happened to work because its section-index matched
 * its global-index). The new tests stage a multi-section issue list and
 * assert that the IDs emitted upward use the global position.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { IssueList } from '../src/components/IssueList.jsx';

const makeIssue = (overrides = {}) => ({
  ruleId:        'color-contrast',
  title:         'Text is hard to read',
  severity:      'Needs Immediate Fix',
  icon:          '👁',
  whyItMatters:  'Low-contrast text fails users with low vision.',
  whatYouCanDo:  'Increase the contrast ratio to at least 4.5:1.',
  targets:       [{ selector: 'header h1', boundingBox: { x: 0, y: 0, width: 100, height: 30 } }],
  standards:     { wcag: ['1.4.3'], gigw: [], ada: [], sesmag: [] },
  ...overrides,
});

const mix = [
  makeIssue({ ruleId: 'r1', severity: 'Needs Immediate Fix', title: 'Critical issue' }),
  makeIssue({ ruleId: 'r2', severity: 'Important',           title: 'Important issue' }),
  makeIssue({ ruleId: 'r3', severity: 'Can Improve',         title: 'Moderate issue' }),
  makeIssue({ ruleId: 'r4', severity: 'Minor',               title: 'Minor issue' }),
];

describe('<IssueList />', () => {
  it('renders the empty state when there are no issues', () => {
    render(<IssueList issues={[]} />);
    expect(screen.getByText(/No accessibility issues found/i)).toBeInTheDocument();
  });

  it('renders the empty state when issues is undefined', () => {
    render(<IssueList issues={undefined} />);
    expect(screen.getByText(/No accessibility issues found/i)).toBeInTheDocument();
  });

  it('groups issues into severity sections', () => {
    render(<IssueList issues={mix} />);
    expect(screen.getByText('Needs Immediate Fix')).toBeInTheDocument();
    expect(screen.getByText('Important')).toBeInTheDocument();
    expect(screen.getByText('Can Improve')).toBeInTheDocument();
    expect(screen.getByText('Minor')).toBeInTheDocument();
  });

  it('opens critical and serious sections by default; collapses lower severities', () => {
    render(<IssueList issues={mix} />);
    expect(screen.getByText('Critical issue')).toBeInTheDocument();
    expect(screen.getByText('Important issue')).toBeInTheDocument();
    expect(screen.queryByText('Moderate issue')).not.toBeInTheDocument();
    expect(screen.queryByText('Minor issue')).not.toBeInTheDocument();
  });

  it('expands a collapsed section when clicked', () => {
    render(<IssueList issues={mix} />);
    fireEvent.click(screen.getByText('Can Improve'));
    expect(screen.getByText('Moderate issue')).toBeInTheDocument();
  });

  it('calls onHoverIssue when mouse enters and leaves an issue row', () => {
    const onHover = vi.fn();
    render(<IssueList issues={[mix[0]]} onHoverIssue={onHover} />);

    const row = screen.getByText('Critical issue').closest('div[class*="cursor-pointer"]');
    fireEvent.mouseEnter(row);
    expect(onHover).toHaveBeenCalledWith(expect.objectContaining({ issue: expect.objectContaining({ title: 'Critical issue' }) }));

    fireEvent.mouseLeave(row);
    expect(onHover).toHaveBeenLastCalledWith(null);
  });

  it('calls onSelectIssue when an issue is clicked', () => {
    const onSelect = vi.fn();
    render(<IssueList issues={[mix[0]]} onSelectIssue={onSelect} />);
    fireEvent.click(screen.getByText('Critical issue'));
    expect(onSelect).toHaveBeenCalledTimes(1);
    expect(onSelect).toHaveBeenCalledWith(expect.objectContaining({ issue: expect.objectContaining({ title: 'Critical issue' }) }));
  });

  it('shows section counts in the header', () => {
    const lots = [
      makeIssue({ ruleId: 'a', severity: 'Needs Immediate Fix' }),
      makeIssue({ ruleId: 'b', severity: 'Needs Immediate Fix' }),
      makeIssue({ ruleId: 'c', severity: 'Needs Immediate Fix' }),
    ];
    render(<IssueList issues={lots} />);
    expect(screen.getByText('3 issues')).toBeInTheDocument();
  });

  it('shows "Details" button on an issue and expands inline when clicked', () => {
    render(<IssueList issues={[mix[0]]} />);
    const detailsBtn = screen.getByLabelText(/Show more/i);
    fireEvent.click(detailsBtn);
    expect(screen.getByText(/Increase the contrast ratio/i)).toBeInTheDocument();
    expect(screen.getByText(/header h1/i)).toBeInTheDocument();
  });

  /* ─────────────── Day 9 regression: cross-section ID mapping ─────────────── */

  it('emits global-index IDs when hovering non-Critical issues', () => {
    // Stage 4 issues across 4 sections so per-section index ≠ global index
    // for everything except the Critical one. Pre-fix, only Critical's ID
    // matched what ScreenshotWithBoxes expects (`r1-0`); the others
    // emitted IDs like `r2-0`, `r3-0`, `r4-0` (per-section position) when
    // they should emit `r2-1`, `r3-2`, `r4-3` (global position).
    const onHover = vi.fn();
    render(<IssueList issues={mix} onHoverIssue={onHover} />);

    // Expand the lower sections so we can hover them
    fireEvent.click(screen.getByText('Can Improve'));
    fireEvent.click(screen.getByText('Minor'));

    const hover = (title) => {
      const row = screen.getByText(title).closest('div[class*="cursor-pointer"]');
      fireEvent.mouseEnter(row);
      return onHover.mock.calls[onHover.mock.calls.length - 1][0];
    };

    expect(hover('Critical issue').id).toBe('r1-0');
    expect(hover('Important issue').id).toBe('r2-1');   // global index 1, NOT 0
    expect(hover('Moderate issue').id).toBe('r3-2');    // global index 2, NOT 0
    expect(hover('Minor issue').id).toBe('r4-3');       // global index 3, NOT 0
  });

  it('emits global-index IDs when clicking non-Critical issues', () => {
    const onSelect = vi.fn();
    render(<IssueList issues={mix} onSelectIssue={onSelect} />);

    fireEvent.click(screen.getByText('Can Improve'));
    fireEvent.click(screen.getByText('Minor'));

    const click = (title) => {
      fireEvent.click(screen.getByText(title));
      return onSelect.mock.calls[onSelect.mock.calls.length - 1][0];
    };

    expect(click('Important issue').id).toBe('r2-1');
    expect(click('Moderate issue').id).toBe('r3-2');
    expect(click('Minor issue').id).toBe('r4-3');
  });

  it('honours selectedIssueId when it uses the global-index form', () => {
    // Verify the visual-selection check uses the same ID shape as the
    // emit path. Pass selectedIssueId for the Moderate issue (global
    // index 2). The Moderate row should render with bg-brand-50.
    render(<IssueList issues={mix} selectedIssueId="r3-2" />);
    fireEvent.click(screen.getByText('Can Improve'));

    const moderateRow = screen.getByText('Moderate issue').closest('div[class*="cursor-pointer"]');
    expect(moderateRow.className).toMatch(/bg-brand-50/);
  });
});
