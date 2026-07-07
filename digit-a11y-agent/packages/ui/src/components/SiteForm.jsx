/**
 * SiteForm — the "Whole site" entry point on the home page.
 *
 * The multi-page sibling of ScanForm: instead of one URL it takes a list
 * (one per line — the sitemap), posts to POST /api/site, and routes to the
 * site progress page. Reuses AuthConfigPanel for credentials and offers a
 * one-click DIGIT Studio preset that fills the validated Studio URLs plus
 * the Studio login config (credentials still typed by the user).
 *
 * Like the single-page scanner, the server logs in automatically and runs
 * headless — there is no manual-login step here.
 */

import { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { createSiteScan, ApiClientError } from '../lib/api.js';
import { AuthConfigPanel } from './AuthConfigPanel.jsx';
import { _PRESETS } from './DigitPresetButton.jsx';

// Reuse the Studio auth config from the single-page preset (same shape
// AuthConfigPanel's `preset` prop expects).
const STUDIO_PRESET = _PRESETS.find((p) => p.id === 'studio-uat-landing');

// The validated Studio sitemap — login + Service Designer + Public Services pages.
const STUDIO_SITEMAP = [
  'https://unified-uat.digit.org/digit-studio/employee/user/login',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/LandingPage',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/create-service',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/create-module',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/create-form-Home?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/form-builder?variant=app&masterName=FormBuilder&fieldType=FieldTypeMappingConfig&prefix=CMP-2025-07-24-006759&localeModule=APPONE&tenantId=st&campaignNumber=CMP-2025-07-24-006759&formId=default&projectType=Bednet&module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/Roles?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/Workflow?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/Checklist?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/notifications?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/Service-Builder-Home?module=STUDIO_ACCESSIBILITY_SERVICE&service=STUDIO_ACCESSIBILITY_MODULE&edit=true',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/preview?module=Action&service=Preview&published=false',
  'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/manage-users?module=test_perfor1&service=module_perfor_1',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/modules?selectedPath=Apply',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/test_perfor1/search?selectedModule=true&module=test_perfor1&service=module_perfor_1',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/test_perfor1/inbox',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/test_perfor1/module_perfor_1/Apply?serviceCode=...&selectedModule=true&module=test_perfor1&service=module_perfor_1',
  'https://unified-uat.digit.org/digit-studio/employee/publicservices/test_perfor1/module_perfor_1/ViewScreen?applicationNumber=test_perfor1-module_perfor_1-app-2026-05-04-023437&serviceCode=test_perfor1-module_perfor_1-svc-2026-04-30-023430&businessService=test_perfor1.module_perfor_1&selectedModule=true&from=inbox',
];

function parseUrls(text) {
  return text.split('\n').map((l) => l.trim()).filter(Boolean);
}

function isLikelyUrl(value) {
  try {
    const u = new URL(value);
    return u.protocol === 'http:' || u.protocol === 'https:';
  } catch {
    return false;
  }
}

export function SiteForm() {
  const navigate = useNavigate();

  const [urlsText, setUrlsText]       = useState('');
  const [authState, setAuthState]     = useState({ type: 'none', config: null, hasErrors: false });
  const [authPreset, setAuthPreset]   = useState(null);
  const [submitting, setSubmitting]   = useState(false);
  const [submitError, setSubmitError] = useState(null);
  const [touched, setTouched]         = useState(false);

  const urls    = parseUrls(urlsText);
  const badUrls = urls.filter((u) => !isLikelyUrl(u));

  const urlsError = touched
    ? (urls.length === 0
        ? 'Add at least one URL (one per line).'
        : (badUrls.length ? `${badUrls.length} line${badUrls.length === 1 ? '' : 's'} not a valid URL (need https://…).` : null))
    : null;

  const authBlocking = authState.type !== 'none' && (authState.hasErrors || !authState.config);
  const canSubmit    = urls.length > 0 && badUrls.length === 0 && !authBlocking && !submitting;

  const applyStudioPreset = () => {
    setUrlsText(STUDIO_SITEMAP.join('\n'));
    if (STUDIO_PRESET?.auth) setAuthPreset(STUDIO_PRESET.auth);
    setTouched(true);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    setTouched(true);
    if (!canSubmit) return;

    setSubmitting(true);
    setSubmitError(null);

    const requestBody = { urls };
    if (authState.config) requestBody.auth = authState.config;

    try {
      const { siteId } = await createSiteScan(requestBody);
      navigate(`/site/${siteId}`);
    } catch (err) {
      if (err instanceof ApiClientError) {
        if (err.code === 'API_KEY_INVALID') {
          setSubmitError({
            title:   'API key required',
            message: 'The API server requires an API key. Set one via `localStorage.setItem("A11Y_API_KEY", "<your-key>")` in the browser console and refresh.',
          });
        } else if (err.code === 'INVALID_REQUEST_BODY') {
          setSubmitError({ title: 'Server rejected the request', message: err.message, details: err.details?.issues });
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
        <div className="flex items-center justify-between gap-3 mb-1.5">
          <label htmlFor="site-urls" className="block text-sm font-semibold text-slate-900">
            Pages to scan <span className="font-normal text-slate-400">(one URL per line)</span>
          </label>
          <button
            type="button"
            onClick={applyStudioPreset}
            className="text-xs text-brand-500 hover:text-brand-600 font-medium inline-flex items-center gap-1"
          >
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" aria-hidden="true">
              <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z" />
            </svg>
            DIGIT Studio (18 pages)
          </button>
        </div>
        <textarea
          id="site-urls"
          value={urlsText}
          onChange={(e) => setUrlsText(e.target.value)}
          onBlur={() => setTouched(true)}
          rows={6}
          placeholder={'https://example.gov.in/dashboard\nhttps://example.gov.in/reports\nhttps://example.gov.in/settings'}
          spellCheck={false}
          className={`w-full px-4 py-3 text-sm font-mono border-2 rounded-lg transition-colors resize-y ${
            urlsError
              ? 'border-red-300 focus:border-red-500 focus:ring-1 focus:ring-red-500'
              : 'border-slate-300 focus:border-brand-500 focus:ring-1 focus:ring-brand-500'
          }`}
          aria-invalid={Boolean(urlsError)}
          aria-describedby={urlsError ? 'site-urls-error' : 'site-urls-hint'}
        />
        {urlsError ? (
          <p id="site-urls-error" className="text-xs text-red-600 mt-1.5">{urlsError}</p>
        ) : (
          <p id="site-urls-hint" className="text-xs text-slate-500 mt-1.5">
            {urls.length > 0
              ? `${urls.length} page${urls.length === 1 ? '' : 's'} queued. The server logs in once and scans each page; navigation only follows this list.`
              : 'List the pages you want audited. For protected pages, configure login below.'}
          </p>
        )}
      </div>

      <AuthConfigPanel onChange={setAuthState} preset={authPreset} />

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
            <span className="inline-flex items-center gap-2"><Spinner /> Starting…</span>
          ) : (
            `Scan ${urls.length || ''} ${urls.length === 1 ? 'page' : 'pages'}`.replace('  ', ' ').trim()
          )}
        </button>
        {authBlocking && touched && (
          <span className="text-xs text-amber-700">Authentication has errors — please fix them.</span>
        )}
      </div>

      <p className="text-xs text-slate-500">
        A whole-site scan logs in automatically and runs headless on the server. It can take a couple of minutes per page.
      </p>
    </form>
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
