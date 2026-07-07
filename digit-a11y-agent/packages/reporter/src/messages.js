/**
 * Human-friendly messages for axe-core rule IDs.
 * Each entry provides plain-language context for non-technical users.
 * Falls back to a generic message for unknown rules.
 *
 * ─────────────────────────────────────────────────────────────────────────────
 * COVERAGE (axe-core 4.11.x)
 *
 *   WCAG 2.0 Level A & AA  ........  59 rules
 *   WCAG 2.1 Level A & AA  ........   2 rules
 *   Best-practice         ........  28 rules
 *   Legacy entries         ........   1 (focus-trap — not a real axe rule,
 *                                       kept for backward compatibility)
 *   ─────────────────────────────────
 *   TOTAL                  ........  90 entries
 *
 * Excluded by design:
 *   • WCAG 2.2 rules           — handled in a separate mapping pass (Phase 2)
 *   • WCAG 2.x AAA rules       — disabled by default in axe-core
 *   • Experimental rules       — disabled by default in axe-core
 *   • Deprecated rules         — disabled by default in axe-core
 *
 * ─────────────────────────────────────────────────────────────────────────────
 * STANDARDS NOTES — please read before reviewing
 *
 *   wcag:   Always cited from the official W3C SC list. Format:
 *           "X.Y.Z Name (Level A|AA)".
 *
 *   ada:    The ADA does not publish per-rule technical criteria. We use
 *           Title III catch-all phrases to flag whichever public-accommodation
 *           obligation applies most cleanly:
 *             • "Title III – Effective Communication"     (content / text)
 *             • "Title III – Accessible Design Standards" (structure / UX)
 *
 *   gigw:   The numbering scheme used here ("3.x", "4.x", "5.x") follows the
 *           pattern established by the existing 13 entries. It is INDICATIVE
 *           and groups rules by theme; it does NOT correspond 1:1 to the
 *           official GIGW v3.0 document. ⚠ HUMAN REVIEW REQUIRED to map
 *           against authoritative GIGW source. Empty array = no clean fit.
 *
 *   sesmag: Uses POUR-aligned section labels:
 *             • Section 2 – Perceivability
 *             • Section 3 – Operability
 *             • Section 4 – Understandability
 *             • Section 5 – Robustness
 *           ⚠ Verify against authoritative SesMag document.
 *
 * @see ./types.js for the canonical RuleMessage typedef (used by editor type-checking).
 * ─────────────────────────────────────────────────────────────────────────────
 */

// ─── Reusable user groups ────────────────────────────────────────────────────

const U = {
  screenReader:  { icon: '👁',  label: 'Screen reader users' },
  lowVision:     { icon: '🎨',  label: 'Low vision users' },
  keyboard:      { icon: '⌨️',  label: 'Keyboard-only users' },
  cognitive:     { icon: '🧠',  label: 'Users with cognitive disabilities' },
  motor:         { icon: '🖐',  label: 'Users with motor disabilities' },
  nonNative:     { icon: '🌐',  label: 'Non-native language speakers' },
  deaf:          { icon: '🔇',  label: 'Deaf or hard-of-hearing users' },
  photosensitive:{ icon: '⚡',  label: 'Users with photosensitivity' },
  voiceControl:  { icon: '🎙',  label: 'Voice-control users' },
};

// ─── Rule map ────────────────────────────────────────────────────────────────

