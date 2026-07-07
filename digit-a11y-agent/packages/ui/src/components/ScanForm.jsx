/**
 * ScanForm — the main entry point on the home page.
 *
 * Day 8 update: per-scan timeout field exposed alongside waitForSelector.
 * Default is left unset (server uses its own default, currently 60s — bump
 * to 90s via SCAN_TIMEOUT_MS env var if available). DIGIT scans typically
 * need 90-150s with auth + redirect-aware waits, so giving the user a
 * direct knob avoids the "scan failed at 60s for no obvious reason" trap.
 */

import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { createScan, ApiClientError } from '../lib/api.js';
import { AuthConfigPanel } from './AuthConfigPanel.jsx';
import { DigitPresetButton } from './DigitPresetButton.jsx';

function isLikelyUrl(value) {
  if (!value || typeof value !== 'string') return false;
  try {
    const u = new URL(value.trim());
    return u.protocol === 'http:' || u.protocol === 'https:';
  } catch {
    return false;
  }
}

export function ScanForm() {
  const navigate = useNavigate();

  const [url, setUrl]                     = useState('');
  const [waitSelector, setWaitSelector]   = useState('');
  const [timeoutSec, setTimeoutSec]       = useState('');                                     // empty = use server default
  const [authState, setAuthState]         = useState({ type: 'none', config: null, hasErrors: false });
  const [authPreset, setAuthPreset]       = useState(null);  // when a preset is applied, hand it down so the panel pre-fills
  const [submitting, setSubmitting]       = useState(false);
  const [submitError, setSubmitError]     = useState(null);
  const [touched, setTouched]             = useState(false);

  const urlError = touched && !isLikelyUrl(url) ? 'Please enter a full URL (https://…).' : null;
  const authBlocking = authState.type !== 'none' && (authState.hasErrors || !authState.config);
  const canSubmit = isLikelyUrl(url) && !authBlocking && !submitting;

  const handlePresetApplied = (preset) => {
    if (preset.url) setUrl(preset.url);
    if (preset.waitForSelector) setWaitSelector(preset.waitForSelector);
    if (preset.timeoutSec) setTimeoutSec(String(preset.timeoutSec));
    if (preset.auth) setAuthPreset(preset.auth);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setTouched(true);
    if (!canSubmit) return;

    setSubmitting(true);
    setSubmitError(null);

    const request = { url: url.trim() };
    if (authState.config) request.auth = authState.config;
    const options = {};
    if (waitSelector.trim()) options.waitForSelector = waitSelector.trim();
    const parsedTimeout = parseInt(timeoutSec, 10);
    if (Number.isFinite(parsedTimeout) && parsedTimeout > 0) {
      options.timeoutMs = parsedTimeout * 1000;
    }
    if (Object.keys(options).length > 0) request.options = options;

    try {
      const { scanId } = await createScan(request);
      navigate(`/scan/${scanId}`);
    } catch (err) {
      if (err instanceof ApiClientError) {
        if (err.code === 'API_KEY_INVALID') {
          setSubmitError({
            title:   'API key required',
            message: 'The API server is configured to require an API key. Set one via `localStorage.setItem("A11Y_API_KEY", "<your-key>")` in the browser console and refresh.',
          });
        } else if (err.code === 'INVALID_REQUEST_BODY') {
          setSubmitError({
            title:   'Server rejected the request',
            message: err.message,
            details: err.details?.issues,
          });
        } else {
          setSubmitError({ title: err.code, message: err.message });
        }
      } else {
        setSubmitError({
          title:   'Could not reach the server',
          message: err.message ?? 'Network error. Is the API running on port 3000?',
        });
      }
      setSubmitting(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-5" noValidate>
      <div>
        <label htmlFor="scan-url" className="block text-sm font-semibold text-slate-900 mb-1.5">
          URL to scan
        </label>
        <input
          id="scan-url"
          type="url"
          value={url}
          onChange={(e) => setUrl(e.target.value)}
          onBlur={() => setTouched(true)}
          placeholder="https://example.gov.in/dashboard"
          autoComplete="off"
          autoFocus
          className={`w-full px-4 py-3 text-base border-2 rounded-lg transition-colors ${
            urlError
              ? 'border-red-300 focus:border-red-500 focus:ring-1 focus:ring-red-500'
              : 'border-slate-300 focus:border-brand-500 focus:ring-1 focus:ring-brand-500'
          }`}
          aria-invalid={Boolean(urlError)}
          aria-describedby={urlError ? 'scan-url-error' : 'scan-url-hint'}
        />
        {urlError ? (
          <p id="scan-url-error" className="text-xs text-red-600 mt-1.5">{urlError}</p>
        ) : (
          <div className="flex items-center justify-between gap-3 mt-1.5">
            <p id="scan-url-hint" className="text-xs text-slate-500">
              The page to scan. For protected pages, configure authentication below.
            </p>
            <DigitPresetButton onApply={handlePresetApplied} />
          </div>
        )}
      </div>

      <AuthConfigPanel onChange={setAuthState} preset={authPreset} />

      <AdvancedOptions
        waitSelector={waitSelector}
        onWaitSelectorChange={setWaitSelector}
        timeoutSec={timeoutSec}
        onTimeoutChange={setTimeoutSec}
      />

      {submitError && (
        <div role="alert" className="rounded-md border border-red-200 bg-red-50 p-3">
          <p className="text-sm font-medium text-red-800">{submitError.title}</p>
          <p className="text-sm text-red-700 mt-0.5">{submitError.message}</p>
          {submitError.details && (
            <ul className="text-xs text-red-700 mt-2 ml-4 list-disc space-y-0.5">
              {submitError.details.map((issue, i) => (
                <li key={i}>
                  <code className="font-mono">{issue.path?.join('.') || 'root'}</code>: {issue.message}
                </li>
              ))}
            </ul>
          )}
        </div>
      )}

      <div className="flex items-center gap-3 pt-1">
        <button
          type="submit"
          disabled={!canSubmit}
          className="btn-primary text-base px-6 py-3 disabled:opacity-60"
        >
          {submitting ? (
            <span className="inline-flex items-center gap-2">
              <Spinner /> Starting…
            </span>
          ) : (
            'Start scan'
          )}
        </button>
        {authBlocking && touched && (
          <span className="text-xs text-amber-700">
            Authentication has errors — please fix them.
          </span>
        )}
      </div>
    </form>
  );
}

/**
 * Collapsible advanced options. Hidden by default to keep the form
 * uncluttered. Expands when one of the fields has a value, or on click.
 * Two settings inside:
 *   - Wait for element on target page  (waitForSelector)
 *   - Scan timeout in seconds          (options.timeoutMs ÷ 1000)
 */
function AdvancedOptions({ waitSelector, onWaitSelectorChange, timeoutSec, onTimeoutChange }) {
  const [expanded, setExpanded] = useState(Boolean(waitSelector || timeoutSec));

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
          Advanced options (wait for element, scan timeout)
        </button>
        <p className="text-xs text-slate-500 mt-1">
          Recommended for authenticated DIGIT pages — set both for the most reliable scan.
        </p>
      </div>
    );
  }

  return (
    <div className="border border-slate-200 rounded-lg p-4 bg-slate-50/50 space-y-4">
      <div className="flex items-start justify-between gap-4">
        <div>
          <h4 className="text-sm font-semibold text-slate-900">Advanced options</h4>
          <p className="text-xs text-slate-500 mt-0.5">
            Useful for slow or protected pages where the defaults aren't enough.
          </p>
        </div>
        <button
          type="button"
          onClick={() => { setExpanded(false); onWaitSelectorChange(''); onTimeoutChange(''); }}
          className="text-slate-400 hover:text-slate-700 text-xs flex-shrink-0"
        >
          Remove
        </button>
      </div>

      <div>
        <label htmlFor="scan-wait-selector" className="block text-xs uppercase tracking-wide text-slate-500 mb-1.5">
          Wait for element on target page
        </label>
        <input
          id="scan-wait-selector"
          type="text"
          value={waitSelector}
          onChange={(e) => onWaitSelectorChange(e.target.value)}
          placeholder='e.g. text=My Campaigns  or  .inventory_list  or  #dashboard-header'
          className="w-full px-3 py-2 text-sm font-mono border border-slate-300 rounded-md focus:border-brand-500 focus:ring-1 focus:ring-brand-500"
        />
        <p className="text-xs text-slate-500 mt-1.5">
          A CSS or Playwright selector that must be visible before the scan runs. If it
          doesn't appear within 30 seconds, the scan fails (rather than silently auditing
          a redirect / loading screen).
        </p>
      </div>

      <div>
        <label htmlFor="scan-timeout" className="block text-xs uppercase tracking-wide text-slate-500 mb-1.5">
          Scan timeout <span className="text-slate-400 normal-case">(seconds)</span>
        </label>
        <input
          id="scan-timeout"
          type="number"
          min="10"
          max="600"
          step="10"
          value={timeoutSec}
          onChange={(e) => onTimeoutChange(e.target.value)}
          placeholder="e.g. 120 (default: server-configured, usually 60-120)"
          className="w-full px-3 py-2 text-sm border border-slate-300 rounded-md focus:border-brand-500 focus:ring-1 focus:ring-brand-500"
        />
        <p className="text-xs text-slate-500 mt-1.5">
          Total time the scanner gets, end to end. DIGIT scans with auth typically need 90-150s.
          Leave blank to use the server's default.
        </p>
      </div>
    </div>
  );
}

function Spinner() {
  return (
    <svg className="animate-spin h-4 w-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3" aria-hidden="true">
      <circle cx="12" cy="12" r="10" opacity="0.25" />
      <path d="M22 12a10 10 0 01-10 10" strokeLinecap="round" />
    </svg>
  );
}
