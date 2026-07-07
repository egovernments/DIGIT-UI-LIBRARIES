/**
 * Bounding box computation.
 *
 * For each violating element axe-core reports, we compute its position and
 * size in **document coordinates** (top-left of full page, not viewport).
 * These coordinates live in the same coordinate space as the full-page
 * screenshot, so the UI can render a red highlight rectangle on top of the
 * screenshot with no further math.
 *
 * Mutates the violation array in-place — adds a `_bounds` field to each
 * node. We use `_bounds` (underscore-prefixed) because it's our own
 * augmentation; everything else under `node` is axe-core's own data.
 *
 * Edge cases handled:
 *   - Element no longer exists in the DOM (page mutated post-scan)     → null
 *   - Element is `display: none` or zero-size                          → bounds with width:0, height:0
 *   - querySelector throws on invalid selectors (axe occasionally emits these) → null
 *   - Selector matches multiple elements                               → first match wins
 *
 * @see ./screenshot.js
 */

/**
 * @typedef {Object} BoundingBox
 * @property {number} x
 * @property {number} y
 * @property {number} width
 * @property {number} height
 */

/**
 * Compute and attach bounding boxes to every node in every violation.
 *
 * @param {import('playwright').Page} page
 * @param {Array} violations - Mutated in place; each `node._bounds` set to a BoundingBox or null
 * @returns {Promise<{computed: number, missing: number}>} - Counts for diagnostics/warnings
 */
export async function computeBoundingBoxes(page, violations) {
  let computed = 0;
  let missing  = 0;

  // Collect all selectors first so we can do a single page.evaluate call.
  // Iterating with individual evaluate calls works but is 10–20× slower on
  // pages with many violations (each call has a ~5ms IPC overhead).
  const tasks = [];
  for (const violation of violations) {
    for (const node of violation.nodes ?? []) {
      const selector = node.target?.[0];
      if (!selector) {
        node._bounds = null;
        missing++;
        continue;
      }
      tasks.push({ node, selector });
    }
  }

  if (tasks.length === 0) {
    return { computed: 0, missing };
  }

  // One batched evaluate that resolves every selector and returns coords.
  const selectors = tasks.map((t) => t.selector);
  const results = await page.evaluate((sels) => {
    return sels.map((sel) => {
      try {
        const el = document.querySelector(sel);
        if (!el) return null;
        const rect = el.getBoundingClientRect();
        // Convert viewport coordinates → document coordinates.
        return {
          x:      Math.round(rect.left + window.scrollX),
          y:      Math.round(rect.top  + window.scrollY),
          width:  Math.round(rect.width),
          height: Math.round(rect.height),
        };
      } catch {
        // querySelector throws on invalid CSS (e.g. some pseudo-element selectors)
        return null;
      }
    });
  }, selectors);

  // Stitch results back onto the nodes.
  for (let i = 0; i < tasks.length; i++) {
    const bbox = results[i];
    tasks[i].node._bounds = bbox;
    if (bbox) computed++;
    else      missing++;
  }

  return { computed, missing };
}
