/**
 * DigitPresetButton tests.
 *
 * Verifies the menu opens, lists known presets, and calls onApply with the
 * full preset object when one is chosen.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { DigitPresetButton, _PRESETS } from '../src/components/DigitPresetButton.jsx';

describe('<DigitPresetButton />', () => {
  it('exposes at least two presets', () => {
    expect(_PRESETS.length).toBeGreaterThanOrEqual(2);
    for (const p of _PRESETS) {
      expect(p).toMatchObject({ id: expect.any(String), label: expect.any(String), url: expect.any(String) });
    }
  });

  it('renders a button labelled "Use DIGIT preset"', () => {
    render(<DigitPresetButton onApply={() => {}} />);
    expect(screen.getByRole('button', { name: /use digit preset/i })).toBeInTheDocument();
  });

  it('opens a menu listing all presets when clicked', () => {
    render(<DigitPresetButton onApply={() => {}} />);
    fireEvent.click(screen.getByRole('button', { name: /use digit preset/i }));

    for (const p of _PRESETS) {
      expect(screen.getByText(p.label)).toBeInTheDocument();
    }
  });

  it('calls onApply with the chosen preset, then closes the menu', () => {
    const onApply = vi.fn();
    render(<DigitPresetButton onApply={onApply} />);

    fireEvent.click(screen.getByRole('button', { name: /use digit preset/i }));
    const firstPreset = _PRESETS[0];
    fireEvent.click(screen.getByText(firstPreset.label));

    expect(onApply).toHaveBeenCalledTimes(1);
    expect(onApply).toHaveBeenCalledWith(firstPreset);
    // After selection the menu should be closed
    expect(screen.queryByText(_PRESETS[1].label)).not.toBeInTheDocument();
  });

  it('does NOT include credentials in any preset (security check)', () => {
    // Catches accidental commits of test credentials baked into the JS bundle.
    // Test credentials should be typed by users, not shipped in source.
    for (const p of _PRESETS) {
      if (p.auth?.fields) {
        for (const f of p.auth.fields) {
          expect(f.value).toBe(''); // value is always empty in presets
        }
      }
    }
  });

  it('each preset has a context strategy and a wait-for selector', () => {
    // These two settings are what made DIGIT scans work reliably in Day 7.
    // The whole point of the preset is to bake in that knowledge — so guard
    // against future edits accidentally removing it.
    for (const p of _PRESETS) {
      expect(p.waitForSelector).toBeTruthy();
      expect(p.auth?.contextStrategy).toMatch(/^(reuse|single)$/);
    }
  });
});
