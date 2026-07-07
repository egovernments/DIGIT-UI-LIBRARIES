/**
 * Tests for the UI's API client wrapper.
 *
 * We mock window.fetch directly. The client should:
 *   - throw ApiClientError with code+message on non-2xx
 *   - return the parsed JSON on success
 *   - attach the API key header when one is set
 */

import { describe, it, expect, beforeEach, vi } from 'vitest';
import { getHealth, createScan, getScan, ApiClientError } from '../src/lib/api.js';

const okResponse = (body, status = 200) => ({
  ok:     status >= 200 && status < 300,
  status,
  json:   async () => body,
});

beforeEach(() => {
  vi.restoreAllMocks();
  try { window.localStorage.clear(); } catch { /* jsdom env */ }
});

describe('UI api client', () => {
  it('getHealth() returns parsed body on success', async () => {
    vi.spyOn(global, 'fetch').mockResolvedValue(okResponse({ status: 'ok', version: '0.1.0' }));
    const body = await getHealth();
    expect(body.status).toBe('ok');
    expect(body.version).toBe('0.1.0');
  });

  it('throws ApiClientError with code on 4xx', async () => {
    vi.spyOn(global, 'fetch').mockResolvedValue(
      okResponse({ code: 'INVALID_REQUEST_BODY', message: 'bad' }, 400),
    );
    await expect(createScan({ url: 'bad' })).rejects.toMatchObject({
      name:    'ApiClientError',
      code:    'INVALID_REQUEST_BODY',
      message: 'bad',
    });
  });

  it('throws ApiClientError on 5xx', async () => {
    vi.spyOn(global, 'fetch').mockResolvedValue(
      okResponse({ code: 'INTERNAL_ERROR', message: 'boom' }, 500),
    );
    await expect(getScan('scn_x')).rejects.toBeInstanceOf(ApiClientError);
  });

  it('attaches x-api-key header when present in localStorage', async () => {
    window.localStorage.setItem('A11Y_API_KEY', 'k123');
    const spy = vi.spyOn(global, 'fetch').mockResolvedValue(okResponse({ ok: true }));
    await getHealth();
    expect(spy).toHaveBeenCalledWith(
      '/api/health',
      expect.objectContaining({
        headers: expect.objectContaining({ 'x-api-key': 'k123' }),
      }),
    );
  });

  it('omits x-api-key when none is configured', async () => {
    const spy = vi.spyOn(global, 'fetch').mockResolvedValue(okResponse({ ok: true }));
    await getHealth();
    const headers = spy.mock.calls[0][1].headers;
    expect(headers['x-api-key']).toBeUndefined();
  });

  it('serialises the body for POST /api/scan', async () => {
    const spy = vi.spyOn(global, 'fetch').mockResolvedValue(okResponse({ scanId: 'scn_a' }, 202));
    await createScan({ url: 'https://example.gov.in' });
    expect(spy).toHaveBeenCalledWith(
      '/api/scan',
      expect.objectContaining({
        method: 'POST',
        body:   JSON.stringify({ url: 'https://example.gov.in' }),
      }),
    );
  });
});
