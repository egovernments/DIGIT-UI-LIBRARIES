/**
 * Custom error classes for the API layer.
 *
 * Every error thrown intentionally inside route handlers should be an
 * ApiError so the central error middleware can serialise it consistently.
 * Anything else (TypeError, etc.) is treated as a bug and surfaces as a
 * 500 with a generic message.
 */

export class ApiError extends Error {
  /**
   * @param {number} statusCode
   * @param {string} code - SCREAMING_SNAKE machine identifier
   * @param {string} message - Human-readable explanation
   * @param {object} [details]
   */
  constructor(statusCode, code, message, details) {
    super(message);
    this.name        = 'ApiError';
    this.statusCode  = statusCode;
    this.code        = code;
    this.details     = details;
  }
}

/* Convenience constructors so call sites stay short. */
export const BadRequest   = (code, msg, details) => new ApiError(400, code, msg, details);
export const Unauthorized = (code, msg)          => new ApiError(401, code, msg);
export const NotFound     = (code, msg)          => new ApiError(404, code, msg);
export const Conflict     = (code, msg)          => new ApiError(409, code, msg);
export const Internal     = (code, msg, details) => new ApiError(500, code, msg, details);
