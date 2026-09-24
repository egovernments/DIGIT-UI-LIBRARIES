/**
 * AuthConfigPanel — collapsible authentication configuration.
 *
 * Modes via radio:
 *   - 'none' (default)  — no auth
 *   - 'form'            — login by filling a form on a page
 *   - 'token'           — inject session state (multiple localStorage keys + cookies)
 *   - 'session'         — log in by hand once, replay the session
 *
 * 'session' is the one that covers everything else. Form auth can only drive
 * a single-page fill-and-submit; two-step forms, OTP, SSO and captcha are out
 * of its reach by construction. Rather than grow selectors to describe every
 * login flow, a human performs the login once and we keep the result.
 *
 * Stays collapsed until the user clicks "Add authentication". Once open
 * with a non-none type, validates inline as the user edits.
 *
 * Output shape via onChange:
 *   null                  → no auth (or invalid; submitting disabled)
 *   AuthConfig object     → ready to submit
 *
 * The parent renders the submit button — this component just publishes
 * the current config (and a `valid` flag) upward.
 */

import { useEffect, useId, useMemo, useState } from 'react';
import { FieldRows, makeRow } from './FieldRows.jsx';
import {
  startSessionCapture,
  finishSessionCapture,
  cancelSessionCapture,
} from '../lib/api.js';

/* ─────────────────── shape helpers ─────────────────── */

function buildFormConfig(state) {
  const fields = {};
  for (const row of state.fields) {
    if (row.selector.trim() && row.value !== '') {
      fields[row.selector.trim()] = row.value;
    }
  }
  const config = {
    type:           'form',
    loginUrl:       state.loginUrl.trim(),
    fields,
    submitSelector: state.submitSelector.trim(),
  };
  if (state.successSelector.trim()) config.successSelector = state.successSelector.trim();
  if (state.successUrl.trim())      config.successUrl      = state.successUrl.trim();
  if (state.dismissSelectors.length) config.dismissSelectors = state.dismissSelectors;
  if (state.contextStrategy && state.contextStrategy !== 'reuse') {
    config.contextStrategy = state.contextStrategy;
  }
  return config;
}

function buildTokenConfig(state) {
  const localStorage = {};
  for (const row of state.tokenEntries) {
    if (row.selector.trim()) localStorage[row.selector.trim()] = row.value;
  }
  const config = {
    type:     'token',
    loginUrl: state.tokenLoginUrl.trim(),
  };
  if (Object.keys(localStorage).length) config.localStorage = localStorage;
  if (state.tokenSuccessSelector.trim()) config.successSelector = state.tokenSuccessSelector.trim();
  if (state.contextStrategy && state.contextStrategy !== 'reuse') {
    config.contextStrategy = state.contextStrategy;
  }
  return config;
}

function buildSessionConfig(state) {
  const config = {
    type:  'session',
    state: state.session,
  };
  if (state.sessionAuthedSelector.trim()) {
    config.authedSelector = state.sessionAuthedSelector.trim();
  }
  if (state.contextStrategy && state.contextStrategy !== 'reuse') {
    config.contextStrategy = state.contextStrategy;
  }
  return config;
}

/* ─────────────────── validators ─────────────────── */

