# Accessibility in `@egovernments/digit-ui-components`

This guide explains:

1. what was wrong with the components' accessibility,
2. what was fixed in **2.0.0-dev-74** (with **`@egovernments/digit-ui-components-css` 2.0.0-dev-15**),
3. how to use the components so your product's accessibility score goes up, not down.

It is for anyone building a DIGIT product with this library.

---

## 1. Why this matters

DIGIT products are scanned with the **DIGIT Accessibility Scanner** (Playwright + axe-core). The scanner checks pages against
WCAG 2.1, GIGW, Section 508 / EN 301 549 (SesMag) and ADA Title III.

Each page starts at 100 and loses points for every issue it finds:

| Severity | Points per issue | Max deduction |
|---|---|---|
| Severe | −10 | −30 |
| High | −7 | −30 |
| Medium | −4 | −30 |
| Low | −1 | −30 |

The site score is the average of all page scores. HCM Console (UAT, 21 Sep 2026) scored **40 / 100**.

A component bug shows up on **every page that renders that component, in every product**. Fixing it once in the library
removes it everywhere. Library fixes cannot repair markup that products write themselves, though. Section 4 shows how to use
the components correctly.

---

## 2. What was fixed

All fixes change only HTML semantics (ARIA attributes, roles, ids, label links). Nothing changes visually, and no behaviour
changes. The only exception is the new **opt-in** `showLabel` feature, which renders a visible label only when you ask for it.

### 2.1 Form controls

