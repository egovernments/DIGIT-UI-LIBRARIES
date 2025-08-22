# **Module Integration Guide for React 19 Upgraded DIGIT Platform**  **Introduction**

This document provides a comprehensive guide for upgrading existing DIGIT modules or integrating new ones into the upgraded DIGIT platform, which is now compatible with React 19 and Node 20\.

With the DIGIT core and shared libraries/components already upgraded to React 19, module developers must ensure that their respective modules are compatible, optimized, and follow the updated conventions to avoid breaking the unified application experience.

Whether you are integrating an entirely new module (like Campaign Manager) or upgrading an existing one (like Workbench), this guide outlines all necessary steps, configurations, common issues, and best practices to ensure seamless integration.

*As this documentation is only focused on the integration of a particular module with the upgraded React 19 DIGIT app, you don’t really need to see the backstory of how the core, components, libraries upgradation happened.*  
*But if you're curious about the complete storyline—including the challenges we faced and how we conquered them—[**click here**](https://docs.google.com/document/d/1Yel3hZWOU_fuZ_JZzIFP1QHpuRmvUX-L-V-TQLRr4tI/edit?tab=t.0) to explore our detailed upgrade journey.*

**📁 Document Scope**

This document focuses solely on **module-level integration**, assuming that the core platform (UI-components,libraries, react-components, SVG-components, core module, etc.) has already been upgraded.

It includes:

* Prerequisites for module integration

* Integration instructions

* Frequent Errors and their solutions

* Build & Deployment

**⚙️ Prerequisites for module integration**

Before beginning the integration of your module into the upgraded **React 19 DIGIT app**, there are several **critical pre-integration steps** you must complete. Consider this as your **must-do checklist** — skipping these may lead to unnecessary debugging or runtime failures later.

This phase involves reviewing and aligning your module both at the **micro-ui-internals** level and at the **example** level to ensure smooth integration.

🛑 **Do not proceed with module integration unless the steps below are completed and verified.**

**🔍 1\. Review at web/micro-ui-internals Level**

* **✅** Ensure the root `package.json` of micro-ui-internals has upgraded versions of:

  * `react`: `^19.0.0`  
  * `react-dom`: `^19.0.0`  
  * `react-router-dom`: `^6.x.x`  
  * `@tanstack/react-query`: latest v5

* **✅** All core packages and libraries must be already upgraded and published:

  * `@egovernments/digit-ui-libraries`  
  * `@egovernments/digit-ui-components`  
  * `@egovernments/digit-ui-react-components`  
  * `@egovernments/digit-ui-module-core`

* **✅** React must be listed as a `Dependency` in micro-ui-internals package.json

* ✅ Ensure you're using the correct versions of the upgraded core packages and libraries:

