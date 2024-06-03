<!-- TODO: update this -->

# digit-ui-css

## Install

```bash
npm install --save @egovernments/digit-ui-components-css
```

## Limitation

```bash
This Package is more specific to DIGIT-UI's can be used across mission's
It is the base css for all Digit UI's
```

## Usage

After adding the dependency make sure you have this dependency in

```bash
frontend/micro-ui/web/package.json
```

```json
"@egovernments/digit-ui-components-css":"0.0.2",
```

then navigate to App.js

```bash
frontend/micro-ui/web/public/index.html
```

```jsx
/** add this import **/

  <link rel="stylesheet" href="https://unpkg.com/@egovernments/digit-ui-components-css@0.0.2/dist/index.css" />

```
## Changelog

### Summary for Version [0.0.2] - 2024-06-03

#### New Changes

- Added Error Message Component.
- Added Info Button Component.
- Added Panels Component.
- Added Popup Component with two variants: `default` and `alert`.
- Added RemoveableTag Component.
- Added Stepper Component.
- Added TextBlock Component.
- Added Timeline Component.
- Added Uploader Component with three variants: `UploadFile`, `UploadPopup`, and `UploadImage`.
- Added PanelCard Molecule.

#### Enhancements

- Updated Button Component Styles.
- Updated Dropdown Component Styles and added SelectAll Option.
- Updated InfoCard Component Styles.
- Added Animation for Toast.
- Added new prop `type` for Toast, replacing the separate props for `info`, `warning`, and `error`.
- Updated Typography with lineHeight.
- Updated Color Typography.

For a detailed changelog, see the [CHANGELOG.md](./CHANGELOG.md) file.

## Published from DIGIT-UI-LIBRARIES

DIGIT-UI-LIBRARIES Repo (https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/master)

# Contributors

[jagankumar-egov] [nipunarora-eGov] [Tulika-eGov] [Ramkrishna-egov] [nabeelmd-eGov] [anil-egov] [swathi-egov]

## License

MIT © [jagankumar-egov](https://github.com/jagankumar-egov)