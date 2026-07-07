/**
 * Lightweight on-disk cache of completed site reports.
 *
 * The job store is in-memory, so a finished report disappears on an API restart
 * (or after the 30-min eviction) — which breaks the JSON/PDF downloads even
 * though the report page still shows a cached copy. To fix that WITHOUT a
 * database, we drop one small JSON file per scan next to that scan's screenshot
 * artifacts when it completes, and the export routes fall back to it when the
 * in-memory job is gone.
 *
 * This is deliberately minimal: one file per scan, best-effort, no indexing.
 */

import { promises as fs } from 'node:fs';
import path from 'node:path';

// Same base dir the scanner writes screenshots to (scanner default './artifacts').
const BASE_DIR = process.env.ARTIFACTS_DIR || './artifacts';

// scanIds are generated as `scn_<hex>`. The export routes pass a URL param into
// this, so guard against path traversal (no slashes / dots / etc).
const SAFE_ID = /^scn_[A-Za-z0-9_-]+$/;

/** Absolute path to a scan's cached report JSON. */
export function siteReportPath(scanId) {
  return path.resolve(BASE_DIR, scanId, 'report.json');
}

/**
 * Persist a completed export payload ({ siteId, request, completedAt, report }).
 * Never write credentials — callers pass an already-redacted request.
 * @returns {Promise<string|null>} the path written, or null on failure
 */
export async function writeSiteReport(scanId, payload) {
  if (!SAFE_ID.test(scanId)) return null;
  try {
    const p = siteReportPath(scanId);
    await fs.mkdir(path.dirname(p), { recursive: true });
    await fs.writeFile(p, JSON.stringify(payload), 'utf8');
    return p;
  } catch {
    return null;
  }
}

/**
 * Read a scan's cached export payload, or null if absent/unreadable.
 * @returns {Promise<object|null>}
 */
export async function readSiteReport(scanId) {
  if (!SAFE_ID.test(scanId)) return null;
  try {
    const raw = await fs.readFile(siteReportPath(scanId), 'utf8');
    return JSON.parse(raw);
  } catch {
    return null;
  }
}
