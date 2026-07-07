import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { tmpdir } from 'node:os';
import { mkdtemp, rm, stat } from 'node:fs/promises';
import path from 'node:path';
import { runScan, ScanError } from '../src/index.js';

// ─── Input validation (no browser needed) ────────────────────────────────────

describe('runScan() — input validation', () => {
  it('throws INVALID_REQUEST for null/undefined input', async () => {
    await expect(runScan(null)).rejects.toMatchObject({
      name: 'ScanError', code: 'INVALID_REQUEST',
    });
    await expect(runScan(undefined)).rejects.toMatchObject({ code: 'INVALID_REQUEST' });
  });

  it('throws INVALID_URL for missing or non-string url', async () => {
    await expect(runScan({})).rejects.toMatchObject({ code: 'INVALID_URL' });
    await expect(runScan({ url: 42 })).rejects.toMatchObject({ code: 'INVALID_URL' });
    await expect(runScan({ url: '' })).rejects.toMatchObject({ code: 'INVALID_URL' });
  });

  it('throws INVALID_URL for unparsable URLs', async () => {
    await expect(runScan({ url: 'not a url' })).rejects.toMatchObject({ code: 'INVALID_URL' });
  });

  it('throws INVALID_URL for disallowed schemes (ftp, file)', async () => {
    await expect(runScan({ url: 'ftp://example.com' })).rejects.toMatchObject({ code: 'INVALID_URL' });
    await expect(runScan({ url: 'file:///etc/passwd' })).rejects.toMatchObject({ code: 'INVALID_URL' });
  });

  it('ScanError instances are real Error instances', async () => {
    try {
      await runScan({ url: 'bad' });
    } catch (err) {
      expect(err).toBeInstanceOf(Error);
      expect(err).toBeInstanceOf(ScanError);
    }
  });
});

// ─── Real-browser end-to-end tests ───────────────────────────────────────────
//
// Tagged "[browser]" — launches Chromium against fixture pages.
// Requires `pnpm exec playwright install chromium` to have been run.

describe('runScan() — [browser] end-to-end against a fixture page', () => {
  let artifactsDir;

  beforeAll(async () => {
    artifactsDir = await mkdtemp(path.join(tmpdir(), 'digit-a11y-scan-'));
  });

  afterAll(async () => {
    if (artifactsDir) {
      await rm(artifactsDir, { recursive: true, force: true });
    }
  });

  it('returns violations for a page with deliberate accessibility issues', async () => {
    const fixture = `
      <!DOCTYPE html>
      <html><head><title>Day 3 fixture</title></head>
      <body>
        <img src="logo.png" />
        <button></button>
        <a href="/next"></a>
        <main><h1>Welcome</h1></main>
      </body></html>
    `;
    const url = 'data:text/html;charset=utf-8,' + encodeURIComponent(fixture);

    const result = await runScan({ url, options: { artifactsDir } });

    expect(result).toHaveProperty('violations');
    expect(result).toHaveProperty('meta');

    const ids = result.violations.map((v) => v.id);
    expect(ids).toContain('image-alt');
    expect(ids).toContain('button-name');
    expect(ids).toContain('link-name');

    // Meta is well-formed
    expect(result.meta.scanId).toMatch(/^scn_/);
    expect(result.meta.authenticated).toBe(false);  // no auth was supplied
  }, 60_000);

  it('captures a full-page screenshot and reports its dimensions', async () => {
    const fixture = '<!DOCTYPE html><html><body><h1>Hi</h1><p>Test page</p></body></html>';
    const url = 'data:text/html;charset=utf-8,' + encodeURIComponent(fixture);

    const result = await runScan({ url, options: { artifactsDir } });

    expect(result.screenshot).toBeDefined();
    expect(result.screenshot.path).toMatch(/screenshot\.png$/);
    expect(result.screenshot.width).toBeGreaterThan(0);
    expect(result.screenshot.height).toBeGreaterThan(0);
    expect(result.screenshot.sizeBytes).toBeGreaterThan(0);

    // File actually exists on disk
    const fileStats = await stat(result.screenshot.path);
    expect(fileStats.size).toBe(result.screenshot.sizeBytes);
  }, 60_000);

  it('attaches _bounds to each violation node (in document coordinates)', async () => {
    const fixture = `
      <!DOCTYPE html>
      <html><body>
        <img id="bad-img" src="x.png" style="position:absolute; left:50px; top:100px; width:200px; height:80px;" />
      </body></html>
    `;
    const url = 'data:text/html;charset=utf-8,' + encodeURIComponent(fixture);

    const result = await runScan({ url, options: { artifactsDir } });

    const imgViolation = result.violations.find((v) => v.id === 'image-alt');
    expect(imgViolation).toBeDefined();
    expect(imgViolation.nodes[0]._bounds).toBeDefined();

    const bb = imgViolation.nodes[0]._bounds;
    expect(bb).not.toBeNull();
    // Positions roughly match what we set inline (allowing default body margins)
    expect(bb.width).toBe(200);
    expect(bb.height).toBe(80);
    expect(bb.x).toBeGreaterThanOrEqual(50);
    expect(bb.y).toBeGreaterThanOrEqual(100);
  }, 60_000);

  it('skips screenshot when captureScreenshot is false', async () => {
    const fixture = '<!DOCTYPE html><html><body><h1>OK</h1></body></html>';
    const url = 'data:text/html;charset=utf-8,' + encodeURIComponent(fixture);

    const result = await runScan({
      url,
      options: { captureScreenshot: false, artifactsDir },
    });

    expect(result.screenshot).toBeUndefined();
  }, 60_000);

  it('returns 0 violations for a clean page', async () => {
    const fixture = `
      <!DOCTYPE html>
      <html lang="en">
        <head><title>Clean</title></head>
        <body>
          <main><h1>Hello</h1><p style="color:black;background:white;">Readable.</p></main>
        </body>
      </html>
    `;
    const url = 'data:text/html;charset=utf-8,' + encodeURIComponent(fixture);

    const result = await runScan({ url, options: { artifactsDir } });
    expect(result.violations).toEqual([]);
  }, 60_000);

  it('meta.warnings is always an array, even when nothing went wrong', async () => {
    const url = 'data:text/html,<html><body><h1>OK</h1></body></html>';
    const result = await runScan({ url, options: { artifactsDir } });
    expect(Array.isArray(result.meta.warnings)).toBe(true);
  }, 60_000);
});
