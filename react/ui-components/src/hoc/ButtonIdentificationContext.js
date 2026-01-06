import React, { createContext, useContext, useRef, useId, useMemo } from 'react';

/**
 * ButtonIdentificationContext
 *
 * Provides automatic, unique identification for buttons throughout the application.
 * This context enables Analytics tracking without requiring developers to manually
 * provide unique IDs for each button.
 *
 * The ID pattern generated is:
 * {screenPath}-{composerType}-{composerId}-{sectionId}-btn-{autoIndex}-{uniqueSuffix}
 *
 * Example: "employee-inbox-formcomposer-searchform-details-btn-0-r1"
 *
 */

// Context to hold identification hierarchy
const ButtonIdentificationContext = createContext(null);

/**
 * Hook to get button identification context
 * @returns {Object|null} The current button identification context
 */
export const useButtonIdentification = () => {
  return useContext(ButtonIdentificationContext);
};

/**
 * Extracts screen path from current URL
 * Removes first two segments (usually context path and user type)
 * @returns {string} Sanitized screen path
 */
const getScreenPath = () => {
  if (typeof window === 'undefined') return 'ssr';

  const screenPaths = window.location.pathname
    .split('/')
    .filter(Boolean)
    .slice(2); // Skip context path and user type (e.g., /digit-ui/employee/)

  return screenPaths.length > 0
    ? screenPaths.join('-').toLowerCase().replace(/[^a-z0-9-]/g, '-')
    : 'root';
};

/**
 * Sanitizes a string to be a valid HTML ID
 * @param {string} input - The string to sanitize
 * @returns {string} Sanitized HTML ID
 */
const sanitizeToHtmlId = (input) => {
  if (!input) return '';
  return input
    .toLowerCase()
    .replace(/[^a-z0-9-_]+/g, '-')
    .replace(/^-+|-+$/g, '')
    .replace(/-+/g, '-');
};

/**
 * ButtonIdentificationProvider
 *
 * Wraps components to provide button identification context.
 * Should be used in FormComposer, InboxSearchComposer, ViewComposer, etc.
 *
 * @param {Object} props
 * @param {string} props.composerType - Type of composer (formcomposer, inboxsearch, view, standalone)
 * @param {string} props.composerId - Unique identifier for this composer instance (formId, configId, etc.)
 * @param {string} [props.sectionId] - Optional section identifier within the composer
 * @param {React.ReactNode} props.children - Child components
 *
 * @example
 * // In FormComposer:
 * <ButtonIdentificationProvider
 *   composerType="formcomposer"
 *   composerId={props.formId || "form"}
 *   sectionId={section.headId}
 * >
 *   {children}
 * </ButtonIdentificationProvider>
 */
export const ButtonIdentificationProvider = ({
  composerType = 'standalone',
  composerId = '',
  sectionId = '',
  children
}) => {
  // Counter for auto-incrementing button indices within this context
  const buttonCounterRef = useRef(0);

  // Get parent context if nested
  const parentContext = useContext(ButtonIdentificationContext);

  // Memoize the context value to prevent unnecessary re-renders
  const contextValue = useMemo(() => ({
    // Hierarchy information
    screenPath: parentContext?.screenPath || getScreenPath(),
    composerType: sanitizeToHtmlId(composerType),
    composerId: sanitizeToHtmlId(composerId),
    sectionId: sanitizeToHtmlId(sectionId),

    // Parent context reference for nested scenarios
    parentContext,

    /**
     * Gets the next button index and increments the counter
     * @returns {number} The current button index
     */
    getNextButtonIndex: () => {
      return buttonCounterRef.current++;
    },

    /**
     * Resets the button counter (useful when section changes)
     */
    resetButtonCounter: () => {
      buttonCounterRef.current = 0;
    },

    /**
     * Gets current counter value without incrementing
     * @returns {number} Current counter value
     */
    getCurrentCount: () => buttonCounterRef.current,

  }), [composerType, composerId, sectionId, parentContext]);

  return (
    <ButtonIdentificationContext.Provider value={contextValue}>
      {children}
    </ButtonIdentificationContext.Provider>
  );
};

/**
 * SectionIdentificationProvider
 *
 * A lightweight provider specifically for sections within a composer.
 * Inherits parent composer context and adds section-specific identification.
 *
 * @param {Object} props
 * @param {string} props.sectionId - Section identifier (headId from config)
 * @param {React.ReactNode} props.children - Child components
 */
