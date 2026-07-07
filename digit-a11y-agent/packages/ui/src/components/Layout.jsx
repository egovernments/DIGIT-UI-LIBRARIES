/**
 * Shared application layout — header, content slot, footer.
 *
 * Kept intentionally small. Days 6-7 add proper navigation, theme toggle,
 * and (if needed) a sidebar with scan history.
 */

import { Link } from 'react-router-dom';

export function Layout({ children }) {
  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <main className="flex-1 py-10">
        <div className="container-app">{children}</div>
      </main>
      <Footer />
    </div>
  );
}

function Header() {
  return (
    <header className="border-b border-slate-200 bg-white">
      <div className="container-app flex items-center justify-between py-4">
        <Link to="/" className="flex items-center gap-3">
          <div className="h-9 w-9 rounded-md bg-brand-500 flex items-center justify-center">
            <span className="text-white font-bold text-lg">A</span>
          </div>
          <div>
            <h1 className="text-base font-semibold text-slate-900 leading-tight">
              DIGIT Accessibility Scanner
            </h1>
            <p className="text-xs text-slate-500 leading-tight">
              WCAG, GIGW, SesMag & ADA compliance for govt portals
            </p>
          </div>
        </Link>
        <nav className="hidden sm:flex items-center gap-5 text-sm text-slate-700">
          <span className="text-xs text-slate-400 font-mono">Phase 1 · v0.1.0</span>
          <a
            href="https://github.com/egovernments/digit-a11y-agent"
            className="hover:text-brand-500 transition-colors"
            target="_blank"
            rel="noopener noreferrer"
          >
            Repo
          </a>
        </nav>
      </div>
    </header>
  );
}

function Footer() {
  return (
    <footer className="border-t border-slate-200 bg-white">
      <div className="container-app py-6 flex flex-col sm:flex-row items-start sm:items-center justify-between gap-2 text-xs text-slate-500">
        <span>DIGIT Accessibility Scanner · v0.1.0 · Phase 1 (in progress)</span>
        <span>Built on Playwright + axe-core 4.11</span>
      </div>
    </footer>
  );
}
