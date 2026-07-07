/**
 * Request validation schemas (zod).
 *
 * The API only accepts requests that conform to these schemas. Anything
 * malformed gets a 400 with the exact zod error details — far easier to
 * debug than "something is wrong with your request."
 *
 * The schemas mirror the JSDoc typedefs in `@digit-a11y/reporter/src/types.js`
 * but live in zod-land because they need runtime enforcement at the boundary.
 */

import { z } from 'zod';

/* ───────────────────────── AuthConfig sub-schemas ──────────────────────── */

const cookieSchema = z.object({
  name:     z.string().min(1),
  value:    z.string(),
  url:      z.string().url().optional(),
  domain:   z.string().optional(),
  path:     z.string().optional(),
  expires:  z.number().optional(),
  httpOnly: z.boolean().optional(),
  secure:   z.boolean().optional(),
  sameSite: z.enum(['Strict', 'Lax', 'None']).optional(),
}).refine(
  (c) => Boolean(c.url) || (Boolean(c.domain) && Boolean(c.path)),
  { message: 'Cookie needs either url, or both domain and path' },
);

const timeoutsSchema = z.object({
  navigation:  z.number().int().positive().optional(),
  fieldFill:   z.number().int().positive().optional(),
  submit:      z.number().int().positive().optional(),
  successWait: z.number().int().positive().optional(),
  dismiss:     z.number().int().positive().optional(),
  verification: z.number().int().positive().optional(),
}).optional();

const formAuthSchema = z.object({
  type:             z.literal('form'),
  contextStrategy:  z.enum(['reuse', 'single']).optional(),
  loginUrl:         z.string().url(),
  dismissSelectors: z.array(z.string()).optional(),
  fields:           z.record(z.string(), z.string()),
  submitSelector:   z.string().min(1),
  successUrl:       z.string().optional(),
  successSelector:  z.string().optional(),
  timeouts:         timeoutsSchema,
}).refine(
  (a) => Boolean(a.successUrl) || Boolean(a.successSelector),
  { message: 'Form auth needs either successUrl or successSelector' },
);

const tokenAuthSchema = z.object({
  type:             z.literal('token'),
  contextStrategy:  z.enum(['reuse', 'single']).optional(),
  loginUrl:         z.string().url(),
  token:            z.string().min(1).optional(),
  tokenStorageKey:  z.string().min(1).optional(),
  localStorage:     z.record(z.string(), z.string()).optional(),
  cookies:          z.array(cookieSchema).optional(),
  successUrl:       z.string().optional(),
  successSelector:  z.string().optional(),
  timeouts:         timeoutsSchema,
}).refine(
  (a) => Boolean(a.token && a.tokenStorageKey) || Boolean(a.localStorage) || Boolean(a.cookies?.length),
  { message: 'Token auth needs either token+tokenStorageKey, a localStorage map, or cookies' },
);

const authSchema = z.union([formAuthSchema, tokenAuthSchema]);

/* ───────────────────────── ScanOptions sub-schema ──────────────────────── */

const optionsSchema = z.object({
  axeTags:           z.array(z.string()).optional(),
  captureScreenshot: z.boolean().optional(),
  waitForSelector:   z.string().optional(),
  artifactsDir:      z.string().optional(),
  timeoutMs:         z.number().int().positive().optional(),
}).optional();

/* ────────────────────────── Top-level request ──────────────────────────── */

export const createScanSchema = z.object({
  url:     z.string().url(),
  auth:    authSchema.optional(),
  options: optionsSchema,
});

/**
 * @typedef {z.infer<typeof createScanSchema>} CreateScanInput
 */

/* ──────────────────── Site (multi-page) request ─────────────────────────── */

// A sitemap entry is a plain URL, or { url, ready } where `ready` is a per-page
// selector confirming that page loaded. Mirrors the explorer's sitemap shape.
const sitemapEntrySchema = z.union([
  z.string().url(),
  z.object({
    url:   z.string().url(),
    ready: z.string().min(1).optional(),
  }),
]);

export const createSiteScanSchema = z.object({
  urls:    z.array(sitemapEntrySchema).min(1).max(50),
  auth:    authSchema.optional(),
  options: optionsSchema,
});

/**
 * @typedef {z.infer<typeof createSiteScanSchema>} CreateSiteScanInput
 */