| Package Name | Latest Version |
| ----- | ----- |
| `@egovernments/digit-ui-libraries` | [Click here for latest version](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/libraries) |
| `@egovernments/digit-ui-components` | [Click here for latest version](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/ui-components) |
| `@egovernments/digit-ui-react-components` | [Click here for latest version](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/react-components) |
| `@egovernments/digit-ui-svg-components` | [Click here for latest version](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/svg-components) |
| `@egovernments/digit-ui-module-core` | [Click here for latest version](https://github.com/egovernments/DIGIT-Frontend/tree/develop-react19/micro-ui/web/micro-ui-internals/packages/modules/core) |
| `@egovernments/digit-ui-module-workbench` | [Click here for latest version](https://github.com/egovernments/DIGIT-Frontend/tree/develop-react19/micro-ui/web/micro-ui-internals/packages/modules/workbench) |


* Refer this package.json of micro-ui-internals for reference:

| *{   "name": "egovernments",   "version": "1.0.0",   "main": "index.js",   "workspaces": \[     "example",     "packages/\*",     "packages/modules/core",     "packages/modules/campaign-manager"   \],   "author": "JaganKumar \<jagan.kumar@egov.org.in\>",   "license": "MIT",   "private": true,   "engines": {     "node": "\>=14"   },   "scripts": {     "start": "cross-env SKIP\_PREFLIGHT\_CHECK=true run-s build start:dev",     "sprint": "SKIP\_PREFLIGHT\_CHECK=true run-s start:script",     "start:dev": "run-p dev:\*\*",     "start:script": "./scripts/create.sh",     "build": "run-s build:\*\*",     "buildD:svg-components": "cd packages/svg-components && yarn build",     "buildD:libraries": "cd packages/libraries && yarn build",     "buildDD:ui-components": "cd packages/ui-components && yarn build",     "buildD:react-components": "cd packages/react-components && yarn build",     "buildD:core": "cd packages/modules/core && yarn build",     "build:campaign": "cd packages/modules/campaign-manager && yarn build",     "buildD:assignment": "cd packages/modules/assignment && yarn build",     "dev:example": "cd example && yarn start",     "clean": "run-s clean:\*\*",     "clean-nm": "rm \-rf node\_modules && yarn clean:ui-components && yarn clean:react-components && yarn clean:libraries && yarn clean:core && yarn clean:assignment && yarn clean:sample && yarn clean:example && yarn clean:workbench",     "clean-dist": "yarn clean:ui-components-dist && yarn clean:react-components-dist && yarn clean:svg-components-dist && yarn clean:libraries-dist && yarn clean:core-dist && yarn clean:assignment-dist && yarn clean:sample-dist && yarn clean:workbench-dist",     "clean:ui-components": "cd packages/ui-components && rm \-rf node\_modules",     "clean:react-components": "cd packages/react-components && rm \-rf node\_modules",     "clean:svg-components": "cd packages/svg-components && rm \-rf node\_modules",     "clean:libraries": "cd packages/libraries && rm \-rf node\_modules",     "clean:core": "cd packages/modules/core && rm \-rf node\_modules",     "clean:workbench": "cd packages/modules/workbench && rm \-rf node\_modules",     "cleanD:assignment": "cd packages/modules/assignment && rm \-rf node\_modules",     "cleanD:sample": "cd packages/modules/sample && rm \-rf node\_modules",     "clean:example": "cd example && rm \-rf node\_modules",     "clean:ui-components-dist": "cd packages/ui-components && rm \-rf dist",     "clean:svg-components-dist": "cd packages/svg-components && rm \-rf dist",     "clean:react-components-dist": "cd packages/react-components && rm \-rf dist",     "clean:libraries-dist": "cd packages/libraries && rm \-rf dist",     "clean:core-dist": "cd packages/modules/core && rm \-rf dist",     "clean:workbench-dist": "cd packages/modules/workbench && rm \-rf dist",     "cleanD:assignment-dist": "cd packages/modules/assignment && rm \-rf dist",     "cleanD:sample-dist": "cd packages/modules/sample && rm \-rf dist",     "clean:yarnLock": "rm \-rf yarn.lock",     "clean:WebyarnLock": "cd ../ && rm \-rf yarn.lock",     "clean:Web": "cd ../ && rm \-rf node\_modules",     "clean:mui": "rm \-rf node\_modules",     "cleancmd": "find . \\\\( \-name 'node\_modules' \-o \-name 'dist' \\\\) \-type d \-prune \-exec rm \-rf '{}' \+"   },   "resolutions": {     "\*\*/@babel/runtime": "7.20.1",     "\*\*/babel-preset-react-app": "10.0.0",     "\*\*/styled-components": "5.0.0",     "fast-uri": "2.1.0",     "\*\*/react": "19.0.0",     "\*\*/react-dom": "19.0.0"   },   "peerDependencies": {     "@tanstack/react-query": "^5.62.16"   },   "husky": {},   "lint-staged": {     "\*.{js,css,md}": "prettier \--write"   },   "eslintConfig": {     "extends": \[       "react-app"     \]   },   "devDependencies": {     "clean-webpack-plugin": "^4.0.0",     "dotenv-webpack": "^8.0.0",     "eslint-config-react-app": "^7.0.1",     "html-webpack-plugin": "^5.6.3",     "husky": "7.0.4",     "lint-staged": "12.3.7",     "npm-run-all": "4.1.5",     "prettier": "2.1.2",     "vite": "^6.1.0",     "webpack": "^5.97.1",     "webpack-cli": "^6.0.1",     "webpack-dev-server": "^5.2.0"   },   "dependencies": {     "@babel/core": "^7.26.10",     "@babel/plugin-proposal-private-property-in-object": "7.21.0",     "@babel/preset-env": "^7.26.9",     "@babel/preset-react": "^7.26.3",     "@egovernments/digit-ui-components": "0.2.0-beta.40-rc19.01",     "@egovernments/digit-ui-libraries": "1.8.17-rc19.01",     "@egovernments/digit-ui-module-core": "1.8.35-rc19.01",     "@egovernments/digit-ui-react-components": "1.8.21-rc19.01",     "@tanstack/react-query": "^5.62.16",     "babel-loader": "^9",     "cross-env": "^7.0.3",     "css-loader": "5.2.6",     "http-proxy-middleware": "1.3.1",     "lodash": "4.17.21",     "microbundle-crl": "0.13.11",     "process": "^0.11.10",     "react": "19.0.0",     "react-dom": "19.0.0",     "react-hook-form": "7.52.2",     "react-i18next": "15.0.0",     "react-redux": "^9.2.0",     "react-router-dom": "6.25.1",     "style-loader": "2.0.0",     "terser-brunch": "^4.1.0",     "url": "^0.11.4",     "web-vitals": "1.1.2"   } }* |
| :---- |

  

### **🔍 2\. Review at “web/micro-ui-internals/example” Level**

* **✅** Ensure the `package.json` of micro-ui-internals/example has upgraded versions of:

  * `react`: `^19.0.0`  
  * `react-dom`: `^19.0.0`  
  * `react-router-dom`: `^6.x.x`  
  * `@tanstack/react-query`: latest v5

* **✅** All core packages and libraries must be already upgraded and published:

  * `@egovernments/digit-ui-libraries`  
  * `@egovernments/digit-ui-components`  
  * `@egovernments/digit-ui-react-components`  
  * `@egovernments/digit-ui-module-core`

* **✅** React, react-dom must be listed as a `peerDependencies` in micro-ui-internals/example package.json

* ✅ Ensure you're using the correct versions of the upgraded core packages and libraries:

| Package Name | Latest Version |
| ----- | ----- |
| `@egovernments/digit-ui-libraries` | [Click here for latest version](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/libraries) |
| `@egovernments/digit-ui-components` | [Click here for latest version](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/ui-components) |
| `@egovernments/digit-ui-react-components` | [Click here for latest version](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/react-components) |
| `@egovernments/digit-ui-svg-components` | [Click here for latest version](https://github.com/egovernments/DIGIT-UI-LIBRARIES/tree/develop-webpack/webpack/svg-components) |
| `@egovernments/digit-ui-module-core` | [Click here for latest version](https://github.com/egovernments/DIGIT-Frontend/tree/develop-react19/micro-ui/web/micro-ui-internals/packages/modules/core) |
| `@egovernments/digit-ui-module-workbench` | [Click here for latest version](https://github.com/egovernments/DIGIT-Frontend/tree/develop-react19/micro-ui/web/micro-ui-internals/packages/modules/workbench) |


* ✅ react-scripts should no longer be used for starting the app, use webpack instead.

* Refer this package.json of micro-ui-internals/example for reference:

| *{   "name": "@egovernments/digit-ui-example",   "version": "1.0.0",   "license": "MIT",   "private": true,   "homepage": "digit-ui",   "scripts": {     "start": "webpack serve \--config webpack.config.js \--mode development",     "start:old": "react-scripts start"   },   "peerDependencies": {     "react": "19.0.0",     "react-dom": "19.0.0",     "react-router-dom": "6.25.1",     "@tanstack/react-query": "^5.62.16"   },   "devDependencies": {     "@egovernments/digit-ui-libraries": "1.8.17-rc19.01",     "@egovernments/digit-ui-module-core": "1.8.35-rc19.01",     "@egovernments/digit-ui-components": "0.2.0-beta.40-rc19.01",     "@egovernments/digit-ui-react-components": "1.8.21-rc19.01",     "@egovernments/digit-ui-module-campaign-manager": "0.3.1",     "http-proxy-middleware": "^1.0.5",     "react-i18next": "15.0.0",     "react-router-dom": "6.25.1",     "webpack": "^5.97.1",     "webpack-cli": "^6.0.1",     "webpack-dev-server": "^5.2.0",     "dotenv-webpack": "^8.0.0"   },   "browserslist": {     "production": \[       "\>0.2%",       "not dead",       "not op\_mini all"     \],     "development": \[       "last 1 chrome version",       "last 1 firefox version",       "last 1 safari version"     \]   } }* |
| :---- |


* ✅ Ensure the `example/src/index.js` uses the latest structure, such as:

  * `ReactDOM.createRoot()` instead of `ReactDOM.render()`  
  * Uses **lazy loading** for `DigitUI` and other modules

  * Refer below example/src/index.js file for reference: 

| *import React, { useEffect, useState, lazy, Suspense } from "react"; import ReactDOM from "react-dom/client"; import { Hooks } from "@egovernments/digit-ui-libraries"; import { initLibraries } from "@egovernments/digit-ui-libraries"; window.Digit \= window.Digit || {}; window.Digit.Hooks \= Hooks; const DigitUILazy \= lazy(() \=\> import("@egovernments/digit-ui-module-core").then((module) \=\> ({ default: module.DigitUI }))); const enabledModules \= \["assignment", "HRMS", "Workbench", "Utilities","Campaign"\]; const initTokens \= (stateCode) \=\> {   const userType \= window.sessionStorage.getItem("userType") || process.env.REACT\_APP\_USER\_TYPE || "CITIZEN";   const token \= window.localStorage.getItem("token") || process.env\[\`REACT\_APP\_${userType}\_TOKEN\`\];   const citizenInfo \= window.localStorage.getItem("Citizen.user-info");   const citizenTenantId \= window.localStorage.getItem("Citizen.tenant-id") || stateCode;   const employeeInfo \= window.localStorage.getItem("Employee.user-info");   const employeeTenantId \= window.localStorage.getItem("Employee.tenant-id");   const userTypeInfo \= userType \=== "CITIZEN" || userType \=== "QACT" ? "citizen" : "employee";   window.Digit.SessionStorage.set("user\_type", userTypeInfo);   window.Digit.SessionStorage.set("userType", userTypeInfo);   if (userType \!== "CITIZEN") {     window.Digit.SessionStorage.set("User", {       access\_token: token,       info: userType \!== "CITIZEN" ? JSON.parse(employeeInfo) : citizenInfo,     });   }   window.Digit.SessionStorage.set("Citizen.tenantId", citizenTenantId);   if (employeeTenantId && employeeTenantId.length) {     window.Digit.SessionStorage.set("Employee.tenantId", employeeTenantId);   } }; const initDigitUI \= () \=\> {   window.contextPath \= window?.globalConfigs?.getConfig("CONTEXT\_PATH") || "digit-ui";   const stateCode \= window?.globalConfigs?.getConfig("STATE\_LEVEL\_TENANT\_ID") || "mz";   const root \= ReactDOM.createRoot(document.getElementById("root"));   root.render(\<MainApp stateCode={stateCode} enabledModules={enabledModules} /\>); }; const MainApp \= ({ stateCode, enabledModules }) \=\> {   const \[isReady, setIsReady\] \= useState(false);   const \[loaded, setLoaded\] \= useState(false);   useEffect(() \=\> {     initLibraries().then(async () \=\> {       const {initCampaignComponents}=await import("@egovernments/digit-ui-module-campaign-manager")       initCampaignComponents()       setIsReady(true);     });   }, \[\]);   useEffect(() \=\> {     initTokens(stateCode);     setLoaded(true);   }, \[stateCode, isReady\]);   if (\!loaded) {     return \<div\>Loading...\</div\>;   }   return (     \<Suspense fallback={\<div\>Loading...\</div\>}\>       {window.Digit && (         \<DigitUILazy stateCode={stateCode} enabledModules={enabledModules}   allowedUserTypes={\["employee", "citizen"\]} defaultLanding="employee" /\>       )}     \</Suspense\>   ); }; initDigitUI();* |
| :---- |

* ✅ Confirm Webpack is configured:  
  * `webpack.config.js` is present and valid.  
  * Proxy configuration must be handled **directly inside `webpack.config.js`**  
    * 🗑️ Remove any `setupProxy.js` files. They are not compatible with Webpack and are specific to `react-scripts`.  
    * ✅ Migrate all proxy routes to the `devServer.proxy` field inside `webpack.config.js`.   
    * See below example’s webpack file for reference : 

| *const path \= require("path"); const webpack \= require("webpack"); const HtmlWebpackPlugin \= require("html-webpack-plugin"); const { CleanWebpackPlugin } \= require("clean-webpack-plugin"); const dotenv \= require("dotenv"); const fs \= require("fs"); // Load .env variables const envFile \= dotenv.config().parsed || {}; // Make DefinePlugin-compatible keys const envKeys \= Object.entries(envFile).reduce((acc, \[key, val\]) \=\> {   acc\[\`process.env.${key}\`\] \= JSON.stringify(val);   return acc; }, {}); module.exports \= {   mode: "development",   entry: path.resolve(\_\_dirname, "src/index.js"),   devtool: "source-map",   module: {     rules: \[       {         test: /\\.(js)$/,         exclude: /node\_modules/,         use: {           loader: "babel-loader",           options: {             presets: \["@babel/preset-env", "@babel/preset-react"\],             plugins: \["@babel/plugin-proposal-optional-chaining"\],           },         },       },       {         test: /\\.css$/i,         use: \["style-loader", "css-loader"\],       },     \],   },   output: {     filename: "\[name\].bundle.js",     path: path.resolve(\_\_dirname, "build"),     publicPath: "/",   },   optimization: {     splitChunks: {       chunks: "all",       minSize: 20000,       maxSize: 50000,       enforceSizeThreshold: 50000,       minChunks: 1,       maxAsyncRequests: 30,       maxInitialRequests: 30,     },   },   plugins: \[     new webpack.ProvidePlugin({       process: "process/browser",     }),     new webpack.DefinePlugin(envKeys), // \<-- Add this     new CleanWebpackPlugin(),     new HtmlWebpackPlugin({       inject: true,       template: "public/index.html",       templateParameters: {         REACT\_APP\_GLOBAL: envFile.REACT\_APP\_GLOBAL, // \<-- Inject env into HTML       },     }),   \],   resolve: {     modules: \[path.resolve(\_\_dirname, "src"), "node\_modules"\],     extensions: \[".js", ".jsx", ".ts", ".tsx"\],     preferRelative: true,     fallback: {       process: require.resolve("process/browser"),     },   },   devServer: {     static: path.join(\_\_dirname, "dist"),     compress: true,     port: 3000,     hot: true,     historyApiFallback: true,     proxy: \[       {         context: \[           "/access/v1/actions/mdms",           "/tenant-management",           "/user-otp",           "/egov-mdms-service",           "/plan-service",           "/mdms-v2",           "/egov-idgen",           "/egov-location",           "/localization",           "/egov-workflow-v2",           "/pgr-services",           "/filestore",           "/egov-hrms",           "/user-otp",           "/user",           "/fsm",           "/billing-service",           "/collection-services",           "/pdf-service",           "/pg-service",           "/vehicle",           "/vendor",           "/property-services",           "/fsm-calculator/v1/billingSlab/\_search",           "/pt-calculator-v2",           "/dashboard-analytics",           "/echallan-services",           "/egov-searcher/bill-genie/mcollectbills/\_get",           "/egov-searcher/bill-genie/billswithaddranduser/\_get",           "/egov-searcher/bill-genie/waterbills/\_get",           "/egov-searcher/bill-genie/seweragebills/\_get",           "/egov-pdf/download/UC/mcollect-challan",           "/egov-hrms/employees/\_count",           "/tl-services/v1/\_create",           "/tl-services/v1/\_search",           "/egov-url-shortening/shortener",           "/inbox/v1/\_search",           "/inbox/v2/\_search",           "/tl-services",           "/tl-calculator",           "/org-services",           "/edcr",           "/hcm-moz-impl",           "/bpa-services",           "/noc-services",           "/egov-user-event",           "/egov-document-uploader",           "/egov-pdf",           "/egov-survey-services",           "/ws-services",           "/sw-services",           "/ws-calculator",           "/sw-calculator/",           "/audit-service/",           "/egov-searcher",           "/report",           "/inbox/v1/dss/\_search",           "/loi-service",           "/project/v1/",           "/estimate-service",           "/loi-service",           "/works-inbox-service/v2/\_search",           "/egov-pdf/download/WORKSESTIMATE/estimatepdf",           "/muster-roll",           "/individual",           "/mdms-v2",           "/facility/v1/\_search",           "/project/staff/v1/\_create",           "/product/v1/\_create",           "/boundary-service",           "/project-factory",           "/project-factory/v1/data/\_autoGenerateBoundaryCode",           "/billing-service/bill/v2/\_fetchbill",           "/tenant-management",           "/default-data-handler",           "/facility/v1/\_create"         \],         target: "https://unified-dev.digit.org",         changeOrigin: true,         secure: false,       },     \],   }, };*  |
| :---- |

    * Please make sure that the “**target**” in webpack file for proxy should be similar to **REACT\_APP\_PROXY\_API** from the environment file(.env) you’re using.

       


## **🔗 Integration Instructions**

This section outlines the **step-by-step process** for integrating an individual module into the React 19-compatible DIGIT application. These steps assume that all prerequisites (outlined above) have already been completed.

---

### **🛠️ 1\. Place Your Module Inside micro-ui-internals**

Add your module inside:  
`/micro-ui/web/micro-ui-internals/packages/modules/<your-module-name>`

Structure should include:

`├── src/`

`│   └── Module.js  ← entry point`

`├── package.json`

`├── webpack.config.js`

`├── babel.rc`

`└── dist/ (auto-generated after build)`

---

**🧩 2\. Add `<your-module>` to Workspaces**

* Open the root `package.json` of `micro-ui-internals` and add your module path under the `workspaces` array:

| *"workspaces": \[   "example",   "packages/modules/\*",   "packages/modules/\<your-module\>" // ✅ Add this line if not covered by wildcard \]* |
| :---- |

💡 If you're already using the wildcard path (`packages/modules/*`), you **don’t need** to add the module explicitly.

---

### **🧾 3\. Add Your Module in `example/package.json`**

* Go to `example/package.json` and add your module in `devDependencies`:

| `"@egovernments/digit-ui-module-<your-module>": "0.0.0"` |
| :---- |

✅ This ensures that the example app can access the latest local build of your module.

---

### **🧾 4\. Add Your Module in Root `package.json` (micro-ui-internals)**

* Add the module under devDependencies:

| *`"@egovernments/digit-ui-module-<your-module>": "0.0.0"`* |
| :---- |


---

### **🔧 5\. Add Your Module to Build Script**

* In the root `package.json` of `micro-ui-internals`, locate the `"scripts"` block and add:

| *`"build:<your-module>": "cd packages/modules/<your-module> && yarn build",`* |
| :---- |

  This will ensure your module gets built when running `yarn build` across the entire app.

### ---

  **⚙️ 6\. Webpack Setup for the Module**

* Ensure `webpack.config.js` exists at the module root with the correct configuration.

| *const path \= require("path"); const webpack \= require("webpack"); module.exports \= {   mode: "development",   entry: "./src/Module.js",   output: {     filename: "main.js",     path: path.resolve(\_\_dirname, "dist"),     library: "@egovernments/digit-ui-module-campaign-manager",     libraryTarget: "umd", // This replaces the object with name \+ type     globalObject: "this", // Ensures compatibility in Node and browser environments   },   resolve: {     extensions: \[".js"\],     alias: {       process: "process/browser.js" // replace fallback with alias     }   },   externals: {     react: {       commonjs: "react",       commonjs2: "react",       amd: "react",       root: "React"     },     "react-dom": {       commonjs: "react-dom",       commonjs2: "react-dom",       amd: "react-dom",       root: "ReactDOM"     },     "react-i18next": "react-i18next",     "react-router-dom": "react-router-dom",     "@tanstack/react-query": "@tanstack/react-query"   },   module: {     rules: \[       {         test: /\\.js$/,         use: {           loader: "babel-loader",           options: {             presets: \["@babel/preset-env", "@babel/preset-react"\]           }         }       }     \]   },   plugins: \[     new webpack.ProvidePlugin({       process: "process/browser.js"     })   \] };*  |
| :---- |

⚠️ Ensure the output filename is lowercase `"main.js"` — capitalized filenames (e.g., `"Main.js"`) will cause build/deployment issues.

* Ensure `babel.rc` exists at the module root with the correct configuration.

| *{     "presets": \["@babel/preset-env", "@babel/preset-react"\],   }* |
| :---- |

---

### **🧾 7\. Update `package.json` of \<Your Module\>**

* Ensure the following fields are correct:  
  * Dependencies should be latest and compatible to react19  
  * React. React-dom, @tanstack/react-query, react-router-dom must go inside peerDependencies.  
  * build command should be through webpack, instead react-scripts.  
    Refer below file for example: 

| *{   "name": "@egovernments/digit-ui-module-campaign-manager",   "version": "0.3.1",   "description": "Campaign",   "main": "dist/main.js",   "module": "dist/main.js",   "source": "src/Module.js",   "files": \[     "dist"   \],   "scripts": {     "start": "webpack serve \--mode=development \--open \--hot",     "build": "webpack  \--mode=development \--node-env=development \--config webpack.config.js",     "prepublish": "yarn build"   },   "peerDependencies": {     "react": "19.0.0",     "react-dom": "19.0.0",     "react-router-dom": "6.25.1",     "@tanstack/react-query": "^5.62.16"   },   "dependencies": {     "@cyntler/react-doc-viewer": "1.10.3",     "@egovernments/digit-ui-react-components": "1.8.21-rc19.01",     "@egovernments/digit-ui-svg-components": "1.0.21-rc19.1",     "@egovernments/digit-ui-components": "0.2.0-beta.40-rc19.01",     "react-data-table-component": "7.6.2",     "styled-components": "5.0.0",     "@rjsf/core": "5.10.0",     "@rjsf/utils": "5.10.0",     "@rjsf/validator-ajv8": "5.10.0",     "ajv": "8.12.0",     "geojsonhint": "^2.0.0",     "leaflet": "^1.9.4",     "proj4": "^2.15.0",     "react-date-range": "1.4.0",     "react-drag-drop-files": "^2.3.10",     "react-hook-form": "6.15.8",     "react-i18next": "15.0.0",     "react-select": "5.7.4",     "react-table": "7.7.0",     "exceljs": "^4.4.0",     "xlsx": "0.17.5",     "react-dnd-html5-backend": "16.0.1",     "react-dnd": "16.0.1",     "react-qr-code": "1.1.1"   },   "devDependencies": {     "@babel/core": "^7.23.3",     "@babel/preset-env": "^7.23.3",     "@babel/preset-react": "^7.23.3",     "babel-loader": "9.1.3",     "cross-env": "7.0.3",     "lint-staged": "12.3.7",     "webpack": "^5.97.1",     "webpack-cli": "^6.0.1",     "webpack-dev-server": "^5.2.0"   },   "author": "JaganKumar \<jagan.kumar@egov.org.in\>",   "license": "MIT",   "keywords": \[     "digit",     "egov",     "dpg",     "digit-ui",     "workbench",     "campaign",     "Campaign"   \] }* |
| :---- |

* Add any module-specific dependencies under `dependencies` or `devDependencies` as required.

---

### **🔄 8\. Add Your Module in micro-ui-internals/example/src/index.js**

Go to: `/micro-ui/web/micro-ui-internals/example/src/index.js`

For any particular module, we need to do some changes to access and use the module in app: 

* Import your module dynamically using lazy loading and use the init method of that module.

|   useEffect(() \=\> {     initLibraries().then(async () \=\> {       const {initCampaignComponents}=await import("@egovernments/digit-ui-module-campaign-manager")       initCampaignComponents()       setIsReady(true);     });   }, \[\]); |
| :---- |

* Add your module to the `enabledModules` list:

| const enabledModules \= \["\<your-module\>", "HRMS", "assignment"\]; |
| :---- |

Refer this [file](https://github.com/egovernments/DIGIT-Frontend/blob/console-react19-campaign/health/micro-ui/web/micro-ui-internals/example/src/index.js) for the entire example/src/index.js.

---

### **🧪 9\. Run and Test the Module**

Once integration is completed as per given instructions, you can start the app and test your module using below commands : 

| *cd micro-ui/web/micro-ui-internals yarn install yarn start* |
| :---- |

---

## **🐞 Frequent Errors & Solutions**

Below are common errors you may face during module integration into the React 19-compatible DIGIT application, along with their causes and resolutions.

### **❌ 1\. `Digit is not defined`**

**Root Cause:**  
 When React 19's strict mode or new rendering model is used, the `Digit` object might not be globally available at the time of rendering.

**Solution:**

* Use **lazy loading** for `DigitUI` module.

* Ensure `Digit` is initialized **before rendering** any modules.

* Use `ReactDOM.createRoot()` (not `ReactDOM.render()`).

✅ Refer to the correct example `index.js` here:  
 [Digit React19 Example Index](https://github.com/egovernments/DIGIT-Frontend/blob/develop-react19/micro-ui/web/micro-ui-internals/example/src/index.js)

---

### **❌ 2\. `Invalid hook call` Error**

**Root Cause:**  
 Caused by multiple instances of `react` or `react-dom` (typically one from the app and another from a library/module).

**Solution:**

* Ensure `react`, `react-dom`, `@tanstack/react-query`, etc., are added to `peerDependencies` in your module.

* Ensure they are **not duplicated in node\_modules**.

* Add them in `externals` of your module’s `webpack.config.js`.

✅ Example:

| externals: {   react: "react",   "react-dom": "react-dom",   "@tanstack/react-query": "@tanstack/react-query" } |
| :---- |

---

### **❌ 3\. `Module not found` or `Package not found` during build**

**Root Cause:**  
 The module's `package.json` or `webpack.config.js` is misconfigured.

**Solution:**

* Ensure correct `main` and `module` fields in `package.json`:

| "main": "dist/main.js", "module": "dist/main.js"  |
| :---- |

* Ensure `output.filename` in `webpack.config.js` is:  
  filename: "main.js"

🔴 Avoid using `"Main.js"` (capital M) — it breaks builds and publishing.

---

### **❌ 4\. App routes not working or API returning 404 in local**

**Root Cause:**  
 Proxy routes were configured in `setupProxy.js`, which is no longer supported.

**Solution:**

* Delete `setupProxy.js`.  
* Move all proxy config to `devServer.proxy` in `webpack.config.js`.

Example:

| *devServer: {   proxy: {     '/user': {       target: 'https://unified-qa.digit.org',       changeOrigin: true,       secure: false,     },     ...   }* } |
| :---- |

---

### **❌ 5\. `QueryClient` errors even inside QueryClientProvider**

**Root Cause:**  
 Multiple isolated instances of `@tanstack/react-query`.

**Solution:**

* Add `@tanstack/react-query` to `externals` in Webpack.

* Move it to `peerDependencies` in all relevant packages.

* Ensure only one shared instance exists in root (`micro-ui-internals`).

---

### **❌ 6\. Syntax Errors from `react-query`, `react-router-dom`, etc.**

**Root Cause:**  
 You're likely using **outdated syntax** after upgrading to the latest versions of libraries like `@tanstack/react-query` (v5) and `react-router-dom` (v6+). These libraries introduced **major breaking changes** in APIs and component structures.

**Examples & Solutions:**

#### **🛑 `Switch` is not exported from `react-router-dom`**

* **Cause:** `Switch` is removed in v6+.  
* ✅ **Fix:** Use `Routes` and `Route` instead.

| \- import { Switch, Route } from "react-router-dom"; \+ import { Routes, Route } from "react-router-dom"; \<Routes\>   \<Route path="/home" element={\<Home /\>} /\> \</Routes\> |
| :---- |

#### **🛑 `useQuery` from react-query throws errors or doesn’t behave as expected**

* **Cause:** Using old syntax from `react-query` v3/v4 with v5 (`@tanstack/react-query`).

* ✅ **Fix:** Use latest function signature from v5.


| *\- const { data, isLoading } \= useQuery("todos", fetchTodos); \+ const { data, isLoading } \= useQuery({     queryKey: \["todos"\],     queryFn: fetchTodos   });*  |
| :---- |

#### **🛑 `useHistory`, `useLocation`, `useParams`, etc. mismatch**

* **Cause:** Misuse of deprecated or changed hooks.

* ✅ **Fix:** Update routing logic to align with `react-router-dom` v6 structure.

---

### **❌ 7\. `PrivateRoute` Not Working / Unexpected Redirects**

**Root Cause:**  
 The routing system has changed significantly in **React Router v6+**, and `PrivateRoute` usage must follow the new structure because PrivateRoute itself has been changed as per routerV6 which needs new syntax.

### **✅ Correct Usage of `PrivateRoute` (React Router v6+)**

Instead of wrapping components inside `<PrivateRoute>...</PrivateRoute>`, you now pass the protected component using the `element` prop of `PrivateRoute`.

#### **Updated Route Structure example:**

| *\<AppContainer className="workbench"\>   \<Routes\>     \<Route path="sample" element={\<PrivateRoute element={\<div\>Sample Screen loaded\</div\>} /\>} /\>     \<Route path="localisation-search" element={\<PrivateRoute element={\<LocalisationSearch /\>} /\>} /\>     \<Route path="mdms-search" element={\<PrivateRoute element={\<MDMSSearch /\>} /\>} /\>     \<Route path="mdms-add" element={\<PrivateRoute element={\<MDMSAdd FormSession={MDMSCreateSession} parentRoute={path} /\>} /\>} /\>     {/\* Add more routes below as needed \*/}   \</Routes\> \</AppContainer\>* |
| :---- |

#### *If you want to check out the upgraded `PrivateRoute` Component, you can refer to the latest ui-components.*

---

## **🚀 Build & Deploy**

After your module is integrated and verified, the next step is to **build and deploy** it as part of the upgraded React 19 DIGIT platform.

⚠️ All build and deploy operations are performed from the `web/` level, **not from `web/micro-ui-internals/` directly**.

### **🧱 1\. Build the App**

Ensure that:

* Your module is correctly placed inside:  
  `/web/micro-ui-internals/packages/modules/<your-module>`  
* The build script for your module is defined in:  
  `/web/micro-ui-internals/package.json`

| *"build:\<your\_module\>": "cd packages/modules/\<your\_module\> && yarn build",* |
| :---- |

####  **✅ Build through Github Actions**

1. Make sure to add build.yml file in .github/workflows if it’s not already present there.

| *name: Build Pipeline run-name: Build ${{ github.event.inputs.pipeline\_name }} on:   workflow\_dispatch:     inputs:       pipeline\_name:         description: 'Name of the config pipeline to build and deploy'         required: true         type: choice         options:           \- digit-ui           \- core-ui           \- workbench-ui           \- sandbox-ui           \- microplan-ui           \- console           \- payments-ui           \- storybook-svg           \- storybook           \- egov-bff           \- core-digit-ui           \- dss-ui           \- hrms-ui           \- karnataka-ui           \- meghalaya-ui env:   DOCKER\_USERNAME: ${{ vars.DOCKER\_USERNAME }}   DOCKER\_PASSWORD: ${{ secrets.DOCKER\_ACCESS\_TOKEN }} jobs:   resolve-config:     name: Resolve ${{ github.event.inputs.pipeline\_name }} config     runs-on: ubuntu-latest     outputs:       work\_dir:    ${{ steps.setenv.outputs.work\_dir }}       image\_name:  ${{ steps.setenv.outputs.image\_name }}       dockerfile:  ${{ steps.setenv.outputs.dockerfile }}       tag:         ${{ steps.tag.outputs.tag }}     steps:       \- name: Checkout Code         uses: actions/checkout@v3       \- name: Install yq         run: |           VERSION="4.30.8"           URL="https://github.com/mikefarah/yq/releases/download/v${VERSION}/yq\_linux\_amd64"           sudo curl \-sSL "$URL" \-o /usr/local/bin/yq           sudo chmod \+x /usr/local/bin/yq       \- name: Resolve env from build-config.yml         id: setenv         run: |           PIPELINE\_NAME="${{ github.event.inputs.pipeline\_name }}"           DEFAULT\_DOCKERFILE="Dockerfile"           echo "\#\#\# Pipeline Name \- $PIPELINE\_NAME" \>\> $GITHUB\_STEP\_SUMMARY           \# Find exactly one matching config block           MATCHING\_CONFIGS=$(yq eval \-o=json '.config\[\] | select(.name | test("/'"$PIPELINE\_NAME"'$"))' build/build-config.yml)           MATCH\_COUNT=$(echo "$MATCHING\_CONFIGS" | jq \-s 'length')           if \[ "$MATCH\_COUNT" \-ne 1 \]; then             echo "ERROR: Expected exactly 1 matching pipeline config, but found $MATCH\_COUNT"             exit 1           fi           \# Extract fields           SERVICE\_BUILD\_CONFIG=$(echo "$MATCHING\_CONFIGS" | jq \-c '.build\[\] | select(.\["image-name"\])')           SERVICE\_WORK\_DIR=$(echo "$SERVICE\_BUILD\_CONFIG" | yq eval \-r '.\["work-dir"\] // ""' \-)           SERVICE\_IMAGE\_NAME=$(echo "$SERVICE\_BUILD\_CONFIG" | yq eval \-r '.\["image-name"\] // ""' \-)           SERVICE\_DOCKERFILE=$(echo "$SERVICE\_BUILD\_CONFIG" | yq eval \-r '.dockerfile // ""' \-)           \# Default Dockerfile if none specified           if \[ \-z "$SERVICE\_DOCKERFILE" \]; then             SERVICE\_DOCKERFILE="$SERVICE\_WORK\_DIR/$DEFAULT\_DOCKERFILE"           fi           \# Export           echo "SERVICE\_WORK\_DIR=$SERVICE\_WORK\_DIR" \>\> "$GITHUB\_ENV"           echo "SERVICE\_IMAGE\_NAME=$SERVICE\_IMAGE\_NAME" \>\> "$GITHUB\_ENV"           echo "SERVICE\_DOCKERFILE=$SERVICE\_DOCKERFILE" \>\> "$GITHUB\_ENV"           echo "work\_dir=$SERVICE\_WORK\_DIR" \>\> $GITHUB\_OUTPUT           echo "image\_name=$SERVICE\_IMAGE\_NAME" \>\> $GITHUB\_OUTPUT           echo "dockerfile=$SERVICE\_DOCKERFILE" \>\> $GITHUB\_OUTPUT                      \# Put summary for the step           echo "\#\#\#\# Application Config Summary" \>\> $GITHUB\_STEP\_SUMMARY           echo "Application Work Directory \- $SERVICE\_WORK\_DIR" \>\> $GITHUB\_STEP\_SUMMARY           echo "Image Name \- $SERVICE\_IMAGE\_NAME" \>\> $GITHUB\_STEP\_SUMMARY           echo "Dockerfile Path \- $SERVICE\_DOCKERFILE" \>\> $GITHUB\_STEP\_SUMMARY       \- name: Generate the Next Tag         id: tag         run: |           set \-euxo pipefail           BRANCH="${GITHUB\_REF\#\#\*/}"           COMMIT\_HASH=$(git rev-parse \--short HEAD)           SERVICE\_NAME="${{ env.SERVICE\_IMAGE\_NAME }}"           TOKEN=$(curl \-s \-X POST "https://hub.docker.com/v2/users/login/" \\             \-H "Content-Type: application/json" \\             \-d "{\\"username\\": \\"$DOCKER\_USERNAME\\", \\"password\\": \\"$DOCKER\_PASSWORD\\"}" \\             | jq \-r .token)           if \[ \-z "$TOKEN" \]; then             echo "Failed to authenticate with Docker Hub." \>&2             exit 1           fi           \# Check if repo exists           HTTP\_CODE=$(curl \-s \-o /dev/null \-w '%{http\_code}' \\             \-H "Authorization: JWT $TOKEN" \\             "https://hub.docker.com/v2/repositories/$DOCKER\_USERNAME/$SERVICE\_NAME/")           if \[ "$HTTP\_CODE" \-ne 200 \]; then             NEXT\_TAG="${BRANCH}-${COMMIT\_HASH}"           else             EXISTING\_TAGS=$(curl \-s \-H "Authorization: JWT $TOKEN" \\               "https://hub.docker.com/v2/repositories/$DOCKER\_USERNAME/$SERVICE\_NAME/tags?page\_size=100" \\               | jq \-r '.results\[\].name')             LATEST\_TAG=$(echo "$EXISTING\_TAGS" \\               | grep "^${BRANCH}-${COMMIT\_HASH}" || true \\               | sort \-V \\               | tail \-n 1\)             NEXT\_TAG="${LATEST\_TAG:-${BRANCH}-${COMMIT\_HASH}}"           fi           echo "tag=$NEXT\_TAG" \>\> "$GITHUB\_OUTPUT"           echo "NEXT\_TAG=$NEXT\_TAG" \>\> "$GITHUB\_ENV"           echo "tag \- $NEXT\_TAG" \>\> $GITHUB\_STEP\_SUMMARY   build-matrix:     name: Build application ${{ matrix.arch }}     needs: \[resolve-config\]     strategy:       matrix:         include:           \- arch: amd64             platform: linux/amd64             runner: ubuntu-latest           \- arch: arm64             platform: linux/arm64             runner: ubuntu-24.04-arm     runs-on: ${{ matrix.runner }}     outputs:       amd64\_digest: ${{ steps.digest\_amd64.outputs.digest }}       arm64\_digest: ${{ steps.digest\_arm64.outputs.digest }}     steps:       \- name: Checkout Code         uses: actions/checkout@v3       \- name: Set up Docker Buildx         uses: docker/setup-buildx-action@v3       \- name: Cache Docker Layers         uses: actions/cache@v3         with:           path: /tmp/.buildx-cache           key: ${{ runner.os }}-${{ matrix.arch }}-buildx-${{ github.event.inputs.pipeline\_name }}-${{ github.ref\_name }}           restore-keys: |             ${{ runner.os }}-${{ matrix.arch }}-buildx-${{ github.event.inputs.pipeline\_name }}-       \- name: Log in to Docker Hub         uses: docker/login-action@v2         with:           username: ${{ env.DOCKER\_USERNAME }}           password: ${{ env.DOCKER\_PASSWORD }}       \- name: Build image for ${{ matrix.arch }}         run: |           docker buildx build \\             \--platform ${{ matrix.platform }} \\             \--build-arg WORK\_DIR=${{ needs.resolve-config.outputs.work\_dir }} \\             \--file ${{ needs.resolve-config.outputs.dockerfile }} \\             \--tag egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }}-${{ matrix.arch }} \\             \--cache-from=type=local,src=/tmp/.buildx-cache \\             \--cache-to=type=local,dest=/tmp/.buildx-cache,mode=max \\             \--push \\             \--iidfile digest.txt \\             .       \- name: Inspect Manifest List         run: |           docker buildx imagetools inspect egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }}-${{ matrix.arch }}       \- name: Export Digest (amd64)         if: matrix.arch \== 'amd64'         id: digest\_amd64         run: |           digest=$(docker buildx imagetools inspect \\             egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }}-${{ matrix.arch }} \\             \--format '{{json .}}' | jq \-r '.manifest.manifests\[\] | select(.platform.architecture=="amd64" and .platform.os=="linux") | .digest')           echo "digest=$digest" \>\> $GITHUB\_OUTPUT       \- name: Export Digest (arm64)         if: matrix.arch \== 'arm64'         id: digest\_arm64         run: |           digest=$(docker buildx imagetools inspect \\             egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }}-${{ matrix.arch }} \\             \--format '{{json .}}' | jq \-r '.manifest.manifests\[\] | select(.platform.architecture=="arm64" and .platform.os=="linux") | .digest')           echo "digest=$digest" \>\> $GITHUB\_OUTPUT   create-manifest:     name: Create and Push Manifest     needs: \[build-matrix, resolve-config\]     runs-on: ubuntu-latest     steps:       \- name: Log in to Docker Hub         uses: docker/login-action@v2         with:           username: ${{ env.DOCKER\_USERNAME }}           password: ${{ env.DOCKER\_PASSWORD }}       \- name: Create and push manifest         run: |           docker manifest create egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }} \\             \--amend egovio/${{ needs.resolve-config.outputs.image\_name }}@${{ needs.build-matrix.outputs.amd64\_digest }} \\             \--amend egovio/${{ needs.resolve-config.outputs.image\_name }}@${{ needs.build-matrix.outputs.arm64\_digest }}           docker manifest push egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }}       \- name: Cleanup local manifest refs         run: |           docker manifest rm egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }}-amd64 || true           docker manifest rm egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }}-arm64 || true       \- name: Add summary to GitHub Actions         run: |           echo "- Image: egovio/${{ needs.resolve-config.outputs.image\_name }}:${{ needs.resolve-config.outputs.tag }}" \>\> $GITHUB\_STEP\_SUMMARY           echo "- Platform: amd64, arm64" \>\> $GITHUB\_STEP\_SUMMARY* |
| :---- |

2. Trigger the build manually  
   1. Head towards this url on github and click on **Run workflow** on top right corner. [https://github.com/egovernments/DIGIT-Frontend/actions/workflows/build.yaml](https://github.com/egovernments/DIGIT-Frontend/actions/workflows/build.yaml)  
   2. Select your branch and pipeline you want to use.  
      ![][image1]  
3. Once build is completed you can get your docker image from logs or from summary page.

---

### **🚀 2\. Deployment via Jenkins**

Once your module is built and tested locally, deploy it using **Jenkins CI/CD pipeline**.  
**Trigger the deployment job** manually from the Jenkins dashboard.

\------------------------------------------END OF THE DOCUMENT-------------------------------------------

[image1]: <data:image/png;base64,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>