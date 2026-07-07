/**
 * DigitPresetButton — quick-fill for common DIGIT scan configurations.
 *
 * Lives next to the URL field on the home page. Clicking it opens a small
 * dropdown of known DIGIT presets; selecting one fills the form's URL +
 * waitForSelector + a partial auth config (selectors + login URL, but
 * NOT credentials — those still need to be typed in by the user).
 *
 * Rationale: when running demos, manually typing the eleven different
 * selectors and URLs is tedious and error-prone. The preset captures the
 * "this is how DIGIT auth works" knowledge in one place so demos start
 * from a working baseline.
 *
 * Why we don't include credentials:
 *   - Security: credentials in source code is bad practice even for test
 *     credentials.
 *   - Clarity: forcing the user to type them makes it explicit that real
 *     credentials are needed; users have to consciously choose what to use.
 *   - DIGIT instances rotate test credentials sometimes — hardcoded values
 *     would silently get stale.
 */

import { useState, useEffect, useRef } from 'react';

/**
 * Presets are defined here. To add another, follow the shape below.
 * `auth` is what flows into AuthConfigPanel via its `preset` prop.
 */
const PRESETS = [
  {
    id:    'health-demo-console',
    label: 'DIGIT health-demo (HCM Console)',
    blurb: 'Reuse-context flow. Fill in EMPLOYEE / eGov@123 (or your credentials) after applying.',
    url:               'https://health-demo.digit.org/console/employee',
    waitForSelector:   'text=HCM Console',
    timeoutSec:        120,
    auth: {
      type:             'form',
      loginUrl:         'https://health-demo.digit.org/console/employee/user/login',
      submitSelector:   'button:has-text("Continue")',
      successSelector:  'text=HCM Console',
      successUrl:       '',
      dismissSelectors: 'input[type="checkbox"]',
      contextStrategy:  'reuse',
      fields: [
        { selector: 'input[type="text"]',     value: '' },
        { selector: 'input[type="password"]', value: '' },
      ],
    },
  },
  {
    id:    'workbench-uat-hcm',
    label: 'DIGIT HCM / workbench-ui UAT',
    blurb: 'Single-context flow. Login uses a "Continue" button gated by a privacy checkbox. Fill in your workbench credentials after applying.',
    url:               'https://unified-uat.digit.org/workbench-ui/employee',
    waitForSelector:   '.digit-sidebar-items-container',
    timeoutSec:        150,
    auth: {
      type:             'form',
      loginUrl:         'https://unified-uat.digit.org/workbench-ui/employee/user/login',
      submitSelector:   'button:has-text("Continue")',
      successSelector:  '.digit-sidebar-items-container',
      successUrl:       '',
      dismissSelectors: 'input[type="checkbox"]',
      contextStrategy:  'single',
      fields: [
        { selector: 'input[type="text"]',     value: '' },
        { selector: 'input[type="password"]', value: '' },
      ],
    },
  },
  {
    id:    'studio-uat-landing',
    label: 'DIGIT Studio UAT (Service Designer)',
    blurb: 'Single-context flow (Studio binds sessions to browser). Fill in STUDIOUAT / eGov@123 after applying.',
    url:               'https://unified-uat.digit.org/digit-studio/employee/servicedesigner/LandingPage',
    waitForSelector:   'h1:has-text("Design and Launch Public Services")',
    timeoutSec:        150,
    auth: {
      type:             'form',
      loginUrl:         'https://unified-uat.digit.org/digit-studio/employee/user/login',
      submitSelector:   'button:has-text("Login")',
      successSelector:  'h1:has-text("Design and Launch Public Services")',
      successUrl:       '',
      dismissSelectors: 'input[type="checkbox"]',
      contextStrategy:  'single',
      fields: [
        { selector: 'input[type="text"]',     value: '' },
        { selector: 'input[type="password"]', value: '' },
      ],
    },
  },
];

export function DigitPresetButton({ onApply }) {
  const [open, setOpen] = useState(false);
  const wrapperRef = useRef(null);

  // Close on outside click (just an open/close menu, no fancy popover lib).
  useEffect(() => {
    if (!open) return undefined;
    const onClick = (e) => {
      if (!wrapperRef.current?.contains(e.target)) setOpen(false);
    };
    document.addEventListener('mousedown', onClick);
    return () => document.removeEventListener('mousedown', onClick);
  }, [open]);

  return (
    <div ref={wrapperRef} className="relative">
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        className="text-xs text-brand-500 hover:text-brand-600 font-medium inline-flex items-center gap-1"
        aria-haspopup="menu"
        aria-expanded={open}
      >
        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" aria-hidden="true">
          <path d="M13 2L3 14h9l-1 8 10-12h-9l1-8z" />
        </svg>
        Use DIGIT preset
      </button>

      {open && (
        <div
          className="absolute right-0 top-full mt-1 w-80 bg-white border border-slate-200 rounded-lg shadow-lg z-10 overflow-hidden"
          role="menu"
        >
          <div className="px-3 py-2 border-b border-slate-200 bg-slate-50">
            <p className="text-xs font-semibold text-slate-700">Quick-fill DIGIT scan config</p>
            <p className="text-[11px] text-slate-500 mt-0.5">
              Fills URLs and selectors. You'll still need to type credentials.
            </p>
          </div>
          <div>
            {PRESETS.map((p) => (
              <button
                key={p.id}
                type="button"
                role="menuitem"
                onClick={() => { onApply(p); setOpen(false); }}
                className="block w-full text-left px-3 py-2.5 hover:bg-slate-50 transition-colors border-b border-slate-100 last:border-b-0"
              >
                <p className="text-sm font-medium text-slate-900">{p.label}</p>
                <p className="text-[11px] text-slate-500 mt-0.5 leading-relaxed">{p.blurb}</p>
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

// Export the presets too so tests can reference them without duplicating values.
export { PRESETS as _PRESETS };
