/**
 * API key authentication middleware.
 *
 * Checks the `x-api-key` header on every request that mounts this middleware.
 * Disabled when config.apiKeyEnabled is false (development default).
 *
 * Returns 401 with a stable error code on mismatch. Doesn't leak whether the
 * key was present-but-wrong vs absent — same response either way.
 */

import { config } from '../config.js';
import { Unauthorized } from '../errors.js';

export function apiKeyMiddleware(req, _res, next) {
  if (!config.apiKeyEnabled) return next();

  const provided = req.header('x-api-key');
  if (!provided || provided !== config.apiKey) {
    return next(Unauthorized(
      'API_KEY_INVALID',
      'Missing or invalid x-api-key header.',
    ));
  }
  return next();
}
