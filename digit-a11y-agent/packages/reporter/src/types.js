/**
 * Canonical type definitions for the DIGIT Accessibility Scanner.
 *
 * Every package in the monorepo speaks the shapes defined here. The same JSON
 * the UI receives is what the API returns and what the PDF is templated from.
 * Do not introduce per-channel transforms — extend types here instead.
 *
 * These are pure JSDoc typedefs (no runtime code). Modern editors give you
 * autocomplete and type checking from these without a TypeScript build step.
 */

/**
 * @typedef {Object} ScanRequest
 * @property {string} url - Target URL to scan
 * @property {AuthConfig} [auth] - Optional authentication config
 * @property {ScanOptions} [options] - Optional scan tuning
 */

/**
 * @typedef {Object} AuthConfig
 * @property {'form'|'token'} type
 * @property {string} loginUrl - URL of the login page
 * @property {Record<string,string>} fields - CSS selector → value (e.g. "#username": "auditor")
 * @property {string} submitSelector - CSS selector for the submit button
 * @property {string} successSelector - CSS selector that only appears once logged in
 * @property {string} [tokenStorageKey] - localStorage key (for token-based auth)
 */

/**
 * @typedef {Object} ScanOptions
 * @property {number} [timeoutMs=30000] - Per-page timeout
 * @property {string[]} [axeTags] - Override default axe tag set
 * @property {boolean} [captureScreenshot=true]
 * @property {string} [waitForSelector] - Optional ready signal for SPA pages
 */

/**
 * @typedef {Object} AffectedUser
 * @property {string} icon - Emoji
 * @property {string} label - Plain-language group name
 */

/**
 * @typedef {Object} BoundingBox
 * @property {number} x
 * @property {number} y
 * @property {number} width
 * @property {number} height
 */

/**
 * @typedef {Object} ViolationTarget
 * @property {string} selector - CSS selector for the violating element
 * @property {BoundingBox|null} boundingBox - Pixel coords on the screenshot, or null if not visible
 */

/**
 * @typedef {Object} Standards
 * @property {string[]} wcag - WCAG SC references, e.g. "1.1.1 Non-text Content (Level A)"
 * @property {string[]} gigw - GIGW guidelines
 * @property {string[]} ada - ADA Title III references
 * @property {string[]} sesmag - SesMag sections
 */

/**
 * @typedef {'Needs Immediate Fix'|'Important'|'Can Improve'|'Minor'} SeverityLabel
 */

/**
 * @typedef {Object} RuleMessage
 * @property {string} title - Plain-language issue title
 * @property {string} whyItMatters - Why this matters, in 1-2 sentences
 * @property {string} whatYouCanDo - Actionable fix in 1-2 sentences
 * @property {string} [example] - Optional before/after snippet
 * @property {AffectedUser[]} affectedUsers - User groups impacted (1-3)
 * @property {Standards} standards - Standards mappings (WCAG/GIGW/SesMag/ADA)
 */

/**
 * @typedef {Object} FriendlyIssue
 * @property {string} ruleId - axe rule ID (e.g. "color-contrast")
 * @property {string} title
 * @property {SeverityLabel} severity
 * @property {string} icon - Severity icon
 * @property {string} whyItMatters
 * @property {string} whatYouCanDo
 * @property {string} [example]
 * @property {AffectedUser[]} affectedUsers
 * @property {ViolationTarget[]} targets
 * @property {Standards} standards
 * @property {string[]} sections - Detected page regions affected (e.g. "Navigation", "Main Content")
 */

/**
 * @typedef {'Good to go'|'Needs some improvement'|'Needs attention'|'Needs major fixes'} ScoreStatus
 */

/**
 * @typedef {Object} SeveritySummary
 * @property {number} totalIssues
 * @property {number} critical
 * @property {number} serious
 * @property {number} moderate
 * @property {number} minor
 */

/**
 * @typedef {Object} StandardScore
 * @property {number} totalRulesChecked
 * @property {number} rulesFailed
 * @property {number} rulesPassed
 * @property {number} compliancePercent - 0..100
 */

/**
 * @typedef {Object} StandardsBreakdown
 * @property {StandardScore} wcag
 * @property {StandardScore} gigw
 * @property {StandardScore} sesmag
 * @property {StandardScore} ada
 */

/**
 * @typedef {Object} ScanMetadata
 * @property {string} scanId
 * @property {string} url
 * @property {string} scannedAt - ISO 8601 timestamp
 * @property {number} durationMs
 * @property {string} axeCoreVersion
 * @property {Warning[]} [warnings] - Non-fatal scan-time concerns
 */

/**
 * @typedef {Object} Warning
 * @property {string} code - Machine-readable code, e.g. "page-may-not-be-fully-loaded"
 * @property {string} message - Human-readable explanation
 */

/**
 * @typedef {Object} FriendlyReport
 * @property {number} score - 0..100
 * @property {ScoreStatus} status
 * @property {string} summaryText - One-sentence status summary
 * @property {string} keySummary - "Top issues" phrase
 * @property {SeveritySummary} summary
 * @property {FriendlyIssue[]} startHere - Top 3 critical/serious issues to address first
 * @property {FriendlyIssue[]} issues - All issues sorted by severity
 * @property {StandardsBreakdown} standardsBreakdown
 * @property {ScanMetadata} meta
 */

/**
 * Raw scanner output before the reporter translates it.
 * @typedef {Object} RawScanResult
 * @property {AxeViolation[]} violations
 * @property {AxeViolation[]} incomplete
 * @property {string} [screenshotPath] - Path on disk to full-page screenshot
 * @property {ScanMetadata} meta
 */

/**
 * Raw axe-core violation as returned by `@axe-core/playwright`.
 * @typedef {Object} AxeViolation
 * @property {string} id - axe rule ID
 * @property {'critical'|'serious'|'moderate'|'minor'} impact
 * @property {string} description
 * @property {string} help
 * @property {string} helpUrl
 * @property {AxeNode[]} nodes
 */

/**
 * @typedef {Object} AxeNode
 * @property {string[]} target - Array of CSS selectors (1 per node)
 * @property {string} html - HTML snippet of the violating element
 * @property {BoundingBox} [_bounds] - Computed by scanner, may be null if hidden
 */

// Exported as an empty object so this module can be `import`ed for type side effects.
export {};
