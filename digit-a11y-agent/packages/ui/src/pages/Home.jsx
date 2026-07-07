/**
 * Home page — Day 6 rewrite.
 *
 * Day 5 was a static shell. Day 6 makes it functional:
 *   - hero / value-prop
 *   - the scan form (URL + optional auth)
 *   - small "what gets checked" section so first-time users know what
 *     to expect
 *
 * The live API-status indicator moved to a small chip in the corner
 * instead of dominating the page — it's nice-to-have, not the message.
 */

import { useEffect, useState } from 'react';
import { getHealth } from '../lib/api.js';
import { ScanForm } from '../components/ScanForm.jsx';
import { SiteForm } from '../components/SiteForm.jsx';

export function Home() {
  const [mode, setMode] = useState('single');
  return (
    <div className="space-y-8">
      <Hero />
      <div className="card">
        <ModeTabs mode={mode} onChange={setMode} />
        {mode === 'single' ? <ScanForm /> : <SiteForm />}
      </div>
      <WhatGetsChecked />
    </div>
  );
}

/** Segmented toggle between single-page and whole-site scans. */
function ModeTabs({ mode, onChange }) {
  const tabs = [
    { key: 'single', label: 'Single page' },
    { key: 'site',   label: 'Whole site'  },
  ];
  return (
    <div className="mb-5">
      <div className="inline-flex rounded-lg border border-slate-200 bg-slate-50 p-1" role="tablist" aria-label="Scan mode">
        {tabs.map((t) => {
          const active = mode === t.key;
          return (
            <button
              key={t.key}
              type="button"
              role="tab"
              aria-selected={active}
              onClick={() => onChange(t.key)}
              className={`px-4 py-2 text-sm font-medium rounded-md transition-colors ${
                active ? 'bg-white text-slate-900 shadow-sm' : 'text-slate-500 hover:text-slate-700'
              }`}
            >
              {t.label}
            </button>
          );
        })}
      </div>
      <p className="text-xs text-slate-500 mt-2">
        {mode === 'single'
          ? 'Scan a single URL.'
          : 'Scan a list of pages in one run — one combined report with a per-page breakdown.'}
      </p>
    </div>
  );
}

function Hero() {
  return (
    <header className="flex items-start justify-between gap-4">
      <div className="max-w-2xl">
        <p className="text-xs font-semibold uppercase tracking-widest text-brand-500 mb-2">
          DIGIT Accessibility Scanner · Phase 1
        </p>
        <h1 className="text-3xl sm:text-4xl font-bold text-slate-900 leading-[1.15] tracking-tight">
          Accessibility audits for Indian government portals,
          <span className="text-brand-500"> in one click.</span>
        </h1>
        <p className="text-base text-slate-600 mt-3 leading-relaxed">
          Paste a URL. Get a plain-language report mapped to WCAG, GIGW, SesMag and ADA — with
          pixel-coordinate highlights, full-page screenshots, and severity-ranked fix guidance.
          Works on protected pages with login.
        </p>
      </div>
      <ApiPill />
    </header>
  );
}

/** Tiny corner indicator showing live API connection state. */
function ApiPill() {
  const [state, setState] = useState({ status: 'loading' });

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const data = await getHealth();
        if (!cancelled) setState({ status: 'ok', data });
      } catch (err) {
        if (!cancelled) setState({ status: 'down', error: err.message });
      }
    })();
    return () => { cancelled = true; };
  }, []);

  const tone =
    state.status === 'ok'      ? { dot: 'bg-statusOk',   label: 'API online' } :
    state.status === 'down'    ? { dot: 'bg-statusBad',  label: 'API offline' } :
                                 { dot: 'bg-slate-400',  label: 'Connecting…' };

  return (
    <div
      className="hidden sm:flex flex-shrink-0 items-center gap-2 px-3 py-1.5 rounded-full bg-white border border-slate-200 text-xs text-slate-600"
      title={state.status === 'ok' ? `v${state.data.version} · uptime ${state.data.uptimeSeconds}s` : (state.error ?? '')}
    >
      <span className={`relative inline-block h-2 w-2 rounded-full ${tone.dot}`}>
        {state.status === 'ok' && (
          <span className={`absolute inset-0 rounded-full ${tone.dot} animate-ping opacity-50`} />
        )}
      </span>
      {tone.label}
    </div>
  );
}

const CHECKS = [
  { icon: '👁',   title: 'Visual contrast',          desc: 'Color contrast, focus indicators, text size.' },
  { icon: '⌨️',  title: 'Keyboard reachability',    desc: 'Tab order, focus traps, interactive elements.' },
  { icon: '🔊',  title: 'Screen reader support',    desc: 'ARIA, alt text, semantic landmarks.' },
  { icon: '🧠',  title: 'Cognitive accessibility',  desc: 'Clear headings, labelled forms, plain language.' },
  { icon: '📱',  title: 'Mobile & responsive',      desc: 'Touch target size, viewport behaviour.' },
  { icon: '📜',  title: 'Standards mapping',        desc: 'WCAG 2.0/2.1 A & AA, GIGW, SesMag, ADA.' },
];

function WhatGetsChecked() {
  return (
    <section aria-labelledby="checks-heading">
      <h2 id="checks-heading" className="text-sm font-semibold text-slate-900 mb-3">
        What gets checked
      </h2>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
        {CHECKS.map((c) => (
          <div key={c.title} className="rounded-card border border-slate-200 bg-white p-4">
            <div className="flex items-start gap-3">
              <span className="text-xl leading-none" aria-hidden="true">{c.icon}</span>
              <div>
                <p className="text-sm font-medium text-slate-900">{c.title}</p>
                <p className="text-xs text-slate-500 mt-0.5">{c.desc}</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
