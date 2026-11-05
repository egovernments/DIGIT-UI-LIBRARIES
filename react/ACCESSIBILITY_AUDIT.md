# Accessibility Audit & Remediation Plan — `@egovernments/digit-ui-components`

> Context file for future work sessions (human or Claude). Read this before making accessibility changes.
> Findings come from a code review done on **2026-10-09** (no runtime verification yet).
> Line numbers were correct on that date (`develop` @ `856f3ecf2c`). Re-check them before editing.

> **Ground rule (2026-10-09): fixes must be markup/ARIA-only, with no visual change.**
> - Do not change colours, SCSS/CSS, classNames, or inline styles. The contrast items in §4 are **out of scope**.
> - Do not swap tag names: `react/css` has ~55 tag selectors (`header`, `h2`, `label`…). Remove wrong semantics with
>   `role="none"`, and add semantics with `role`/`aria-*`. No CSS targets `[role]`/`[aria-*]`, so those attributes are safe.
> - Landmarks that products could duplicate (`main`, `banner`, `contentinfo`) are added only as **opt-in props**.

## 0. Verified status (2026-10-11): read this first

The original code-reading checklist in §2–§4 **overstated** what axe actually flags. A first pass that applied all of it
(84 files) was reverted because it changed behaviour, ids and labels. Fixes are now driven by **measured** axe results.

**How it was measured:** every Storybook story was rendered from `ui-components/src` in jsdom with axe-core 4.10 (the scanner's engine),
in both the default and the "dropdown open" state, using the real `Digit.Utils.generateUniqueId`. Before/after HTML was compared;
the only differences were the intended attributes.

**Applied (4 files, attribute-only):** removes 63 axe violations across 240 story states, with 0 new ones.

| Component | Change | axe rule fixed |
|---|---|---|
| Tab | removed `aria-controls` (it pointed at a tabpanel that is never rendered) | aria-valid-attr-value |
| Dropdown | option `role="button"` → `role="option"`; listbox `aria-label` = the combobox's existing label text; `aria-controls` while open | aria-required-children, aria-input-field-name, aria-required-attr |
| MultiSelectDropdown | `aria-controls` while open; listbox `aria-label="Dropdown options"` (existing string) | aria-required-attr, aria-input-field-name |
| TableMolecule | `aria-label` "Previous page"/"Next page" on the icon-only pagination buttons | button-name |

**Second round (2026-10-12), measured with ~170 extra prop-variant cases for 48 components (error, disabled, required,
icon-only, hidden label, empty list, open menus) plus all stories. Against `develop`: 0 new violations, 0 unexplained HTML differences.**

| Component | Change | axe rule fixed |
|---|---|---|
| Button | icon-only: `aria-label` falls back to `title` (was `aria-label=""`); the empty label `<h2>` gets `role="none"` **only when the label is empty** | button-name, empty-heading |
| Menu + Button | Menu accepts optional `ariaLabel` for its listbox; an action Button passes its own visible label | aria-input-field-name |
| CheckBox | with `hideLabel`, the input gets `aria-label={label}` (its own label text) | label |
| CustomSVG | `Ellipsis` → "More options", `PngFile` → "PNG File" (the only 2 of 197 icons without a name; follows "PDF File"/"JPG File") | svg-img-alt / button-name |
| UploadFile | file input `aria-label={t("CS_COMMON_CHOOSE_FILE")}`, the same text as the visible button it mirrors | label |
| RenderFormFields (InboxSearchComposer search/filter) | text-type inputs get a `useId`-based id, and the visible `<label>` gets the matching `htmlFor`. These inputs had **no id before**, even when mandatory. A `<label>` ranks below `aria-label`, so fields already named by a placeholder keep that name | label |
| Dropdown | the "No results" row is `role="option" aria-disabled="true"`, as MultiSelectDropdown already does | aria-required-children |

**TextInput `showLabel` (2026-10-12, opt-in):** products often render `<label>`/`<CardLabel>` next to a standalone
`<TextInput>` without linking them, so the input has no name (axe `label`). TextInput now accepts `showLabel`: with
`label` + `showLabel`, it renders FieldV1's exact structure: `LabelFieldPair` (`removeMargin`,
`className="digit-formcomposer-fieldpair …"`, `vertical={populators.alignFieldPairVertically}`) › `HeaderComponent.label` ›
`.label-container` › `<label class="label-styles" htmlFor=…>` + red `*` when `required`, then `div.digit-field` › the input.
The label is linked to the input. In that mode `aria-label` is not set from `label`/placeholder on the input or its group
(it would override the visible label); an explicit `ariaLabel` still wins.
Without `showLabel` the output is byte-identical to before (verified across all stories and cases). FieldV1 does not pass
`label`/`showLabel` to TextInput, so FieldV1 still renders one label. Same prop name as `FileUpload`'s `showLabel`.
Migration for product code: replace `<label>X</label><TextInput …/>` with `<TextInput label={X} showLabel required? …/>`.

