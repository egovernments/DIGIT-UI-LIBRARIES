/**
 * Day 6 Home page tests.
 *
 * Day 5's static shell is gone — the home page now has:
 *   - hero with brand orange eyebrow
 *   - the scan form (URL input)
 *   - a small API status pill (live)
 *   - the "what gets checked" footer grid
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect, beforeEach, vi } from 'vitest';
import { render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { Home } from '../src/pages/Home.jsx';

beforeEach(() => vi.restoreAllMocks());

const renderWithRouter = (ui) => render(<MemoryRouter>{ui}</MemoryRouter>);

describe('<Home /> — Day 6', () => {
  it('renders the hero', () => {
    vi.spyOn(global, 'fetch').mockReturnValue(new Promise(() => {}));
    renderWithRouter(<Home />);
    expect(screen.getByText(/Accessibility audits for Indian government portals/i)).toBeInTheDocument();
  });

  it('shows the URL input as the primary call-to-action', () => {
    vi.spyOn(global, 'fetch').mockReturnValue(new Promise(() => {}));
    renderWithRouter(<Home />);
    expect(screen.getByLabelText(/URL to scan/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /start scan/i })).toBeInTheDocument();
  });

  it('keeps authentication collapsed by default', () => {
    vi.spyOn(global, 'fetch').mockReturnValue(new Promise(() => {}));
    renderWithRouter(<Home />);
    expect(screen.getByRole('button', { name: /add authentication/i })).toBeInTheDocument();
    // Type radios shouldn't be visible until expanded.
    expect(screen.queryByRole('radiogroup', { name: /authentication type/i })).not.toBeInTheDocument();
  });

  it('shows the API pill as "API online" when health succeeds', async () => {
    vi.spyOn(global, 'fetch').mockResolvedValue({
      ok: true, status: 200,
      json: async () => ({
        status: 'ok',
        version: '0.1.0',
        uptimeSeconds: 42,
        nodeVersion: 'v20.18.0',
        jobs: { total: 0, queued: 0, running: 0, complete: 0, failed: 0 },
      }),
    });
    renderWithRouter(<Home />);
    await waitFor(() => expect(screen.getByText(/API online/i)).toBeInTheDocument());
  });

  it('shows the API pill as "API offline" when health fails', async () => {
    vi.spyOn(global, 'fetch').mockRejectedValue(new Error('network'));
    renderWithRouter(<Home />);
    await waitFor(() => expect(screen.getByText(/API offline/i)).toBeInTheDocument());
  });

  it('lists what gets checked', () => {
    vi.spyOn(global, 'fetch').mockReturnValue(new Promise(() => {}));
    renderWithRouter(<Home />);
    expect(screen.getByText(/Visual contrast/i)).toBeInTheDocument();
    expect(screen.getByText(/Keyboard reachability/i)).toBeInTheDocument();
    expect(screen.getByText(/Standards mapping/i)).toBeInTheDocument();
  });
});
