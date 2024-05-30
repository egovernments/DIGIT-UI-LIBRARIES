
# digit-ui-components

## Install

```bash
npm install --save @egovernments/digit-ui-components
```

## Limitation

```bash
This Package is more specific to DIGIT-UI's can be used across mission's
```

## Usage

After adding the dependency make sure you have this dependency in

```bash
frontend/micro-ui/web/package.json
```

```json
"@egovernments/digit-ui-components":"0.0.1",
```

then navigate to App.js

```bash
 frontend/micro-ui/web/src/App.js
```

# Syntax for importing any components

```jsx
import { SVG } from "@egovernments/digit-ui-components";

<SVG.Accessibility />;
```

# Local Development
Use Node 14 version 

Step 1

 ```bash
yarn install 
```

Step 2

 ```bash
yarn storybook 
```


# Changelog

```bash
0.0.1-beta.31 Added new prop named isActive in Stepper
0.0.1-beta.30 Updated Panel Animation Styles
0.0.1-beta.29 Added PopUp,Panels and Panel Cards
0.0.1-beta.28 Added restrictSelection prop in MultiSelectDropdown
0.0.1-beta.27 Added uploader variants and its CSS
0.0.1-beta.26 Updated Toast Usage
0.0.1-beta.25 Updated RemoveableTag component to have error 
0.0.1-beta.24 Updated numeric type to disable input and use only buttons and made date and time fields clickable
0.0.1-beta.23 Updated ErrorMessage component to have new props named showIcon,truncateMessage and maxLength
0.0.1-beta.22 From this version of ui-components the Toast component will have a new prop named type, replacing the seperate props for  info,warning and error
0.0.1-beta.21 Added categorySelectAllState in the nestedmultiselect variant of multiselectdropdown
0.0.1-beta.20 updated multiselectdropdown categoryselectall functionality and added key navigation for dropdown options 
0.0.1-beta.19 making CheckBox more customizable and adding custom color for Button
0.0.1-beta.18 updated dropdown option labels
0.0.1-beta.17 updated toast info varinat css and category option css 
0.0.1-beta.16 added erroe boundary atom
0.0.1-beta.15 added info varinat for toast
0.0.1-beta.14 updated dropdown options label to use optionsKey
0.0.1-beta.13 nested and tree dropdown varinat updated
0.0.1-beta.12 enhancements of components
0.0.1-beta.11 updated mobilenumber classname
0.0.1-beta.10 updated header and textinput classnames
0.0.1-beta.9 updated key to IS_STRING_MANIPULATED
0.0.1-beta.8 Updated the string manipulation based on globalConfig flag isStringManipulated
0.0.1-beta.7 updated classnames 
0.0.1-beta.6 updated version
0.0.1-beta.5 modified classnames
0.0.1-beta.4 fixed some date issues 
0.0.3 Added new components
0.0.1 base version
```

## [0.0.1-beta.28] - 2024-05-24

### New Changes

- Added restrictSelection prop in Multiselectdropdown. If this is sent as true, it restricts any option to get selected. 

  - Usage:
    ```jsx
        <MultiSelectDropdown
          restrictSelection={true}
        />
    ```



## [0.0.1-beta.22] - 2024-05-20

### Breaking Changes

- Toast Component: From this version of `ui-components`, the `Toast` component has a new prop named `type`, replacing the separate props for `info`, `warning`, and `error`.
  - Old Usage:
    ```jsx
        <Toast info={true} label={"Info Toast"} />
        <Toast warning="warning" label={"Warning Toast"}/>
        <Toast error={true} label={"Error Toast"}/>
    ```
  - New Usage:
    ```jsx
        <Toast type="info" label={"Info Toast"} />
        <Toast type="warning" label={"Warning Toast"} />
        <Toast type="error" label={"Error Toast"} />
        <Toast type="success" label={"Success Toast"} />
    ```


## Published from DIGIT Core

Digit Core Repo (https://github.com/egovernments/Core-Platform/tree/digit-ui-core)

# Contributors

[nabeelmd-egov] [anilsingha-eGov] [nipunarora-eGov] [swathi-egov] [jagankumar-egov]

# Reference

Home Page (https://unified-dev.digit.org/storybook/)

## License

MIT © [jagankumar-egov](https://github.com/jagankumar-egov)

![Logo](https://s3.ap-south-1.amazonaws.com/works-dev-asset/mseva-white-logo.png)