export const ruleMessages = {

  // ─────────────────────────────────────────────────────────────────────────
  // 1. IMAGES & MEDIA
  // ─────────────────────────────────────────────────────────────────────────

  'image-alt': {
    title: 'Images are missing descriptions',
    whyItMatters:
      'People using screen readers cannot tell what an image shows if it has no description. This makes images invisible to blind users.',
    whatYouCanDo:
      'Add an alt attribute to every image that conveys information. For decorative images, use alt="".',
    example: 'Before: <img src="chart.png" />\nAfter:  <img src="chart.png" alt="Bar chart showing sales growth from 2020 to 2024" />',
    affectedUsers: [U.screenReader, U.lowVision],
    standards: {
      wcag:   ['1.1.1 Non-text Content (Level A)'],
      gigw:   ['3.1 – Provide text alternatives for all non-text content'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'input-image-alt': {
    title: 'Image buttons are missing descriptions',
    whyItMatters:
      'An image used as a form submit button must describe its action, otherwise screen reader users do not know what the button does.',
    whatYouCanDo:
      'Add an alt attribute describing the action to any <input type="image"> element.',
    example: 'Before: <input type="image" src="submit.png" />\nAfter:  <input type="image" src="submit.png" alt="Submit application" />',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.1.1 Non-text Content (Level A)'],
      gigw:   ['3.1 – Provide text alternatives for all non-text content'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'area-alt': {
    title: 'Image map areas have no description',
    whyItMatters:
      'When an image is split into clickable regions, each region needs a text description. Without it, screen reader users cannot tell what each clickable area does.',
    whatYouCanDo:
      'Add an alt attribute to every <area> element inside an image map.',
    example: 'Before: <area shape="rect" coords="0,0,100,100" href="/home" />\nAfter:  <area shape="rect" coords="0,0,100,100" href="/home" alt="Home page" />',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.1.1 Non-text Content (Level A)', '2.4.4 Link Purpose (In Context) (Level A)'],
      gigw:   ['3.1 – Provide text alternatives for all non-text content'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'object-alt': {
    title: 'Embedded objects have no description',
    whyItMatters:
      'Embedded content like Flash, PDFs, or other plug-in objects need a text alternative so screen reader users know what they contain.',
    whatYouCanDo:
      'Add fallback text inside the <object> tag, or a title/aria-label that describes the embedded content.',
    example: 'Before: <object data="report.pdf"></object>\nAfter:  <object data="report.pdf" title="Annual report 2024">Annual report 2024</object>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.1.1 Non-text Content (Level A)'],
      gigw:   ['3.1 – Provide text alternatives for all non-text content'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'role-img-alt': {
    title: 'Elements marked as images have no description',
    whyItMatters:
      'Any element with role="img" is announced as an image by screen readers. Without an accessible name, users hear "image" with no idea what it shows.',
    whatYouCanDo:
      'Add an aria-label or aria-labelledby to any element with role="img".',
    example: 'Before: <div role="img"></div>\nAfter:  <div role="img" aria-label="Government emblem"></div>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.1.1 Non-text Content (Level A)'],
      gigw:   ['3.1 – Provide text alternatives for all non-text content'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'svg-img-alt': {
    title: 'SVG graphics are missing descriptions',
    whyItMatters:
      'SVG icons and graphics that convey meaning must have a text alternative. Otherwise, screen readers either skip them or read raw shape data.',
    whatYouCanDo:
      'Add a <title> child element inside the SVG, or use aria-label on the SVG itself.',
    example: 'Before: <svg role="img"><path .../></svg>\nAfter:  <svg role="img" aria-label="Download"><path .../></svg>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.1.1 Non-text Content (Level A)'],
      gigw:   ['3.1 – Provide text alternatives for all non-text content'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'image-redundant-alt': {
    title: 'Image description repeats nearby text',
    whyItMatters:
      'When the alt text matches the visible caption or surrounding text, screen reader users hear the same content twice.',
    whatYouCanDo:
      'Either remove the repeated alt text (use alt="") or rewrite it so it adds new information that the surrounding text does not already convey.',
    example: 'Before: <a href="/news"><img alt="Read news" /> Read news</a>\nAfter:  <a href="/news"><img alt="" /> Read news</a>',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   [],
      gigw:   ['3.1 – Provide text alternatives for all non-text content'],
      ada:    [],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'video-caption': {
    title: 'Videos are missing captions',
    whyItMatters:
      'Without captions, deaf and hard-of-hearing users cannot follow the spoken content of a video. Captions also help anyone watching in a noisy environment or learning the language.',
    whatYouCanDo:
      'Add a <track kind="captions"> element with a synchronised caption file (WebVTT) inside every <video> tag that has audio.',
    example: 'After: <video src="speech.mp4">\n  <track kind="captions" src="speech.vtt" srclang="en" label="English" />\n</video>',
    affectedUsers: [U.deaf, U.cognitive, U.nonNative],
    standards: {
      wcag:   ['1.2.2 Captions (Prerecorded) (Level A)'],
      gigw:   ['3.1 – Provide text alternatives for all non-text content'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'no-autoplay-audio': {
    title: 'Audio starts playing automatically',
    whyItMatters:
      'When audio plays without warning, it interferes with screen reader speech and can be disorienting for users with cognitive disabilities or anyone in a quiet space.',
    whatYouCanDo:
      'Stop autoplay, or limit it to under 3 seconds, or provide a clearly visible mute/pause control on the page.',
    example: 'Before: <audio src="welcome.mp3" autoplay></audio>\nAfter:  <audio src="welcome.mp3" controls></audio>',
    affectedUsers: [U.screenReader, U.cognitive, U.deaf],
    standards: {
      wcag:   ['1.4.2 Audio Control (Level A)'],
      gigw:   [],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 2. COLOUR & CONTRAST
  // ─────────────────────────────────────────────────────────────────────────

  'color-contrast': {
    title: 'Text is difficult to read (low contrast)',
    whyItMatters:
      'When text and background colours are too similar, people with low vision or colour blindness struggle to read the content.',
    whatYouCanDo:
      'Increase the contrast between text and background. Normal text needs a ratio of at least 4.5:1. Use a contrast checker tool to verify.',
    example: 'Before: grey text (#aaa) on white — ratio 2.3:1\nAfter:  dark grey text (#595959) on white — ratio 7:1',
    affectedUsers: [U.lowVision],
    standards: {
      wcag:   ['1.4.3 Contrast (Minimum) (Level AA)', '1.4.6 Contrast (Enhanced) (Level AAA)'],
      gigw:   ['3.3 – Ensure sufficient colour contrast for all text'],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'link-in-text-block': {
    title: 'Links rely on colour alone to stand out',
    whyItMatters:
      'If a link inside a paragraph differs from surrounding text only by colour, users who cannot perceive that colour difference will miss the link.',
    whatYouCanDo:
      'Make links visually distinct in another way — usually by underlining them — or ensure the colour contrast between link and surrounding text is at least 3:1 AND a non-colour cue appears on hover/focus.',
    example: 'Before: a { color: #1976d2; text-decoration: none; }\nAfter:  a { color: #1976d2; text-decoration: underline; }',
    affectedUsers: [U.lowVision],
    standards: {
      wcag:   ['1.4.1 Use of Color (Level A)'],
      gigw:   ['3.3 – Ensure sufficient colour contrast for all text'],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 3. FORMS
  // ─────────────────────────────────────────────────────────────────────────

  'label': {
    title: 'Form fields are missing labels',
    whyItMatters:
      'Screen readers read out the label when a user focuses on a form field. Without a label, users do not know what to type.',
    whatYouCanDo:
      'Add a <label> element linked to each input using the for attribute, or use aria-label directly on the input.',
    example: 'Before: <input type="text" placeholder="Email" />\nAfter:  <label for="email">Email address</label>\n        <input id="email" type="text" />',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)', '4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.1 – Label all form controls explicitly'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'select-name': {
    title: 'Dropdowns are missing a name',
    whyItMatters:
      'A <select> dropdown without a label or accessible name leaves screen reader users with no idea what they are choosing.',
    whatYouCanDo:
      'Associate every <select> with a <label>, or add an aria-label or aria-labelledby attribute.',
    example: 'Before: <select><option>...</option></select>\nAfter:  <label for="state">State</label>\n        <select id="state"><option>...</option></select>',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.1 – Label all form controls explicitly'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'form-field-multiple-labels': {
    title: 'A form field has more than one label',
    whyItMatters:
      'When a single field has multiple labels, screen readers may read only one of them or read them in an order that confuses users.',
    whatYouCanDo:
      'Combine the labels into a single <label>, or use one <label> plus aria-describedby for any extra hint text.',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   ['3.3.2 Labels or Instructions (Level A)'],
      gigw:   ['5.1 – Label all form controls explicitly'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'autocomplete-valid': {
    title: 'Autocomplete attribute uses an invalid value',
    whyItMatters:
      'The autocomplete attribute lets browsers and assistive tools fill in forms automatically with the user\'s saved data — saving time for users with motor or cognitive disabilities. Invalid values disable that help.',
    whatYouCanDo:
      'Use a valid autocomplete token from the WHATWG list (e.g. "name", "email", "street-address", "postal-code", "tel").',
    example: 'Before: <input autocomplete="full-name" />\nAfter:  <input autocomplete="name" />',
    affectedUsers: [U.cognitive, U.motor],
    standards: {
      wcag:   ['1.3.5 Identify Input Purpose (Level AA)'],
      gigw:   ['5.1 – Label all form controls explicitly'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'label-title-only': {
    title: 'Form field is labelled only by a title or hidden text',
    whyItMatters:
      'Tooltips, title attributes, and hidden labels are not reliably announced. Sighted keyboard users, voice users, and many screen reader users miss them.',
    whatYouCanDo:
      'Add a visible <label> element associated with the input. Use title or aria-describedby only for additional hint text, never as the primary label.',
    example: 'Before: <input type="text" title="Email" />\nAfter:  <label for="em">Email</label>\n        <input id="em" type="text" />',
    affectedUsers: [U.screenReader, U.voiceControl, U.cognitive],
    standards: {
      wcag:   [],
      gigw:   ['5.1 – Label all form controls explicitly'],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'input-button-name': {
    title: 'Input buttons have no readable name',
    whyItMatters:
      'An <input type="button|submit|reset"> with no value attribute and no label leaves screen reader users hearing only "button" with no context.',
    whatYouCanDo:
      'Add a value attribute, or aria-label, that describes what the button does.',
    example: 'Before: <input type="submit" />\nAfter:  <input type="submit" value="Submit application" />',
    affectedUsers: [U.screenReader, U.voiceControl],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.2 – Provide accessible names for all interactive elements'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 4. BUTTONS, LINKS & SUMMARIES
  // ─────────────────────────────────────────────────────────────────────────

  'button-name': {
    title: 'Buttons have no readable name',
    whyItMatters:
      'If a button contains only an icon or is empty, screen reader users hear "button" with no context about what it does.',
    whatYouCanDo:
      'Add visible text inside the button, or use aria-label to provide a description.',
    example: 'Before: <button><img src="search.png" /></button>\nAfter:  <button aria-label="Search">🔍</button>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.2 – Provide accessible names for all interactive elements'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'link-name': {
    title: 'Links have no readable name',
    whyItMatters:
      'Links that say "click here" or contain only an image give no context to screen reader users navigating a list of links.',
    whatYouCanDo:
      'Use descriptive link text that makes sense on its own, or add an aria-label.',
    example: 'Before: <a href="/report">Click here</a>\nAfter:  <a href="/report">Download the accessibility report</a>',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   ['2.4.4 Link Purpose (In Context) (Level A)', '2.4.9 Link Purpose (Link Only) (Level AAA)'],
      gigw:   ['3.5 – Use descriptive, meaningful link text'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'summary-name': {
    title: 'Disclosure widgets have no readable name',
    whyItMatters:
      'A <summary> inside <details> needs visible text — without it, screen reader users hear only "summary" and have no idea what expands when clicked.',
    whatYouCanDo:
      'Put visible, descriptive text inside the <summary> element.',
    example: 'Before: <details><summary></summary>...</details>\nAfter:  <details><summary>Eligibility criteria</summary>...</details>',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.2 – Provide accessible names for all interactive elements'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 5. HEADINGS
  // ─────────────────────────────────────────────────────────────────────────

  'page-has-heading-one': {
    title: 'Page is missing a main heading',
    whyItMatters:
      'The main heading (H1) tells users what the page is about. Screen reader users often skim headings to navigate — a missing H1 is disorienting.',
    whatYouCanDo:
      'Add one <h1> element that clearly describes the purpose of the page.',
    example: 'Before: <h2>Welcome to our portal</h2>\nAfter:  <h1>Welcome to the Government Services Portal</h1>',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)', '2.4.6 Headings and Labels (Level AA)'],
      gigw:   ['4.4 – Use a logical, hierarchical heading structure'],
      ada:    ['Title III – Effective Communication'],
      sesmag: [],
    },
  },

  'heading-order': {
    title: 'Headings are not in the right order',
    whyItMatters:
      'Screen reader users navigate by heading level. Skipping levels (e.g. H1 → H3) breaks the document outline and makes the structure hard to follow.',
    whatYouCanDo:
      'Use heading levels in sequence: H1 once, then H2 for sections, H3 for subsections, and so on. Do not skip levels.',
    example: 'Before: <h1>Title</h1> ... <h3>Subsection</h3>\nAfter:  <h1>Title</h1> ... <h2>Section</h2> ... <h3>Subsection</h3>',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   [],
      gigw:   ['4.4 – Use a logical, hierarchical heading structure'],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'empty-heading': {
    title: 'A heading has no text',
    whyItMatters:
      'An empty heading appears in the screen reader\'s heading list as a blank entry, breaking page navigation.',
    whatYouCanDo:
      'Either fill the heading with descriptive text, or remove it entirely.',
    example: 'Before: <h2></h2>\nAfter:  <h2>Application status</h2>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   ['4.4 – Use a logical, hierarchical heading structure'],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 6. PAGE STRUCTURE & DOCUMENT METADATA
  // ─────────────────────────────────────────────────────────────────────────

  'document-title': {
    title: 'Page has no title',
    whyItMatters:
      'The page title is the first thing a screen reader announces and appears in browser tabs and bookmarks. Without it, users cannot identify which page they are on.',
    whatYouCanDo:
      'Add a descriptive <title> inside the <head> of your page.',
    example: 'Before: <title></title>\nAfter:  <title>Apply for a Birth Certificate — Government Services</title>',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   ['2.4.2 Page Titled (Level A)'],
      gigw:   ['4.5 – Provide a descriptive and unique page title'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'html-has-lang': {
    title: 'Page language is not declared',
    whyItMatters:
      'Screen readers use the page language to pronounce content correctly. Without it, words may be read in the wrong language or accent.',
    whatYouCanDo:
      'Add a lang attribute to the opening <html> tag that matches the main language of your page.',
    example: 'Before: <html>\nAfter:  <html lang="en">',
    affectedUsers: [U.screenReader, U.nonNative],
    standards: {
      wcag:   ['3.1.1 Language of Page (Level A)'],
      gigw:   ['4.2 – Declare the primary language of each page'],
      ada:    ['Title III – Effective Communication'],
      sesmag: [],
    },
  },

  'html-lang-valid': {
    title: 'Page language code is invalid',
    whyItMatters:
      'If the lang attribute uses a code that is not a valid BCP 47 language tag, screen readers fall back to the default voice and may mispronounce everything.',
    whatYouCanDo:
      'Use a valid language code: "en" for English, "hi" for Hindi, "en-IN" for Indian English, etc. See the IANA language registry for the full list.',
    example: 'Before: <html lang="english">\nAfter:  <html lang="en">',
    affectedUsers: [U.screenReader, U.nonNative],
    standards: {
      wcag:   ['3.1.1 Language of Page (Level A)'],
      gigw:   ['4.2 – Declare the primary language of each page'],
      ada:    ['Title III – Effective Communication'],
      sesmag: [],
    },
  },

  'html-xml-lang-mismatch': {
    title: 'Page lang and xml:lang attributes disagree',
    whyItMatters:
      'When the two language attributes specify different languages, assistive tech may pick either one — pronunciation becomes unpredictable.',
    whatYouCanDo:
      'Make sure the lang and xml:lang attributes on the <html> element have the same base language code.',
    example: 'Before: <html lang="en" xml:lang="fr">\nAfter:  <html lang="en" xml:lang="en">',
    affectedUsers: [U.screenReader, U.nonNative],
    standards: {
      wcag:   ['3.1.1 Language of Page (Level A)'],
      gigw:   ['4.2 – Declare the primary language of each page'],
      ada:    [],
      sesmag: [],
    },
  },

  'valid-lang': {
    title: 'A language change uses an invalid code',
    whyItMatters:
      'When part of a page is in a different language, the lang attribute on that section tells screen readers to switch voice. An invalid code defeats this and the wrong voice keeps reading.',
    whatYouCanDo:
      'Use valid BCP 47 language codes everywhere lang appears, not just on <html>.',
    example: 'Before: <span lang="hindi">नमस्ते</span>\nAfter:  <span lang="hi">नमस्ते</span>',
    affectedUsers: [U.screenReader, U.nonNative],
    standards: {
      wcag:   ['3.1.2 Language of Parts (Level AA)'],
      gigw:   ['4.2 – Declare the primary language of each page'],
      ada:    ['Title III – Effective Communication'],
      sesmag: [],
    },
  },

  'meta-refresh': {
    title: 'Page auto-refreshes or auto-redirects',
    whyItMatters:
      'A timed refresh interrupts users who read slowly, use screen readers, or are filling out a form. Their progress can be lost without warning.',
    whatYouCanDo:
      'Remove <meta http-equiv="refresh">, or set the timeout to 0 (immediate redirect, which is acceptable). For genuine refresh needs, give users a button instead.',
    example: 'Before: <meta http-equiv="refresh" content="30; url=/next" />\nAfter: provide a "Continue" button users can click when ready',
    affectedUsers: [U.cognitive, U.motor, U.screenReader],
    standards: {
      wcag:   ['2.2.1 Timing Adjustable (Level A)', '3.2.5 Change on Request (Level AAA)'],
      gigw:   [],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'meta-viewport': {
    title: 'Zoom is disabled on the page',
    whyItMatters:
      'When user-scalable=no or maximum-scale is set too low, people with low vision cannot pinch-zoom to read the page on a phone or tablet.',
    whatYouCanDo:
      'Remove user-scalable=no and let users zoom to at least 200%. The viewport meta tag should permit scaling.',
    example: 'Before: <meta name="viewport" content="width=device-width, user-scalable=no">\nAfter:  <meta name="viewport" content="width=device-width, initial-scale=1">',
    affectedUsers: [U.lowVision],
    standards: {
      wcag:   ['1.4.4 Resize Text (Level AA)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'meta-viewport-large': {
    title: 'Page does not allow enough zoom',
    whyItMatters:
      'A maximum-scale below 5 prevents users with low vision from zooming far enough to read comfortably.',
    whatYouCanDo:
      'Remove maximum-scale entirely, or set it to 5 or higher.',
    example: 'Before: <meta name="viewport" content="width=device-width, maximum-scale=2">\nAfter:  <meta name="viewport" content="width=device-width, initial-scale=1">',
    affectedUsers: [U.lowVision],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'avoid-inline-spacing': {
    title: 'Text spacing cannot be adjusted',
    whyItMatters:
      'Some users override line-height, letter-spacing, or word-spacing with custom stylesheets to make text readable. !important inline rules block those overrides.',
    whatYouCanDo:
      'Avoid !important on line-height, letter-spacing, word-spacing, and similar properties. Move spacing into a regular stylesheet.',
    example: 'Before: <p style="line-height: 1.0 !important">\nAfter:  <p style="line-height: 1.5">',
    affectedUsers: [U.lowVision, U.cognitive],
    standards: {
      wcag:   ['1.4.12 Text Spacing (Level AA)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 7. LANDMARKS, REGIONS & SKIP LINKS
  // ─────────────────────────────────────────────────────────────────────────

  'landmark-one-main': {
    title: 'Page has no main content area marked',
    whyItMatters:
      'Screen reader users can jump straight to the main content by pressing a shortcut key. Without a <main> landmark, they have to listen through the entire navigation first.',
    whatYouCanDo:
      'Wrap your page\'s primary content in a <main> element.',
    example: 'Before: <div class="content">...</div>\nAfter:  <main>...</main>',
    affectedUsers: [U.screenReader, U.keyboard],
    standards: {
      wcag:   ['2.4.1 Bypass Blocks (Level A)'],
      gigw:   ['4.1 – Provide a skip-to-main-content mechanism'],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'region': {
    title: 'Page sections are not labelled for navigation',
    whyItMatters:
      'Landmarks like <header>, <nav>, <main>, and <footer> let keyboard and screen reader users jump between sections quickly.',
    whatYouCanDo:
      'Wrap major sections in appropriate semantic HTML elements or add role attributes.',
    example: 'Before: <div class="nav">...</div>\nAfter:  <nav aria-label="Main navigation">...</nav>',
    affectedUsers: [U.screenReader, U.keyboard],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)', '2.4.1 Bypass Blocks (Level A)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: [],
    },
  },

  'bypass': {
    title: 'No way to skip past the navigation',
    whyItMatters:
      'Users who navigate with a keyboard or screen reader have to tab through the entire menu on every page if there is no skip link or main landmark.',
    whatYouCanDo:
      'Add a "Skip to main content" link as the first focusable element, OR ensure a <main> landmark and proper headings exist.',
    example: 'After: <a href="#main" class="skip-link">Skip to main content</a>\n       ...\n       <main id="main">...</main>',
    affectedUsers: [U.screenReader, U.keyboard, U.motor],
    standards: {
      wcag:   ['2.4.1 Bypass Blocks (Level A)'],
      gigw:   ['4.1 – Provide a skip-to-main-content mechanism'],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'skip-link': {
    title: 'Skip link is broken',
    whyItMatters:
      'A "Skip to main content" link must actually move focus to the main content. If the target does not exist or is not focusable, the link does nothing.',
    whatYouCanDo:
      'Make sure the skip link\'s href matches an existing element id, and that the target can receive focus (use tabindex="-1" if needed).',
    example: 'Skip link: <a href="#main">Skip to main</a>\nTarget:    <main id="main" tabindex="-1">...</main>',
    affectedUsers: [U.keyboard, U.screenReader, U.motor],
    standards: {
      wcag:   [],
      gigw:   ['4.1 – Provide a skip-to-main-content mechanism'],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'landmark-banner-is-top-level': {
    title: 'Banner landmark is nested inside another landmark',
    whyItMatters:
      'The site banner (<header>) should sit at the top level of the page so screen reader users can find it predictably. Nesting it confuses landmark navigation.',
    whatYouCanDo:
      'Move the <header> or role="banner" element so it is not inside <main>, <article>, <section>, or another landmark.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'landmark-complementary-is-top-level': {
    title: 'Sidebar landmark is nested inside another landmark',
    whyItMatters:
      'A sidebar (<aside>) should be at the top level so screen reader users can locate it directly from the landmark menu.',
    whatYouCanDo:
      'Move <aside> elements out of other landmarks and place them at the page\'s top level.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'landmark-contentinfo-is-top-level': {
    title: 'Footer landmark is nested inside another landmark',
    whyItMatters:
      'The footer (<footer>) representing site-wide info should be at the top level. When nested, screen readers may not announce it as the page footer.',
    whatYouCanDo:
      'Move the page-level <footer> outside of <main>, <article>, or other landmarks.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'landmark-main-is-top-level': {
    title: 'Main landmark is nested inside another landmark',
    whyItMatters:
      '<main> should always sit at the top level of the page. Putting it inside another landmark breaks the assumption that a page has exactly one main content area.',
    whatYouCanDo:
      'Move the <main> element out of any wrapper landmark and place it at the page\'s top level.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'landmark-no-duplicate-banner': {
    title: 'Page has more than one banner landmark',
    whyItMatters:
      'A page should have only one banner. Multiple banners confuse screen reader users navigating the landmark list.',
    whatYouCanDo:
      'Keep one <header> at the page level and remove role="banner" from other elements.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'landmark-no-duplicate-contentinfo': {
    title: 'Page has more than one footer landmark',
    whyItMatters:
      'Only one element should represent the page footer. Multiple footer landmarks make it unclear which one carries the site-wide info.',
    whatYouCanDo:
      'Keep one page-level <footer> and remove role="contentinfo" from any other elements.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'landmark-no-duplicate-main': {
    title: 'Page has more than one main landmark',
    whyItMatters:
      'A page should have exactly one <main>. Multiple main landmarks confuse navigation and indicate a structure problem.',
    whatYouCanDo:
      'Combine the content into one <main>, or convert extras into <section> with their own headings.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'landmark-unique': {
    title: 'Two landmarks have the same role and label',
    whyItMatters:
      'When two landmarks of the same kind have identical (or no) labels, screen reader users cannot tell them apart in the landmark list.',
    whatYouCanDo:
      'Add a unique aria-label or aria-labelledby to each landmark — e.g. "Main navigation" vs "Footer navigation".',
    example: 'Before: <nav>...</nav>  <nav>...</nav>\nAfter:  <nav aria-label="Main">...</nav>  <nav aria-label="Footer">...</nav>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 8. ARIA — names, attributes, roles
  // ─────────────────────────────────────────────────────────────────────────

  'aria-required-attr': {
    title: 'Interactive elements are missing required accessibility attributes',
    whyItMatters:
      'Some ARIA roles need specific attributes to work correctly. Missing these breaks screen reader announcements.',
    whatYouCanDo:
      'Check the ARIA role used and add the required attributes listed in the error details.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: [],
    },
  },

  'aria-allowed-attr': {
    title: 'ARIA attribute is not allowed for this role',
    whyItMatters:
      'Each ARIA role only supports certain attributes. Using disallowed ones means the attribute is ignored — and the developer\'s intent is not communicated.',
    whatYouCanDo:
      'Look up the role in the ARIA specification and remove any attributes not listed as supported.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-allowed-role': {
    title: 'Element has a role that is not allowed for that tag',
    whyItMatters:
      'Some HTML elements should not have certain ARIA roles applied — e.g. <a href> with role="heading" makes it stop working as a link in some screen readers.',
    whatYouCanDo:
      'Either change the ARIA role to one allowed for this element, or use a different element.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-braille-equivalent': {
    title: 'Braille label is missing a non-braille version',
    whyItMatters:
      'aria-braillelabel and aria-brailleroledescription only render on braille displays. Without a normal aria-label, voice screen readers have nothing to say.',
    whatYouCanDo:
      'Whenever you set aria-braillelabel, also set aria-label. Same for aria-brailleroledescription / aria-roledescription.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-command-name': {
    title: 'ARIA buttons or links have no readable name',
    whyItMatters:
      'Custom buttons, links, and menuitems built with role="button|link|menuitem" need an accessible name, otherwise screen readers announce only the role.',
    whatYouCanDo:
      'Add visible text inside the element, or set aria-label / aria-labelledby.',
    example: 'Before: <div role="button" onclick="..."></div>\nAfter:  <div role="button" aria-label="Close">×</div>',
    affectedUsers: [U.screenReader, U.voiceControl],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.2 – Provide accessible names for all interactive elements'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'aria-conditional-attr': {
    title: 'ARIA attribute conflicts with the element\'s state',
    whyItMatters:
      'Some ARIA attributes only make sense in particular states. Using them inconsistently — for example, aria-checked on a non-checkable role — gives screen readers contradictory information.',
    whatYouCanDo:
      'Review the ARIA specification for the role you are using and only set conditional attributes when the state genuinely applies.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-deprecated-role': {
    title: 'ARIA role has been deprecated',
    whyItMatters:
      'Deprecated roles (e.g. role="directory") may stop working in newer browsers and assistive tech.',
    whatYouCanDo:
      'Replace the deprecated role with the current equivalent. For role="directory", use role="list".',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-dialog-name': {
    title: 'Dialog has no readable name',
    whyItMatters:
      'When a dialog opens, screen readers announce its name. Without one, users hear "dialog" with no idea what it is for.',
    whatYouCanDo:
      'Add aria-label or aria-labelledby (pointing to the dialog\'s heading) to every role="dialog" or role="alertdialog" element.',
    example: 'Before: <div role="dialog">...</div>\nAfter:  <div role="dialog" aria-labelledby="dlg-title">\n          <h2 id="dlg-title">Confirm submission</h2>...\n        </div>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   ['5.2 – Provide accessible names for all interactive elements'],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'aria-hidden-body': {
    title: 'Entire page is hidden from assistive technology',
    whyItMatters:
      'aria-hidden="true" on the <body> hides the entire page from screen readers. Users get nothing.',
    whatYouCanDo:
      'Remove aria-hidden from <body>. Use it only on specific elements that should be skipped.',
    example: 'Before: <body aria-hidden="true">\nAfter:  <body>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)', '4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-hidden-focus': {
    title: 'Hidden element can still receive keyboard focus',
    whyItMatters:
      'When something is marked aria-hidden but is still tabbable, keyboard users land on an "invisible" element with no announcement — extremely confusing.',
    whatYouCanDo:
      'Either remove aria-hidden from the element, or make it non-focusable using tabindex="-1" and ensure no focusable descendants.',
    affectedUsers: [U.screenReader, U.keyboard],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'aria-input-field-name': {
    title: 'ARIA input field has no readable name',
    whyItMatters:
      'Custom inputs built with role="textbox|combobox|searchbox|spinbutton" need an accessible name, otherwise screen readers cannot announce what the field is for.',
    whatYouCanDo:
      'Add aria-label or aria-labelledby pointing to a visible label.',
    affectedUsers: [U.screenReader, U.voiceControl],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.1 – Label all form controls explicitly'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'aria-meter-name': {
    title: 'Meter has no readable name',
    whyItMatters:
      'A role="meter" without a name is read out only as "meter" — users cannot tell what it measures.',
    whatYouCanDo:
      'Set aria-label or aria-labelledby on every meter element.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.1.1 Non-text Content (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'aria-progressbar-name': {
    title: 'Progress bar has no readable name',
    whyItMatters:
      'A role="progressbar" without a name leaves screen readers announcing only the percentage with no context — "75 percent" of what?',
    whatYouCanDo:
      'Set aria-label or aria-labelledby on every progressbar.',
    example: 'Before: <div role="progressbar" aria-valuenow="75"></div>\nAfter:  <div role="progressbar" aria-label="Upload progress" aria-valuenow="75"></div>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.1.1 Non-text Content (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 2 – Perceivability'],
    },
  },

  'aria-prohibited-attr': {
    title: 'Element uses an ARIA attribute it should not have',
    whyItMatters:
      'Some elements explicitly forbid certain ARIA attributes — for example, generic elements (role="generic", <span>) should not carry aria-label. Using them silently fails or produces inconsistent screen reader output.',
    whatYouCanDo:
      'Either change the element\'s role to one that supports the attribute, or remove the attribute and use a child with text instead.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-required-children': {
    title: 'ARIA role is missing required child elements',
    whyItMatters:
      'Some roles (like role="list", "tablist", "tree") expect specific child roles to work. Missing them means screen readers cannot announce the structure.',
    whatYouCanDo:
      'Check the ARIA specification for the role and ensure the required child roles are present.',
    example: 'Before: <ul role="tablist"><div>...</div></ul>\nAfter:  <ul role="tablist"><li role="tab">...</li></ul>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-required-parent': {
    title: 'ARIA role is missing its required parent',
    whyItMatters:
      'Some roles (like role="tab", "menuitem", "treeitem") only make sense inside a specific parent role. Used standalone, screen readers cannot announce the relationship.',
    whatYouCanDo:
      'Wrap the element in the appropriate parent role — e.g. role="tab" must be inside role="tablist".',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-roles': {
    title: 'ARIA role value is invalid',
    whyItMatters:
      'A role attribute with an unknown value is ignored. Whatever accessibility behaviour the developer expected does not happen.',
    whatYouCanDo:
      'Use a role from the official ARIA roles list, or remove the attribute entirely.',
    example: 'Before: <div role="buton">...</div>\nAfter:  <div role="button">...</div>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-text': {
    title: 'Element with role="text" contains focusable items',
    whyItMatters:
      'role="text" tells assistive tech to treat the element as plain text. If it contains focusable elements (links, buttons), they cannot be reached by keyboard.',
    whatYouCanDo:
      'Either remove role="text", or move focusable elements outside it.',
    affectedUsers: [U.keyboard, U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'aria-toggle-field-name': {
    title: 'Toggle control has no readable name',
    whyItMatters:
      'Switches, checkboxes, and radio buttons built with ARIA need a name. Without it, users hear "checkbox checked" with no indication of what they just toggled.',
    whatYouCanDo:
      'Add aria-label or aria-labelledby to every role="checkbox|radio|switch|menuitemcheckbox|menuitemradio" element.',
    example: 'Before: <div role="switch" aria-checked="false"></div>\nAfter:  <div role="switch" aria-checked="false" aria-label="Email notifications"></div>',
    affectedUsers: [U.screenReader, U.voiceControl],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.1 – Label all form controls explicitly'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'aria-tooltip-name': {
    title: 'Tooltip has no readable text',
    whyItMatters:
      'A role="tooltip" element without text content or a label is announced as "tooltip" with no information.',
    whatYouCanDo:
      'Put descriptive text inside the tooltip element, or set aria-label.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-treeitem-name': {
    title: 'Tree item has no readable name',
    whyItMatters:
      'Each item inside a role="tree" needs a name so users know what they are navigating to.',
    whatYouCanDo:
      'Provide visible text inside the treeitem, or set aria-label.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   ['5.2 – Provide accessible names for all interactive elements'],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'aria-valid-attr': {
    title: 'ARIA attribute name is misspelt',
    whyItMatters:
      'A misspelt aria-* attribute is silently ignored. Whatever the developer was trying to communicate to screen readers does not happen.',
    whatYouCanDo:
      'Check the spelling against the ARIA specification. Common typos: aria-labeledby (correct: aria-labelledby), aria-haspop (correct: aria-haspopup).',
    example: 'Before: <button aria-labeledby="x">Save</button>\nAfter:  <button aria-labelledby="x">Save</button>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'aria-valid-attr-value': {
    title: 'ARIA attribute has an invalid value',
    whyItMatters:
      'When an ARIA attribute uses a value that is not allowed (e.g. aria-checked="yes" instead of "true"), it is ignored and screen readers cannot announce the state.',
    whatYouCanDo:
      'Check the allowed values for each ARIA attribute. Boolean attributes accept only "true" / "false" — not "yes" / "no" / 1 / 0.',
    example: 'Before: <div role="checkbox" aria-checked="yes">\nAfter:  <div role="checkbox" aria-checked="true">',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  'presentation-role-conflict': {
    title: 'Element marked as presentational still has accessibility info',
    whyItMatters:
      'role="presentation" or role="none" tells screen readers to ignore the element. But if the element also has aria-* attributes or a tabindex, those override the role and create confusing output.',
    whatYouCanDo:
      'Remove ARIA attributes, tabindex, and event handlers from elements with role="presentation" / role="none". Or remove the role.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 9. LISTS
  // ─────────────────────────────────────────────────────────────────────────

  'list': {
    title: 'List contains items that are not list items',
    whyItMatters:
      'Screen readers announce lists as "list of N items". When non-<li> elements are inside <ul> or <ol>, the count is wrong and the structure is broken.',
    whatYouCanDo:
      'Allow only <li>, <script>, or <template> as direct children of <ul> and <ol>.',
    example: 'Before: <ul><li>One</li><div>Two</div></ul>\nAfter:  <ul><li>One</li><li>Two</li></ul>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'listitem': {
    title: 'List item is outside any list',
    whyItMatters:
      'A <li> element only makes sense inside <ul>, <ol>, or <menu>. Standalone, screen readers cannot tell users they are part of a list.',
    whatYouCanDo:
      'Wrap orphan <li> elements in <ul> or <ol>, or change the tag to something else.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'definition-list': {
    title: 'Definition list is structured incorrectly',
    whyItMatters:
      'A <dl> should only contain matched groups of <dt> (term) and <dd> (description). Other elements break the term–definition relationship for screen readers.',
    whatYouCanDo:
      'Inside <dl>, use only <dt>, <dd>, <div>, <script>, or <template>. Each <dt> must have at least one <dd>.',
    example: 'Before: <dl><p>Term</p><p>Def</p></dl>\nAfter:  <dl><dt>Term</dt><dd>Def</dd></dl>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'dlitem': {
    title: 'Definition term or description is outside a definition list',
    whyItMatters:
      'A <dt> or <dd> outside a <dl> has no semantic meaning — screen readers cannot announce term/definition pairs.',
    whatYouCanDo:
      'Wrap matching <dt>/<dd> pairs in a <dl> element, or change the tag.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 10. TABLES
  // ─────────────────────────────────────────────────────────────────────────

  'td-headers-attr': {
    title: 'Table cell headers attribute points to invalid cells',
    whyItMatters:
      'When a <td> uses headers="..." to link to its column/row headers, the IDs must point to <th> cells in the same table — otherwise screen readers cannot read the relationship.',
    whatYouCanDo:
      'Make sure every ID in headers="..." refers to an existing <th> in the same table.',
    affectedUsers: [U.screenReader, U.cognitive],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'th-has-data-cells': {
    title: 'Table header has no data cells',
    whyItMatters:
      'A <th> that does not actually describe any data cells creates phantom column or row headers in the screen reader\'s table-navigation mode.',
    whatYouCanDo:
      'Either remove the unused <th>, or make sure data cells in its column/row reference it.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['1.3.1 Info and Relationships (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'scope-attr-valid': {
    title: 'Table header scope attribute is invalid',
    whyItMatters:
      'The scope attribute on <th> tells screen readers whether the header applies to a row or column. Invalid values are ignored and the relationship is lost.',
    whatYouCanDo:
      'Use only one of: scope="row", scope="col", scope="rowgroup", scope="colgroup".',
    example: 'Before: <th scope="column">\nAfter:  <th scope="col">',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'empty-table-header': {
    title: 'Table header cell is empty',
    whyItMatters:
      'An empty <th> makes screen readers announce blank when navigating that column or row — users cannot tell what the data means.',
    whatYouCanDo:
      'Add visible text inside the <th>, or remove the empty header.',
    example: 'Before: <th></th>\nAfter:  <th>Application date</th>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  'table-duplicate-name': {
    title: 'Table caption duplicates the summary attribute',
    whyItMatters:
      'When the <caption> and the summary attribute say the same thing, screen reader users hear it twice.',
    whatYouCanDo:
      'Use either <caption> or summary — not both with identical text. Prefer <caption> as it is the modern approach.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 4 – Understandability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 11. FRAMES & IFRAMES
  // ─────────────────────────────────────────────────────────────────────────

  'frame-title': {
    title: 'Frame is missing a title',
    whyItMatters:
      'Screen readers list iframes by their title attribute. Without one, users hear only "frame" and have no idea what is inside.',
    whatYouCanDo:
      'Add a title attribute to every <iframe> and <frame> describing its contents.',
    example: 'Before: <iframe src="map.html"></iframe>\nAfter:  <iframe src="map.html" title="Office locations map"></iframe>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)', '2.4.1 Bypass Blocks (Level A)'],
      gigw:   ['5.2 – Provide accessible names for all interactive elements'],
      ada:    ['Title III – Effective Communication'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'frame-title-unique': {
    title: 'Two frames have the same title',
    whyItMatters:
      'When multiple iframes share the same title, screen reader users cannot tell them apart in the frame list.',
    whatYouCanDo:
      'Make every iframe title unique and descriptive of that frame\'s specific contents.',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   ['5.2 – Provide accessible names for all interactive elements'],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'frame-focusable-content': {
    title: 'Frame with focusable content is unreachable by keyboard',
    whyItMatters:
      'When an iframe has tabindex="-1" but contains links or form fields, keyboard users cannot tab into it.',
    whatYouCanDo:
      'Remove tabindex="-1" from the <iframe>, or remove all focusable content from inside it.',
    affectedUsers: [U.keyboard],
    standards: {
      wcag:   ['2.1.1 Keyboard (Level A)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'frame-tested': {
    title: 'Frame could not be tested for accessibility',
    whyItMatters:
      'When axe-core cannot inject into a cross-origin or sandboxed iframe, the content inside is not scanned at all — its accessibility is unknown.',
    whatYouCanDo:
      'For first-party iframes, ensure axe-core can run inside them. For third-party iframes, audit the third-party content separately.',
    affectedUsers: [U.screenReader, U.keyboard, U.lowVision],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: [],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 12. KEYBOARD & FOCUS
  // ─────────────────────────────────────────────────────────────────────────

  'accesskeys': {
    title: 'Two elements share the same access key',
    whyItMatters:
      'Access keys (Alt+letter shortcuts) must be unique on the page. When duplicated, only one of them works and the others silently fail.',
    whatYouCanDo:
      'Give each accesskey attribute a unique value, or remove duplicates.',
    affectedUsers: [U.keyboard, U.motor],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'tabindex': {
    title: 'Tab order is forced into an unnatural sequence',
    whyItMatters:
      'A tabindex value greater than 0 pushes the element to the front of the tab order, which almost always confuses keyboard users — focus jumps around the page in an unpredictable way.',
    whatYouCanDo:
      'Use tabindex="0" (joins natural tab order) or tabindex="-1" (focusable only by script). Avoid positive values.',
    example: 'Before: <button tabindex="3">Save</button>\nAfter:  <button>Save</button>',
    affectedUsers: [U.keyboard, U.screenReader],
    standards: {
      wcag:   [],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'scrollable-region-focusable': {
    title: 'Scrollable area cannot be reached by keyboard',
    whyItMatters:
      'When a region scrolls but has no focusable content and no tabindex, keyboard users cannot scroll it at all — they are stuck.',
    whatYouCanDo:
      'Add tabindex="0" to the scrollable container, or include focusable elements inside it.',
    example: 'Before: <div style="overflow:auto;height:200px">...</div>\nAfter:  <div tabindex="0" style="overflow:auto;height:200px">...</div>',
    affectedUsers: [U.keyboard],
    standards: {
      wcag:   ['2.1.1 Keyboard (Level A)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'nested-interactive': {
    title: 'Interactive elements are nested inside each other',
    whyItMatters:
      'Nesting buttons inside links (or inputs inside buttons) confuses both screen readers and keyboard users — clicking either parent or child triggers different things, and screen readers may announce only one.',
    whatYouCanDo:
      'Place interactive elements side by side instead of nested. Restructure the markup so each control is independent.',
    example: 'Before: <a href="..."><button>Open</button></a>\nAfter:  <a href="...">Open</a>',
    affectedUsers: [U.keyboard, U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  // ─── Legacy entry — focus-trap is NOT a real axe-core rule. ──────────────
  // Preserved for backward compatibility with any existing reports/data
  // that may reference it. Will never fire from a real axe scan.
  'focus-trap': {
    title: 'Keyboard focus is trapped',
    whyItMatters:
      'Users who navigate by keyboard can get stuck in a part of the page and cannot move out without a mouse.',
    whatYouCanDo:
      'Ensure that dialogs and menus release focus when closed, and that the Tab key can always move to the next element.',
    affectedUsers: [U.keyboard, U.motor],
    standards: {
      wcag:   ['2.1.2 No Keyboard Trap (Level A)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 13. PARSING / DUPLICATE IDs
  // ─────────────────────────────────────────────────────────────────────────

  'duplicate-id-aria': {
    title: 'Two elements share an ID used by ARIA',
    whyItMatters:
      'ARIA references like aria-labelledby and aria-describedby point to an element by ID. When two elements share an ID, the wrong one may be picked — labels go to the wrong control.',
    whatYouCanDo:
      'Make sure every ID is unique within the page. Inspect dynamic templates that may emit duplicates.',
    example: 'Before: <input id="name"> ... <span id="name">...</span>\nAfter:  <input id="name"> ... <span id="name-hint">...</span>',
    affectedUsers: [U.screenReader],
    standards: {
      wcag:   ['4.1.2 Name, Role, Value (Level A)'],
      gigw:   [],
      ada:    [],
      sesmag: ['Section 5 – Robustness'],
    },
  },

  // ─────────────────────────────────────────────────────────────────────────
  // 14. OUTDATED / DEPRECATED HTML
  // ─────────────────────────────────────────────────────────────────────────

  'blink': {
    title: 'Page uses obsolete <blink> element',
    whyItMatters:
      'Blinking text triggers seizures in users with photosensitivity and cannot be paused, breaking the WCAG requirement that flashing content must be controllable.',
    whatYouCanDo:
      'Remove every <blink> tag. The element is obsolete and not supported by modern browsers.',
    affectedUsers: [U.photosensitive, U.cognitive],
    standards: {
      wcag:   ['2.2.2 Pause, Stop, Hide (Level A)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'marquee': {
    title: 'Page uses obsolete <marquee> element',
    whyItMatters:
      'Scrolling marquees move text faster than many users can read, and there is no way to pause them. They are especially difficult for users with cognitive disabilities or low vision.',
    whatYouCanDo:
      'Replace <marquee> with static content, or with CSS animation that the user can pause.',
    affectedUsers: [U.cognitive, U.lowVision, U.motor],
    standards: {
      wcag:   ['2.2.2 Pause, Stop, Hide (Level A)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

  'server-side-image-map': {
    title: 'Page uses a server-side image map',
    whyItMatters:
      'Server-side image maps (<img ismap>) cannot be navigated by keyboard — users have to point with a mouse and click coordinates. Use of these has been discouraged for over two decades.',
    whatYouCanDo:
      'Replace with a client-side image map (<img usemap> + <map>), or with separate links/buttons.',
    affectedUsers: [U.keyboard, U.motor, U.screenReader],
    standards: {
      wcag:   ['2.1.1 Keyboard (Level A)'],
      gigw:   [],
      ada:    ['Title III – Accessible Design Standards'],
      sesmag: ['Section 3 – Operability'],
    },
  },

};

// ─── Lookup ──────────────────────────────────────────────────────────────────

const FALLBACK_USERS = [
  { icon: '👤', label: 'Users with disabilities' },
];

export function getMessage(ruleId) {
  return ruleMessages[ruleId] ?? {
    title: formatFallbackTitle(ruleId),
    whyItMatters: 'This issue may prevent some users from accessing content on this page.',
    whatYouCanDo: 'Review the flagged element and follow accessibility best practices for this pattern.',
    affectedUsers: FALLBACK_USERS,
    standards: {
      wcag:   ['Refer to WCAG 2.1 guidelines for this rule'],
      gigw:   [],
      ada:    [],
      sesmag: [],
    },
  };
}

function formatFallbackTitle(ruleId) {
  return ruleId
    .split('-')
    .map((word, i) => (i === 0 ? word.charAt(0).toUpperCase() + word.slice(1) : word))
    .join(' ');
}
