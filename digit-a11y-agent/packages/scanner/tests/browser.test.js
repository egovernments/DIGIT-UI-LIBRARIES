import { describe, it, expect, vi } from 'vitest';
import { _defaults, closeContext, closeBrowser } from '../src/browser.js';

describe('browser.js — defaults', () => {
  it('runs headless by default', () => {
    expect(_defaults.launch.headless).toBe(true);
  });

  it('includes the --no-sandbox flag (required for Docker)', () => {
    expect(_defaults.launch.args).toContain('--no-sandbox');
  });

  it('uses an Indian locale and timezone for context', () => {
    expect(_defaults.context.locale).toBe('en-IN');
    expect(_defaults.context.timezoneId).toBe('Asia/Kolkata');
  });

  it('uses a 1280×800 desktop viewport', () => {
    expect(_defaults.context.viewport).toEqual({ width: 1280, height: 800 });
  });

  it('identifies itself in the user agent so scans are auditable in server logs', () => {
    expect(_defaults.context.userAgent).toMatch(/DigitA11yScanner/);
  });

  it('ignores HTTPS errors (govt UAT hosts often have self-signed certs)', () => {
    expect(_defaults.context.ignoreHTTPSErrors).toBe(true);
  });
});

describe('browser.js — cleanup is best-effort', () => {
  it('closeContext is a no-op for null/undefined inputs', async () => {
    await expect(closeContext(null)).resolves.toBeUndefined();
    await expect(closeContext(undefined)).resolves.toBeUndefined();
  });

  it('closeContext swallows errors from already-closed contexts', async () => {
    const fakeContext = {
      close: vi.fn().mockRejectedValue(new Error('Already closed')),
    };
    await expect(closeContext(fakeContext)).resolves.toBeUndefined();
    expect(fakeContext.close).toHaveBeenCalledOnce();
  });

  it('closeBrowser is a no-op for null/undefined inputs', async () => {
    await expect(closeBrowser(null)).resolves.toBeUndefined();
    await expect(closeBrowser(undefined)).resolves.toBeUndefined();
  });

  it('closeBrowser swallows errors from already-closed browsers', async () => {
    const fakeBrowser = {
      close: vi.fn().mockRejectedValue(new Error('Process exited')),
    };
    await expect(closeBrowser(fakeBrowser)).resolves.toBeUndefined();
    expect(fakeBrowser.close).toHaveBeenCalledOnce();
  });
});