**Measured and NOT library bugs:**
- FormComposerV2/FieldV1 forms: **no `label` violations**, because label `for` and input `id` match. §2.1 is not needed for axe.
- `aria-disabled="Default"` (BackLink, CheckBox) comes from the stories passing `disabled: "Default"` (a string). Products pass booleans.
- Unlabelled TextArea (BasicCard story) and TextInput (FilterCard stories) are rendered without a label by the story itself (usage issue).

**Real violations still open (each needs a behaviour or structure change, so they need sign-off):**
- CheckBox `<label role="button" tabindex=0>` (aria-allowed-role). The label is the only keyboard stop, so removing the role would make it worse.
- Chip and MultiSelectDropdown options contain focusable children (nested-interactive). Fixing this changes tab stops.
- Menu (header dropdown) listbox contains a search input (aria-required-children). Fixing this changes DOM structure.
- Header profile trigger with an SVG avatar has no name (aria-command-name). There is no text to reuse; products must pass one.
- TreeDropdown / TreeMultiselect: unnamed checkbox, aria-expanded on a role-less div, nested-interactive.
- Timeline: the "view details" wrapper (`role=button tabindex=0`) wraps a Button (nested-interactive). Fixing it removes a tab stop.
- Icon-only Button with neither `title` nor `ariaLabel` stays nameless. Products must pass one (or opt into deriving a name from the icon).
- Searchable Menu: the search input sits inside the listbox (structure).
- Usage, not library: TextInput/TextArea rendered with no `label`; LabelFieldPair + CardLabel do not link label to input; FieldV1 `withoutLabel`.
- Functional bug (not a11y): `UploadFile` crashes when `uploadedFiles` is not passed (`.length` of undefined).

**Story bugs found:** FormComposerV2 story imports `FormComposer`, but `hoc` exports `FormComposerV2`.
TooltipWrapper story: `commonArgs is not defined`. BottomSheet/HeaderDocs/PanelCardDocs: `Iframe is not defined`.
TimelineMolecule: `Wrapper is not defined`. FormCard: `layout.split`.

## 1. Background

- DIGIT products (HCM Console / workbench-ui, DIGIT Studio / service designer, …) were scanned with the
  **DIGIT Accessibility Scanner** (Playwright + axe-core) on **2026-09-21**.
- HCM Console – UAT: score **40/100**, 22 distinct issues, adherence 77%
  (WCAG 79%, GIGW 78%, SesMag 76%, ADA 75%).
- Scoring per page: Severe −10, High −7, Medium −4, Low −1 (each capped at −30).
  The site score is the average of all page scores. **Fixing one rule in a shared component removes that
  rule from every page that uses the component.** That is why component-level fixes matter most.
