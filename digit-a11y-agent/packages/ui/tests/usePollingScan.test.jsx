/**
 * usePollingScan tests.
 *
 * Uses REAL timers with a tiny 20-50ms poll interval. Earlier this file
 * used vi.useFakeTimers(), but that breaks @testing-library's `waitFor`
 * (which itself relies on setInterval internally). Real timers with a
 * fast interval are simpler and faster.
 *
 * Module-level consts that the vi.mock factory references are wrapped in
 * vi.hoisted() so they're initialised before the hoisted mock runs.
 *
 * Verifies:
 *   - polls until status is terminal then stops
 *   - sets reconnecting on transient network error
 *   - sets error + stops on SCAN_NOT_FOUND
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';

const { getScanMock, FakeApiClientError } = vi.hoisted(() => {
  class FakeApiClientError extends Error {
    constructor(code, message) { super(message); this.code = code; }
  }
  return { getScanMock: vi.fn(), FakeApiClientError };
});

vi.mock('../src/lib/api.js', () => ({
  getScan:        (...args) => getScanMock(...args),
  ApiClientError: FakeApiClientError,
}));

import { usePollingScan } from '../src/lib/usePollingScan.js';

function Harness({ scanId, intervalMs }) {
  const { scan, error, reconnecting, isPolling } = usePollingScan(scanId, intervalMs ? { intervalMs } : undefined);
  return (
    <div>
      <span data-testid="status">{scan?.status ?? 'none'}</span>
      <span data-testid="error">{error?.code ?? 'no-error'}</span>
      <span data-testid="reconnecting">{reconnecting ? 'yes' : 'no'}</span>
      <span data-testid="polling">{isPolling ? 'yes' : 'no'}</span>
      <span data-testid="score">{scan?.report?.score ?? '-'}</span>
    </div>
  );
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

beforeEach(() => {
  getScanMock.mockReset();
});

describe('usePollingScan', () => {
  it('returns scan=null and isPolling=false when scanId is missing', () => {
    render(<Harness scanId={null} />);
    expect(screen.getByTestId('status').textContent).toBe('none');
    expect(screen.getByTestId('polling').textContent).toBe('no');
  });

  it('polls until status is "complete" then stops', async () => {
    getScanMock
      .mockResolvedValueOnce({ scanId: 'scn_1', status: 'queued' })
      .mockResolvedValueOnce({ scanId: 'scn_1', status: 'running' })
      .mockResolvedValueOnce({ scanId: 'scn_1', status: 'complete', report: { score: 87 } });

    render(<Harness scanId="scn_1" intervalMs={20} />);

    await waitFor(() =>
      expect(screen.getByTestId('status').textContent).toBe('complete'),
    );
    expect(screen.getByTestId('score').textContent).toBe('87');

    const callsAfterComplete = getScanMock.mock.calls.length;
    await sleep(150);
    expect(getScanMock).toHaveBeenCalledTimes(callsAfterComplete);
    expect(screen.getByTestId('polling').textContent).toBe('no');
  });

  it('marks reconnecting on transient errors but keeps polling', async () => {
    getScanMock
      .mockRejectedValueOnce(new Error('ECONNREFUSED'))
      .mockResolvedValueOnce({ scanId: 'scn_2', status: 'complete', report: { score: 50 } });

    render(<Harness scanId="scn_2" intervalMs={20} />);

    await waitFor(() =>
      expect(screen.getByTestId('reconnecting').textContent).toBe('yes'),
    );

    await waitFor(() =>
      expect(screen.getByTestId('status').textContent).toBe('complete'),
    );
    expect(screen.getByTestId('reconnecting').textContent).toBe('no');
  });

  it('stops polling and surfaces error on SCAN_NOT_FOUND', async () => {
    getScanMock.mockRejectedValue(new FakeApiClientError('SCAN_NOT_FOUND', 'No scan'));

    render(<Harness scanId="scn_missing" intervalMs={20} />);

    await waitFor(() =>
      expect(screen.getByTestId('error').textContent).toBe('SCAN_NOT_FOUND'),
    );
    expect(screen.getByTestId('polling').textContent).toBe('no');

    const callsAtError = getScanMock.mock.calls.length;
    await sleep(150);
    expect(getScanMock).toHaveBeenCalledTimes(callsAtError);
  });
});
