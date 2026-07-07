/**
 * Centralised pino logger.
 *
 * One logger instance shared across the app. HTTP requests use pino-http
 * middleware which is wired up separately (see src/index.js) and inherits
 * this config.
 *
 * In development, pretty-printing makes the output readable in a terminal.
 * In production, structured JSON is what log aggregators expect.
 */

import pino from 'pino';
import { config } from './config.js';

/** @type {pino.LoggerOptions} */
const baseOptions = {
  level: config.logLevel,
  // Sanitise any incidental secrets that might land in log lines.
  // pino-http already redacts request headers; this catches body fields.
  redact: {
    paths: [
      'req.headers["x-api-key"]',
      'auth.fields["input[type=\\"password\\"]"]',
      'auth.token',
      'auth.cookies[*].value',
      '*.password',
    ],
    censor: '[REDACTED]',
  },
};

export const logger = config.prettyLogs
  ? pino({
      ...baseOptions,
      transport: {
        target:  'pino-pretty',
        options: {
          translateTime: 'HH:MM:ss',
          ignore:        'pid,hostname',
        },
      },
    })
  : pino(baseOptions);
