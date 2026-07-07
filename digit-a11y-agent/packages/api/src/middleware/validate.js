/**
 * zod request-body validation middleware.
 *
 * Usage:
 *   router.post('/scan', validateBody(createScanSchema), handler);
 *
 * On success, replaces req.body with the parsed (and type-coerced) value
 * so downstream handlers can rely on the schema-defined shape.
 *
 * On failure, throws a 400 ApiError with the zod issues attached as
 * `details.issues` for client-side debugging.
 */

import { BadRequest } from '../errors.js';

/**
 * @param {import('zod').ZodSchema} schema
 */
export function validateBody(schema) {
  return (req, _res, next) => {
    const result = schema.safeParse(req.body);
    if (!result.success) {
      return next(BadRequest(
        'INVALID_REQUEST_BODY',
        'Request body did not match the expected schema.',
        { issues: result.error.issues },
      ));
    }
    req.body = result.data;
    return next();
  };
}