| Component | Problem (axe rule) | Fix |
|---|---|---|
| **Dropdown** | The open list contained `role="button"` items, which a listbox may not contain (`aria-required-children`, Severe). The list had no name (`aria-input-field-name`). The expanded combobox had no `aria-controls` (`aria-required-attr`). | Items are `role="option"`. The list is named, using the same text as the input. The input points at the open list. The "No results" row is a disabled option. |
| **MultiSelectDropdown** | The open list had no name. The combobox had no `aria-controls`. | The list is named and the combobox points at the open list. A new `ariaLabel` prop lets you name the control without showing a label. |
| **TextInput / Dropdown / MultiSelectDropdown** | Products put a separate `<label>`/`CardLabel` next to the field without linking it, so the field had no name (`label`, Severe). | New **opt-in** `label` + `showLabel` props render a visible label exactly like `FieldV1` and link it to the field. See [§4.1](#41-text-fields-and-dropdowns). |
| **InboxSearchComposer** (search/filter fields) | Visible labels were not linked to their text inputs (`label`, Severe). | Each label is now linked to its input with `htmlFor`/`id`. |
| **CheckBox** | With `hideLabel`, the checkbox had no name (`label`). | The input is named with its `label` text. |
| **UploadFile** | The file input had no name (`label`). | It is named with the same text as its visible "Choose file" button. |
| **Tab** | Each tab's `aria-controls` pointed at a panel that is never rendered (`aria-valid-attr-value`, Severe). | Removed the invalid reference. |

### 2.2 Buttons, icons, menus

| Component | Problem (axe rule) | Fix |
|---|---|---|
| **Button** (icon-only) | `aria-label=""` meant the button had no name (`button-name`, Severe). Its empty `<h2>` was reported as an empty heading. | The button falls back to its `title`. The empty heading is no longer a heading. |
| **Button** (`actionButton`) / **Menu** | The options list had no name (`aria-input-field-name`). | Menu accepts `ariaLabel`. The action button passes its own label, and other menus fall back to "Options". |
| **Dropdown** (profile / custom selector) | The trigger was named only by an initial or an image. | It accepts an `ariaLabel` for a real name. |
| **CustomSVG** | `Ellipsis` and `PngFile` were the only 2 of 197 icons with `role="img"` and no name (`svg-img-alt`). | Named "More options" and "PNG File", matching the other icons. |
| **TableMolecule**, **ResultsDataTableWrapper** | The previous/next page buttons contained only an icon (`button-name`, Severe). | The buttons are named. |

### 2.3 Page structure

| Component | Problem (axe rule) | Fix |
|---|---|---|
| **SearchComponent** (filter header) | `role="banner"` inside page content created a second banner landmark (`landmark-no-duplicate-banner`). | Role removed. |
| **Banner**, **CollapseAndExpandGroups**, **ConnectingCheckPoints** | Message and group text used `<header>`, which counts as a page banner landmark. | Uses a plain container. |
| **LinkLabel** | `<label role="button">`, but `<label>` may not carry a role (`aria-allowed-role`). | Rendered as a `<span role="button">`. It looks and behaves the same. |
| **InboxSearchComposer** results | The sideways-scrolling table could not be reached by keyboard (`scrollable-region-focusable`, High). | Becomes a named, focusable region while it scrolls. |

### 2.4 Measured result

Every Storybook story (240 states) and 123 extra prop combinations were rendered and scanned with axe-core. Each was scanned
in its default state and again with dropdowns and menus opened.

| | develop | this release |
|---|---|---|
| Violations found | **317** | **130** (−59%) |
| New violations introduced | — | **0** |

| Rule | before | after |
|---|---|---|
| aria-input-field-name | 67 | 0 |
| aria-required-attr | 53 | 0 |
| aria-required-children | 42 | 8 |
| button-name | 21 | 1 |
| label | 38 | 34 (the rest are usage issues, see §4) |
| aria-valid-attr-value | 3 | 0 |
| empty-heading, svg-img-alt, landmark-* | 5 | 0 |

The remaining violations are listed in [§5](#5-known-limitations).

---

## 3. Upgrade

```json
"@egovernments/digit-ui-components": "2.0.0-dev-74",
"@egovernments/digit-ui-components-css": "2.0.0-dev-15"
```

Upgrade **both packages together**, because the `showLabel` layout uses CSS from the new CSS package.

Many issues in older scans come from an outdated library version (for example, HCM Console runs 2.0.0-dev-66). Upgrading
alone clears them.

---

## 4. How to use the components accessibly

### 4.1 Text fields and dropdowns

**Every form control needs a name.** A visible label is best. Choose one of these, in order of preference:

**A. Use `FieldV1` / `FormComposerV2`** whenever you can. They render the label and link it for you.

**B. Use the `label` + `showLabel` props** when you render a control on its own. The control then draws the label exactly the
way FieldV1 does (same markup and classes) and links it:

```jsx
// ❌ Before: the label is not linked, so axe reports "Form fields are missing labels"
<LabelFieldPair>
  <CardLabel>{t("CAMPAIGN_NO_OF_CYCLE")} <span className="mandatory-span">*</span></CardLabel>
  <TextInput type="numeric" value={cycle} onChange={onCycleChange} />
</LabelFieldPair>

// ✅ After
<TextInput label={t("CAMPAIGN_NO_OF_CYCLE")} showLabel required type="numeric" value={cycle} onChange={onCycleChange} />
<Dropdown  label={t("BOUNDARY_TYPE")} showLabel option={options} optionKey="name" select={onSelect} t={t} />
<MultiSelectDropdown label={t("TARGET_GROUPS")} showLabel options={options} optionsKey="name" onSelect={onSelect} selected={selected} t={t} />
```

- `required` adds the red `*`, the same as FieldV1. `isRequired` is **not** a component prop.
- **Delete your own `<label>` / `CardLabel` / `LabelFieldPair`** when you add `showLabel`, or the label shows twice.
- By default the label is on the left and the field on the right on desktop, and they stack on narrow screens.

**Label above the field (vertical alignment).** To put the label above the field on every screen size, also send
`populators` with `alignFieldPairVertically: true`:

```jsx
<TextInput
  label={t("CAMPAIGN_NO_OF_CYCLE")}
  showLabel
  required
  type="numeric"
  value={cycle}
  onChange={onCycleChange}
  populators={{
    "alignFieldPairVertically": true
  }}
/>

<Dropdown
  label={t("BOUNDARY_TYPE")}
  showLabel
  option={options}
  optionKey="name"
  select={onSelect}
  t={t}
  populators={{
    "alignFieldPairVertically": true
  }}
/>

<MultiSelectDropdown
  label={t("TARGET_GROUPS")}
  showLabel
  options={options}
  optionsKey="name"
  onSelect={onSelect}
  selected={selected}
  t={t}
  populators={{
    "alignFieldPairVertically": true
  }}
/>
```

- In vertical mode the gap between the label and the field is 4px.
- If the component already receives `populators` (for example TextInput's `prefix`, `suffix` or `validation`), add the key to
  that same object instead of passing a second one:
  `populators={{ ...yourPopulators, alignFieldPairVertically: true }}`.
- `alignFieldPairVertically` only has an effect together with `showLabel`. Without `showLabel` there is no label wrapper to align.

- To add your own class to the wrapper, use `populators={{ fieldPairClassName: "my-class" }}`.

**What else the `showLabel` label supports.** `showLabel` renders FieldV1's label block, but not everything FieldV1 adds
around a field:

| Feature | FieldV1 | `showLabel` (TextInput / Dropdown / MultiSelectDropdown) |
|---|---|---|
| Red mandatory `*` next to the label | `required` | ✅ pass `required` |
| Info icon with a hover message next to the label | `infoMessage` | ❌ not supported yet |
| Error message text below the field | `error` | ❌ not rendered. On TextInput, `error` only adds the red error style |
| Description / helper text below the field | `description` | ❌ not supported |
| Character count | `charCount` | ❌ not supported |

- **Mandatory star:** pass `required`. Don't add your own `<span className="mandatory-span">*</span>`, or the star shows twice.
- **Error message:** render it yourself, directly after the control:

  ```jsx
  <TextInput label={t("WAYBILL_NUMBER")} showLabel required error={errors.waybill} value={value} onChange={onChange} />
  {errors.waybill && <ErrorMessage message={t(errors.waybill)} showIcon />}
  ```

- **Info icon, description or character count:** if a field needs any of these, use `FieldV1` / `FormComposerV2`, which
  support them all. Alternatively, keep your existing label markup and pass `label` (TextInput) or `ariaLabel` (Dropdown /
  MultiSelectDropdown) without `showLabel`, as shown in option C below.
- `showLabel` mode removes the wrapper's bottom margin, like FieldV1. Space consecutive fields from their container.

**C. Pass `label` (TextInput) or `ariaLabel` without `showLabel`** when you must keep your current layout. Nothing changes
visually, but screen readers get a name:

```jsx
<label className="cm-shipment-label">{t("WAYBILL_NUMBER")}</label>
<TextInput label={t("WAYBILL_NUMBER")} value={value} onChange={onChange} />          {/* TextInput */}
<Dropdown ariaLabel={t("BOUNDARY_TYPE")} option={options} optionKey="name" select={onSelect} t={t} />
<MultiSelectDropdown ariaLabel={t("TARGET_GROUPS")} options={options} optionsKey="name" onSelect={onSelect} t={t} />
```

**Avoid relying on `placeholder` alone.** It is used as a fallback name, but `placeholder={t("")}` gives an empty one, and a
Dropdown without a placeholder is only called "Select an option".

### 4.2 Buttons and icons

- An icon-only `Button` must have `ariaLabel` or `title`:
  `<Button icon="Close" label="" ariaLabel={t("CLOSE")} variation="teritiary" onClick={onClose} />`
- A raw `<button>` that contains only an icon needs `aria-label`. Put `aria-hidden="true"` on the icon inside it.
- Don't make a `div`/`span` clickable with `onClick`. Use `Button`, which is focusable and works with Enter/Space.
- `Card` with `onClick` already acts as a button. Don't put other interactive elements (Button, Tag, Chip) inside a clickable
  Card, or axe reports nested interactive controls.

### 4.3 Checkboxes, switches, radios

- `CheckBox`: always pass a non-empty `label`. Use `hideLabel` to hide it visually. An empty `label=""` is reported as
  three separate issues.
- `Switch`: pass `label`, or `ariaLabel` when there's no visible text. Without either, it is called "Toggle switch on/off".
- `RadioButtons`: pass `label` (the group name) and `name`.

### 4.4 Page structure (product responsibility)

- Each page needs **one `<main>`**, ideally rendered once in the module's page wrapper, and **one `<h1>`** (the page title).
  `HeaderComponent` and `CardHeader` are deliberately not landmarks or headings, so add your own `<h1>`.
- Don't add `<header>`, `role="banner"` or `<footer>` inside page content. The app shell owns those landmarks.
- **Never use a positive `tabIndex`** (`tabIndex={1}`, `{2}`, …). It reorders keyboard navigation (High).
- Use `<h1>`–`<h6>` for real headings only. Don't use them for "No data" messages, and don't skip levels.
- Colour contrast comes from CSS and theme tokens. Check custom colours with a contrast checker (4.5:1 for normal text).

### 4.5 Localisation keys

These names are translated through `t()`. Add them to your localisation, otherwise screen readers read the key itself:

| Key | Used by |
|---|---|
| `CS_COMMON_PREVIOUS_PAGE`, `CS_COMMON_NEXT_PAGE` | ResultsDataTableWrapper pagination |
| `CS_COMMON_CHOOSE_FILE` | UploadFile (already used for the visible button) |
| `Select an option`, `Options`, `Search results` | Dropdown fallback name, Menu fallback name, InboxSearchComposer results region. When untranslated, the English text is used. |

---

## 5. Known limitations

These issues are still open. Each needs a behaviour or structure change, so each will be handled separately:

| Component | Issue | Workaround |
|---|---|---|
| MultiSelectDropdown | Each option contains a focusable checkbox (`nested-interactive`). | none yet |
| CheckBox | The clickable label is `<label role="button">` (`aria-allowed-role`, Low). | none yet |
| Chip, Timeline ("view details") | A control nested inside another control. | none yet |
| Menu (searchable), TreeSelect, TreeDropdown / TreeMultiselect | Invalid list structure, unnamed checkboxes. | prefer the non-tree variants |
| Header profile menu | Needs a name when the profile is only an image. | pass `ariaLabel` |
| Tag | Always focusable with `role="button"`, even without `onClick`. | avoid putting Tags inside clickable Cards |

---

## 6. Checking your own screens

- **Storybook:** the *Accessibility* panel (`@storybook/addon-a11y`) runs axe on the current story.
- **Browser:** the axe DevTools extension, or Lighthouse → Accessibility.
- **Keyboard:** unplug the mouse, then Tab through the page. Every control should be reachable, show focus, and work with
  Enter/Space.
- **Screen reader:** NVDA (Windows) or VoiceOver (macOS). Every field should announce its label.
- **Before release:** re-run the DIGIT Accessibility Scanner on your main pages.