- **Already fixed (2026-09-22, PR #443):** Dropdown combobox semantics, TextInput names, SideNav tree roles,
  SidePanel landmark, TextArea name, Switch always named, CardHeader/HeaderComponent no longer `<header>`,
  PanelCard. Commits: `d0f36a8239`, `bc05b928d8`, `c588919b81`.

### Audit rule → library root cause

| Audit issue (axe rule) | Severity | Root cause in library (section) |
|---|---|---|
| Form fields missing labels (`label`) | Severe | FieldV1 / RenderFormFields / FieldComposer id + label wiring (§2.1) |
| ARIA input field has no name (`aria-input-field-name`) | High | Dropdown `aria-label` fallback, unnamed listboxes (§2.1, §3) |
| Toggle has no name (`aria-toggle-field-name`) | High | ToggleSwitch, TreeSelect `role=checkbox`, radios (§2.1, §3) |
| Field labelled only by title/hidden text (`label-title-only`) | High | Placeholder/`aria-label` used instead of a real label (§2.1) |
| Buttons have no name (`button-name`) | Severe | Icon-only Button/InfoButton emit `aria-label=""` (§2.3) |
| SVG missing description (`svg-img-alt`) | High | svg-components icons have no `aria-hidden`/`<title>` (§2.3) |
| ARIA attr not allowed (`aria-allowed-attr`, `aria-prohibited-attr`) | Severe/High | `aria-label`/`aria-expanded` on role-less divs (§3) |
| ARIA role missing children (`aria-required-children`) | Severe | Dropdown/Menu/MultiSelect listbox children (§3) |
| ARIA attr invalid value (`aria-valid-attr-value`) | Severe | `aria-controls`/`aria-labelledby` pointing at missing ids (§3) |
| Nested interactive (`nested-interactive`) | High | Chip, Timeline, DetailsCard, FilterCard, MultiSelect, TreeSelect, Card (§3) |
| Role not allowed for tag (`aria-allowed-role`) | Low | `<label role="button">` (§3) |
| No main landmark / content not in landmarks (`landmark-one-main`, `region`) | Medium | App shell renders only divs (§2.4) |
| Duplicate/nested banner, main, footer; non-unique landmarks | Medium | LandingPageWrapper, SearchComponent, Banner, fixed-label regions (§2.4) |
| Missing h1 / heading order / empty heading | Medium/Low | Headings removed or misused (§2.4) |
| Scrollable region not focusable (`scrollable-region-focusable`) | High | Table, PanelCard, SidePanel, BottomSheet scroll containers (§4) |
| Low contrast (`color-contrast`) | High | Colour tokens (§4) |
| Positive tabindex (`tabindex`) | High | **Not in library**: no positive tabIndex in `src`; product code |

Paths below are relative to `react/ui-components/src/` unless noted.

---

## 2. Priority 1: central fixes (highest score impact, fewest files)

### 2.1 Form label / id wiring
- [ ] `hoc/FieldV1.js:77`: `fieldId = Digit?.Utils.getFieldIdName?.(label) || "NA"`. The id comes from the label
  text only, so labels that repeat (multi-child forms) give duplicate ids, and unlabelled fields get `"NA"`.
  **Fix:** id = composer/form id + `populators.name` + `useId()`. Also derive `${id}-label`, `${id}-error`, `${id}-desc`.
- [ ] `hoc/FieldV1.js:627`: `<label for=…>` should be `htmlFor`, and it needs `id={fieldId+"-label"}`.
- [ ] FieldV1 passes the id to only some controls. Missing: radio, toggle, multiselectdropdown, dateRange,
  locationdropdown, apidropdown, boundary, custom. Pass `id` + `labelId` to all of them. Group controls use `aria-labelledby={labelId}`.
- [ ] Required `*` (FieldV1 ~line 638) sits outside the `<label>`. Expose `aria-required` / `required` on the control.
- [ ] `molecules/RenderFormFields.js:352`: `<label>` has no `htmlFor` and no control gets an id
  (lines ~71,102,124,157,194,237,261,288). This covers every search and inbox field. Use the same scheme as FieldV1, or render through FieldV1.
- [ ] `hoc/FieldComposer.js:412-424`: label is plain text, stray `<label> ⓘ</label>`, no ids.
- [ ] `molecules/CustomDropdown.js:11`, `ApiDropdown.js:72`, `LocationDropdownWrapper.js:~99`,
  `atoms-groups/CustomDropdown.js:49`: these don't forward the label, so `atoms/Dropdown.js:680-683` falls back to
  `aria-label=placeholder || "Select an option"`. That **overrides** the visible label. When `id`/`labelId` is present, use
  `aria-labelledby` and drop the fallback. (`atoms-groups/CustomDropdown` also passes `disable` where Dropdown expects `disabled`.)
- [ ] `atoms/RadioButtons.js:25,34-39`: inputs get `${id}-0` ids; the wrapper div has `aria-label` but no role.
  Error id is hard-coded `radio-error` (38,132). **Fix:** `role="radiogroup"` + `aria-labelledby`, `${id}-error`.
  `molecules/CustomDropdown.js:89` never passes `name` to radios.
- [ ] `atoms/MultiSelectDropdown.js:844`: id sits on a wrapper div. Move it to the combobox/input (line ~860).
- [ ] Standalone inputs with no name: `ToggleSwitch.js:8-25`, `Numeric.js:44`, `PlusMinusInput.js:31`,
  `molecules/DateRangeNew.js:139` (calendar icon at 140 is mouse-only), `TextInput.js:333` (newDateFormat DatePicker),
  `UploadFile.js:81` (random id every render), `molecules/TextInputCard.js:24-25`, `OTPInput.js:148` (`otp-label` id missing at 144).
- [ ] `TextInput.js:532/681`: placeholder used as `aria-label` overrides the visible label. Prefix/suffix `<button>` (138/166) has no `type="button"`.

### 2.2 Error / state linkage
- [ ] `atoms/ErrorMessage.js` has **no `id` prop**, so `aria-describedby={id}-error` in `TextInput.js:327,533,682`
  points at nothing. Add an `id` prop. FieldV1 (~line 107) passes `${fieldId}-error`.
- [ ] Pass `required` + `error` to every control, and set `aria-required`, `aria-invalid`, `aria-describedby`
  (currently only TextInput does; TextArea lacks all three).
- [ ] `FileUpload.js:302` & `529`: `inputId` is generated twice via `getRandomId()`, so `aria-describedby` (370,382) never matches the hint (551).

### 2.3 Icons and icon-only buttons
- [ ] `react/svg-components/src/svg/*.js` (855 files): no `aria-hidden`, `focusable`, `role`, or `<title>`; only ~21 forward `...props`.
  - Quick fix: `utils/iconRender.js:10-24`: `React.cloneElement(svgElement, { "aria-hidden": true, focusable: "false" })`
    (works because icons are called as functions and return the `<svg>` element).
  - Proper fix: codemod or shared `IconBase`. Default to decorative; when `title`/`aria-label` is passed, use `role="img"` + `<title>`.
- [ ] `atoms/Button.js:135-137`: `aria-label={props?.ariaLabel || formattedLabel}` gives `aria-label=""` for icon-only buttons,
  and `title=""` is always emitted. **Fix:** `aria-label={ariaLabel ?? (formattedLabel ? undefined : title || humanize(icon))}`,
  omit an empty title, and log a dev `console.warn` when the button is icon-only with no name.
- [ ] `atoms/Button.js:148`: `<h2>` inside `<button>`. Use `<span>`. The same applies to `InfoButton.js:64` (`<h1>`), `SubmitBar.js:41`, `ButtonSelector.js:33`.
- [ ] `atoms/Button.js:138`: `aria-haspopup="menu"` but `Menu` renders `role="listbox"`.
- [ ] `atoms/InfoButton.js:47-66`: no `aria-label` forwarding.
- [ ] `atoms/SVG.js:790-817`: without `onClick` the icon renders with no `aria-hidden`; with `onClick` it renders a `span role=button` with a
  hard-coded English name. Add an `ariaLabel` prop and prefer a real `<button type="button">`.
- [ ] `atoms/CustomSVG.js`: icons use `role={onClick?"button":"img"}` + a fixed English `aria-label` (e.g. 111-112, 1041).
  `DocumentSVG` (653-655) and `SearchIconSvg` (713-715, 774, 838) are **always** `role=button tabIndex=0`, which gives nested-interactive inside a Button.
  Make them interactive only with `onClick`; otherwise `aria-hidden`.

### 2.4 App shell, landmarks, headings
- [ ] Shell components render plain divs: `AppContainer.js:7`, `BodyContainer.js:6`, `HeaderBar.js:6`, `Header.js:54/84`,
  `Hamburger.js:283`, `HomeFooter.js:9`. **Provide:** a single `<header>` (top bar only), `<nav aria-label>`,
  one `<main id="main-content" tabIndex={-1}>`, `<footer>` (HomeFooter, **not** `Footer.js`, which is the in-page action bar),
  and a `SkipLink` as the first child of AppContainer. Add an `as` / `landmark={false}` opt-out for products with their own shell.
- [ ] `molecules/LandingPageWrapper.js:76`: `role="main"` + `aria-live="polite"` gives a duplicate/nested main and re-announces the page. Remove both.
- [ ] `atoms/SearchComponent.js:179`: `role="banner"`. Remove it and make the title a heading. Ids `search-header`/`search-instructions` repeat across instances.
- [ ] `<header>` used for text: `Banner.js:18,66`, `CollapseAndExpandGroups.js:19`, `ConnectingCheckPoints.js:7-8` (the latter also has an empty `<h2>`). Use headings with a level prop or divs; use `<ol>/<li>` for checkpoints.
- [ ] `atoms/HorizontalNav.js:30`: fixed `aria-label="Secondary"`. Accept an `ariaLabel` prop, or use tablist semantics (it switches sections).
- [ ] `role="region"` with fixed labels (fails landmark-unique when repeated): `SidePanel.js:152,192,199,211`, `PanelCard.js:102` (+aria-live),
  `BottomSheet.js:123`, `Timeline.js:142`, `Accordion.js:115`, `FilterCard.js:140,238,251`, `MultiSelectDropdown.js:917,942`.
  Keep region only with `aria-labelledby` pointing at a visible title; otherwise drop the role.
- [ ] `SidePanel.js:110`: `role="complementary"`, label "Side panel expanded". Take an `ariaLabel` prop.
- [ ] **Headings regression from PR #443:** CardHeader/HeaderComponent now render **no heading at all**, so page titles
  (`hoc/InboxSearchComposer.js:240`) and section titles (`hoc/FormComposerV2.js:203-305,376-378`) are not headings.
  HeaderComponent also drops the `id` prop (`id={section.headId}` at FormComposerV2 205/210/223).
  **Fix:** `level` prop (1–6) that renders `<hN>`. Page title default 1, sections 2. Forward `id`/rest props.
- [ ] Hard-coded headings used as labels/values: `CardLabel.js:6`, `CardLabelError.js:6`, `AlertCard.js:41`, `UploadFile.js:79`,
  `CitizenInfoLabel.js:14`, `KeyNote.js:7`, `DetailsCard.js:17`, `CardBasedOptions.js:27`, `ErrorBoundary.js:32`,
  `CitizenHomeCard.js:8`, `WhatsNewCard.js:13`. Fixed `aria-level`: `LandingPageCard.js:70`, `NestedTable.js:83-84`.

---

## 3. Priority 2: invalid ARIA structure

- [ ] `atoms/Dropdown.js:777/828`: `role="listbox"` children are `role="button"` divs (479), unroled category headers (584),
  no-results div (797). Listbox has no name. Every instance uses `id="jk-dropdown-unique"`. Combobox has no `aria-controls`.
  **Fix:** `role="option"` + `aria-selected`, `role="group"` for categories, `useId` ids, `aria-controls`, `aria-activedescendant`.
- [ ] `atoms/MultiSelectDropdown.js:675-707,746-755,806-822`: focusable checkbox inside `role="option"`; `aria-owns` (857) points at a region;
  duplicate ids `jk-dropdown-unique`/`dropdown-description`/`option-desc-N`; empty-state option (776) sits outside a listbox.
- [ ] `atoms/TreeSelect.js`: `aria-expanded` (28) and `aria-label` (29) on role-less div; `role=button` wraps a native checkbox and an
  unnamed `role=checkbox` (136/170/178); no `aria-checked="mixed"`. Use tree/treeitem/group.
- [ ] `atoms/Menu.js:54-91`: listbox contains a search TextInput and a no-results div; all options `tabIndex=0` with no key handler;
  duplicate ids `option-N` / `header-dropdown-unique`. Move search out and use menu/menuitem or listbox/option with roving focus.
- [ ] `atoms/CheckBox.js:57-63,141-147`: `<label role="button" tabIndex=0>`; `<p tabIndex=0>` (106) is a fake control while the real
  input is `tabIndex=-1` (98); redundant `aria-checked` (103). Keep the native input focusable and set `indeterminate`.
- [ ] Nested interactive:
  - `Chip.js:42-51` (role=button contains remove span role=button at 69)
  - `Timeline.js:161` (div role=button wraps `<Button>`)
  - `molecules/DetailsCard.js:10,48-64,84-105` (Details always role=button, inside `<Link>`, inside focusable listitem; `<a>` between list and listitem)
  - `molecules/FilterCard.js:190-216` (overlay role=button wraps the dialog)
  - `molecules/MenuCard.js:79` (default `onClick` makes `Card.js:27-33` always role=button; Card may contain form controls)
- [ ] Always-interactive: `Tag.js:58-68` (role=button even without onClick; Enter throws TypeError).
- [ ] `aria-allowed-role`: `LinkLabel.js:11` and `UploadImage.js:318-338` use `<label role="button">`; `UploadImage.js:359` has a hard-coded `id="file"`; delete span (233) is not focusable.
- [ ] `aria-required-parent`: `UploadImage.js:209`, `UploadWidget.js:154/160` (listitem with no list).
- [ ] Dangling id references (`aria-valid-attr-value`): `Tab.js:62-80` (`aria-controls` → missing tabpanels),
  `Stepper.js:96-97,118` (`stepper-heading`, `stepper-description`, `step-${i}-status`), `Timeline.js:74` (`timeline-label-${label}`, may contain spaces).
- [ ] `ActionLinks.js:14`: default `aria-label="Action link"` hides the visible text (label-content-name-mismatch).
- [ ] `DisplayPhotos.js:9-11`: PDF link contains only an svg; img alt is the generic "Image".
- [ ] `Rating.js:13-44`: stars are span role=button labelled "Star Filled"/"Star Empty". Use a radiogroup (`aria-label="3 of 5"`), or `role=img` when read-only.

## 4. Priority 3: keyboard, dialogs, tables, contrast

- [ ] **Scrollable containers** (CSS in `react/css/src/digitv2/components/`) need `tabIndex={0}` + a content-derived label when they overflow:
  `.digit-table-container` (`tableV2.scss:10`; `TableMolecule.js:267`, `NestedTable.js:26`),
  `.digit-panelcard-children-wrap` (`panelCardV2.scss:47`; `PanelCard.js:96`),
  `.slider-body` (`sidePanelV2.scss:172`; `SidePanel.js:186`),
  `.digit-bottom-sheet-content` (`bottomSheetV2.scss:67`; `BottomSheet.js:119`).
- [ ] **Keyboard:**
  - `Tab.js`: no Arrow/Home/End keys, so inactive tabs (tabIndex −1) are unreachable.
  - `Hamburger.js:158-163,218-223` (div onClick tabIndex=0, no role/keys/aria-expanded) and `:237-241,309-312` (no tabIndex).
  - `Header.js:67,95,111,145`: clickable images.
  - `TableRow.js:6`: clickable rows.
  - `HamburgerButton.js:14`: no `aria-expanded`.
- [ ] **Dialogs:** build one `useDialog` hook (role=dialog, aria-modal, aria-labelledby, focus trap, Escape, restore focus) for
  `PopUp.js:143-160` (no role/label; overlay tabIndex=0 gets initial focus; `handleKeyDown` 123-129 fires submit on *any* Enter),
  `FilterCard.js`, `BottomSheet.js:99-112` (resize separator is mouse-only). `hoc/Modal.js:40` and `hoc/EditablePopup.js:82` inherit PopUp.
- [ ] **Tooltip** `Tooltip.js:7-9`: `role=tooltip` with tabIndex=0, not linked via `aria-describedby`, no Escape. `TooltipWrapper.js:119` passes `tooltipRef` to a DOM element.
- [ ] **Toast** `Toast.js:62-69,113-114`: live region mounts together with its content (keep the container mounted); "NO"/"YES" hard-coded.
- [ ] **Tables:**
  - `TableMolecule.js:345-352`: no `aria-sort`; sort control label is just "sort". Use "Sort by {column}".
  - `TableCell.js:197`: header cells have no `scope="col"`.
  - `TableMain.js:6` and `Table.js:156`: no caption or label.
- [ ] **Contrast** (tokens: `constants/colors/colorconstants.js`, `react/css/src/theme-variables.css`):

  | Pair | Ratio | Suggested fix |
  |---|---|---|
  | text-secondary `#787878` on white (captions, helper, breadcrumb, stepper, tab…) | 4.42 | `#6B6B6B` (~5.3) |
  | `#787878` on `#EEEEEE` / `#FAFAFA` | 3.81 / 4.23 | same as above |
  | placeholder = text-disabled `#C5C5C5` (`textInputV2.scss:129`) | 1.73 | separate placeholder token ≥ `#767676` |
  | white on warning toast `#F19100` (`toastV2.scss:36/47`) | 2.39 | dark text, or bg `#9E5F00` |
  | primary-1 `#C84C0E` on primary-bg `#FBEEE8` | 4.11 | `#B4440C` for text on that bg |
  | divider `#D6D5D4`, switch track `#BFBFBF` (non-text, needs 3:1) | 1.47 / 1.84 | ≥ `#949494` |

  Passing: primary-1 on white (4.67), text-primary `#363636` (12.1), primary-2 `#0B4B66` (9.1), status tag colours (4.9–6.1).

## 5. Priority 4: regression prevention

- `@storybook/addon-a11y` is installed (`react/storybook/.storybook/main.js`) but only used as a manual panel.
- [ ] Add `@storybook/test-runner` with axe checks on every story; fail CI on serious/critical violations.
- [ ] Add `eslint-plugin-jsx-a11y` (only `babel-eslint` is configured today).
- [ ] After each phase, re-scan one HCM Console page and one Studio page with the DIGIT Accessibility Scanner to confirm.

## 6. Already in good shape (don't regress)

Accordion (button + aria-expanded/controls + region via aria-labelledby), Toast/AlertCard live roles, SelectionTag,
Toggle (native radios), BreadCrumb (`nav`, `aria-current`), BackLink, CardBasedOptions, Stepper `aria-current="step"`,
Switch naming, Dropdown text-field combobox semantics, TextInput main inputs, SideNav tree, DatePicker (when given an id),
LabelFieldPair/SearchForm layout wrappers. `hoc/Fields.js` is marked unused.

## 7. Suggested rollout

1. **Phase 1** (§2.1–2.3): FieldV1 id/label/error contract, `ErrorMessage` id, RenderFormFields/FieldComposer, Dropdown label forwarding,
   iconRender `aria-hidden`, Button/InfoButton naming. This clears most Severe findings.
2. **Phase 2** (§2.4): landmarks, skip link, heading `level` prop. Release as a minor version with an opt-out, because products
   that render their own `<main>` need to opt out.
3. **Phase 3** (§3): ARIA structure, component by component.
4. **Phase 4** (§4–5): keyboard, dialogs, tables, contrast tokens, CI gate.

Some audit items remain product-side: page `<h1>`, custom markup, positive tabindex.

## 8. Progress log

| Date | Change | PR / commit |
|---|---|---|
| 2026-09-22 | Landmarks/Switch names, SideNav/SidePanel/TextArea, Dropdown/TextInput | #443 |
| 2026-10-09 | This audit document created | — |
| 2026-10-09 | Broad 84-file pass reverted (behaviour/id/label changes) | not committed |
| 2026-10-11 | Verified attribute-only fixes: Tab, Dropdown, MultiSelectDropdown, TableMolecule (−63 axe violations, 0 new) | branch `feature/a11y-markup-fixes` |
| 2026-10-12 | Second round: Button, Menu, CheckBox, CustomSVG, UploadFile, RenderFormFields, Dropdown no-results (stories −68, extra cases −47, 0 new) | branch `feature/a11y-markup-fixes` |
