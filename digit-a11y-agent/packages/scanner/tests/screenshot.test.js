import { describe, it, expect } from 'vitest';
import { captureScreenshot } from '../src/screenshot.js';

describe('screenshot.js — input validation', () => {
  it('throws if scanId is missing', async () => {
    const fakePage = { screenshot: async () => {} };
    await expect(captureScreenshot(fakePage, {})).rejects.toThrow(/scanId is required/);
    await expect(captureScreenshot(fakePage)).rejects.toThrow(/scanId is required/);
  });

  it('throws with a clear message that mentions the missing field', async () => {
    const fakePage = { screenshot: async () => {} };
    try {
      await captureScreenshot(fakePage, { artifactsDir: '/tmp' });
    } catch (err) {
      expect(err.message).toMatch(/scanId/);
    }
  });
});
