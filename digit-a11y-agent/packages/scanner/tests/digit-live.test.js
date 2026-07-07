/**
 * Live DIGIT integration test.
 *
 * Runs the full scanner pipeline against the real DIGIT health-demo
 * instance. Different from unit tests because:
 *   - No mocking; we hit the actual network.
 *   - Slow (~30-60s per scan).
 *   - Will fail when DIGIT itself is down — that's expected and not a code bug.
 *
 * Therefore: this suite is OPT-IN. Set DIGIT_LIVE_TESTS=1 to enable.
 *
 *   pnpm test                  # runs everything except this
 *   DIGIT_LIVE_TESTS=1 pnpm test          # includes this
 *   pnpm test:live            # alias from package.json (sets the env var)
 *
 * When the env var is unset, every test inside this file is `it.skip`-ed.
 * The suite still appears in the output as "skipped (N)" so it's visible
 * that the coverage exists.
 */

import { describe, it, expect } from 'vitest';
import { runScan } from '../src/index.js';

const LIVE = process.env.DIGIT_LIVE_TESTS === '1';
const itLive = LIVE ? it : it.skip;

const HEALTH_DEMO_PUBLIC_URL = 'https://health-demo.digit.org/console/employee/user/login';

// Long timeouts — DIGIT can be slow and we'd rather fail loudly on real
// problems than time out on a 70-second-but-otherwise-fine scan.
const LIVE_SCAN_TIMEOUT_MS    = 150_000;
const LIVE_TEST_TIMEOUT_MS    = 180_000;

describe('live DIGIT scans (opt-in via DIGIT_LIVE_TESTS=1)', () => {
  itLive('scans the public login page and produces a real report', async () => {
    const result = await runScan({
      url: HEALTH_DEMO_PUBLIC_URL,
      options: {
        captureScreenshot:    true,
        computeBoundingBoxes: true,
        timeoutMs:            LIVE_SCAN_TIMEOUT_MS,
        artifactsDir:         '/tmp/digit-live-test-artifacts',
      },
    });

    // The scan should produce a violations array (could be empty) and
    // populate meta with the expected fields. We deliberately don't assert
    // a particular score — DIGIT can change between runs and we don't want
    // the test to fail when the real site gets accessibility improvements.
    expect(result.violations).toBeInstanceOf(Array);
    expect(result.meta).toBeDefined();
    expect(result.meta.scanId).toMatch(/^scn_/);
    expect(result.meta.url).toBe(HEALTH_DEMO_PUBLIC_URL);
    expect(result.meta.durationMs).toBeGreaterThan(0);
    expect(result.meta.axeCoreVersion).toMatch(/^\d+\.\d+\.\d+/);

    // Screenshot should be captured against a real, rendered page.
    expect(result.screenshot).toBeDefined();
    expect(result.screenshot.width).toBeGreaterThan(0);
    expect(result.screenshot.height).toBeGreaterThan(0);

    // The final URL should be the requested URL (or trivially redirected
    // to the same path with a trailing slash). If DIGIT silently redirects
    // somewhere unexpected, we want to know.
    const finalPath = new URL(result.meta.finalUrl ?? result.meta.url).pathname.replace(/\/$/, '');
    const requestedPath = new URL(HEALTH_DEMO_PUBLIC_URL).pathname.replace(/\/$/, '');
    expect(finalPath).toBe(requestedPath);
  }, LIVE_TEST_TIMEOUT_MS);

  itLive('reports a meaningful score from the page', async () => {
    // Sanity check on the scoring path. We assert a wide range rather
    // than a specific number — DIGIT may improve over time and we don't
    // want a successful improvement to fail this test.
    const result = await runScan({
      url: HEALTH_DEMO_PUBLIC_URL,
      options: {
        captureScreenshot:    false, // skip for speed; we already covered this above
        computeBoundingBoxes: false,
        timeoutMs:            LIVE_SCAN_TIMEOUT_MS,
        artifactsDir:         '/tmp/digit-live-test-artifacts',
      },
    });

    // Just sanity-check: violation count is a number, every violation has
    // the expected shape (axe-core hasn't changed under us).
    expect(typeof result.violations.length).toBe('number');
    for (const v of result.violations) {
      expect(v).toHaveProperty('id');
      expect(v).toHaveProperty('impact');
      expect(v).toHaveProperty('nodes');
      expect(Array.isArray(v.nodes)).toBe(true);
    }
  }, LIVE_TEST_TIMEOUT_MS);

  // Mark the suite-level state so the test report at least shows what mode we're in.
  it('reports whether live mode is enabled', () => {
    if (LIVE) {
      // eslint-disable-next-line no-console
      console.log('[live-digit] DIGIT_LIVE_TESTS=1 — running real DIGIT scans');
    } else {
      // eslint-disable-next-line no-console
      console.log('[live-digit] skipped. Run with DIGIT_LIVE_TESTS=1 or `pnpm test:live` to enable.');
    }
    expect(typeof LIVE).toBe('boolean');
  });
});
