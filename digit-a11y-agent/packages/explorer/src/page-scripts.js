/**
 * Browser-side functions. These run INSIDE the page via `page.evaluate(fn)`,
 * so they must be fully self-contained (no imports, no closures over module
 * scope). Everything each one needs is defined inside it.
 *
 * Two functions:
 *   collectInPage() — find clickable elements, collapse to the OUTERMOST
 *     clickable (cursor:pointer is inherited, so a card's nested pieces would
 *     otherwise each look clickable), stamp each with data-spike-id, and return
 *     { id, sig (structure-only signature), text, name (accessible name) }.
 *   probeState()  — a cheap fingerprint of the current page state plus the node
 *     count and whether a dialog is open, used to decide "did something open?"
 *     and to dedup identical states across the whole crawl.
 */

export function collectInPage() {
  function classify(el) {
    var tag = el.tagName.toLowerCase();
    var role = el.getAttribute('role');
    if (tag === 'a' || tag === 'button' || role === 'button' || role === 'link' || el.hasAttribute('onclick')) return 'intrinsic';
    var cursor = '';
    try { cursor = getComputedStyle(el).cursor; } catch (e) {}
    if (cursor === 'pointer') return 'pointer';
    return null;
  }
  function signature(el) {
    var parts = [];
    var node = el, depth = 0;
    while (node && node !== document.body && depth < 6) {
      var tag = node.tagName.toLowerCase();
      var cls = '';
      if (node.className && typeof node.className === 'string') {
        cls = '.' + node.className.trim().split(/\s+/).filter(Boolean).slice(0, 2).join('.');
      }
      parts.unshift(tag + cls);
      node = node.parentElement; depth++;
    }
    return parts.join('>'); // structure only — text is data, not identity
  }
  function accName(el) {
    return ((el.getAttribute('aria-label') || '') + ' ' + (el.getAttribute('title') || '') + ' ' + (el.textContent || ''))
      .replace(/\s+/g, ' ').trim().slice(0, 80);
  }

  var all = document.querySelectorAll('*');
  var marked = [], markedSet = new Set();
  for (var i = 0; i < all.length; i++) {
    var el = all[i];
    var kind = classify(el);
    if (!kind) continue;
    var rect = el.getBoundingClientRect();
    if (rect.width < 2 || rect.height < 2) continue;
    el.__k = kind; marked.push(el); markedSet.add(el);
  }
  // keep intrinsic always; keep pointer only if no clickable ancestor
  var kept = [];
  for (var j = 0; j < marked.length; j++) {
    var e = marked[j];
    if (e.__k === 'intrinsic') { kept.push(e); continue; }
    var anc = e.parentElement, hasAnc = false;
    while (anc && anc !== document.body) { if (markedSet.has(anc)) { hasAnc = true; break; } anc = anc.parentElement; }
    if (!hasAnc) kept.push(e);
  }
  var out = [];
  for (var k = 0; k < kept.length; k++) {
    var el2 = kept[k];
    el2.setAttribute('data-spike-id', String(k));
    out.push({
      id: k,
      sig: signature(el2),
      text: (el2.textContent || '').trim().replace(/\s+/g, ' ').slice(0, 50),
      name: accName(el2),
    });
  }
  return out;
}

export function probeState() {
  var dlg = document.querySelector('[role=dialog],[aria-modal=true],[class*="modal" i],[class*="popup" i],[class*="Modal"],[class*="Popup"]');
  var nodes = document.querySelectorAll('body *').length;
  var dlgSig = dlg ? (dlg.className + '::' + (dlg.textContent || '').trim().slice(0, 50)) : '';
  return { fp: location.href + '|n=' + nodes + '|' + dlgSig, nodes: nodes, dialog: !!dlg };
}
