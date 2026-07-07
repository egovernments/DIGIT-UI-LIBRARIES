import { describe, it, expect } from 'vitest';
import { createScanSchema } from '../src/schemas.js';

describe('createScanSchema', () => {
  it('accepts a bare URL-only request', () => {
    const result = createScanSchema.safeParse({ url: 'https://example.gov.in' });
    expect(result.success).toBe(true);
  });

  it('rejects a missing url', () => {
    const result = createScanSchema.safeParse({});
    expect(result.success).toBe(false);
  });

  it('rejects a non-URL string', () => {
    const result = createScanSchema.safeParse({ url: 'not-a-url' });
    expect(result.success).toBe(false);
  });

  it('accepts form auth with successSelector', () => {
    const result = createScanSchema.safeParse({
      url: 'https://example.gov.in/dashboard',
      auth: {
        type:            'form',
        loginUrl:        'https://example.gov.in/login',
        fields:          { '#user': 'a', '#pass': 'b' },
        submitSelector:  'button[type="submit"]',
        successSelector: 'h1',
      },
    });
    expect(result.success).toBe(true);
  });

  it('rejects form auth missing both successUrl and successSelector', () => {
    const result = createScanSchema.safeParse({
      url: 'https://example.gov.in',
      auth: {
        type:           'form',
        loginUrl:       'https://example.gov.in/login',
        fields:         { '#user': 'a', '#pass': 'b' },
        submitSelector: '#submit',
      },
    });
    expect(result.success).toBe(false);
  });

  it('accepts token auth with a localStorage map', () => {
    const result = createScanSchema.safeParse({
      url: 'https://example.gov.in/dashboard',
      auth: {
        type:         'token',
        loginUrl:     'https://example.gov.in/',
        localStorage: { 'token': 'abc', 'user-info': '{}' },
      },
    });
    expect(result.success).toBe(true);
  });

  it('rejects token auth without any token data', () => {
    const result = createScanSchema.safeParse({
      url: 'https://example.gov.in',
      auth: {
        type:     'token',
        loginUrl: 'https://example.gov.in/',
      },
    });
    expect(result.success).toBe(false);
  });

  it('accepts contextStrategy on auth configs', () => {
    const result = createScanSchema.safeParse({
      url: 'https://example.gov.in/dashboard',
      auth: {
        type:            'form',
        contextStrategy: 'single',
        loginUrl:        'https://example.gov.in/login',
        fields:          { '#u': 'a', '#p': 'b' },
        submitSelector:  '#go',
        successSelector: '.dashboard',
      },
    });
    expect(result.success).toBe(true);
  });

  it('rejects unknown contextStrategy values', () => {
    const result = createScanSchema.safeParse({
      url: 'https://example.gov.in',
      auth: {
        type:            'form',
        contextStrategy: 'invalid',
        loginUrl:        'https://example.gov.in/login',
        fields:          { '#u': 'a', '#p': 'b' },
        submitSelector:  '#go',
        successSelector: '.dashboard',
      },
    });
    expect(result.success).toBe(false);
  });
});
