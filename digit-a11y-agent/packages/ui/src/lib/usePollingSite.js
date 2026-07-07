/**
 * usePollingSite(siteId) — React hook that polls `GET /api/site/:siteId`
 * until the job reaches a terminal state. The multi-page sibling of
 * usePollingScan; the returned `site` object carries a live `progress`
 * field (phase / page index / states scanned) while it runs.
 *
 * Stops polling on 'complete' or 'failed'. A 'SITE_SCAN_NOT_FOUND' is a
 * real miss (stop + surface). Other errors mark `reconnecting` and keep
 * trying. Cleans up on unmount.
 *
 * @param {string|null|undefined} siteId
 * @param {object} [opts]
 * @param {number} [opts.intervalMs=2000]
 * @returns {{ site: object|null, error: Error|null, reconnecting: boolean, isPolling: boolean }}
 */

import { useEffect, useRef, useState } from 'react';
import { getSiteScan, ApiClientError } from './api.js';

const TERMINAL_STATUSES = new Set(['complete', 'failed']);

export function usePollingSite(siteId, opts = {}) {
  const intervalMs = opts.intervalMs ?? 2000;

  const [site, setSite]                 = useState(null);
  const [error, setError]               = useState(null);
  const [reconnecting, setReconnecting] = useState(false);
  const [isPolling, setIsPolling]       = useState(Boolean(siteId));

  const cancelledRef = useRef(false);

  useEffect(() => {
    if (!siteId) {
      setIsPolling(false);
      return undefined;
    }

    cancelledRef.current = false;
    setIsPolling(true);
    setError(null);

    let timeoutId;

    const poll = async () => {
      try {
        const next = await getSiteScan(siteId);
        if (cancelledRef.current) return;

        setSite(next);
        setReconnecting(false);
        setError(null);

        if (TERMINAL_STATUSES.has(next.status)) {
          setIsPolling(false);
          return;
        }
      } catch (err) {
        if (cancelledRef.current) return;

        if (err instanceof ApiClientError && err.code === 'SITE_SCAN_NOT_FOUND') {
          setError(err);
          setIsPolling(false);
          return;
        }
        setReconnecting(true);
      }

      timeoutId = setTimeout(poll, intervalMs);
    };

    poll();

    return () => {
      cancelledRef.current = true;
      clearTimeout(timeoutId);
    };
  }, [siteId, intervalMs]);

  return { site, error, reconnecting, isPolling };
}
