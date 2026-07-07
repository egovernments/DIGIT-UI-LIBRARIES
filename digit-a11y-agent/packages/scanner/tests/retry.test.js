import { describe, it, expect, vi } from 'vitest';
import { retryWithBackoff, isTransientNetworkError } from '../src/retry.js';

describe('retryWithBackoff()', () => {
  it('returns the result on first success without retrying', async () => {
    const fn = vi.fn().mockResolvedValue('ok');
    const result = await retryWithBackoff(fn);
    expect(result).toBe('ok');
    expect(fn).toHaveBeenCalledTimes(1);
  });

  it('retries up to maxAttempts on transient errors', async () => {
    const fn = vi.fn()
      .mockRejectedValueOnce(new Error('ETIMEDOUT'))
      .mockRejectedValueOnce(new Error('ETIMEDOUT'))
      .mockResolvedValue('finally');

    const result = await retryWithBackoff(fn, {
      maxAttempts: 3,
      baseDelayMs: 1,
      isTransient: () => true,
    });

    expect(result).toBe('finally');
    expect(fn).toHaveBeenCalledTimes(3);
  });

  it('does not retry permanent errors', async () => {
    const fn = vi.fn().mockRejectedValue(new Error('Wrong password'));
    await expect(retryWithBackoff(fn, {
      maxAttempts: 5,
      isTransient: () => false,
    })).rejects.toThrow('Wrong password');
    expect(fn).toHaveBeenCalledTimes(1);
  });

  it('throws the last error after exhausting attempts', async () => {
    const fn = vi.fn().mockRejectedValue(new Error('ETIMEDOUT'));
    await expect(retryWithBackoff(fn, {
      maxAttempts: 2,
      baseDelayMs: 1,
      isTransient: () => true,
    })).rejects.toThrow('ETIMEDOUT');
    expect(fn).toHaveBeenCalledTimes(2);
  });

  it('passes attempt number to the function (1-indexed)', async () => {
    const seen = [];
    const fn = vi.fn().mockImplementation(async (attempt) => {
      seen.push(attempt);
      if (attempt < 3) throw new Error('ETIMEDOUT');
      return 'done';
    });

    await retryWithBackoff(fn, {
      maxAttempts: 5,
      baseDelayMs: 1,
      isTransient: () => true,
    });

    expect(seen).toEqual([1, 2, 3]);
  });

  it('calls onRetry between attempts but not after the final failure', async () => {
    const onRetry = vi.fn();
    const fn = vi.fn().mockRejectedValue(new Error('ETIMEDOUT'));

    await expect(retryWithBackoff(fn, {
      maxAttempts: 3,
      baseDelayMs: 1,
      isTransient: () => true,
      onRetry,
    })).rejects.toThrow();

    // onRetry fires between attempts (2 retries between 3 attempts)
    expect(onRetry).toHaveBeenCalledTimes(2);
    expect(onRetry.mock.calls[0][0]).toMatchObject({ attempt: 1 });
    expect(onRetry.mock.calls[1][0]).toMatchObject({ attempt: 2 });
  });

  it('uses exponential backoff capped by maxDelayMs', async () => {
    const delays = [];
    const fn = vi.fn().mockRejectedValue(new Error('ETIMEDOUT'));

    await expect(retryWithBackoff(fn, {
      maxAttempts: 5,
      baseDelayMs: 100,
      maxDelayMs:  300,
      isTransient: () => true,
      onRetry: ({ delayMs }) => delays.push(delayMs),
    })).rejects.toThrow();

    // 100ms, 200ms, 300ms (capped), 300ms (capped)
    expect(delays).toEqual([100, 200, 300, 300]);
  });
});

describe('isTransientNetworkError()', () => {
  it('detects common Node network errors', () => {
    expect(isTransientNetworkError(new Error('ECONNRESET'))).toBe(true);
    expect(isTransientNetworkError(new Error('ECONNREFUSED'))).toBe(true);
    expect(isTransientNetworkError(new Error('ETIMEDOUT'))).toBe(true);
    expect(isTransientNetworkError(new Error('EHOSTUNREACH'))).toBe(true);
    expect(isTransientNetworkError(new Error('ENOTFOUND'))).toBe(true);
    expect(isTransientNetworkError(new Error('socket hang up'))).toBe(true);
  });

  it('detects Playwright/Chromium network errors', () => {
    expect(isTransientNetworkError(new Error('net::ERR_CONNECTION_RESET'))).toBe(true);
    expect(isTransientNetworkError(new Error('net::ERR_INTERNET_DISCONNECTED'))).toBe(true);
    expect(isTransientNetworkError(new Error('Navigation timeout exceeded'))).toBe(true);
  });

  it('detects 5xx server errors', () => {
    expect(isTransientNetworkError(new Error('Got 502 Bad Gateway'))).toBe(true);
    expect(isTransientNetworkError(new Error('Got 503 Service Unavailable'))).toBe(true);
    expect(isTransientNetworkError(new Error('Got 504 Gateway Timeout'))).toBe(true);
  });

  it('does NOT mark "selector not found" timeouts as transient', () => {
    // These are usually wrong credentials or wrong selectors — retrying won't help
    expect(isTransientNetworkError(new Error('Selector not found within timeout'))).toBe(false);
  });

  it('does not mark business errors as transient', () => {
    expect(isTransientNetworkError(new Error('Invalid credentials'))).toBe(false);
    expect(isTransientNetworkError(new Error('Unauthorized'))).toBe(false);
    expect(isTransientNetworkError(new Error('Forbidden'))).toBe(false);
    expect(isTransientNetworkError(new Error('404 Not Found'))).toBe(false);
  });

  it('handles null/undefined/empty without crashing', () => {
    expect(isTransientNetworkError(null)).toBe(false);
    expect(isTransientNetworkError(undefined)).toBe(false);
    expect(isTransientNetworkError(new Error(''))).toBe(false);
  });
});
