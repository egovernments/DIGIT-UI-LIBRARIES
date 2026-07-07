/**
 * Tailwind config — design tokens for the DIGIT Accessibility Scanner UI.
 *
 * Why these colours: they map to severity semantics in the FriendlyReport,
 * not just an arbitrary palette. Each severity gets a bg/text/border triple
 * that other components reuse via the `severity-{level}` utilities.
 *
 * Phase 1 keeps it minimal. Phase 2 will add a dark mode toggle if we get
 * that request — Tailwind makes it a one-line change at that point.
 */

/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './index.html',
    './src/**/*.{js,jsx}',
  ],

  theme: {
    extend: {
      colors: {
        // Brand
        brand: {
          50:  '#fff5ed',
          100: '#ffe6d2',
          500: '#c84c0e',    // DIGIT signature orange
          600: '#a83e09',
          700: '#852f06',
        },

        // Severity semantics
        critical: {
          bg:     '#fee2e2',
          text:   '#991b1b',
          border: '#fecaca',
          dot:    '#dc2626',
        },
        serious: {
          bg:     '#ffedd5',
          text:   '#9a3412',
          border: '#fed7aa',
          dot:    '#ea580c',
        },
        moderate: {
          bg:     '#fef3c7',
          text:   '#92400e',
          border: '#fde68a',
          dot:    '#d97706',
        },
        minor: {
          bg:     '#dbeafe',
          text:   '#1e40af',
          border: '#bfdbfe',
          dot:    '#2563eb',
        },

        // Status (full-score badges)
        statusOk:      '#16a34a',
        statusWarn:    '#ca8a04',
        statusBad:     '#dc2626',
      },

      fontFamily: {
        sans: ['"Inter"', 'ui-sans-serif', 'system-ui', 'sans-serif'],
        mono: ['"JetBrains Mono"', 'ui-monospace', 'monospace'],
      },

      boxShadow: {
        card: '0 1px 2px rgba(0,0,0,0.06), 0 4px 12px rgba(0,0,0,0.05)',
      },

      borderRadius: {
        card: '12px',
      },
    },
  },

  plugins: [],
};
