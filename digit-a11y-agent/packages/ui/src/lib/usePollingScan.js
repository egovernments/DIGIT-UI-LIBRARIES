/**
 * usePollingScan(scanId) — React hook that polls `GET /api/scan/:scanId`
 * until the job reaches a terminal state.
 *
 * Returns the latest known scan object plus a connection status. Stops
 * polling automatically when status is 'complete' or 'failed'. Cleans
 * up on unmount.
 *
 * Network errors don't crash the page — they surface as a 'reconnecting'
 * flag so the UI can show a non-fatal warning while the next attempt
 * runs.
 *
 * @param {string|null|undefined} scanId
 * @param {object} [opts]
 * @param {number} [opts.intervalMs=1000]
 * @returns {{
 *   scan: object|null,
 *   error: Error|null,
 *   reconnecting: boolean,
 *   isPolling: boolean
 * }}
 */

import { useEffect, useRef, useState } from 'react';
import { getScan, ApiClientError } from './api.js';

const TERMINAL_STATUSES = new Set(['complete', 'failed']);

export function usePollingScan(scanId, opts = {}) {
  const intervalMs = opts.intervalMs ?? 1000;

  const [scan, setScan]                 = useState(null);
  const [error, setError]               = useState(null);
  const [reconnecting, setReconnecting] = useState(false);
  const [isPolling, setIsPolling]       = useState(Boolean(scanId));

  // We use a ref for the cancellation flag so the cleanup function
  // captures the latest value even after re-renders.
  const cancelledRef = useRef(false);

  useEffect(() => {
    if (!scanId) {
      setIsPolling(false);
      return undefined;
    }

    cancelledRef.current = false;
    setIsPolling(true);
    setError(null);

    let timeoutId;

    const poll = async () => {
      try {
        const next = await getScan(scanId);
        if (cancelledRef.current) return;

        setScan(next);
        setReconnecting(false);
        setError(null);

        if (TERMINAL_STATUSES.has(next.status)) {
          setIsPolling(false);
          return;
        }
      } catch (err) {
        if (cancelledRef.current) return;

        // 404 is a real failure (no job with this id) — stop polling, surface it.
        if (err instanceof ApiClientError && err.code === 'SCAN_NOT_FOUND') {
          setError(err);
          setIsPolling(false);
          return;
        }
        // Other errors (network blip, server restart) → mark reconnecting, keep polling.
        setReconnecting(true);
      }

      timeoutId = setTimeout(poll, intervalMs);
    };

    // First call is immediate so the UI populates fast on mount.
    poll();

    return () => {
      cancelledRef.current = true;
      clearTimeout(timeoutId);
    };
  }, [scanId, intervalMs]);

  return { scan, error, reconnecting, isPolling };
}
