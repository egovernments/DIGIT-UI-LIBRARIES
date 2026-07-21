import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

/**
 * Vite config.
 *
 * `base` is the URL prefix the app is served under. It MUST match the API's
 * BASE_PATH so static assets and `${base}/api/*` line up. Defaults to
 * '/digit-a11y/' (never the domain root); override with the BASE_PATH env at
 * build time. Vite exposes this to the app as `import.meta.env.BASE_URL`.
 *
 * The dev proxy forwards `${base}api/*` to the local API server (which also
 * serves under the same base), so UI code can call the API without CORS
 * hassle. In production the single API process serves both, so this is
 * dev-only sugar.
 */
function normalizeBase(raw) {
  if (!raw || raw.trim() === '' || raw.trim() === '/') return '/';
  let p = raw.trim();
  if (!p.startsWith('/')) p = `/${p}`;
  if (!p.endsWith('/'))   p = `${p}/`;
  return p;
}

const base = normalizeBase(process.env.BASE_PATH ?? '/digit-a11y/');

export default defineConfig({
  base,

  plugins: [react({ jsxRuntime: 'automatic' })],

  server: {
    host: '127.0.0.1',
    port: 5173,
    proxy: {
      [`${base}api`]: {
        target: 'http://127.0.0.1:3000',
        changeOrigin: false,
      },
    },
  },

  build: {
    outDir:    'dist',
    sourcemap: true,
  },

  test: {
    environment: 'jsdom',
    setupFiles:  ['./tests/setup.js'],
    globals:     true,
  },
});
