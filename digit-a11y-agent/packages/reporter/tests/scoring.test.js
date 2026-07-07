import { describe, it, expect } from 'vitest';
import { computeScore } from '../src/scoring.js';

const counts = (critical = 0, serious = 0, moderate = 0, minor = 0) => ({
  critical, serious, moderate, minor,
});

describe('scoring.js — computeScore()', () => {
  describe('score', () => {
    it('returns 100 when there are no violations', () => {
      const { score } = computeScore(counts());
      expect(score).toBe(100);
    });

    it('deducts 10 per critical issue', () => {
      expect(computeScore(counts(1)).score).toBe(90);
      expect(computeScore(counts(2)).score).toBe(80);
      expect(computeScore(counts(3)).score).toBe(70);
    });

    it('deducts 7 per serious issue', () => {
      expect(computeScore(counts(0, 1)).score).toBe(93);
      expect(computeScore(counts(0, 2)).score).toBe(86);
    });

    it('deducts 4 per moderate issue', () => {
      expect(computeScore(counts(0, 0, 1)).score).toBe(96);
      expect(computeScore(counts(0, 0, 5)).score).toBe(80);
    });

    it('deducts 1 per minor issue', () => {
      expect(computeScore(counts(0, 0, 0, 5)).score).toBe(95);
    });

    it('caps the per-severity penalty at 30', () => {
      // 10 critical issues would be -100 uncapped; cap brings it to -30
      const { score } = computeScore(counts(10));
      expect(score).toBe(70);
    });

    it('combines penalties across severity tiers', () => {
      // 2 critical (-20) + 1 serious (-7) + 1 moderate (-4) = -31, score = 69
      const { score } = computeScore(counts(2, 1, 1, 0));
      expect(score).toBe(69);
    });

    it('clamps at 0 (never goes negative)', () => {
      // Even with extreme counts, score stays >= 0
      const { score } = computeScore(counts(100, 100, 100, 100));
      expect(score).toBeGreaterThanOrEqual(0);
      expect(score).toBe(0);
    });
  });

  describe('status', () => {
    it('returns "Good to go" for scores 90-100', () => {
      expect(computeScore(counts()).status).toBe('Good to go');
      expect(computeScore(counts(1)).status).toBe('Good to go');  // 90
    });

    it('returns "Needs some improvement" for scores 70-89', () => {
      expect(computeScore(counts(2)).status).toBe('Needs some improvement');  // 80
      expect(computeScore(counts(3)).status).toBe('Needs some improvement');  // 70
    });

    it('returns "Needs attention" for scores 50-69', () => {
      // critical(2) + serious(1) = 20 + 7 = 27, score 73 — too high. Need more.
      // critical(3) + serious(2) = 30 (capped) + 14 = 44, score 56
      expect(computeScore(counts(3, 2)).status).toBe('Needs attention');
    });

    it('returns "Needs major fixes" for scores 0-49', () => {
      // critical(5) + serious(5) = 30 (capped) + 30 (capped) = 60, score 40
      expect(computeScore(counts(5, 5)).status).toBe('Needs major fixes');
    });
  });

  describe('summaryText', () => {
    it('celebrates a perfect page', () => {
      const { summaryText } = computeScore(counts());
      expect(summaryText).toMatch(/no accessibility issues were found/i);
    });

    it('leads with critical issues when present', () => {
      const { summaryText } = computeScore(counts(2, 1, 1, 0));
      expect(summaryText).toMatch(/2 critical/i);
      expect(summaryText).toMatch(/block some users/i);
    });

    it('mentions important issues when no critical but serious present', () => {
      const { summaryText } = computeScore(counts(0, 3, 1, 0));
      expect(summaryText).toMatch(/important issues/i);
    });

    it('uses singular grammar when count is 1', () => {
      const { summaryText } = computeScore(counts(1, 0, 0, 0));
      expect(summaryText).toMatch(/1 critical issue/i);
      expect(summaryText).not.toMatch(/1 critical issues/i);
    });
  });
});
