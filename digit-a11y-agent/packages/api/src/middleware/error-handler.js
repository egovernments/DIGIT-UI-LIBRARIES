/**
 * Central error-handling middleware.
 *
 * MUST be registered last in the Express middleware chain (after all routes).
 * Express identifies error handlers by their 4-argument signature.
 *
 * Behaviour:
 *   - ApiError instances → use their statusCode / code / message / details
 *   - Anything else → 500 INTERNAL_ERROR with a generic message
 *                     (the original is logged but never leaked to clients)
 *
 * pino-http logs the request automatically; we just emit an `error` event so
 * the structured log captures the full stack and any extra context.
 */

import { ApiError } from '../errors.js';
import { logger } from '../logger.js';

// eslint-disable-next-line no-unused-vars
export function errorHandler(err, req, res, _next) {
  if (err instanceof ApiError) {
    logger.warn(
      { code: err.code, statusCode: err.statusCode, path: req.path, details: err.details },
      err.message,
    );
    return res.status(err.statusCode).json({
      code:    err.code,
      message: err.message,
      ...(err.details ? { details: err.details } : {}),
    });
  }

  // Unexpected error. Log the full thing for debugging; respond generically.
  logger.error(
    { err, path: req.path, method: req.method },
    'Unhandled error in route handler',
  );
  return res.status(500).json({
    code:    'INTERNAL_ERROR',
    message: 'An unexpected error occurred. Please try again or contact support.',
  });
}
