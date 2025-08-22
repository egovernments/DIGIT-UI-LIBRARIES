# **Upgrading DIGIT for React 19 and Node 20 Compatibility: Key Changes and Improvements**

## **Introduction**

This document outlines the key upgrades and changes implemented to ensure **DIGIT** remains fully compatible with **React 19** and **Node 20**. The primary focus of these updates includes the following core libraries and components:

* `@egovernmentdigit-ui-react-components`

* `@egovernment/digit-ui-components`

* `@egovernment/digit-ui-svg-components`

* `@egovernment/digit-ui-libraries`

Additionally, these updates extend to **core and workbench modules**, ensuring that all aspects of the DIGIT platform remain up-to-date and function as expected.

Beyond dependency upgrades, we have also migrated from **Microbundle** to **Webpack**, significantly improving build performance, modular bundling, and overall flexibility. This transition enhances the development workflow, eliminates previous limitations, and paves the way for better maintainability.

This document provides a comprehensive breakdown of the upgrades, the challenges addressed, and the resulting improvements. It serves as a valuable reference for future maintenance and further enhancements.

# **DIGIT-UI-LIBRARIES: `develop-webpack` Branch**

The **`DIGIT-UI-LIBRARIES`** repository and its **`develop-webpack`** branch contain all the upgraded packages. This section provides a detailed breakdown of each package, covering:

* The changes made

* Challenges encountered

* Solutions implemented during the upgrade process

## **1\. Major Updates**

This package underwent significant modifications, including:

* **Upgrading dependencies** to ensure compatibility with **React 19**

* **Refactoring code** to align with the latest dependency syntax changes

* **Migrating the build system** from **Microbundle** to **Webpack**

### **Changes in `package.json`**

The `package.json` file was updated to support the latest dependencies required for **React 19 compatibility**. Key updates include:

* **Upgrading `react-router-dom` from version 5 to version 6**

* Updating other dependencies to match the latest React ecosystem requirements

Since we migrated from **Microbundle to Webpack**, the **build script** was also updated accordingly. More details on **Webpack configurations** will be discussed later in this document. Additionally, **Webpack-specific `devDependencies`** have been added to support this transition.

Below is the latest `package.json` file for this package:

(*Insert package.json content here*)

---

## **2\. Code & Syntax Changes for Latest Dependencies**

Several major dependency updates required code modifications, particularly in the following libraries:

* `react-router-dom`

* `react-i18next`

* `@tanstack/react-query`

These changes ensure smooth integration with **React 19** while leveraging the latest features and best practices.

---

## **3\. Migration to Webpack from Microbundle**

Previously, the **Microbundle** tool was used for building packages. As part of this upgrade, we have migrated to **Webpack**, which offers:

* **Better build performance**

* **Improved modular bundling**

* **Greater flexibility** in configuration

This migration required the addition of:

* A **dedicated Webpack configuration file (`webpack.config.js`)**

* A **Babel configuration file (`.babelrc`)**

### **Key Webpack Configuration Details**

The most critical elements in the **Webpack configuration** are:

* **Entry file:** `index.js`

* **Output file:** `main.js` (generated under `dist/` after compilation)

Below is the `webpack.config.js` and `.babelrc` configuration:

*`webpack.config.js`*

