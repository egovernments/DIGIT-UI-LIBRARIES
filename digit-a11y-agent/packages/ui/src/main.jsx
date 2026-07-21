/**
 * React entry point.
 *
 * Mounts the App into #root and wires up the router. Strict mode helps
 * catch issues like rendering side effects early during dev.
 */

import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import { App } from './App.jsx';
import './styles/index.css';

// Router basename mirrors the app's base path (Vite's BASE_URL, e.g.
// '/digit-a11y') so client-side routes resolve correctly when the app is
// served under a prefix. Trailing slash stripped; '' means the domain root.
const basename = (import.meta.env.BASE_URL ?? '/').replace(/\/$/, '');

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <BrowserRouter basename={basename}>
      <App />
    </BrowserRouter>
  </StrictMode>,
);
