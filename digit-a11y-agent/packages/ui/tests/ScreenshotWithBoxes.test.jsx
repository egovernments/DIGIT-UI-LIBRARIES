/**
 * ScreenshotWithBoxes tests.
 *
 * Day 9 update for Option A (hide all boxes by default, reveal on hover/click):
 *   - The header no longer says "N bounding boxes". It says "N issues on this
 *     page — hover an issue below to see its location" in the default state.
 *   - When hovering an issue, the header says "<title> — N elements highlighted".
 *
 * Image events (load / error) are simulated via fireEvent. We don't actually
 * load PNGs in tests.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { ScreenshotWithBoxes } from '../src/components/ScreenshotWithBoxes.jsx';

const issues = [
  {
    ruleId:   'r1',
    severity: 'Needs Immediate Fix',
    title:    'Bad heading',
    targets: [
      { selector: 'h1', boundingBox: { x: 10, y: 20, width: 200, height: 50 } },
    ],
  },
  {
    ruleId:   'r2',
    severity: 'Minor',
    title:    'Small thing',
    targets: [
      { selector: 'small', boundingBox: { x: 50, y: 100, width: 80, height: 20 } },
    ],
  },
];

describe('<ScreenshotWithBoxes />', () => {
  it('renders an empty-state when no screenshotUrl is provided', () => {
    render(<ScreenshotWithBoxes screenshotUrl={null} nativeWidth={0} nativeHeight={0} issues={[]} />);
    expect(screen.getByText(/Screenshot not captured/i)).toBeInTheDocument();
  });

  it('renders an error-state when the image fails to load', () => {
    render(
      <ScreenshotWithBoxes
        screenshotUrl="/api/scan/scn_x/screenshot"
        nativeWidth={1280}
        nativeHeight={2000}
        issues={issues}
      />
    );

    expect(screen.getByAltText(/Full-page screenshot/i)).toBeInTheDocument();

    fireEvent.error(screen.getByAltText(/Full-page screenshot/i));

    expect(screen.getByText(/Screenshot not available/i)).toBeInTheDocument();
  });

  it('shows the default-state header: issue count + hover hint', () => {
    render(
      <ScreenshotWithBoxes
        screenshotUrl="/api/scan/scn_x/screenshot"
        nativeWidth={1280}
        nativeHeight={2000}
        issues={issues}
      />
    );

    // Default state — no hover, no selection — should show the prompt
    expect(screen.getByText(/2 issues on this page/i)).toBeInTheDocument();
    expect(screen.getByText(/hover an issue below to see its location/i)).toBeInTheDocument();
  });

  it('shows the hovered issue title and element count in the header', () => {
    render(
      <ScreenshotWithBoxes
        screenshotUrl="/api/scan/scn_x/screenshot"
        nativeWidth={1280}
        nativeHeight={2000}
        issues={issues}
        hoveredIssue={{ id: 'r1-0', issue: issues[0] }}
      />
    );

    expect(screen.getByText(/Bad heading/i)).toBeInTheDocument();
    // r1 has 1 target → "1 element highlighted" (singular)
    expect(screen.getByText(/1 element highlighted/i)).toBeInTheDocument();
    // The default-state hint should NOT be present
    expect(screen.queryByText(/hover an issue below/i)).not.toBeInTheDocument();
  });

  it('falls back to selectedIssue when no hover, and shows its title in the header', () => {
    render(
      <ScreenshotWithBoxes
        screenshotUrl="/api/scan/scn_x/screenshot"
        nativeWidth={1280}
        nativeHeight={2000}
        issues={issues}
        selectedIssue={{ id: 'r2-1', issue: issues[1] }}
      />
    );

    expect(screen.getByText(/Small thing/i)).toBeInTheDocument();
  });

  it('treats hover as taking precedence over selection in the header', () => {
    render(
      <ScreenshotWithBoxes
        screenshotUrl="/api/scan/scn_x/screenshot"
        nativeWidth={1280}
        nativeHeight={2000}
        issues={issues}
        hoveredIssue={{ id: 'r1-0', issue: issues[0] }}
        selectedIssue={{ id: 'r2-1', issue: issues[1] }}
      />
    );

    // Bad heading (hover) wins, Small thing (selection) is not shown
    expect(screen.getByText(/Bad heading/i)).toBeInTheDocument();
    expect(screen.queryByText(/Small thing/i)).not.toBeInTheDocument();
  });

  it('renders the screenshot image at the expected URL', () => {
    const { container } = render(
      <ScreenshotWithBoxes
        screenshotUrl="/api/scan/scn_x/screenshot"
        nativeWidth={1280}
        nativeHeight={2000}
        issues={issues}
      />
    );

    fireEvent.load(screen.getByAltText(/Full-page screenshot/i));

    // Note: jsdom doesn't have a real ResizeObserver, so renderedWidth stays
    // 0 and the SVG overlay never mounts. We just verify the image element.
    const img = container.querySelector('img');
    expect(img).toBeInTheDocument();
    expect(img.getAttribute('src')).toBe('/api/scan/scn_x/screenshot');
  });
});