| *const path \= require("path"); module.exports \= {   mode: "production",   entry: "./src/index.js",   output: {     filename: "main.js",     path: path.resolve(\_\_dirname, "dist"),     library: {       name: "@egovernments/digit-ui-components",       type: "umd",     },     globalObject: 'this', // Add this line to ensure compatibility in different environments   },   resolve: {     extensions: \[".js"\],   },   externals: {     react: {       commonjs: 'react',       commonjs2: 'react',       amd: 'react',       root: 'React',     },     'react-dom': {       commonjs: 'react-dom',       commonjs2: 'react-dom',       amd: 'react-dom',       root: 'ReactDOM',     },     'react-i18next': 'react-i18next',     'react-router-dom': 'react-router-dom'   },   module: {     rules: \[       {         test: /\\.js$/,         exclude: /node\_modules/,         use: {           loader: "babel-loader",           options: {             presets: \["@babel/preset-env", "@babel/preset-react"\],           },         },       },     \],   }, };*  |
| :---- |

*`.babelrc`*

| *`{   "presets": ["@babel/preset-env", "@babel/preset-react"] }`* |
| :---- |

## 

## 

## 

## 

## 

## 

## 

## 

## 

## **Publishing Updated Packages**

### **Version Updates for Packages:**

Once all changes were completed, the packages were assigned new versions and published. Below is a list of updated versions:

| Package Name | Version |
| ----- | ----- |
| `@egovernments/digit-ui-libraries` |  |
| `@egovernments/digit-ui-components` |  |
| `@egovernments/digit-ui-react-components` |  |
| `@egovernments/digit-ui-svg-components` |  |

### **GitHub Actions for Automated Publishing**

Since there were modifications in the build process, the GitHub Actions workflow was updated accordingly. Below is the modified GitHub Actions file handling the package publishing process:

| *name: Node.js Publish UI Packages on:   push:     branches: \[ 'develop-webpack' \]     paths:       \- 'webpack/react-components/\*\*'       \- 'webpack/svg-components/\*\*'       \- 'webpack/ui-components/\*\*'       \- 'webpack/libraries/\*\*'       \- 'react/modules/core/\*\*' jobs:   setup-python-and-build-tools:     name: Set up Python and Build Tools     runs-on: ubuntu-latest     steps:       \- name: Update apt and install Python 3 and build tools         run: |           sudo apt-get update           sudo apt-get install \-y python3 python3-pip python3-setuptools build-essential           sudo apt-get install \-y python3-distutils || sudo apt-get install \-y python3-dev   publish-webpack-ui-components:      name: Publish Webpack UI Components     runs-on: ubuntu-latest     steps:       \- uses: actions/checkout@v2       \- uses: actions/setup-node@v2         with:           node-version: 20           registry-url: https://registry.npmjs.org/       \- name: Install dependencies for SVG Components         run: |           cd webpack/ui-components/           rm \-rf node\_modules yarn.lock           yarn install \--frozen-lockfile           npm publish \--tag core-webpack-v0.1         env:           NODE\_AUTH\_TOKEN: ${{ secrets.npm\_token }}   publish-webpack-react-components:     name: Publish Webpack React Components     runs-on: ubuntu-latest     steps:       \- uses: actions/checkout@v2       \- uses: actions/setup-node@v2         with:           node-version: 20           registry-url: https://registry.npmjs.org/       \- name: Install dependencies for Webpack React Components         run: |           cd webpack/react-components/           rm \-rf node\_modules yarn.lock           yarn install \--frozen-lockfile           npm publish \--tag core-webpack-v0.1         env:           NODE\_AUTH\_TOKEN: ${{ secrets.npm\_token }}   publish-webpack-svg-components:     name: Publish Webpack SVG Components     runs-on: ubuntu-latest     steps:       \- uses: actions/checkout@v2       \- uses: actions/setup-node@v2         with:           node-version: 20           registry-url: https://registry.npmjs.org/       \- name: Install dependencies for Webpack SVG Components         run: |           cd webpack/svg-components/           rm \-rf node\_modules yarn.lock           yarn install \--frozen-lockfile           npm publish \--tag core-webpack-v0.1         env:           NODE\_AUTH\_TOKEN: ${{ secrets.npm\_token }}   publish-react-module-libraries:     name: Publish React Module Libraries     runs-on: ubuntu-latest     steps:       \- uses: actions/checkout@v2       \- uses: actions/setup-node@v2         with:           node-version: 20           registry-url: https://registry.npmjs.org/       \- name: Install dependencies for React Libraries         run: |           cd webpack/libraries/           rm \-rf node\_modules yarn.lock           yarn install \--frozen-lockfile           npm publish \--tag libraries-v0.1         env:           NODE\_AUTH\_TOKEN: ${{ secrets.npm\_token }}   publish-react-module-core:     name: Publish React Module Core     runs-on: ubuntu-latest     steps:       \- uses: actions/checkout@v2       \- uses: actions/setup-node@v2         with:           node-version: 20           registry-url: https://registry.npmjs.org/       \- name: Install dependencies for React Core         run: |           cd react/modules/core/           rm \-rf node\_modules yarn.lock           yarn install \--frozen-lockfile           npm publish \--tag core-module-v0.1         env:           NODE\_AUTH\_TOKEN: ${{ secrets.npm\_token }}* |
| :---- |

---

## **Challenges Faced During Publishing**

### **Issue: 404 Package Not Found Error**

* During the publishing process, we encountered an error where the package was not found (404 error).  
* **Solution:** The issue was resolved by upgrading the package versions to ensure no conflicts with existing published versions.

# **Testing the upgraded packages in the DIGIT Application**

## **Overview**

To ensure the seamless integration of upgraded packages in the DIGIT application, we conducted a structured testing approach. This involved testing each package in isolation using a simple React application and then integrating them into the core DIGIT module to verify compatibility and stability.

---

## **1\. Testing Upgraded Packages in a Simple React Application**

Before integrating the upgraded packages into the DIGIT application, we created a minimal React application to test their functionality. The following steps were performed:

1. **Creating a simple React app**

   * A lightweight React application was set up to import and test components from each upgraded package.

   * The goal was to ensure that basic component rendering and interactions worked without errors.

2. **Observations and Results**

   * All packages performed as expected in the standalone React environment.

   * No major issues were encountered at this stage, indicating that the package upgrades were stable in an isolated setup.

---

## **2\. Integration Testing: Running Upgraded Packages in the DIGIT Core Module**

After verifying individual package functionality, the next step was to test their integration within the DIGIT application. This involved modifying configurations and dependencies in the core DIGIT module.

**2.1 Updating `package.json` in the DIGIT Frontend**

The `package.json` file in `DIGIT-Frontend/micro-ui/web/micro-ui-internals` was updated to include:

* The latest dependencies from the upgraded packages.

* Additional dependencies for compatibility with React 19\.

* Ensuring alignment with the existing DIGIT application setup.

Below is the updated `package.json` file:

| *{   "name": "egovernments",   "version": "1.0.0",   "main": "index.js",   "workspaces": \[     "packages/libraries",     "packages/react-components",     "packages/ui-components",     "example",     "packages/modules/\*"   \],   "author": "JaganKumar \<jagan.kumar@egov.org.in\>",   "license": "MIT",   "private": true,   "engines": {     "node": "\>=14"   },   "scripts": {     "start": "cross-env SKIP\_PREFLIGHT\_CHECK=true run-s build start:dev",     "sprint": "SKIP\_PREFLIGHT\_CHECK=true run-s start:script",     "start:dev": "run-p dev:\*\*",     "start:script": "./scripts/create.sh",     "build": "run-S build:\*\*",     "buildD:svg-components": "cd packages/svg-components && yarn build",     "build:ui-components": "cd packages/ui-components && yarn build",     "build:react-components": "cd packages/react-components && yarn build",     "build:libraries": "cd packages/libraries && yarn build",     "build:core": "cd packages/modules/core && yarn build",     "build:assignment": "cd packages/modules/assignment && yarn build",     "build:workbench": "cd packages/modules/workbench && yarn build",     "dev:example": "cd example && yarn start",     "clean": "rm \-rf node\_modules && yarn clean:ui-components && yarn clean:react-components && yarn clean:libraries && yarn clean:core && yarn clean:workbench && yarn clean:assignment && yarn clean:example && yarn clean:ui-components-dist && yarn clean:react-components-dist && yarn clean:libraries-dist && yarn clean:core-dist && yarn clean:workbench-dist && yarn clean:assignment-dist && yarn clean:yarnLock",     "clean-nm": "rm \-rf node\_modules && yarn clean:ui-components && yarn clean:react-components && yarn clean:libraries && yarn clean:core && yarn clean:assignment && yarn clean:example",     "clean-dist": "yarn clean:ui-components-dist && yarn clean:react-components-dist && yarn clean:libraries-dist && yarn clean:core-dist && yarn clean:assignment-dist && yarn clean:workbench-dist",     "clean:ui-components": "cd packages/ui-components && rm \-rf node\_modules",     "clean:react-components": "cd packages/react-components && rm \-rf node\_modules",     "clean:libraries": "cd packages/libraries && rm \-rf node\_modules",     "clean:core": "cd packages/modules/core && rm \-rf node\_modules",     "clean:workbench": "cd packages/modules/workbench && rm \-rf node\_modules",     "clean:assignment": "cd packages/modules/assignment && rm \-rf node\_modules",     "clean:example": "cd example && rm \-rf node\_modules",     "clean:ui-components-dist": "cd packages/ui-components && rm \-rf dist",     "clean:react-components-dist": "cd packages/react-components && rm \-rf dist",     "clean:libraries-dist": "cd packages/libraries && rm \-rf dist",     "clean:core-dist": "cd packages/modules/core && rm \-rf dist",     "clean:workbench-dist": "cd packages/modules/workbench && rm \-rf dist",     "clean:assignment-dist": "cd packages/modules/assignment && rm \-rf dist",     "clean:yarnLock": "rm \-rf yarn.lock"   },   "resolutions": {     "\*\*/@babel/runtime": "7.20.1",     "\*\*/babel-preset-react-app": "10.0.0",     "\*\*/styled-components": "5.0.0",     "fast-uri": "2.1.0"   },   "devDependencies": {     "clean-webpack-plugin": "^4.0.0",     "eslint-config-react-app": "^7.0.1",     "html-webpack-plugin": "^5.6.3",     "husky": "7.0.4",     "lint-staged": "12.3.7",     "npm-run-all": "4.1.5",     "prettier": "2.1.2",     "vite": "^6.1.0",     "webpack": "^5.97.1",     "webpack-cli": "^6.0.1",     "webpack-dev-server": "^5.2.0",     "dotenv-webpack": "^8.0.0"   },   "husky": {},   "lint-staged": {     "\*.{js,css,md}": "prettier \--write"   },   "eslintConfig": {     "extends": \[       "react-app"     \]   },   "dependencies": {     "@egovernments/digit-ui-components": "0.0.2-beta.4-webpack.2",     "@egovernments/digit-ui-react-components": "1.8.16-upgrade.2",     "@tanstack/react-query": "^5.62.16",     "lodash": "4.17.21",     "microbundle-crl": "0.13.11",     "process": "^0.11.10",     "react": "^19.0.0",     "react-dom": "^19.0.0",     "react-hook-form": "7.52.2",     "react-i18next": "15.0.0",     "react-redux": "^9.2.0",     "react-router-dom": "6.25.1"   } }* |
| :---- |

### **2.2 Updating `package.json` in `DIGIT-Frontend/micro-ui/web/micro-ui-internals/examples`**

Since the `examples` directory serves as the entry point for our application, it was crucial to update its dependencies to align with the latest package upgrades and ensure compatibility with React 19\.

Below is the updated `package.json` file:

| *{   "name": "@egovernments/digit-ui-example",   "version": "1.0.0",   "license": "MIT",   "private": true,   "homepage": "digit-ui",   "scripts": {     "start": "webpack serve \--config webpack.config.js \--mode development",     "start:old": "react-scripts start"   },   "devDependencies": {     "@egovernments/digit-ui-libraries": "1.8.1-upgrade.6",     "@egovernments/digit-ui-module-core": "1.9.1-test.100",     "@egovernments/digit-ui-components": "0.0.2-beta.4-webpack.2",     "@egovernments/digit-ui-react-components": "1.8.16-upgrade.2",     "@egovernments/digit-ui-module-assignment": "0.0.1",     "@egovernments/digit-ui-module-workbench": "1.0.19-test.1",     "http-proxy-middleware": "^1.0.5",     "react": "19.0.0",     "react-dom": "19.0.0",     "react-i18next": "15.0.0",     "react-router-dom": "6.25.1",     "react-scripts": "4.0.1",     "webpack": "^5.97.1",     "webpack-cli": "^6.0.1",     "webpack-dev-server": "^5.2.0",     "dotenv-webpack": "^8.0.0"   },   "browserslist": {     "production": \[       "\>0.2%",       "not dead",       "not op\_mini all"     \],     "development": \[       "last 1 chrome version",       "last 1 firefox version",       "last 1 safari version"     \]   } }* |
| :---- |

### **Key Changes and Updates**

1. **Latest Dependencies**

   * All upgraded dependencies have been incorporated to ensure stability and feature compatibility.

   * Updated critical libraries like React, React Router, and other essential dependencies.

2. **Migration from `react-scripts` to Webpack**

   * One of the most significant changes in this update is the removal of `react-scripts`.

   * We have transitioned to **Webpack** for build and compilation, providing greater flexibility and control over the bundling process.

   * A new build script using Webpack has been added to the `scripts` section.

3. **Webpack Integration**

   * To support this transition, Webpack and its necessary dependencies have been added under `devDependencies`.

   * This shift improves build performance, allows better optimizations, and reduces unnecessary dependencies.

In the next section, we will discuss the specific changes made for Webpack integration and the new configuration files added.

### **2.3 Webpack Configuration for the Example App**

Previously, the example application was built on top of **Create React App (CRA)**, which relied on `react-scripts` for compilation and bundling. However, since we have migrated to **Webpack**, we now require a dedicated **Webpack configuration file (`webpack.config.js`)** and a **Babel configuration file (`.babelrc`)** to handle the build process.

Below is the Webpack configuration file:

| *const path \= require("path"); const webpack \= require("webpack"); const HtmlWebpackPlugin \= require("html-webpack-plugin"); const { CleanWebpackPlugin } \= require("clean-webpack-plugin"); module.exports \= {   mode: "development", // Set mode to development   entry: path.resolve(\_\_dirname, 'src/index.js'),   devtool: "source-map", // Enable source maps for easier debugging in development   module: {     rules: \[       {         test: /\\.(js)$/,         exclude: /node\_modules/,         use: {           loader: "babel-loader",           options: {             presets: \["@babel/preset-env", "@babel/preset-react"\],             plugins: \["@babel/plugin-proposal-optional-chaining"\]           }         },       },       {         test: /\\.css$/i,         use: \["style-loader", "css-loader"\],       }     \],   },   output: {     filename: "\[name\].bundle.js",     path: path.resolve(\_\_dirname, "build"),     publicPath: "/",   },   optimization: {     splitChunks: {       chunks: 'all',       minSize: 20000,       maxSize: 50000,       enforceSizeThreshold: 50000,       minChunks: 1,       maxAsyncRequests: 30,       maxInitialRequests: 30     },   },   plugins: \[     new webpack.ProvidePlugin({       process: "process/browser",     }),     new CleanWebpackPlugin(),     new HtmlWebpackPlugin({ inject: true, template: "public/index.html" }),   \],   resolve: {     modules: \[path.resolve(\_\_dirname, 'src'), 'node\_modules'\],     extensions: \['.js', '.jsx', '.ts', '.tsx'\],     preferRelative: true, // Try resolving relatively if needed     fallback: {       process: require.resolve("process/browser"),     },   },   devServer: {     static: path.join(\_\_dirname, "dist"), // Change this to "dist"     compress: true,     port: 3000,     hot: true,     historyApiFallback: true,     proxy: \[       {         context: \["/egov-mdms-service",           "/access/v1/actions/mdms",           "/tenant-management",           "/user-otp",           "/egov-mdms-service",           "/mdms-v2",           "/egov-idgen",           "/egov-location",           "/localization",           "/egov-workflow-v2",           "/pgr-services",           "/filestore",           "/egov-hrms",           "/user-otp",           "/user",           "/fsm",           "/billing-service",           "/collection-services",           "/pdf-service",           "/pg-service",           "/vehicle",           "/vendor",           "/property-services",           "/fsm-calculator/v1/billingSlab/\_search",           "/pt-calculator-v2",           "/dashboard-analytics",           "/echallan-services",           "/egov-searcher/bill-genie/mcollectbills/\_get",           "/egov-searcher/bill-genie/billswithaddranduser/\_get",           "/egov-searcher/bill-genie/waterbills/\_get",           "/egov-searcher/bill-genie/seweragebills/\_get",           "/egov-pdf/download/UC/mcollect-challan",           "/egov-hrms/employees/\_count",           "/tl-services/v1/\_create",           "/tl-services/v1/\_search",           "/egov-url-shortening/shortener",           "/inbox/v1/\_search",           "/inbox/v2/\_search",           "/tl-services",           "/tl-calculator",           "/org-services",           "/edcr",           "/hcm-moz-impl",           "/bpa-services",           "/noc-services",           "/egov-user-event",           "/egov-document-uploader",           "/egov-pdf",           "/egov-survey-services",           "/ws-services",           "/sw-services",           "/ws-calculator",           "/sw-calculator/",           "/audit-service/",           "/egov-searcher",           "/report",           "/inbox/v1/dss/\_search",           "/loi-service",           "/project/v1/",           "/estimate-service",           "/loi-service",           "/works-inbox-service/v2/\_search",           "/egov-pdf/download/WORKSESTIMATE/estimatepdf",           "/muster-roll",           "/individual",           "/mdms-v2",           "/facility/v1/\_search",           "/project/staff/v1/\_create",           "/product/v1/\_create",           "/boundary-service",           "/project-factory",           "/project-factory/v1/data/\_autoGenerateBoundaryCode",           "/billing-service/bill/v2/\_fetchbill",           "/tenant-management",           "/default-data-handler",           "/facility/v1/\_create"         \], // Add all endpoints that need to be proxied         target: "https://unified-qa.digit.org",         changeOrigin: true,         secure: false,       },     \], } };* |
| :---- |

### **Key Changes and Considerations**

1. **Replacing `react-scripts` with Webpack**

   * CRA previously handled bundling and compilation internally via `react-scripts`.

   * Now, Webpack explicitly manages the entire build process, allowing greater customization and optimizations.

2. **Handling Proxy Configuration Inside Webpack**

   * One critical change is the migration of **proxy settings** from the separate `setupProxy.js` file to **inside the Webpack config itself**.

   * This change was necessary because Webpack does not recognize `setupProxy.js`, which was previously utilized by `react-scripts`.

   * Integrating proxies directly within `webpack.config.js` ensures smooth API request handling and local development without additional configurations.

### **2.4 Adding the Core Module Locally for Testing**

Since the **Core Module** was not upgraded along with the other packages, we added it locally inside:

📂 `DIGIT-Frontend/micro-ui/web/micro-ui-internals/packages/modules`

### **Key Updates & Changes**

#### **(a) Migration to Webpack**

Similar to other packages, we migrated the **Core Module** from **Microbundle** to **Webpack** for better compatibility and optimization. Below is the updated **Webpack configuration file**:

| *const path \= require("path"); module.exports \= {   mode: "development",   entry: "./src/Module.js",   output: {     filename: "main.js",     path: path.resolve(\_\_dirname, "dist"),     library: {       name: "@egovernments/digit-ui-module-core",       type: "umd",     },     globalObject: 'this', // Add this line to ensure compatibility in different environments   },   resolve: {     extensions: \[".js"\],   },   externals: {     react: {       commonjs: 'react',       commonjs2: 'react',       amd: 'react',       root: 'React',     },     'react-dom': {       commonjs: 'react-dom',       commonjs2: 'react-dom',       amd: 'react-dom',       root: 'ReactDOM',     },     'react-i18next': 'react-i18next',     'react-router-dom': 'react-router-dom'   },   module: {     rules: \[       {         test: /\\.js$/,         exclude: /node\_modules/,         use: {           loader: "babel-loader",           options: {             presets: \["@babel/preset-env", "@babel/preset-react"\],           },         },       },     \],   }, };* |
| :---- |

#### **(b) Upgrading `package.json`**

The **Core Module’s** `package.json` was also updated to align with:

* The latest **package upgrades**  
* **React 19 compatibility**

| *{   "name": "@egovernments/digit-ui-module-core",   "version": "1.9.1-test.100",   "license": "MIT",   "main": "dist/main.js",   "module": "dist/main.js",   "source": "src/Module.js",   "files": \[     "dist"   \],   "scripts": {     "example": "cd example && npm run start",     "start": "react-scripts start",     "build": "webpack  \--mode=development \--node-env=production \--config webpack.config.js",     "prepare": "yarn build",     "publish:components": "npm publish \--tag core-webpack-v0.1",     "predeploy": "cd example && yarn install && yarn run build",     "deploy": "gh-pages \-d example/build"   },   "dependencies": {     "@egovernments/digit-ui-components": "0.0.2-beta.4-webpack.2",     "@egovernments/digit-ui-react-components": "1.8.16-upgrade.2",     "@egovernments/digit-ui-module-workbench": "1.0.19-test.1",     "@tanstack/react-query": "^5.62.16",     "react": "19.0.0",     "react-dom": "19.0.0",     "react-i18next": "11.16.2",     "react-redux": "7.2.8",     "react-router-dom": "5.3.0",     "react-tooltip": "4.1.2",     "redux": "5.0.0",     "redux-thunk": "2.4.1"   },   "author": "JaganKumar \<jagan.kumar@egov.org.in\>",   "keywords": \[     "digit",     "egov",     "dpg",     "digit-ui",     "core"   \],   "devDependencies": {     "sass": "^1.83.4",     "sass-loader": "^16.0.4",     "@babel/core": "^7.23.3",     "@babel/preset-env": "^7.23.3",     "@babel/preset-react": "^7.23.3",     "babel-loader": "8.0.0",     "cross-env": "7.0.3",     "lint-staged": "12.3.7",     "react": "19.0.0",     "react-dom": "19.0.0",     "webpack": "^5.97.1",     "webpack-cli": "^4.10.0"   } }* |
| :---- |

---

### **Resolving the `node-sass` Error**

After making these initial upgrades and changes, we attempted to run the application. However, we encountered a **"node-sass" error** during compilation.

#### **Debugging the Issue**

To diagnose the issue, we examined the dependency tree of `node-sass` using the following co

`npm list node-sass`

This command revealed multiple direct and indirect dependencies relying on `node-sass`.

#### **Solution: Removing Conflicting Dependencies**

To resolve the error, we removed all dependencies related to `node-sass`, including:

* `digit-ui-css`  
* `react-scripts` (which was no longer needed after the migration to Webpack)

After these fixes, the application compiled **successfully**.

### **Further Issues and Fixes in the Example App**

After successfully compiling the application, we encountered a few additional errors that required resolution.

---

### **1\. Error: "Digit Not Defined"**

#### **Issue:**

After upgrading the **Example App** to **React 19**, the application failed to recognize **"Digit"**, causing the screen to break with the following error:

Uncaught ReferenceError: Digit is not defined

#### **Root Cause:**

The error occurred due to changes in the **execution order** of modules. The previous approach, which worked before the upgrade, was no longer compatible with the updated **React 19** environment.

#### **Solution:**

To resolve this issue, we **restructured the execution order** using **lazy loading**. This ensures that modules are loaded dynamically and in the correct sequence.

Below is the updated **`index.js`** file for the Example App:

| *import React, { useEffect, useState, lazy, Suspense } from "react"; import ReactDOM from "react-dom/client"; // Use createRoot from React 18 import { initGlobalConfigs } from "./globalConfig"; import {initAssignmentComponents} from "@egovernments/digit-ui-module-assignment" // import {initWorkbenchComponents} from "@egovernments/digit-ui-module-workbench" import { BrowserRouter } from "react-router-dom"; import { QueryClient, QueryClientProvider } from "@tanstack/react-query"; import { Hooks } from "@egovernments/digit-ui-libraries"; // Ensure Digit is defined before using it window.Digit \= window.Digit || {}; window.Digit.Hooks \= Hooks;  const queryClient \= new QueryClient(); const DigitUILazy \= lazy(() \=\>   import("@egovernments/digit-ui-module-core").then((module) \=\> ({ default: module.DigitUI })) );import { initLibraries } from "@egovernments/digit-ui-libraries"; const enabledModules \= \["assignment", "HRMS", "Workbench"\]; const initTokens \= (stateCode) \=\> {   console.log(window.globalConfigs, "window.globalConfigs");   const userType \=     window.sessionStorage.getItem("userType") ||     process.env.REACT\_APP\_USER\_TYPE ||     "CITIZEN";   const token \=     window.localStorage.getItem("token") ||     process.env\[\`REACT\_APP\_${userType}\_TOKEN\`\];   const citizenInfo \= window.localStorage.getItem("Citizen.user-info");   const citizenTenantId \=     window.localStorage.getItem("Citizen.tenant-id") || stateCode;   const employeeInfo \= window.localStorage.getItem("Employee.user-info");   const employeeTenantId \= window.localStorage.getItem("Employee.tenant-id");   const userTypeInfo \=     userType \=== "CITIZEN" || userType \=== "QACT" ? "citizen" : "employee";   window.Digit.SessionStorage.set("user\_type", userTypeInfo);   window.Digit.SessionStorage.set("userType", userTypeInfo);   if (userType \!== "CITIZEN") {     window.Digit.SessionStorage.set("User", {       access\_token: token,       info: userType \!== "CITIZEN" ? JSON.parse(employeeInfo) : citizenInfo,     });   }   window.Digit.SessionStorage.set("Citizen.tenantId", citizenTenantId);   if (employeeTenantId && employeeTenantId.length) {     window.Digit.SessionStorage.set("Employee.tenantId", employeeTenantId);   } }; const initDigitUI \= () \=\> {   initGlobalConfigs(); // Ensure global configs are set first   // console.log("initWorkbenchComponents", initWorkbenchComponents)   // initWorkbenchComponents();   window.contextPath \=   window?.globalConfigs?.getConfig("CONTEXT\_PATH") || "digit-ui";      const stateCode \= Digit?.ULBService?.getStateId();      const root \= ReactDOM.createRoot(document.getElementById("root")); // ✅ React 18 uses createRoot()   root.render(     \<BrowserRouter\>\<QueryClientProvider client={queryClient            }\>\<MainApp stateCode={stateCode} enabledModules={enabledModules} /\>\</QueryClientProvider\>\</BrowserRouter\>); }; const MainApp \= ({ stateCode, enabledModules }) \=\> {   const \[isReady, setIsReady\] \= useState(false);   const \[loaded, setLoaded\] \= useState(false);            useEffect(() \=\> {          initLibraries().then(() \=\> {       console.log(Digit,window?.Digit);       // initAssignmentComponents();              setIsReady(true)     });     // initWorkbenchComponents();        }, \[\]);   useEffect(() \=\> {     initTokens(stateCode);      setLoaded(true);   }, \[stateCode,isReady\]);   if (\!loaded) {     return \<div\>Loading...\</div\>;   }   return (     \<Suspense fallback={\<div\>Loading...\</div\>}\>     {window.Digit && (       \<DigitUILazy         stateCode={stateCode}         enabledModules={enabledModules}         defaultLanding="home"       /\>     )}   \</Suspense\>   ); }; // Start the app initDigitUI();*  |
| :---- |

**Note:** Instead of `root.render()`, we’re using `ReactDOM.createRoot()` as per the latest React syntax changes.

---

### **2\. QueryClient Error \[Temporary Fix\]**

#### **Issue:**

After resolving the "Digit Not Defined" error, we successfully accessed `Digit` in the **window object**, but encountered **QueryClient errors**.

#### **Root Cause:**

Inside the **core module**, even though the application was wrapped inside `QueryClientProvider`, queryClient errors persisted. This was likely due to **different contexts** between the **modules/packages**.

#### **Solution:**

To resolve this, we imported the **libraries module** locally and extracted the `Hooks` from it inside the **core module**. Instead of setting up the hooks inside the **libraries** `init` function, we **moved them into the core module** and removed them from **libraries**.

Below are the changes made inside the **core module**:

| *import { BodyContainer } from "@egovernments/digit-ui-components"; import { Loader } from "@egovernments/digit-ui-components"; import React from "react"; import { getI18n } from "react-i18next"; import { QueryClient, QueryClientProvider } from "@tanstack/react-query"; import { Provider } from "react-redux"; import { BrowserRouter as Router } from "react-router-dom"; import { DigitApp, DigitAppWrapper } from "./App"; import SelectOtp from "./pages/citizen/Login/SelectOtp"; import ChangeCity from "./components/ChangeCity"; import ChangeLanguage from "./components/ChangeLanguage"; import { useState } from "react"; import ErrorBoundary from "./components/ErrorBoundaries"; import getStore from "./redux/store"; import PrivacyComponent from "./components/PrivacyComponent"; import OtpComponent from "./pages/employee/Otp/OtpCustomComponent"; // import {useInitStore} from "../libraries/src/hooks/store" // import {initWorkbenchComponents} from "@egovernments/digit-ui-module-workbench" import { initWorkbenchComponents } from "../../workbench/src/Module"; import Hooks from "../../../libraries/src/hooks"; import { initI18n } from "@egovernments/digit-ui-libraries/src/translations"; console.log("inside module.js of core") console.log(Digit.Hooks); const DigitUIWrapper \= ({ stateCode, enabledModules, defaultLanding }) \=\> {   console.log("inside DigitUIWrapper of core");   window.Digit\["Hooks"\] \= Hooks || {};   const { isLoading, data: initData={} } \= Digit.Hooks.useInitStore(stateCode, enabledModules);   if (isLoading) {     return \<Loader page={true} /\>;   }   const data=getStore(initData) || {};   const i18n \= getI18n();   initWorkbenchComponents();   if(\!Digit.ComponentRegistryService.getComponent("PrivacyComponent")){     Digit.ComponentRegistryService.setComponent("PrivacyComponent", PrivacyComponent);   }   return (     \<Provider store={data}\>       \<Router\>         \<BodyContainer\>           {Digit.Utils.getMultiRootTenant() ? (             \<DigitAppWrapper               initData={initData}               stateCode={stateCode}               modules={\[                 {                   "module": "assignment",                   "code": "assignment",                   "active": true,                   "order": 13,                   "tenants": \[                     {                       "code": "mz"                     }                   \]                 },                 {                   "module": "HRMS",                   "code": "HRMS",                   "active": true,                   "order": 4,                   "tenants": \[                     {                       "code": "mz"                     }                   \]                 }               \]}               appTenants={initData.tenants}               logoUrl={initData?.stateInfo?.logoUrl}               logoUrlWhite={initData?.stateInfo?.logoUrlWhite}               defaultLanding={defaultLanding}             /\>           ) : (             \<DigitApp               initData={initData}               stateCode={stateCode}               modules={initData?.modules}               appTenants={initData.tenants}               logoUrl={initData?.stateInfo?.logoUrl}               defaultLanding={defaultLanding}             /\>           )}         \</BodyContainer\>       \</Router\>     \</Provider\>   ); }; export const DigitUI \= ({ stateCode, registry, enabledModules, moduleReducers, defaultLanding }) \=\> {   console.log("inside digitui of core");   var Digit \= window.Digit || {};   initI18n();   const \[privacy, setPrivacy\] \= useState(Digit.Utils.getPrivacyObject() || {});   const userType \= Digit.UserService.getType();   const queryClient \= new QueryClient({     defaultOptions: {       queries: {         staleTime: 15 \* 60 \* 1000,         gcTime: 50 \* 60 \* 1000,         retry: false,         retryDelay: (attemptIndex) \=\> Infinity,         /\*           enable this to have auto retry incase of failure           retryDelay: attemptIndex \=\> Math.min(1000 \* 3 \*\* attemptIndex, 60000\)          \*/       },     },   });   const ComponentProvider \= Digit.Contexts.ComponentProvider;   const PrivacyProvider \= Digit.Contexts.PrivacyProvider;   const DSO \= Digit.UserService.hasAccess(\["FSM\_DSO"\]);   return (     \<QueryClientProvider client={queryClient}\>       \<ErrorBoundary\>           \<ComponentProvider.Provider value={registry}\>             \<PrivacyProvider.Provider               value={{                 privacy: privacy?.\[window.location.pathname\],                 resetPrivacy: (\_data) \=\> {                   Digit.Utils.setPrivacyObject({});                   setPrivacy({});                 },                 getPrivacy: () \=\> {                   const privacyObj \= Digit.Utils.getPrivacyObject();                   setPrivacy(privacyObj);                   return privacyObj;                 },                 /\*  Descoped method to update privacy object  \*/                 updatePrivacyDescoped: (\_data) \=\> {                   const privacyObj \= Digit.Utils.getAllPrivacyObject();                   const newObj \= { ...privacyObj, \[window.location.pathname\]: \_data };                   Digit.Utils.setPrivacyObject({ ...newObj });                   setPrivacy(privacyObj?.\[window.location.pathname\] || {});                 },                 /\*\*                  \* Main Method to update the privacy object anywhere in the application                  \*                  \* @author jagankumar-egov                  \*                  \* Feature :: Privacy                  \*                  \* @example                  \*    const { privacy , updatePrivacy } \= Digit.Hooks.usePrivacyContext();                  \*/                 updatePrivacy: (uuid, fieldName) \=\> {                   setPrivacy(Digit.Utils.updatePrivacy(uuid, fieldName) || {});                 },               }}             \>               \<DigitUIWrapper stateCode={stateCode} enabledModules={enabledModules} defaultLanding={defaultLanding} /\>             \</PrivacyProvider.Provider\>           \</ComponentProvider.Provider\>       \</ErrorBoundary\>       \</QueryClientProvider\>   ); }; const componentsToRegister \= {   SelectOtp,   ChangeCity,   ChangeLanguage,   PrivacyComponent,   OtpComponent, }; export const initCoreComponents \= () \=\> {   Object.entries(componentsToRegister).forEach((\[key, value\]) \=\> {     Digit.ComponentRegistryService.setComponent(key, value);   }); };*  |
| :---- |

After implementing this fix, we were finally able to see the **login screen** from the core module, though the **login inputs were not functioning properly**.

---

### **3\. Login Screen Frozen**

#### **Issue:**

After resolving the queryClient errors, the login screen became visible but the **login inputs were unresponsive**.

#### **Root Cause:**

The issue occurred due to an error in the **FormComposer component**, which prevented user inputs from registering properly.

#### **Solution:**

The issue was fixed by updating the **FormComposer component**. Below are the code changes made to resolve this:

//I’ll add the code here soon

After implementing this fix, the login inputs started functioning correctly.

---

### **4\. Localization Issue**

#### **Issue:**

The localization API was being called and stored in **localStorage**, but it was **not working properly**.

#### **Root Cause:**

The execution order of localization functions was incorrect. Previously, `i18n` was initialized inside the **libraries module**, which caused issues in execution.

#### **Solution:**

To fix this issue, we **imported `i18n` inside `Module.js` of the core module** instead of using it in **libraries**. This change ensured that localization was correctly set up.

Below are the code changes made inside the **core module**:

| *import { initI18n } from "@egovernments/digit-ui-libraries/src/translations"; const DigitUIWrapper \= ({ stateCode, enabledModules, defaultLanding }) \=\> {   console.log("inside DigitUIWrapper of core");   window.Digit\["Hooks"\] \= Hooks || {};   const { isLoading, data: initData={} } \= Digit.Hooks.useInitStore(stateCode, enabledModules);   if (isLoading) {     return \<Loader page={true} /\>;   }   const data=getStore(initData) || {};   const i18n \= getI18n();   initWorkbenchComponents();   if(\!Digit.ComponentRegistryService.getComponent("PrivacyComponent")){     Digit.ComponentRegistryService.setComponent("PrivacyComponent", PrivacyComponent);   }   return (     \<Provider store={data}\>       \<Router\>         \<BodyContainer\>           {Digit.Utils.getMultiRootTenant() ? (             \<DigitAppWrapper               initData={initData}               stateCode={stateCode}               modules={\[                 {                   "module": "assignment",                   "code": "assignment",                   "active": true,                   "order": 13,                   "tenants": \[                     {                       "code": "mz"                     }                   \]                 },                 {                   "module": "HRMS",                   "code": "HRMS",                   "active": true,                   "order": 4,                   "tenants": \[                     {                       "code": "mz"                     }                   \]                 }               \]}               appTenants={initData.tenants}               logoUrl={initData?.stateInfo?.logoUrl}               logoUrlWhite={initData?.stateInfo?.logoUrlWhite}               defaultLanding={defaultLanding}             /\>           ) : (             \<DigitApp               initData={initData}               stateCode={stateCode}               modules={initData?.modules}               appTenants={initData.tenants}               logoUrl={initData?.stateInfo?.logoUrl}               defaultLanding={defaultLanding}             /\>           )}         \</BodyContainer\>       \</Router\>     \</Provider\>   ); };*  |
| :---- |

After implementing this fix, localization started working as expected.

**5\. QueryClient Error \[Revisit \- Permanent Fix\]**

**Issue:**

Issue here is same as discussed in point number 2 but the solution discussed in point number 2 for QueryClient Error was a temporary fix and is not recommended at all because we can’t have libraries in local all the time and then import the methods from local library to local.

#### **Solution:**

To resolve this,   
(a) We simply added @tanstack/react-query" in externals of webpack config of each module/package. For ex:

|  *externals: {     react: {       commonjs: 'react',       commonjs2: 'react',       amd: 'react',       root: 'React',     },     'react-dom': {       commonjs: 'react-dom',       commonjs2: 'react-dom',       amd: 'react-dom',       root: 'ReactDOM',     },     'react-i18next': 'react-i18next',     'react-router-dom': 'react-router-dom',     "@tanstack/react-query": "@tanstack/react-query"   },* |
| :---- |

(b) Also, we need to add @tanstack/react-query in peer dependencies of package.json as we don’t want duplicate instances of @tanstack/react-query to be installed. We want a centralized @tanstack/react-query which will be handled at root level (package.json of micro-ui-internals)

**6\. App crash on any particular action, ex: props.OnChange is not a function**

#### **Issue:**

Sometimes while navigating through the app, you may encounter a situation where on a particular click or change in input field the app gets crashed and it throws errors like : props.OnChange is not a function.

#### **Root Cause:**

The issue comes from mostly formcomposer and inboxsearchcomposer where react-hook-form library is being frequently used.

#### **Solution:**

After hours and hours of debugging, we found that it’s just about syntax changes introduced in the latest version of react-hook-form. We can’t directly use props in render like this : render(props)

It should be destructured to field and then can access onChange from field like : render({field})  
Here you can use, field.props → Valid syntax

Since we were upgrading to the latest dependencies, we updated react-hook-form to version 7 from 6 and didn’t handle the syntax.

To fix this issue, you have two options: either use the latest version with correct valid syntax or just stick with the older version i.e, 6.15.8.  
In my case, I switched back to the older version and it works fine with react19.

**7\. Package “xyz” not found, during build**

#### **Issue:**

While build and deployment through github workflows or jenkins pipeline we might face this error : Package “xyz” not found.

#### **Root Cause:**

This issue arises because the system is unable to identify the “dist” file of a particular package or module.

#### **Solution:**

Please make sure we have correct main and module in package.json and correct output in webpack config.

Incorrect Method : 

|  Package.json*"main": "dist/main.js",   "module": "dist/main.js",*Webpack config *output: {     filename: "Main.js",* |
| :---- |

correct Method : 

|  Package.json*"main": "dist/main.js",   "module": "dist/main.js",*Webpack config *output: {     filename: "main.js",* |
| :---- |

**8\. Incorrect Proxy**

**Issue:**

After build and deployment(or during development in some cases), you might find any route is not working and is leading to “can’t get” or “not found” on the webpage.

#### **Root Cause:**

This issue arises due to incorrect proxy setup in webpack config of example where all the proxies rest.

#### **Solution:**

Just make sure that whatever environment you’re using, that proxy url should match with your webpack target proxy url.  
For ex :   
Your env is using **REACT\_APP\_PROXY\_API=[https://unified-qa.digit.org](https://unified-qa.digit.org) then** you should also use [https://unified-qa.digit.org](https://unified-qa.digit.org) in webpack config as *target*.

| *target: "https://unified-qa.digit.org",* |
| :---- |

**FAQs**  
**1\. I’m not able to run the app after upgrading React to react 19\. It says “Digit is not defined” Why?**  
**→** The most possible reason could be that you upgraded to react19 but may be still using the older syntax in index.js of example. I’d recommend using this file as your index.js from now onwards.  
[https://github.com/egovernments/DIGIT-Frontend/blob/develop-react19/micro-ui/web/micro-ui-internals/example/src/index.js](https://github.com/egovernments/DIGIT-Frontend/blob/develop-react19/micro-ui/web/micro-ui-internals/example/src/index.js)

\[Also make sure you’ve added .env file before running the app, sometimes this also could be the reason\]

**2\. From where I can find all the upgraded packages and modules?**  
→ Please refer below for all upgraded packages and modules :   
(a) [@egovernments/digit-ui-module-core](https://github.com/egovernments/DIGIT-Frontend/tree/develop-react19/micro-ui/web/micro-ui-internals/packages/modules/core)  
(b) [@egovernments/digit-ui-module-workbench](https://github.com/egovernments/DIGIT-Frontend/tree/develop-react19/micro-ui/web/micro-ui-internals/packages/modules/workbench)  
(c) [@egovernments/digit-ui-libraries](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/libraries)  
(d) [@egovernments/digit-ui-react-components](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/react-components)  
(e) [@egovernments/digit-ui-svg-components](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/svg-components)  
(f) [@egovernments/digit-ui-components](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/ui-components)

**3\. Invalid hook call. Hooks can only be called inside of the body of a function component. Why is this error showing up frequently and how to fix this?**  
→ This usually happens when two different versions of React or react-dom are installed in your node\_modules (for example, one from your app and another from a shared package or library like @egovernments/digit-ui-campaign-manager).

To fix this, please make sure to have a single react instance which will be in root(mostly micro-ui-internals) and add any particular module’s react versions in peerDependencies.