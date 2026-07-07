/**
 * ScanForm tests.
 *
 * Verifies:
 *   - URL validation (blocks submit until valid)
 *   - successful submit calls createScan with the right shape
 *   - validation error from API surfaces as an inline alert
 *   - network error from API surfaces as an inline alert (recoverable)
 *
 * Mock setup uses vi.hoisted() because vi.mock() is hoisted to the top of
 * the file by vitest — module-level consts referenced by the factory must
 * be hoisted too, otherwise the factory runs before the consts are bound.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';

const { createScanMock, FakeApiClientError } = vi.hoisted(() => {
  class FakeApiClientError extends Error {
    constructor(code, message, details) {
      super(message);
      this.code = code;
      this.details = details;
    }
  }
  return { createScanMock: vi.fn(), FakeApiClientError };
});

vi.mock('../src/lib/api.js', () => ({
  createScan:     (...args) => createScanMock(...args),
  ApiClientError: FakeApiClientError,
}));

import { ScanForm } from '../src/components/ScanForm.jsx';

beforeEach(() => {
  createScanMock.mockReset();
});

const renderForm = () => render(<MemoryRouter><ScanForm /></MemoryRouter>);

describe('<ScanForm />', () => {
  it('disables submit until a valid URL is entered', () => {
    renderForm();
    const button = screen.getByRole('button', { name: /start scan/i });
    expect(button).toBeDisabled();

    fireEvent.change(screen.getByLabelText(/URL to scan/i), { target: { value: 'not-a-url' } });
    expect(button).toBeDisabled();

    fireEvent.change(screen.getByLabelText(/URL to scan/i), { target: { value: 'https://example.gov.in' } });
    expect(button).toBeEnabled();
  });

  it('shows an inline URL error when the input is blurred with an invalid value', () => {
    renderForm();
    const input = screen.getByLabelText(/URL to scan/i);
    fireEvent.change(input, { target: { value: 'bad' } });
    fireEvent.blur(input);
    expect(screen.getByText(/Please enter a full URL/i)).toBeInTheDocument();
  });

  it('calls createScan with just the URL when no auth is configured', async () => {
    createScanMock.mockResolvedValue({ scanId: 'scn_abc', status: 'queued', statusUrl: '/api/scan/scn_abc' });
    renderForm();
    fireEvent.change(screen.getByLabelText(/URL to scan/i), { target: { value: 'https://example.gov.in' } });
    fireEvent.click(screen.getByRole('button', { name: /start scan/i }));

    await waitFor(() => expect(createScanMock).toHaveBeenCalledTimes(1));
    expect(createScanMock).toHaveBeenCalledWith({ url: 'https://example.gov.in' });
  });

  it('surfaces an INVALID_REQUEST_BODY error from the API', async () => {
    createScanMock.mockRejectedValue(new FakeApiClientError(
      'INVALID_REQUEST_BODY',
      'Request body did not match the expected schema.',
      { issues: [{ path: ['auth', 'fields'], message: 'required' }] },
    ));
    renderForm();
    fireEvent.change(screen.getByLabelText(/URL to scan/i), { target: { value: 'https://example.gov.in' } });
    fireEvent.click(screen.getByRole('button', { name: /start scan/i }));

    await waitFor(() => expect(screen.getByRole('alert')).toBeInTheDocument());
    expect(screen.getByText(/Server rejected the request/i)).toBeInTheDocument();
    expect(screen.getByText(/auth\.fields/i)).toBeInTheDocument();
  });

  it('surfaces a network error with recovery hint', async () => {
    createScanMock.mockRejectedValue(new Error('fetch failed'));
    renderForm();
    fireEvent.change(screen.getByLabelText(/URL to scan/i), { target: { value: 'https://example.gov.in' } });
    fireEvent.click(screen.getByRole('button', { name: /start scan/i }));

    await waitFor(() => expect(screen.getByText(/Could not reach the server/i)).toBeInTheDocument());
  });
});
