/**
 * Manual-login ("session") mode in AuthConfigPanel.
 *
 * This is the path that makes arbitrary login flows reachable from the UI, so
 * the tests cover the parts that would silently strand a user: the live-capture
 * happy path, the headless-host fallback, and the guard against submitting a
 * session that carries no credentials.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';

const api = vi.hoisted(() => ({
  startSessionCapture:  vi.fn(),
  finishSessionCapture: vi.fn(),
  cancelSessionCapture: vi.fn(async () => null),
}));

vi.mock('../src/lib/api.js', () => api);

const { AuthConfigPanel, parseSessionFile, summariseSession } =
  await import('../src/components/AuthConfigPanel.jsx');

const SESSION = {
  cookies: [{ name: 'sid', value: 'a', domain: 'x.gov.in', path: '/' }],
  origins: [{ origin: 'https://x.gov.in', localStorage: [{ name: 'token', value: 'ey' }] }],
  _sessionStorage: { 'Digit.User': '{}' },
  _capturedFrom: 'https://x.gov.in/home',
  _capturedAt: '2026-09-24T10:00:00.000Z',
};

/** Expand the panel and switch to manual-login mode. */
function openSessionMode() {
  fireEvent.click(screen.getByRole('button', { name: /add authentication/i }));
  fireEvent.click(screen.getByRole('radio', { name: /log in manually/i }));
}

beforeEach(() => {
  vi.clearAllMocks();
  api.startSessionCapture.mockResolvedValue({ id: 'cap_1', status: 'waiting' });
  api.finishSessionCapture.mockResolvedValue({
    session: SESSION,
    summary: { cookies: 1, localStorage: 1, sessionStorage: 1, capturedFrom: 'https://x.gov.in/home' },
  });
});

describe('parseSessionFile()', () => {
  it('accepts a well-formed session', () => {
    const { session, error } = parseSessionFile(JSON.stringify(SESSION));
    expect(error).toBeUndefined();
    expect(session.cookies).toHaveLength(1);
  });

  it('rejects invalid JSON', () => {
    expect(parseSessionFile('{ nope').error).toMatch(/not valid JSON/i);
  });

  it('rejects a session with nothing that could sign you in', () => {
    const { error } = parseSessionFile(JSON.stringify({ cookies: [], origins: [] }));
    expect(error).toMatch(/nothing in it could sign you in/i);
  });

  it('accepts the plain `sessionStorage` key too', () => {
    const { session } = parseSessionFile(JSON.stringify({ sessionStorage: { a: 'b' } }));
    expect(session).toBeTruthy();
  });
});

describe('summariseSession()', () => {
  it('counts every store', () => {
    expect(summariseSession(SESSION)).toMatchObject({
      cookies: 1, localStorage: 1, sessionStorage: 1, capturedFrom: 'https://x.gov.in/home',
    });
  });

  it('returns null when there is no session', () => {
    expect(summariseSession(null)).toBeNull();
  });
});

