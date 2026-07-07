/**
 * GET /api/health
 *
 * Liveness + lightweight readiness check. Returns 200 always (the server is
 * running if it can answer) with stats about jobs in flight.
 *
 * Doesn't require an API key — health is fine to expose openly so external
 * monitors (UptimeRobot, etc.) can hit it.
 */

import { Router } from 'express';
import { jobStore } from '../store/jobs.js';

const startedAt = Date.now();

// Read once at module load — assumes the API process matches the package.json
// it was bundled with. Good enough for Phase 1.
const VERSION = '0.1.0';

export const healthRouter = Router();

healthRouter.get('/', (_req, res) => {
  /** @type {import('../types.js').HealthResponse} */
  const body = {
    status:        'ok',
    version:       VERSION,
    uptimeSeconds: Math.floor((Date.now() - startedAt) / 1000),
    nodeVersion:   process.version,
    jobs:          jobStore.stats(),
  };
  res.json(body);
});
