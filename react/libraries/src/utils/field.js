/*
 * SINGLE SOURCE OF TRUTH for unique ID generation.
 * Used for tracking all UI elements: buttons, inputs, dropdowns, textareas, etc.
 *
 * @author jagankumar-egov
 *
 * IMPORTANT: IDs are DETERMINISTIC - same inputs always produce same output.
 * This ensures IDs remain stable across:
 * - Page refreshes
 * - Logout/login
 * - Browser restarts
 *
 * Used by:
 * - react-components (Button, SubmitBar, ButtonSelector, inputs, etc.)
 * - ui-components (Button, SubmitBar, ButtonSelector, inputs, etc.)
 *
 * @example
 * // With name (RECOMMENDED - fully deterministic):
 * Digit.Utils.generateUniqueId({ name: "submit-btn", type: "btn" })
 * // → "works-inbox-standalone-submit-btn-btn"  (ALWAYS same on this screen)
 *
 * // Without name (uses counter - less stable):
 * Digit.Utils.generateUniqueId({ type: "btn" })
 * // → "works-inbox-standalone-btn-1"
 */

// Counter for elements without explicit names (fallback only)
let globalIdCounter = 0;

/**
 * MAIN FUNCTION - Generates unique ID for any UI element.
 *
 * IMPORTANT: For stable IDs across page loads, ALWAYS provide a `name`.
 * IDs without names use a counter which may change based on render order.
 *
 * @param {Object} options - Configuration options
 * @param {string} [options.screenPath] - Screen path (auto-detected from URL if not provided)
 * @param {string} [options.composerType] - "formcomposer", "inboxsearchcomposer", "standalone"
 * @param {string} [options.composerId] - Form ID, module name, config ID, etc.
 * @param {string} [options.sectionId] - Section ID within composer (headId from config)
 * @param {string} [options.name] - Semantic name for the element (REQUIRED for stable IDs)
 * @param {string} [options.type] - Element type: "btn", "input", "dropdown", "textarea", etc.
 * @param {string} [options.id] - Explicit ID (if provided, returns this directly)
 * @returns {string} Unique, sanitized HTML ID
 */
export const generateUniqueId = ({
  screenPath = "",
  composerType = "standalone",
  composerId = "",
  sectionId = "",
  name = "",
  type = "field",
  id = ""
} = {}) => {
  // If explicit ID provided, use it directly
  if (id) {
    return id;
  }

  // Get screen path from URL if not provided
  const screen = screenPath || getScreenPrefix();

  // Build ID parts array
  const idParts = [
    sanitizeToHtmlId(screen),
    sanitizeToHtmlId(composerType),
    sanitizeToHtmlId(composerId),
    sanitizeToHtmlId(sectionId),
    sanitizeToHtmlId(name),
    type
  ].filter(part => part && part !== "");

  // If no name provided, add counter as fallback for uniqueness
  // WARNING: Counter-based IDs may not be stable across page loads
  if (!name) {
    idParts.push((++globalIdCounter).toString());
  }

  return idParts.join("-");
};

/**
 * SIMPLE FUNCTION - For backward compatibility.
 *
 * @param {string} fieldName - Semantic name (REQUIRED for stable IDs)
 * @param {string} fieldId - Explicit ID (overrides if provided)
 * @param {string} screenPrefix - Custom screen prefix
 * @returns {string} Unique ID
 */
export const getFieldIdName = (fieldName = "", fieldId = "", screenPrefix = "") => {
  return generateUniqueId({
    screenPath: screenPrefix,
    name: fieldName,
    type: "field",
    id: fieldId
  });
};

/**
 * Derives screen path from current URL.
 * This is DETERMINISTIC - same URL always gives same prefix.
 *
 * @param {string} prefix - Custom prefix (optional)
 * @returns {string} Screen path
 *
 * @example
 * // URL: /digit-ui/employee/works/inbox
 * getScreenPrefix() // → "works-inbox"
 */
export const getScreenPrefix = (prefix = "") => {
  if (prefix) return prefix;

  if (typeof window === "undefined") return "ssr";

  const screenPaths = window.location.pathname
    .split("/")
    .filter(Boolean)
    .slice(2);

  return screenPaths.length > 0
    ? screenPaths.join("-").toLowerCase()
    : "root";
};

/**
 * Sanitizes string to valid HTML ID.
 * DETERMINISTIC - same input always gives same output.
 *
 * @param {string} input - String to sanitize
 * @returns {string} Valid HTML ID
 */
export const sanitizeToHtmlId = (input) => {
  if (!input) return "";

  return input
    .toLowerCase()
    .replace(/[^a-z0-9-_]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .replace(/-+/g, "-");
};

/**
 * Resets global counter. Use for testing.
 */
export const resetFieldIdCounter = () => {
  globalIdCounter = 0;
};

/**
 * Gets current counter value (for debugging).
 * @returns {number}
 */
export const getFieldIdCounter = () => globalIdCounter;

/**
 * @deprecated Use generateUniqueId instead.
 */
export const generateUniqueString = (length = 10) => {
  const characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  let result = "";
  for (let i = 0; i < length; i++) {
    result += characters.charAt(Math.floor(Math.random() * characters.length));
  }
  return result;
};

// Alias for backward compatibility
export const generateElementId = generateUniqueId;