describe('<AuthConfigPanel /> — manual login', () => {
  it('offers manual login as an auth type', () => {
    render(<AuthConfigPanel onChange={() => {}} />);
    fireEvent.click(screen.getByRole('button', { name: /add authentication/i }));
    expect(screen.getByRole('radio', { name: /log in manually/i })).toBeInTheDocument();
  });

  it('publishes no config until a session exists', () => {
    const onChange = vi.fn();
    render(<AuthConfigPanel onChange={onChange} />);
    openSessionMode();
    expect(onChange).toHaveBeenLastCalledWith(
      expect.objectContaining({ type: 'session', config: null, hasErrors: true }),
    );
  });

  it('keeps the capture button disabled until the login URL is a real URL', () => {
    render(<AuthConfigPanel onChange={() => {}} />);
    openSessionMode();
    const btn = screen.getByRole('button', { name: /open a browser and log in/i });
    expect(btn).toBeDisabled();

    fireEvent.change(screen.getByLabelText(/login page URL/i), { target: { value: 'nope' } });
    expect(btn).toBeDisabled();

    fireEvent.change(screen.getByLabelText(/login page URL/i), {
      target: { value: 'https://x.gov.in/login' },
    });
    expect(btn).toBeEnabled();
  });

  it('captures a session end to end and publishes a valid config', async () => {
    const onChange = vi.fn();
    render(<AuthConfigPanel onChange={onChange} />);
    openSessionMode();

    fireEvent.change(screen.getByLabelText(/login page URL/i), {
      target: { value: 'https://x.gov.in/login' },
    });
    fireEvent.click(screen.getByRole('button', { name: /open a browser and log in/i }));

    // Window open, waiting on the human.
    await waitFor(() => expect(screen.getByText(/waiting for you to log in/i)).toBeInTheDocument());
    expect(api.startSessionCapture).toHaveBeenCalledWith('https://x.gov.in/login');

    fireEvent.click(screen.getByRole('button', { name: /i'm logged in/i }));

    await waitFor(() => expect(screen.getByText(/session ready/i)).toBeInTheDocument());
    expect(onChange).toHaveBeenLastCalledWith(
      expect.objectContaining({
        type: 'session',
        hasErrors: false,
        config: expect.objectContaining({ type: 'session', state: SESSION }),
      }),
    );
  });

  it('points at the CLI when the host has no desktop session', async () => {
    api.startSessionCapture.mockRejectedValue(
      Object.assign(new Error('no display'), { code: 'CAPTURE_UNAVAILABLE' }),
    );
    render(<AuthConfigPanel onChange={() => {}} />);
    openSessionMode();
    fireEvent.change(screen.getByLabelText(/login page URL/i), {
      target: { value: 'https://x.gov.in/login' },
    });
    fireEvent.click(screen.getByRole('button', { name: /open a browser and log in/i }));

    await waitFor(() =>
      expect(screen.getByText(/no desktop session/i)).toBeInTheDocument());
    // Must not dead-end: the upload path has to be reachable.
    expect(screen.getByText(/upload a session file/i)).toBeInTheDocument();
  });

  it('keeps the window open when the capture comes back empty', async () => {
    api.finishSessionCapture.mockRejectedValue(
      Object.assign(new Error('Nothing was captured'), { code: 'CAPTURE_EMPTY' }),
    );
    render(<AuthConfigPanel onChange={() => {}} />);
    openSessionMode();
    fireEvent.change(screen.getByLabelText(/login page URL/i), {
      target: { value: 'https://x.gov.in/login' },
    });
    fireEvent.click(screen.getByRole('button', { name: /open a browser and log in/i }));
    await waitFor(() => screen.getByRole('button', { name: /i'm logged in/i }));

    fireEvent.click(screen.getByRole('button', { name: /i'm logged in/i }));

    await waitFor(() => expect(screen.getByText(/nothing was captured/i)).toBeInTheDocument());
    // Still retryable — the user just wasn't signed in yet.
    expect(screen.getByRole('button', { name: /i'm logged in/i })).toBeInTheDocument();
  });

  it('cancels a capture and returns to the start', async () => {
    render(<AuthConfigPanel onChange={() => {}} />);
    openSessionMode();
    fireEvent.change(screen.getByLabelText(/login page URL/i), {
      target: { value: 'https://x.gov.in/login' },
    });
    fireEvent.click(screen.getByRole('button', { name: /open a browser and log in/i }));
    await waitFor(() => screen.getByRole('button', { name: /cancel/i }));

    fireEvent.click(screen.getByRole('button', { name: /cancel/i }));

    await waitFor(() =>
      expect(screen.getByRole('button', { name: /open a browser and log in/i })).toBeInTheDocument());
    expect(api.cancelSessionCapture).toHaveBeenCalledWith('cap_1');
  });

  it('includes authedSelector in the published config', async () => {
    const onChange = vi.fn();
    render(<AuthConfigPanel onChange={onChange} />);
    openSessionMode();
    fireEvent.change(screen.getByLabelText(/login page URL/i), {
      target: { value: 'https://x.gov.in/login' },
    });
    fireEvent.click(screen.getByRole('button', { name: /open a browser and log in/i }));
    await waitFor(() => screen.getByRole('button', { name: /i'm logged in/i }));
    fireEvent.click(screen.getByRole('button', { name: /i'm logged in/i }));
    await waitFor(() => screen.getByText(/session ready/i));

    fireEvent.change(screen.getByLabelText(/signed-in element selector/i), {
      target: { value: '#user-menu' },
    });

    await waitFor(() => expect(onChange).toHaveBeenLastCalledWith(
      expect.objectContaining({
        config: expect.objectContaining({ authedSelector: '#user-menu' }),
      }),
    ));
  });

  it('lets the user clear a captured session', async () => {
    const onChange = vi.fn();
    render(<AuthConfigPanel onChange={onChange} />);
    openSessionMode();
    fireEvent.change(screen.getByLabelText(/login page URL/i), {
      target: { value: 'https://x.gov.in/login' },
    });
    fireEvent.click(screen.getByRole('button', { name: /open a browser and log in/i }));
    await waitFor(() => screen.getByRole('button', { name: /i'm logged in/i }));
    fireEvent.click(screen.getByRole('button', { name: /i'm logged in/i }));
    await waitFor(() => screen.getByText(/session ready/i));

    fireEvent.click(screen.getByRole('button', { name: /clear/i }));

    await waitFor(() => expect(onChange).toHaveBeenLastCalledWith(
      expect.objectContaining({ config: null, hasErrors: true }),
    ));
  });
});
