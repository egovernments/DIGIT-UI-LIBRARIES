/**
 * Session capture routes — "log in for me" from the UI.
 *
 *   POST   /api/session/capture           { url }  → open a browser window
 *   GET    /api/session/capture/:id                → poll its status
 *   POST   /api/session/capture/:id/finish         → snapshot + close, returns session
 *   DELETE /api/session/capture/:id                → close without snapshotting
 *
 * The point of this route is coverage, not convenience: automated form auth
 * can only drive one shape of login, and plenty of portals don't have that
 * shape (two-step forms, OTP, SSO, captcha). A human can drive all of them.
 * So the server opens a window, the human logs in, and we keep the result.
 *
 * The captured session is returned to the calling tab and never written to
 * disk — it is a live credential, equivalent to a password that has already
 * cleared MFA.
 *
 * @see ../store/session-captures.js
 */

import { Router } from 'express';
import { z } from 'zod';
import { sessionCaptureStore } from '../store/session-captures.js';
import { validateBody } from '../middleware/validate.js';
import { ApiError, BadRequest, NotFound, Conflict, Internal } from '../errors.js';

const startCaptureSchema = z.object({
  url: z.string().url(),
});

export const sessionRouter = Router();

/** Map a store error onto the right HTTP shape. */
function toApiError(err) {
  switch (err.code) {
    case 'CAPTURE_NOT_FOUND':
      return NotFound(err.code, err.message);
    case 'CAPTURE_NOT_WAITING':
      return Conflict(err.code, err.message);
    case 'CAPTURE_EMPTY':
      // Recoverable: the window is still open, the user just isn't logged in yet.
      return BadRequest(err.code, err.message);
    case 'CAPTURE_LIMIT_REACHED':
      return Conflict(err.code, err.message);
    case 'CAPTURE_UNAVAILABLE':
      // No desktop session on this host. 501, not 500: the request was fine,
      // this deployment just can't serve it. The UI reads this code to fall
      // back to the upload path.
      return new ApiError(501, err.code, err.message);
    default:
      return Internal('CAPTURE_FAILED', err.message);
  }
}

/* ── POST /api/session/capture ───────────────────────────────────────────── */

sessionRouter.post('/capture', validateBody(startCaptureSchema), async (req, res, next) => {
  try {
    const capture = await sessionCaptureStore.start(req.body.url);
    res.status(201).json(capture);
  } catch (err) {
    next(toApiError(err));
  }
});

/* ── GET /api/session/capture/:id ────────────────────────────────────────── */

sessionRouter.get('/capture/:id', (req, res, next) => {
  const capture = sessionCaptureStore.get(req.params.id);
  if (!capture) {
    return next(NotFound('CAPTURE_NOT_FOUND',
      'No such capture. It may have finished, been cancelled, or timed out.'));
  }
  res.json(capture);
});

/* ── POST /api/session/capture/:id/finish ────────────────────────────────── */

sessionRouter.post('/capture/:id/finish', async (req, res, next) => {
  try {
    const { session, summary } = await sessionCaptureStore.finish(req.params.id);
    // Returned to the caller only. Never logged, never persisted.
    res.json({ session, summary });
  } catch (err) {
    next(toApiError(err));
  }
});

/* ── DELETE /api/session/capture/:id ─────────────────────────────────────── */

sessionRouter.delete('/capture/:id', async (req, res, next) => {
  try {
    const closed = await sessionCaptureStore.cancel(req.params.id);
    if (!closed) {
      return next(NotFound('CAPTURE_NOT_FOUND', 'No such capture.'));
    }
    res.status(204).end();
  } catch (err) {
    next(toApiError(err));
  }
});
