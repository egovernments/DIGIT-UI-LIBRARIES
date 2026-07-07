import { describe, it, expect } from 'vitest';
import { _defaults } from '../src/axe.js';

describe('axe.js — default tag set', () => {
  it('matches the 89 active axe-core rules covered in messages.js', () => {
    expect(_defaults.tags).toEqual([
      'wcag2a',
      'wcag2aa',
      'wcag21a',
      'wcag21aa',
      'best-practice',
    ]);
  });

  it('does not include WCAG 2.2 (separate Phase 2 mapping)', () => {
    expect(_defaults.tags).not.toContain('wcag22a');
    expect(_defaults.tags).not.toContain('wcag22aa');
  });

  it('does not include AAA (rarely required for govt sites)', () => {
    expect(_defaults.tags).not.toContain('wcag2aaa');
    expect(_defaults.tags).not.toContain('wcag21aaa');
  });

  it('does not include experimental rules', () => {
    expect(_defaults.tags).not.toContain('experimental');
  });
});
