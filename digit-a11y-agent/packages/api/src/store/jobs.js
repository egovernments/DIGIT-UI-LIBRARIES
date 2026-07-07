/**
 * In-memory job store.
 *
 * Phase 1 keeps jobs in a plain Map. Restarting the API server wipes them.
 * Phase 2 swaps this implementation for SQLite (Day 11 in the plan); the
 * interface is intentionally narrow so the swap is mechanical.
 *
 * Eviction policy: lazy. On every access (get/list/stats), entries older
 * than config.jobMaxAgeMs are dropped if their status is final
 * ('complete' or 'failed'). Running/queued jobs never get evicted —
 * they're either active or we want to surface the stall.
 *
 * Concurrency: Node is single-threaded for app code, but we want to be
 * defensive about partial writes. Every mutation goes through one of the
 * methods below; never mutate the returned objects.
 */

import { randomUUID } from 'node:crypto';
import { config } from '../config.js';

/** @typedef {import('../types.js').Job} Job */
/** @typedef {import('../types.js').JobStatus} JobStatus */

const FINAL_STATUSES = new Set(['complete', 'failed']);

export class InMemoryJobStore {
  constructor({ maxAgeMs = config.jobMaxAgeMs } = {}) {
    /** @type {Map<string, Job>} */
    this._jobs = new Map();
    this._maxAgeMs = maxAgeMs;
  }

  /**
   * Create a new queued job and return it.
   * @param {object} scanRequest - The original ScanRequest
   * @returns {Job}
   */
  create(scanRequest) {
    const id = `scn_${randomUUID().replace(/-/g, '').slice(0, 16)}`;
    const now = Date.now();
    /** @type {Job} */
    const job = {
      id,
      status:    'queued',
      createdAt: now,
      updatedAt: now,
      request:   scanRequest,
    };
    this._jobs.set(id, job);
    return job;
  }

  /**
   * @param {string} id
   * @returns {Job|null}
   */
  get(id) {
    this._evictExpired();
    const j = this._jobs.get(id);
    return j ? { ...j } : null;
  }

  /**
   * Update a job's status and optionally attach a report or error.
   * @param {string} id
   * @param {Partial<Job>} patch
   * @returns {Job|null}
   */
  update(id, patch) {
    const current = this._jobs.get(id);
    if (!current) return null;
    const next = {
      ...current,
      ...patch,
      updatedAt: Date.now(),
    };
    this._jobs.set(id, next);
    return { ...next };
  }

  /**
   * Mark a job as started (transition queued -> running).
   * @param {string} id
   * @returns {Job|null}
   */
  markRunning(id) {
    return this.update(id, { status: 'running', startedAt: Date.now() });
  }

  /**
   * Mark a job complete with a finished report.
   * @param {string} id
   * @param {object} report - FriendlyReport
   * @returns {Job|null}
   */
  markComplete(id, report) {
    return this.update(id, {
      status:     'complete',
      finishedAt: Date.now(),
      report,
    });
  }

  /**
   * Mark a job failed with an error description.
   * @param {string} id
   * @param {{ code: string, message: string }} error
   * @returns {Job|null}
   */
  markFailed(id, error) {
    return this.update(id, {
      status:     'failed',
      finishedAt: Date.now(),
      error,
    });
  }

  /**
   * Stats for /health.
   * @returns {{ total: number, queued: number, running: number, complete: number, failed: number }}
   */
  stats() {
    this._evictExpired();
    const out = { total: 0, queued: 0, running: 0, complete: 0, failed: 0 };
    for (const j of this._jobs.values()) {
      out.total++;
      out[j.status]++;
    }
    return out;
  }

  /** Drop completed/failed jobs older than maxAgeMs. */
  _evictExpired() {
    const cutoff = Date.now() - this._maxAgeMs;
    for (const [id, j] of this._jobs) {
      if (FINAL_STATUSES.has(j.status) && (j.finishedAt ?? j.updatedAt) < cutoff) {
        this._jobs.delete(id);
      }
    }
  }

  /** Test-only: wipe everything. */
  _clear() {
    this._jobs.clear();
  }
}

/** Module-level singleton used by the running server. Tests create their own. */
export const jobStore = new InMemoryJobStore();
