import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

/**
 * Vite dev server config.
 *
 * The /api proxy means UI code can call `fetch('/api/scan')` and get routed
 * to the local API server without any CORS hassle. In production, both UI
 * and API are typically served from the same origin (or the proxy is
 * handled by a reverse proxy), so this is dev-only sugar.
 */
export default defineConfig({
  plugins: [react({ jsxRuntime: 'automatic' })],

  server: {
    host: '127.0.0.1',
    port: 5173,
    proxy: {
      '/api': {
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
