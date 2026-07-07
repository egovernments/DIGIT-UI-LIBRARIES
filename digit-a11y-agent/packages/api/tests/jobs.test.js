import { describe, it, expect, beforeEach } from 'vitest';
import { InMemoryJobStore } from '../src/store/jobs.js';

const sampleRequest = { url: 'https://example.gov.in' };

describe('InMemoryJobStore', () => {
  let store;

  beforeEach(() => {
    store = new InMemoryJobStore({ maxAgeMs: 60_000 });
  });

  it('creates jobs in queued state with a unique scn_ prefixed id', () => {
    const a = store.create(sampleRequest);
    const b = store.create(sampleRequest);

    expect(a.id).toMatch(/^scn_[a-f0-9]{16}$/);
    expect(b.id).toMatch(/^scn_[a-f0-9]{16}$/);
    expect(a.id).not.toBe(b.id);
    expect(a.status).toBe('queued');
    expect(a.createdAt).toBeLessThanOrEqual(Date.now());
  });

  it('preserves the original request on the job', () => {
    const job = store.create(sampleRequest);
    expect(job.request).toEqual(sampleRequest);
  });

  it('get() returns null for unknown ids', () => {
    expect(store.get('scn_does_not_exist')).toBeNull();
  });

  it('markRunning transitions status and stamps startedAt', () => {
    const job = store.create(sampleRequest);
    const updated = store.markRunning(job.id);
    expect(updated.status).toBe('running');
    expect(updated.startedAt).toBeGreaterThan(0);
  });

  it('markComplete attaches the report and stamps finishedAt', () => {
    const job = store.create(sampleRequest);
    store.markRunning(job.id);
    const report = { score: 88, summary: { totalIssues: 2 } };
    const updated = store.markComplete(job.id, report);
    expect(updated.status).toBe('complete');
    expect(updated.report).toBe(report);
    expect(updated.finishedAt).toBeGreaterThan(0);
  });

  it('markFailed attaches the error payload', () => {
    const job = store.create(sampleRequest);
    const updated = store.markFailed(job.id, {
      code: 'SCAN_FAILED', message: 'boom',
    });
    expect(updated.status).toBe('failed');
    expect(updated.error).toEqual({ code: 'SCAN_FAILED', message: 'boom' });
  });

  it('stats() returns counts by status', () => {
    const a = store.create(sampleRequest);
    const b = store.create(sampleRequest);
    const c = store.create(sampleRequest);
    store.markRunning(a.id);
    store.markComplete(b.id, { score: 100 });
    store.markFailed(c.id, { code: 'X', message: 'y' });

    expect(store.stats()).toEqual({
      total:    3,
      queued:   0,
      running:  1,
      complete: 1,
      failed:   1,
    });
  });

  it('evicts old final jobs but keeps active ones', () => {
    const oldStore = new InMemoryJobStore({ maxAgeMs: 100 });
    const active = oldStore.create(sampleRequest);
    const finished = oldStore.create(sampleRequest);
    oldStore.markComplete(finished.id, { score: 100 });

    // Force finishedAt into the past so the next access prunes it.
    oldStore._jobs.get(finished.id).finishedAt = Date.now() - 10_000;

    // Stats triggers eviction.
    const s = oldStore.stats();
    expect(s.total).toBe(1);
    expect(oldStore.get(active.id)).not.toBeNull();
    expect(oldStore.get(finished.id)).toBeNull();
  });

  it('returns defensive copies so external mutation cannot corrupt store state', () => {
    const job = store.create(sampleRequest);
    const fetched = store.get(job.id);
    fetched.status = 'complete';

    const refetched = store.get(job.id);
    expect(refetched.status).toBe('queued');
  });
});
