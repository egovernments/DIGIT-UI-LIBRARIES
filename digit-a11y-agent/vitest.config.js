import { defineConfig } from 'vitest/config';

/**
 * Root vitest config.
 *
 * One test runner for the whole monorepo. By default tests run in `node`
 * (no DOM, no React); UI tests opt into `jsdom` via the environmentMatchGlobs
 * mapping below. This avoids needing a separate test command per package.
 *
 * setupFiles loads conditionally — `@testing-library/jest-dom` only attaches
 * when the test environment provides a DOM (i.e. jsdom).
 */
export default defineConfig({
  esbuild: {
    jsx: 'automatic',
  },
  test: {
    globals: true,
    environment: 'node',
    include: ['packages/*/tests/**/*.test.{js,jsx}'],

    environmentMatchGlobs: [
      ['packages/ui/**', 'jsdom'],
    ],

    setupFiles: ['./vitest.setup.js'],

    coverage: {
      provider: 'v8',
      include: ['packages/*/src/**/*.{js,jsx}'],
      exclude: ['**/node_modules/**', '**/dist/**'],
    },

    testTimeout: 10_000,
  },
});