function validateForm(state) {
  const errors = {};
  if (!state.loginUrl.trim())       errors.loginUrl = 'Login URL is required.';
  else if (!/^https?:\/\//.test(state.loginUrl.trim())) errors.loginUrl = 'Must be a full URL (https://…).';
  if (!state.submitSelector.trim()) errors.submitSelector = 'Submit button selector is required.';
  if (!state.successSelector.trim() && !state.successUrl.trim()) {
    errors.success = 'Provide a success selector or a success URL — one is required to detect a successful login.';
  }
  const filledRows = state.fields.filter((r) => r.selector.trim() && r.value !== '');
  if (filledRows.length === 0) {
    errors.fields = 'Add at least one field to fill (e.g. username + password).';
  }
  return errors;
}

function validateToken(state) {
  const errors = {};
  if (!state.tokenLoginUrl.trim()) errors.tokenLoginUrl = 'Origin URL is required (the site that will read the injected state).';
  else if (!/^https?:\/\//.test(state.tokenLoginUrl.trim())) errors.tokenLoginUrl = 'Must be a full URL (https://…).';
  const filledRows = state.tokenEntries.filter((r) => r.selector.trim());
  if (filledRows.length === 0) {
    errors.tokenEntries = 'Add at least one localStorage entry (e.g. an auth token).';
  }
  return errors;
}

function validateSession(state) {
  const errors = {};
  if (!state.session) {
    errors.session = 'Capture or upload a session first.';
  }
  return errors;
}

/**
 * Accept both what our capture writes and a hand-rolled file.
 * Returns { session } or { error }.
 */
export function parseSessionFile(text) {
  let parsed;
  try {
    parsed = JSON.parse(text);
  } catch {
    return { error: 'That file is not valid JSON.' };
  }
  if (!parsed || typeof parsed !== 'object') {
    return { error: 'A session file must contain a JSON object.' };
  }
  const cookies = Array.isArray(parsed.cookies) ? parsed.cookies : [];
  const origins = Array.isArray(parsed.origins) ? parsed.origins : [];
  const session = parsed._sessionStorage ?? parsed.sessionStorage ?? {};
  const localCount = origins.reduce((n, o) => n + (o.localStorage?.length ?? 0), 0);

  if (!cookies.length && !localCount && !Object.keys(session).length) {
    return {
      error: 'That file has no cookies, localStorage or sessionStorage — ' +
             'nothing in it could sign you in. Capture it again while logged in.',
    };
  }
  return { session: parsed };
}

/** Human-readable summary of what a session actually carries. */
export function summariseSession(session) {
  if (!session) return null;
  const origins = Array.isArray(session.origins) ? session.origins : [];
  return {
    cookies:        (session.cookies ?? []).length,
    localStorage:   origins.reduce((n, o) => n + (o.localStorage?.length ?? 0), 0),
    sessionStorage: Object.keys(session._sessionStorage ?? session.sessionStorage ?? {}).length,
    capturedFrom:   session._capturedFrom ?? null,
    capturedAt:     session._capturedAt ?? null,
  };
}

/* ─────────────────── component ─────────────────── */

const INITIAL_STATE = {
  authType:        'none',
  contextStrategy: 'reuse',

  // form-auth fields
  loginUrl:        '',
  submitSelector:  '',
  successSelector: '',
  successUrl:      '',
  dismissSelectors: [],
  fields:          [],

  // token-auth fields
  tokenLoginUrl:        '',
  tokenSuccessSelector: '',
  tokenEntries:         [],

  // session-auth fields
  session:               null,   // the captured session object (held in memory only)
  sessionAuthedSelector: '',
};

export function AuthConfigPanel({ onChange, preset }) {
  const [expanded, setExpanded] = useState(false);
  const [state, setState]       = useState(INITIAL_STATE);

  // Day 8: when a preset is handed down (from DigitPresetButton), expand
  // the panel and merge the preset's values into state. We do NOT clear
  // the user's existing values for fields not in the preset (e.g. typed
  // credentials) — only the preset's keys overwrite.
  useEffect(() => {
    if (!preset) return;
    setExpanded(true);
    setState((prev) => ({
      ...prev,
      authType:         preset.type             ?? prev.authType,
      contextStrategy:  preset.contextStrategy  ?? prev.contextStrategy,
      loginUrl:         preset.loginUrl         ?? prev.loginUrl,
      submitSelector:   preset.submitSelector   ?? prev.submitSelector,
      successSelector:  preset.successSelector  ?? prev.successSelector,
      successUrl:       preset.successUrl       ?? prev.successUrl,
      dismissSelectors: typeof preset.dismissSelectors === 'string'
        ? preset.dismissSelectors.split(/[\n,]/).map((s) => s.trim()).filter(Boolean)
        : (Array.isArray(preset.dismissSelectors) ? preset.dismissSelectors : prev.dismissSelectors),
      fields: Array.isArray(preset.fields) && preset.fields.length
        // Preserve existing typed values for selectors that match.
        ? preset.fields.map((presetRow) => {
            const existing = prev.fields.find((r) => r.selector === presetRow.selector);
            return { selector: presetRow.selector, value: existing?.value ?? presetRow.value ?? '' };
          })
        : prev.fields,
    }));
  }, [preset]);

  // Compute validity + config every render.
  const { config, errors } = useMemo(() => {
    if (state.authType === 'none') return { config: null, errors: {} };
    if (state.authType === 'form') {
      const errs = validateForm(state);
      return { config: Object.keys(errs).length ? null : buildFormConfig(state), errors: errs };
    }
    if (state.authType === 'token') {
      const errs = validateToken(state);
      return { config: Object.keys(errs).length ? null : buildTokenConfig(state), errors: errs };
    }
    if (state.authType === 'session') {
      const errs = validateSession(state);
      return { config: Object.keys(errs).length ? null : buildSessionConfig(state), errors: errs };
    }
    return { config: null, errors: {} };
  }, [state]);

  // Publish upward whenever config or auth-type changes.
  useEffect(() => {
    onChange({
      type:   state.authType,
      config,
      hasErrors: Object.keys(errors).length > 0,
    });
  }, [state.authType, config, errors]); // eslint-disable-line react-hooks/exhaustive-deps

  const update = (patch) => setState((s) => ({ ...s, ...patch }));

  /* ─────────────────── render ─────────────────── */

  if (!expanded) {
    return (
      <div>
        <button
          type="button"
          onClick={() => setExpanded(true)}
          className="text-sm text-brand-500 hover:text-brand-600 font-medium inline-flex items-center gap-1.5"
        >
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
            <path d="M12 5v14M5 12h14" strokeLinecap="round" />
          </svg>
          Add authentication (optional)
        </button>
        <p className="text-xs text-slate-500 mt-1">
          For protected pages behind a login. Skip for public pages.
        </p>
      </div>
    );
  }

  return (
    <div className="border border-slate-200 rounded-lg p-4 bg-slate-50/50">
      <div className="flex items-start justify-between gap-4 mb-4">
        <div>
          <h4 className="text-sm font-semibold text-slate-900">Authentication</h4>
          <p className="text-xs text-slate-500 mt-0.5">
            Configure how the scanner should log in before scanning the protected page.
          </p>
        </div>
        <button
          type="button"
          onClick={() => { setExpanded(false); update({ authType: 'none' }); }}
          className="text-slate-400 hover:text-slate-700 text-xs"
        >
          Remove
        </button>
      </div>

      {/* Auth type selector */}
      <div className="flex gap-2 mb-5" role="radiogroup" aria-label="Authentication type">
        {[
          { value: 'form',    label: 'Form login',      desc: 'Fill in a username/password form' },
          { value: 'token',   label: 'Token injection', desc: 'Paste an existing session token' },
          { value: 'session', label: 'Log in manually', desc: 'Any flow — OTP, SSO, two-step' },
        ].map((opt) => (
          <label
            key={opt.value}
            className={`flex-1 cursor-pointer rounded-md border-2 p-3 transition-colors ${
              state.authType === opt.value
                ? 'border-brand-500 bg-white'
                : 'border-slate-200 bg-white hover:border-slate-300'
            }`}
          >
            <input
              type="radio"
              name="auth-type"
              value={opt.value}
              checked={state.authType === opt.value}
              onChange={() => update({ authType: opt.value })}
              className="sr-only"
            />
            <div className="flex items-center gap-2">
              <span className={`h-3.5 w-3.5 rounded-full border-2 flex-shrink-0 ${state.authType === opt.value ? 'border-brand-500' : 'border-slate-300'}`}>
                {state.authType === opt.value && <span className="block h-1.5 w-1.5 rounded-full bg-brand-500 m-0.5" />}
              </span>
              <span className="text-sm font-medium text-slate-900">{opt.label}</span>
            </div>
            <p className="text-xs text-slate-500 mt-1 ml-5">{opt.desc}</p>
          </label>
        ))}
      </div>

      {/* Form-auth fields */}
      {state.authType === 'form' && (
        <div className="space-y-4">
          <LabeledInput
            label="Login page URL"
            placeholder="e.g. https://example.gov.in/login"
            value={state.loginUrl}
            onChange={(v) => update({ loginUrl: v })}
            error={errors.loginUrl}
            type="url"
            required
          />

          <div>
            <label className="block text-xs uppercase tracking-wide text-slate-500 mb-1.5">
              Fields to fill <span className="text-red-600">*</span>
            </label>
            <FieldRows rows={state.fields} onChange={(fields) => update({ fields })} />
            {errors.fields && <p className="text-xs text-red-600 mt-1.5">{errors.fields}</p>}
          </div>

          <LabeledInput
            label="Submit button selector"
            placeholder='e.g. button:has-text("Login")'
            value={state.submitSelector}
            onChange={(v) => update({ submitSelector: v })}
            error={errors.submitSelector}
            font="mono"
            required
          />

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
            <LabeledInput
              label="Success — element selector"
              placeholder='e.g. text=Dashboard'
              value={state.successSelector}
              onChange={(v) => update({ successSelector: v })}
              font="mono"
              hint="Element visible only after login"
            />
            <LabeledInput
              label="Success — URL match"
              placeholder='e.g. /dashboard (leave blank if using selector)'
              value={state.successUrl}
              onChange={(v) => update({ successUrl: v })}
              font="mono"
              hint="Path the browser lands on"
            />
          </div>
          {errors.success && <p className="text-xs text-red-600 -mt-1">{errors.success}</p>}

          <DismissSelectorsField
            value={state.dismissSelectors}
            onChange={(v) => update({ dismissSelectors: v })}
          />

          <ContextStrategyToggle
            value={state.contextStrategy}
            onChange={(v) => update({ contextStrategy: v })}
          />
        </div>
      )}

      {/* Token-auth fields */}
      {state.authType === 'token' && (
        <div className="space-y-4">
          <LabeledInput
            label="Origin URL"
            placeholder="e.g. https://example.gov.in/"
            value={state.tokenLoginUrl}
            onChange={(v) => update({ tokenLoginUrl: v })}
            error={errors.tokenLoginUrl}
            type="url"
            required
            hint="The site root — where the injected localStorage will apply"
          />

          <div>
            <label className="block text-xs uppercase tracking-wide text-slate-500 mb-1.5">
              localStorage entries to inject <span className="text-red-600">*</span>
            </label>
            <FieldRows
              rows={state.tokenEntries}
              onChange={(tokenEntries) => update({ tokenEntries })}
              addPresets={[
                { label: 'token',          selector: 'token',          placeholder: 'paste token', type: 'text' },
                { label: 'Employee.token', selector: 'Employee.token', placeholder: 'paste token', type: 'text' },
                { label: 'tenant-id',      selector: 'tenant-id',      placeholder: 'mz',          type: 'text' },
              ]}
            />
            {errors.tokenEntries && <p className="text-xs text-red-600 mt-1.5">{errors.tokenEntries}</p>}
          </div>

          <LabeledInput
            label="Success selector (optional)"
            placeholder='e.g. text=Dashboard'
            value={state.tokenSuccessSelector}
            onChange={(v) => update({ tokenSuccessSelector: v })}
            font="mono"
            hint="Verify the injected session worked"
          />

          <ContextStrategyToggle
            value={state.contextStrategy}
            onChange={(v) => update({ contextStrategy: v })}
          />
        </div>
      )}

      {/* Manual-login (session) fields */}
      {state.authType === 'session' && (
        <SessionAuthFields
          session={state.session}
          authedSelector={state.sessionAuthedSelector}
          loginUrlHint={state.loginUrl}
          onSession={(session) => update({ session })}
          onAuthedSelector={(v) => update({ sessionAuthedSelector: v })}
          error={errors.session}
        />
      )}
    </div>
  );
}

/* ─────────────────── manual-login panel ─────────────────── */

/**
 * Two ways to get a session, because one of them can't always work:
 *
 *  - "Open a browser" asks the API to launch a window on the machine running
 *    it. Fine locally; impossible on a headless or remote host, which answers
 *    CAPTURE_UNAVAILABLE. We then point at the upload path instead of leaving
 *    the user stuck.
 *  - Uploading a file captured with bin/capture-session.mjs always works.
 *
 * The session stays in component state and is posted with the scan. It is
 * never written to localStorage — it is a live credential that has already
 * cleared MFA, and localStorage would outlive the tab.
 */
function SessionAuthFields({
  session, authedSelector, loginUrlHint, onSession, onAuthedSelector, error,
}) {
  const [loginUrl, setLoginUrl] = useState(loginUrlHint ?? '');
  const [capture, setCapture]   = useState(null);   // { id } while a window is open
  const [busy, setBusy]         = useState(false);
  const [notice, setNotice]     = useState(null);   // { kind: 'error'|'info', text }
  const summary = useMemo(() => summariseSession(session), [session]);

  const canStart = /^https?:\/\//.test(loginUrl.trim());

  async function handleStart() {
    setBusy(true);
    setNotice(null);
    try {
      const started = await startSessionCapture(loginUrl.trim());
      setCapture(started);
      setNotice({
        kind: 'info',
        text: 'A browser window opened on the machine running the scanner. ' +
              'Log in there, then click "I\'m logged in".',
      });
    } catch (err) {
      setNotice({
        kind: 'error',
        text: err.code === 'CAPTURE_UNAVAILABLE'
          ? 'This scanner has no desktop session, so it cannot open a browser ' +
            'for you. Capture the session on your own machine instead (command ' +
            'below) and upload the file.'
          : err.message,
      });
    } finally {
      setBusy(false);
    }
  }

  async function handleFinish() {
    setBusy(true);
    setNotice(null);
    try {
      const { session: captured, summary: s } = await finishSessionCapture(capture.id);
      onSession(captured);
      setCapture(null);
      // The server flags a capture that still looks like a login page. Show it
      // as a warning, not a success line — a session that isn't signed in is
      // precisely what produces a clean, wrong report later.
      setNotice(s.warning
        ? { kind: 'warn',  text: s.warning }
        : { kind: 'info',  text: `Session captured from ${s.capturedFrom}.` });
    } catch (err) {
      // CAPTURE_EMPTY leaves the window open on purpose — the user can finish
      // logging in and press the button again.
      setNotice({ kind: 'error', text: err.message });
      if (err.code !== 'CAPTURE_EMPTY') setCapture(null);
    } finally {
      setBusy(false);
    }
  }

  async function handleCancel() {
    setBusy(true);
    try { await cancelSessionCapture(capture.id); } catch { /* already gone */ }
    setCapture(null);
    setNotice(null);
    setBusy(false);
  }

  function handleFile(file) {
    if (!file) return;
    const reader = new FileReader();
    reader.onload = () => {
      const { session: parsed, error: parseError } = parseSessionFile(String(reader.result));
      if (parseError) return setNotice({ kind: 'error', text: parseError });
      onSession(parsed);
      setNotice({ kind: 'info', text: `Loaded ${file.name}.` });
    };
    reader.onerror = () => setNotice({ kind: 'error', text: 'Could not read that file.' });
    reader.readAsText(file);
  }

  return (
    <div className="space-y-4">
      <p className="text-xs text-slate-600 bg-white border border-slate-200 rounded-md p-3">
        You log in once by hand, the scanner reuses that session. Works with any
        login flow — OTP, SSO, two-step forms, captcha — because the scanner
        never has to drive the login itself.
      </p>

      {/* ── Already have a session ── */}
      {session && summary && (
        <div className="rounded-md border-2 border-green-300 bg-green-50 p-3">
          <div className="flex items-start justify-between gap-3">
            <div>
              <p className="text-sm font-medium text-green-900">Session ready</p>
              <p className="text-xs text-green-800 mt-1">
                {summary.cookies} cookies · {summary.localStorage} localStorage ·{' '}
                {summary.sessionStorage} sessionStorage
              </p>
              {summary.capturedFrom && (
                <p className="text-xs text-green-700 mt-0.5 font-mono break-all">
                  {summary.capturedFrom}
                </p>
              )}
            </div>
            <button
              type="button"
              onClick={() => { onSession(null); setNotice(null); }}
              className="text-xs text-green-800 hover:text-green-950 underline flex-shrink-0"
            >
              Clear
            </button>
          </div>
        </div>
      )}

      {/* ── Capture live ── */}
      {!session && !capture && (
        <div className="space-y-3">
          <LabeledInput
            label="Login page URL"
            placeholder="e.g. https://example.gov.in/login"
            value={loginUrl}
            onChange={setLoginUrl}
            type="url"
            hint="Where the browser window should open"
          />
          <button
            type="button"
            disabled={!canStart || busy}
            onClick={handleStart}
            className="w-full px-3 py-2 text-sm font-medium rounded-md bg-brand-500 text-white hover:bg-brand-600 disabled:bg-slate-200 disabled:text-slate-400"
          >
            {busy ? 'Opening browser…' : 'Open a browser and log in'}
          </button>
        </div>
      )}

      {/* ── Window open, waiting on the human ── */}
      {capture && (
        <div className="rounded-md border-2 border-amber-300 bg-amber-50 p-3 space-y-3">
          <p className="text-sm text-amber-900">
            Waiting for you to log in. Finish on a page that is definitely signed
            in, then come back.
          </p>
          <div className="flex gap-2">
            <button
              type="button"
              disabled={busy}
              onClick={handleFinish}
              className="flex-1 px-3 py-2 text-sm font-medium rounded-md bg-brand-500 text-white hover:bg-brand-600 disabled:bg-slate-200 disabled:text-slate-400"
            >
              {busy ? 'Capturing…' : "I'm logged in — capture"}
            </button>
            <button
              type="button"
              disabled={busy}
              onClick={handleCancel}
              className="px-3 py-2 text-sm rounded-md border border-slate-300 bg-white hover:border-slate-400"
            >
              Cancel
            </button>
          </div>
        </div>
      )}

      {notice && (
        <p className={`text-xs rounded-md p-2.5 ${
          notice.kind === 'error'
            ? 'text-red-700 bg-red-50 border border-red-200'
            : notice.kind === 'warn'
              ? 'text-amber-900 bg-amber-50 border border-amber-300'
              : 'text-slate-600 bg-slate-100 border border-slate-200'
        }`}>
          {notice.text}
        </p>
      )}

      {/* ── Upload fallback ── */}
      {!session && (
        <details className="text-xs">
          <summary className="cursor-pointer text-slate-600 hover:text-slate-900">
            Or upload a session file
          </summary>
          <div className="mt-2 space-y-2 pl-1">
            <p className="text-slate-500">
              Use this when the scanner runs somewhere without a desktop (Docker,
              a remote server). On your own machine:
            </p>
            <pre className="bg-slate-900 text-slate-100 p-2 rounded text-[11px] overflow-x-auto">
{`node packages/scanner/bin/capture-session.mjs \\
  --url ${loginUrl.trim() || '<login-url>'} --out session.json`}
            </pre>
            <input
              type="file"
              accept="application/json,.json"
              onChange={(e) => handleFile(e.target.files?.[0])}
              className="block w-full text-xs text-slate-600 file:mr-3 file:py-1.5 file:px-3 file:rounded file:border-0 file:text-xs file:font-medium file:bg-slate-200 file:text-slate-700 hover:file:bg-slate-300"
            />
          </div>
        </details>
      )}

      {error && <p className="text-xs text-red-600">{error}</p>}

      <LabeledInput
        label="Signed-in element selector"
        placeholder="e.g. #user-menu"
        value={authedSelector}
        onChange={onAuthedSelector}
        font="mono"
        hint="Strongly recommended. Something only signed-in pages have. Without it an expired session can produce a clean report for the login page."
      />

      <p className="text-xs text-amber-800 bg-amber-50 border border-amber-200 rounded-md p-2.5">
        A captured session signs in as you with no password and no MFA. It is kept
        in this tab only and sent with the scan — never saved to your browser.
      </p>
    </div>
  );
}

/* ─────────────────── sub-fields ─────────────────── */

function LabeledInput({ label, value, onChange, placeholder, error, type, font, required, hint }) {
  const inputId = useId();
  return (
    <div>
      <label htmlFor={inputId} className="block text-xs uppercase tracking-wide text-slate-500 mb-1.5">
        {label} {required && <span className="text-red-600 normal-case">*</span>}
      </label>
      <input
        id={inputId}
        type={type ?? 'text'}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder={placeholder}
        className={`w-full px-3 py-2 text-sm border rounded-md transition-colors ${
          font === 'mono' ? 'font-mono' : ''
        } ${
          error
            ? 'border-red-300 focus:border-red-500 focus:ring-1 focus:ring-red-500'
            : 'border-slate-300 focus:border-brand-500 focus:ring-1 focus:ring-brand-500'
        }`}
      />
      {hint && !error && <p className="text-xs text-slate-500 mt-1">{hint}</p>}
      {error && <p className="text-xs text-red-600 mt-1">{error}</p>}
    </div>
  );
}

function DismissSelectorsField({ value, onChange }) {
  const text = value.join('\n');
  return (
    <div>
      <label className="block text-xs uppercase tracking-wide text-slate-500 mb-1.5">
        Pre-login elements to dismiss <span className="text-slate-400 normal-case">(optional)</span>
      </label>
      <textarea
        rows={2}
        placeholder={'input[type="checkbox"]\n.cookie-banner button'}
        value={text}
        onChange={(e) => onChange(e.target.value.split('\n').map((s) => s.trim()).filter(Boolean))}
        className="w-full px-3 py-2 text-sm font-mono border border-slate-300 rounded-md focus:border-brand-500 focus:ring-1 focus:ring-brand-500"
      />
      <p className="text-xs text-slate-500 mt-1">
        One CSS selector per line. The scanner clicks each before filling the form (consent checkboxes, cookie banners).
      </p>
    </div>
  );
}

function ContextStrategyToggle({ value, onChange }) {
  return (
    <div>
      <label className="block text-xs uppercase tracking-wide text-slate-500 mb-1.5">
        Context strategy <span className="text-slate-400 normal-case">(advanced)</span>
      </label>
      <div className="flex gap-2">
        {[
          { v: 'reuse',  label: 'Reuse',  hint: 'Default. Fast for most sites.' },
          { v: 'single', label: 'Single', hint: 'For sites with strict session binding (e.g. DIGIT Studio UAT).' },
        ].map((opt) => (
          <button
            key={opt.v}
            type="button"
            onClick={() => onChange(opt.v)}
            className={`flex-1 px-3 py-2 text-sm rounded-md border-2 text-left transition-colors ${
              (value ?? 'reuse') === opt.v
                ? 'border-brand-500 bg-white'
                : 'border-slate-200 bg-white hover:border-slate-300'
            }`}
          >
            <span className="block font-medium text-slate-900">{opt.label}</span>
            <span className="block text-xs text-slate-500 mt-0.5">{opt.hint}</span>
          </button>
        ))}
      </div>
    </div>
  );
}
