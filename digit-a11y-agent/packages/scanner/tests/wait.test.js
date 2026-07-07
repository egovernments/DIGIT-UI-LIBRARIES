import { describe, it, expect, vi } from 'vitest';
import { waitForReady, WaitError, _defaults } from '../src/wait.js';

/**
 * Build a fake Playwright Page object configured for a specific scenario.
 * Each test can customise which methods succeed vs reject.
 */
function mockPage({
  waitForSelector  = vi.fn().mockResolvedValue(undefined),
  waitForLoadState = vi.fn().mockResolvedValue(undefined),
  waitForFunction  = vi.fn().mockResolvedValue(undefined),
  waitForTimeout   = vi.fn().mockResolvedValue(undefined),
} = {}) {
  return { waitForSelector, waitForLoadState, waitForFunction, waitForTimeout };
}

describe('wait.js — defaults', () => {
  it('uses a 30s overall timeout', () => {
    expect(_defaults.overallTimeoutMs).toBe(30_000);
  });

  it('uses a 10s networkidle window inside that overall budget', () => {
    expect(_defaults.networkIdleTimeoutMs).toBe(10_000);
    expect(_defaults.networkIdleTimeoutMs).toBeLessThan(_defaults.overallTimeoutMs);
  });

  it('adds a 500ms paint buffer', () => {
    expect(_defaults.paintBufferMs).toBe(500);
  });
});

describe('wait.js — waitForReady() happy paths', () => {
  it('uses waitForSelector when provided (most reliable path)', async () => {
    const page = mockPage();
    const result = await waitForReady(page, { waitForSelector: '#root [data-ready]' });

    expect(page.waitForSelector).toHaveBeenCalledWith(
      '#root [data-ready]',
      expect.objectContaining({ state: 'visible' }),
    );
    expect(result.strategy).toBe('selector');
    expect(result.warnings).toEqual([]);
  });

  it('always applies the paint buffer at the end', async () => {
    const page = mockPage();
    await waitForReady(page);
    expect(page.waitForTimeout).toHaveBeenCalledWith(500);
  });

  it('completes via networkidle when no selector is provided', async () => {
    const page = mockPage({
      waitForLoadState: vi.fn().mockResolvedValue(undefined),
      // Never resolves — represents a page with no SPA ready signal
      waitForFunction:  vi.fn().mockImplementation(() => new Promise(() => {})),
    });
    const result = await waitForReady(page);
    expect(result.strategy).toBe('networkidle');
    expect(result.warnings).toEqual([]);
  });

  it('completes via SPA-ready signal if it arrives before networkidle', async () => {
    const page = mockPage({
      // networkidle never resolves
      waitForLoadState: vi.fn().mockImplementation(() => new Promise(() => {})),
      // SPA signal resolves immediately
      waitForFunction:  vi.fn().mockResolvedValue(undefined),
    });
    const result = await waitForReady(page);
    expect(result.strategy).toBe('spa-signal');
    expect(result.warnings).toEqual([]);
  });
});

describe('wait.js — waitForReady() lenient paths (no selector → never throws)', () => {
  it('attaches a warning when networkidle times out and no SPA signal appears', async () => {
    const page = mockPage({
      waitForLoadState: vi.fn().mockRejectedValue(new Error('Timeout 10000ms exceeded')),
      waitForFunction:  vi.fn().mockRejectedValue(new Error('Timeout 5000ms exceeded')),
    });
    const result = await waitForReady(page);

    expect(result.strategy).toBe('timeout');
    expect(result.warnings).toHaveLength(1);
    expect(result.warnings[0].code).toBe('network-not-idle');
    expect(result.warnings[0].message).toMatch(/did not reach a quiet state/);
  });

  it('attaches a warning when the page is closed mid-wait', async () => {
    const page = mockPage({
      waitForLoadState: vi.fn().mockRejectedValue(new Error('Timeout')),
      waitForFunction:  vi.fn().mockRejectedValue(new Error('Timeout')),
      waitForTimeout:   vi.fn().mockRejectedValue(new Error('Page has been closed')),
    });
    const result = await waitForReady(page);

    expect(result.strategy).toBe('error');
    expect(result.warnings.some((w) => w.code === 'page-may-not-be-fully-loaded')).toBe(true);
  });

  it('returns elapsed time even on degraded paths', async () => {
    const page = mockPage();
    const result = await waitForReady(page);
    expect(result.elapsedMs).toBeGreaterThanOrEqual(0);
    expect(typeof result.elapsedMs).toBe('number');
  });
});

/* ─────────── Day 7: strict mode when waitForSelector is provided ─────────── */

describe('wait.js — waitForReady() STRICT path with waitForSelector', () => {
  it('throws WaitError with code PAGE_NOT_READY when the required selector never appears', async () => {
    const page = mockPage({
      waitForSelector: vi.fn().mockRejectedValue(new Error('Timeout 30000ms exceeded')),
    });

    await expect(
      waitForReady(page, { waitForSelector: 'text=My Campaigns' })
    ).rejects.toThrow(WaitError);

    try {
      await waitForReady(page, { waitForSelector: 'text=My Campaigns' });
    } catch (err) {
      expect(err).toBeInstanceOf(WaitError);
      expect(err.code).toBe('PAGE_NOT_READY');
      expect(err.message).toMatch(/text=My Campaigns/);
      expect(err.message).toMatch(/did not appear/);
    }
  });

  it('does NOT silently warn-and-continue when the selector times out', async () => {
    // Regression guard against the pre-fix behaviour that masked workbench-ui
    // redirects: a missing selector used to result in a warning + a happy
    // result object. The strict path must throw instead.
    const page = mockPage({
      waitForSelector: vi.fn().mockRejectedValue(new Error('Timeout')),
    });

    let threw = false;
    try {
      await waitForReady(page, { waitForSelector: '.required' });
    } catch {
      threw = true;
    }
    expect(threw).toBe(true);
  });

  it('proceeds normally and applies the paint buffer when the selector is found', async () => {
    const page = mockPage();
    const result = await waitForReady(page, { waitForSelector: '#dashboard' });

    expect(result.strategy).toBe('selector');
    expect(result.warnings).toEqual([]);
    expect(page.waitForTimeout).toHaveBeenCalledWith(500);
  });
});

describe('WaitError', () => {
  it('carries a stable code and name', () => {
    const err = new WaitError('PAGE_NOT_READY', 'msg');
    expect(err).toBeInstanceOf(Error);
    expect(err.name).toBe('WaitError');
    expect(err.code).toBe('PAGE_NOT_READY');
    expect(err.message).toBe('msg');
  });
});