export const SectionIdentificationProvider = ({ sectionId, children }) => {
  const parentContext = useButtonIdentification();
  const buttonCounterRef = useRef(0);

  const contextValue = useMemo(() => ({
    ...parentContext,
    sectionId: sanitizeToHtmlId(sectionId),

    getNextButtonIndex: () => {
      return buttonCounterRef.current++;
    },

    resetButtonCounter: () => {
      buttonCounterRef.current = 0;
    },

    getCurrentCount: () => buttonCounterRef.current,

  }), [parentContext, sectionId]);

  return (
    <ButtonIdentificationContext.Provider value={contextValue}>
      {children}
    </ButtonIdentificationContext.Provider>
  );
};

/**
 * useButtonId Hook
 *
 * Generates a unique, stable button ID based on the current context hierarchy.
 * Should be used inside Button components to auto-generate IDs.
 *
 * @param {Object} options
 * @param {string} [options.explicitId] - If provided, uses this ID instead of generating
 * @param {string} [options.buttonType] - Type of button (submit, secondary, action, etc.)
 * @param {string} [options.buttonName] - Optional semantic name for the button
 * @returns {Object} Object containing id and data attributes for the button
 *
 * @example
 * const { id, dataAttributes } = useButtonId({ buttonType: 'submit' });
 * // Returns: {
 * //   id: "employee-inbox-formcomposer-myform-details-btn-0-r1",
 * //   dataAttributes: { 'data-screen': '...', 'data-composer': '...', ... }
 * // }
 */
export const useButtonId = ({ explicitId, buttonType = 'button', buttonName = '' } = {}) => {
  const context = useButtonIdentification();
  const reactId = useId(); // React 18+ hook for SSR-safe unique IDs

  // If explicit ID provided, use it
  if (explicitId) {
    return {
      id: explicitId,
      dataAttributes: {
        'data-button-type': buttonType,
        'data-button-name': buttonName || undefined,
        'data-explicit-id': 'true',
      }
    };
  }

  // Generate ID based on context
  const screenPath = context?.screenPath || getScreenPath();
  const composerType = context?.composerType || 'standalone';
  const composerId = context?.composerId || '';
  const sectionId = context?.sectionId || '';
  const buttonIndex = context?.getNextButtonIndex?.() ?? 0;

  // Extract unique suffix from React's useId (e.g., ":r1:" -> "r1")
  const uniqueSuffix = reactId.replace(/:/g, '');

  // Build the ID parts array, filtering out empty values
  const idParts = [
    screenPath,
    composerType,
    composerId,
    sectionId,
    buttonName ? sanitizeToHtmlId(buttonName) : '',
    'btn',
    buttonIndex.toString(),
    uniqueSuffix
  ].filter(Boolean);

  const generatedId = idParts.join('-');

  return {
    id: generatedId,
    dataAttributes: {
      'data-screen': screenPath,
      'data-composer-type': composerType,
      'data-composer-id': composerId || undefined,
      'data-section-id': sectionId || undefined,
      'data-button-type': buttonType,
      'data-button-name': buttonName || undefined,
      'data-button-index': buttonIndex.toString(),
    }
  };
};

/**
 * generateButtonId Utility Function
 *
 * Standalone utility for generating button IDs outside of React components.
 * Useful for class components or non-hook scenarios.
 *
 * @param {Object} options
 * @param {string} [options.screenPath] - Screen path (auto-detected if not provided)
 * @param {string} [options.composerType] - Type of composer
 * @param {string} [options.composerId] - Composer identifier
 * @param {string} [options.sectionId] - Section identifier
 * @param {string} [options.buttonName] - Semantic button name
 * @param {number} [options.buttonIndex] - Button index (defaults to timestamp-based unique value)
 * @returns {string} Generated button ID
 */
export const generateButtonId = ({
  screenPath,
  composerType = 'standalone',
  composerId = '',
  sectionId = '',
  buttonName = '',
  buttonIndex
} = {}) => {
  const screen = screenPath || getScreenPath();
  const index = buttonIndex ?? Date.now() % 10000; // Fallback to timestamp-based index
  const uniqueSuffix = Math.random().toString(36).substring(2, 6);

  const idParts = [
    sanitizeToHtmlId(screen),
    sanitizeToHtmlId(composerType),
    sanitizeToHtmlId(composerId),
    sanitizeToHtmlId(sectionId),
    sanitizeToHtmlId(buttonName),
    'btn',
    index.toString(),
    uniqueSuffix
  ].filter(Boolean);

  return idParts.join('-');
};

export default ButtonIdentificationContext;
