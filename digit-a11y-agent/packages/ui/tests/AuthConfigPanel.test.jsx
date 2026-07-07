/**
 * AuthConfigPanel tests.
 *
 * Focuses on the user-visible state machine:
 *   - collapsed by default
 *   - expanding shows form/token radio
 *   - selecting form shows its fields
 *   - selecting token shows token fields
 *   - publishes a valid config upward when complete, null when partial
 *
 * Field-presence assertions use getByLabelText (not getByText), because the
 * field labels and their validation error messages share the same text (e.g.
 * "Submit button selector" appears in both <label> and "<field> is required."
 * messages). Targeting by label association is unique and the more correct
 * way to test forms anyway.
 */

import '@testing-library/jest-dom/vitest';
import React from 'react';
import { describe, it, expect, vi } from 'vitest';
import { render, screen, fireEvent } from '@testing-library/react';
import { AuthConfigPanel } from '../src/components/AuthConfigPanel.jsx';

describe('<AuthConfigPanel />', () => {
  it('starts collapsed and reports type=none', () => {
    const onChange = vi.fn();
    render(<AuthConfigPanel onChange={onChange} />);
    expect(screen.getByRole('button', { name: /add authentication/i })).toBeInTheDocument();
    expect(onChange).toHaveBeenCalledWith(expect.objectContaining({ type: 'none', config: null }));
  });

  it('expands when "Add authentication" is clicked', () => {
    render(<AuthConfigPanel onChange={() => {}} />);
    fireEvent.click(screen.getByRole('button', { name: /add authentication/i }));
    expect(screen.getByRole('radiogroup', { name: /authentication type/i })).toBeInTheDocument();
  });

  it('shows form-auth fields after selecting "Form login"', () => {
    render(<AuthConfigPanel onChange={() => {}} />);
    fireEvent.click(screen.getByRole('button', { name: /add authentication/i }));
    fireEvent.click(screen.getByLabelText(/Form login/i));

    // Use getByLabelText to target inputs by their <label>, not text content.
    // The phrase "Submit button selector" also appears in the validation
    // error "Submit button selector is required.", so getByText matches two.
    expect(screen.getByLabelText(/Login page URL/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/Submit button selector/i)).toBeInTheDocument();
    // "Fields to fill" is not a single input but a section, so we still use
    // getByText — but qualified to the label element which has a UPPERCASE-y
    // class. We'll just look for the role-less <label>.
    expect(screen.getByText(/Fields to fill/i, { selector: 'label' })).toBeInTheDocument();
  });

  it('shows token-auth fields after selecting "Token injection"', () => {
    render(<AuthConfigPanel onChange={() => {}} />);
    fireEvent.click(screen.getByRole('button', { name: /add authentication/i }));
    fireEvent.click(screen.getByLabelText(/Token injection/i));

    expect(screen.getByLabelText(/Origin URL/i)).toBeInTheDocument();
    // Same pattern as above for the section header.
    expect(screen.getByText(/localStorage entries to inject/i, { selector: 'label' })).toBeInTheDocument();
  });

  it('reports a valid config once all required form-auth fields are filled', () => {
    const onChange = vi.fn();
    render(<AuthConfigPanel onChange={onChange} />);

    fireEvent.click(screen.getByRole('button', { name: /add authentication/i }));
    fireEvent.click(screen.getByLabelText(/Form login/i));

    // Add a Username + Password preset row
    fireEvent.click(screen.getByRole('button', { name: /\+ Username/ }));
    fireEvent.click(screen.getByRole('button', { name: /\+ Password/ }));

    // Fill the value side of each row
    const valueInputs = screen.getAllByLabelText(/Field \d value/i);
    fireEvent.change(valueInputs[0], { target: { value: 'standard_user' } });
    fireEvent.change(valueInputs[1], { target: { value: 'secret_sauce' } });

    // Top-level fields: login URL, submit selector, success selector.
    // Placeholders use "e.g. https://example.gov.in/login" etc. — the
    // regexes here look for the URL/selector substring inside that.
    fireEvent.change(screen.getByPlaceholderText(/https:\/\/example\.gov\.in\/login/), {
      target: { value: 'https://www.saucedemo.com/' },
    });
    fireEvent.change(screen.getByPlaceholderText(/button:has-text\("Login"\)/), {
      target: { value: '#login-button' },
    });
    fireEvent.change(screen.getByPlaceholderText(/text=Dashboard/), {
      target: { value: '.inventory_list' },
    });

    // The last call to onChange should have a valid config.
    const lastCall = onChange.mock.calls[onChange.mock.calls.length - 1][0];
    expect(lastCall.type).toBe('form');
    expect(lastCall.hasErrors).toBe(false);
    expect(lastCall.config).toMatchObject({
      type:            'form',
      loginUrl:        'https://www.saucedemo.com/',
      submitSelector:  '#login-button',
      successSelector: '.inventory_list',
    });
    expect(lastCall.config.fields['input[type="text"]']).toBe('standard_user');
    expect(lastCall.config.fields['input[type="password"]']).toBe('secret_sauce');
  });

  it('keeps config=null while form-auth is incomplete', () => {
    const onChange = vi.fn();
    render(<AuthConfigPanel onChange={onChange} />);
    fireEvent.click(screen.getByRole('button', { name: /add authentication/i }));
    fireEvent.click(screen.getByLabelText(/Form login/i));

    // Only fill the login URL — nothing else
    fireEvent.change(screen.getByPlaceholderText(/https:\/\/example\.gov\.in\/login/), {
      target: { value: 'https://example.com/' },
    });

    const lastCall = onChange.mock.calls[onChange.mock.calls.length - 1][0];
    expect(lastCall.type).toBe('form');
    expect(lastCall.config).toBeNull();
    expect(lastCall.hasErrors).toBe(true);
  });
});
