import { describe, it, expect, vi } from 'vitest';
import { computeBoundingBoxes } from '../src/bbox.js';

/**
 * Mock page that returns pre-canned bounding boxes for each selector
 * passed to evaluate(). Lets us test the orchestration logic without
 * launching a real browser.
 */
function mockPage(bboxMap) {
  return {
    evaluate: vi.fn().mockImplementation((fn, selectors) => {
      return selectors.map((sel) => bboxMap[sel] ?? null);
    }),
  };
}

describe('computeBoundingBoxes()', () => {
  it('returns zero counts when given no violations', async () => {
    const page = mockPage({});
    const result = await computeBoundingBoxes(page, []);
    expect(result).toEqual({ computed: 0, missing: 0 });
    expect(page.evaluate).not.toHaveBeenCalled();  // no work to batch
  });

  it('attaches _bounds to each node when selectors resolve', async () => {
    const violations = [
      { nodes: [{ target: ['#a'] }, { target: ['#b'] }] },
      { nodes: [{ target: ['#c'] }] },
    ];
    const page = mockPage({
      '#a': { x: 10, y: 20, width: 100, height: 50 },
      '#b': { x: 30, y: 40, width: 80,  height: 40 },
      '#c': { x: 0,  y: 0,  width: 200, height: 60 },
    });

    const result = await computeBoundingBoxes(page, violations);

    expect(result).toEqual({ computed: 3, missing: 0 });
    expect(violations[0].nodes[0]._bounds).toEqual({ x: 10, y: 20, width: 100, height: 50 });
    expect(violations[0].nodes[1]._bounds).toEqual({ x: 30, y: 40, width: 80,  height: 40 });
    expect(violations[1].nodes[0]._bounds).toEqual({ x: 0,  y: 0,  width: 200, height: 60 });
  });

  it('records null _bounds when an element is missing from the DOM', async () => {
    const violations = [{ nodes: [{ target: ['#gone'] }] }];
    const page = mockPage({ '#gone': null });

    const result = await computeBoundingBoxes(page, violations);

    expect(result).toEqual({ computed: 0, missing: 1 });
    expect(violations[0].nodes[0]._bounds).toBeNull();
  });

  it('handles a missing target field gracefully', async () => {
    const violations = [
      { nodes: [{ /* no target field */ }] },
      { nodes: [{ target: [] /* empty array */ }] },
      { nodes: [{ target: ['#real'] }] },
    ];
    const page = mockPage({ '#real': { x: 1, y: 2, width: 3, height: 4 } });

    const result = await computeBoundingBoxes(page, violations);

    expect(result).toEqual({ computed: 1, missing: 2 });
    expect(violations[0].nodes[0]._bounds).toBeNull();
    expect(violations[1].nodes[0]._bounds).toBeNull();
    expect(violations[2].nodes[0]._bounds).toEqual({ x: 1, y: 2, width: 3, height: 4 });
  });

  it('batches all selectors into a single page.evaluate call (perf)', async () => {
    const violations = [
      { nodes: [{ target: ['#a'] }, { target: ['#b'] }, { target: ['#c'] }] },
      { nodes: [{ target: ['#d'] }] },
    ];
    const page = mockPage({
      '#a': { x: 0, y: 0, width: 1, height: 1 },
      '#b': { x: 0, y: 0, width: 1, height: 1 },
      '#c': { x: 0, y: 0, width: 1, height: 1 },
      '#d': { x: 0, y: 0, width: 1, height: 1 },
    });

    await computeBoundingBoxes(page, violations);

    // Critical perf property: one evaluate call total, not one per element.
    expect(page.evaluate).toHaveBeenCalledTimes(1);
  });

  it('does not call evaluate at all when no nodes have usable selectors', async () => {
    const violations = [{ nodes: [{ /* no target */ }, { target: [] }] }];
    const page = mockPage({});

    const result = await computeBoundingBoxes(page, violations);

    expect(result).toEqual({ computed: 0, missing: 2 });
    expect(page.evaluate).not.toHaveBeenCalled();
  });
});
