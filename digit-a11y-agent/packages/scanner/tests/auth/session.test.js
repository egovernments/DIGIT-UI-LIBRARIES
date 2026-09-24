import { describe, it, expect, beforeAll, afterAll } from 'vitest';
import { mkdtempSync, writeFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { captureAuth, AuthError } from '../../src/auth/index.js';
import { loadSessionState, isStale, sessionAgeMs } from '../../src/auth/session.js';

let dir;
beforeAll(() => { dir = mkdtempSync(join(tmpdir(), 'a11y-session-')); });
afterAll(() => { rmSync(dir, { recursive: true, force: true }); });

/** Write a session file and return its path. */
function writeSession(name, obj) {
  const p = join(dir, name);
  writeFileSync(p, JSON.stringify(obj), 'utf8');
  return p;
}

const VALID = {
  cookies: [{ name: 'sid', value: 'abc', domain: 'example.gov.in', path: '/' }],
  origins: [{
    origin: 'https://example.gov.in',
    localStorage: [{ name: 'token', value: 'eyJhbGc' }],
  }],
  _sessionStorage: { 'Digit.User': '{"value":"x"}' },
  _capturedAt: new Date().toISOString(),
  _capturedFrom: 'https://example.gov.in/home',
};

describe('loadSessionState()', () => {
  it('loads a well-formed session file', () => {
    const state = loadSessionState({ sessionPath: writeSession('ok.json', VALID) });
    expect(state.cookies).toHaveLength(1);
    expect(state.origins[0].localStorage).toHaveLength(1);
    expect(state._sessionStorage).toEqual({ 'Digit.User': '{"value":"x"}' });
    expect(state._authMeta.sessionKeys).toBe(1);
    expect(state._authMeta.localKeys).toBe(1);
    expect(state._authMeta.stale).toBe(false);
  });

  it('accepts an inline state object instead of a file', () => {
    const state = loadSessionState({ state: VALID });
    expect(state._authMeta.cookieCount).toBe(1);
  });

  it('accepts the friendlier `sessionStorage` key as well as `_sessionStorage`', () => {
    const state = loadSessionState({
      state: { ...VALID, _sessionStorage: undefined, sessionStorage: { a: 'b' } },
    });
    expect(state._sessionStorage).toEqual({ a: 'b' });
  });

  it('reports a missing file as SESSION_FILE_UNREADABLE', () => {
    expect(() => loadSessionState({ sessionPath: join(dir, 'nope.json') }))
      .toThrow(expect.objectContaining({ code: 'SESSION_FILE_UNREADABLE' }));
  });

  it('reports malformed JSON as SESSION_FILE_INVALID', () => {
    const p = join(dir, 'bad.json');
    writeFileSync(p, '{ not json', 'utf8');
    expect(() => loadSessionState({ sessionPath: p }))
      .toThrow(expect.objectContaining({ code: 'SESSION_FILE_INVALID' }));
  });

  it('rejects a session that carries no credentials at all', () => {
    // The dangerous case: a capture taken before the human actually logged in.
    // Failing here beats silently scanning a login page later.
    const p = writeSession('empty.json', { cookies: [], origins: [] });
    expect(() => loadSessionState({ sessionPath: p }))
      .toThrow(expect.objectContaining({ code: 'SESSION_FILE_INVALID' }));
  });

  it('requires either sessionPath or state', () => {
    expect(() => loadSessionState({}))
      .toThrow(expect.objectContaining({ code: 'INVALID_AUTH_CONFIG' }));
  });

  it('flags a session captured long ago as stale', () => {
    const old = new Date(Date.now() - 48 * 60 * 60 * 1000).toISOString();
    const state = loadSessionState({ state: { ...VALID, _capturedAt: old } });
    expect(state._authMeta.stale).toBe(true);
    expect(state._authMeta.ageMs).toBeGreaterThan(24 * 60 * 60 * 1000);
  });

  it('treats a session with no capture timestamp as age-unknown, not stale', () => {
    const state = loadSessionState({ state: { ...VALID, _capturedAt: undefined } });
    expect(state._authMeta.ageMs).toBeNull();
    expect(state._authMeta.stale).toBe(false);
  });
});

describe('session staleness helpers', () => {
  it('sessionAgeMs returns null for missing or unparseable timestamps', () => {
    expect(sessionAgeMs(undefined)).toBeNull();
    expect(sessionAgeMs('not-a-date')).toBeNull();
  });

  it('isStale honours a custom threshold', () => {
    const tenMinAgo = new Date(Date.now() - 10 * 60 * 1000).toISOString();
    expect(isStale(tenMinAgo, 60 * 60 * 1000)).toBe(false);
    expect(isStale(tenMinAgo, 5 * 60 * 1000)).toBe(true);
  });
});

describe('captureAuth() — session type', () => {
  it('routes type:session through the dispatcher without needing a browser', async () => {
    const state = await captureAuth(null, { type: 'session', state: VALID });
    expect(state._authMeta.type).toBe('session');
  });

  it('does not require loginUrl for session auth', async () => {
    await expect(captureAuth(null, { type: 'session', state: VALID }))
      .resolves.toBeTruthy();
  });

  it('still requires loginUrl for form auth', async () => {
    await expect(captureAuth(null, { type: 'form', fields: { a: 'b' }, submitSelector: 'x' }))
      .rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });

  it('points oauth users at session auth instead of failing blankly', async () => {
    await expect(captureAuth(null, { type: 'oauth', loginUrl: 'https://x.gov.in' }))
      .rejects.toMatchObject({ code: 'NOT_IMPLEMENTED' });
    await expect(captureAuth(null, { type: 'oauth', loginUrl: 'https://x.gov.in' }))
      .rejects.toThrow(/session/i);
  });

  it('rejects an unknown auth type', async () => {
    await expect(captureAuth(null, { type: 'magic', loginUrl: 'https://x.gov.in' }))
      .rejects.toMatchObject({ code: 'INVALID_AUTH_CONFIG' });
  });
});
