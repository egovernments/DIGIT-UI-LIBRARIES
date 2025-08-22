# DIGIT UI Libraries - React 19 & Webpack Migration

[![React Version](https://img.shields.io/badge/React-19.0.0-blue)](https://reactjs.org/)
[![Build System](https://img.shields.io/badge/Build-Webpack-8DD6F9)](https://webpack.js.org/)
[![Node.js Version](https://img.shields.io/badge/Node.js-18+-green)](https://nodejs.org/)

A comprehensive collection of React 19-compatible UI component libraries for the DIGIT platform, migrated from React 17 with Webpack build system replacing Microbundle.

## 📦 Packages Overview

This monorepo contains four interdependent packages:

| Package | Version | Description | NPM Package |
|---------|---------|-------------|-------------|
| **libraries** | `1.8.17-rc19.01` | Core hooks, utilities, services, and contexts | `@egovernments/digit-ui-libraries` |
| **react-components** | `1.8.21-rc19.02` | React atoms, molecules & HOC components | `@egovernments/digit-ui-react-components` |
| **svg-components** | `1.0.21-rc19.01` | SVG icon library with stories | `@egovernments/digit-ui-svg-components` |
| **ui-components** | `0.2.0-beta.40-rc19.02` | Core UI components with Storybook | `@egovernments/digit-ui-components` |

## 🚀 Migration Context

### React 17 → React 19 Migration
These packages were **migrated from React 17 to React 19** with the following key changes:
- **Build System**: Migrated from Microbundle to Webpack 5.97.1
- **Router**: Upgraded from React Router 5 to 6.25.1
- **State Management**: Updated React Query to TanStack Query 5.62.16
- **Dependencies**: All peer dependencies externalized to prevent version conflicts
- **Form Libraries**: react-hook-form syntax updates for v7 compatibility

### Webpack Migration Benefits
- ✅ **Better build performance** and optimization control
- ✅ **UMD builds** for library distribution
- ✅ **External dependency management** preventing conflicts
- ✅ **Development mode builds** for easier debugging
- ✅ **Consistent configuration** across all packages

## 📋 Quick Start

### Prerequisites
- **Node.js**: ≥18.0.0
- **React**: 19.0.0
- **Package Manager**: Yarn (recommended) or npm

### Installation

```bash
# Install all packages
npm install @egovernments/digit-ui-libraries @egovernments/digit-ui-react-components @egovernments/digit-ui-svg-components @egovernments/digit-ui-components

# Or with yarn
yarn add @egovernments/digit-ui-libraries @egovernments/digit-ui-react-components @egovernments/digit-ui-svg-components @egovernments/digit-ui-components
```

### Basic Usage

```jsx
import { initLibraries } from "@egovernments/digit-ui-libraries";
import { Button, Card } from "@egovernments/digit-ui-react-components";
import { Home } from "@egovernments/digit-ui-svg-components";

// Initialize libraries first
initLibraries();

const App = () => {
  return (
    <Card>
      <Home />
      <Button>Click me</Button>
    </Card>
  );
};
```

## 🔧 Development

### Building Packages

Each package uses identical Webpack configurations:

```bash
# Build individual packages
cd libraries && yarn build
cd react-components && yarn build
cd svg-components && yarn build
cd ui-components && yarn build
```

### Development Servers

```bash
# Libraries - webpack dev server
cd libraries && yarn start

# Components with Storybook
cd react-components && yarn storybook  # Port 6006
cd ui-components && yarn storybook     # Port 6006
```

## 🔄 Migration Guide from Older Packages

### From React 17 DIGIT packages to React 19

#### 1. Update Package Versions
Replace all old DIGIT UI package references:

```json
{
  "dependencies": {
    "@egovernments/digit-ui-libraries": "1.8.17-rc19.01",
    "@egovernments/digit-ui-react-components": "1.8.21-rc19.02", 
    "@egovernments/digit-ui-svg-components": "1.0.21-rc19.01",
    "@egovernments/digit-ui-components": "0.2.0-beta.40-rc19.02"
  }
}
```

#### 2. Update React Dependencies
```json
{
  "dependencies": {
    "react": "19.0.0",
    "react-dom": "19.0.0", 
    "react-router-dom": "6.25.1",
    "@tanstack/react-query": "^5.62.16"
  }
}
```

#### 3. Add Peer Dependencies
Prevent version conflicts by adding core dependencies as peerDependencies:

```json
{
  "peerDependencies": {
    "react": "19.0.0",
    "react-dom": "19.0.0",
    "react-router-dom": "6.25.1", 
    "@tanstack/react-query": "^5.62.16"
  }
}
```

#### 4. Router Migration (v5 → v6)
**Old (React Router 5):**
```jsx
import { Switch, Route } from "react-router-dom";

<Switch>
  <Route path="/users" component={Users} />
  <Route path="/home" component={Home} />
</Switch>
```

**New (React Router 6):**
```jsx
import { Routes, Route } from "react-router-dom";

<Routes>
  <Route path="/users" element={<Users />} />
  <Route path="/home" element={<Home />} />
</Routes>
```

#### 5. React Hook Form Updates
**Old (v6):**
```jsx
<Controller
  render={(props) => <input {...props} />}
/>
```

**New (v7):**
```jsx
<Controller
  render={({ field }) => <input {...field} />}
/>
```

#### 6. Webpack Configuration
If building modules, add externals to prevent duplicate React instances:

```javascript
// webpack.config.js
module.exports = {
  externals: {
    react: {
      commonjs: 'react',
      commonjs2: 'react',
      amd: 'react',
      root: 'React',
    },
    'react-dom': {
      commonjs: 'react-dom',
      commonjs2: 'react-dom', 
      amd: 'react-dom',
      root: 'ReactDOM',
    },
    '@tanstack/react-query': '@tanstack/react-query',
    'react-router-dom': 'react-router-dom'
  }
}
```

## ⚠️ Known Issues & Risks

### Critical Issues Identified

#### 1. **Peer Dependency Management** 
- **Risk**: Multiple React instances causing "Invalid hook call" errors
- **Solution**: Ensure React is installed only at root level, use peerDependencies in packages
- **Impact**: High - App crashes

#### 2. **React Hook Form Compatibility**
- **Risk**: Syntax changes in v7 causing "props.onChange is not a function" errors
- **Solution**: Use `render={({ field })}` syntax or downgrade to v6.15.8
- **Impact**: Medium - Form components break

#### 3. **Build Configuration Mismatches**
- **Risk**: Package not found during build due to incorrect webpack output naming
- **Solution**: Ensure `webpack.config.js` output filename matches `package.json` main/module fields
- **Impact**: High - Build failures

#### 4. **Proxy Configuration**
- **Risk**: API routes fail after webpack migration from react-scripts  
- **Solution**: Move proxy config from `setupProxy.js` to `webpack.config.js` devServer
- **Impact**: Medium - API calls fail

#### 5. **QueryClient Context Issues**
- **Risk**: Multiple QueryClient instances causing context errors
- **Solution**: Add `@tanstack/react-query` to webpack externals in all packages
- **Impact**: Medium - Data fetching fails

### Development Risks

#### Performance Concerns
- **Large bundle sizes**: 4 interconnected packages may create large bundles
- **Development builds**: Using development mode for production builds (current setup)
- **Duplicate dependencies**: Without proper externals, dependencies may be duplicated

#### Stability Issues
- **Storybook version mismatch**: Different versions between react-components (6.4.20) and ui-components (8.6.14)
- **Legacy dependencies**: Some packages still use older versions (react-scripts 4.0.1)
- **CSS handling**: Missing sass configuration may cause styling issues

## 🛠️ Key Items to Fix

### High Priority

1. **Standardize Build Mode**
   ```javascript
   // Current: Development builds for production
   mode: "development"
   
   // Recommended: Environment-based builds
   mode: process.env.NODE_ENV === 'production' ? 'production' : 'development'
   ```

2. **Update Storybook Versions**
   - Align react-components to Storybook 8.x
   - Remove deprecated @storybook/preset-create-react-app

3. **Remove Legacy Dependencies**
   ```bash
   # Remove from all packages
   npm uninstall react-scripts microbundle-crl
   ```

4. **Implement CSS/SCSS Support**
   ```javascript
   // Add to webpack.config.js
   {
     test: /\.(sa|sc|c)ss$/,
     use: ["style-loader", "css-loader", "sass-loader"]
   }
   ```

### Medium Priority

1. **Bundle Size Optimization**
   - Implement code splitting
   - Add bundle analyzer
   - Remove unused dependencies

2. **Add Testing Framework**
   - No test commands currently configured
   - Recommend Jest + React Testing Library

3. **Improve Build Scripts**
   - Add production builds
   - Implement pre-commit hooks
   - Add CI/CD optimizations

## 📚 Additional Resources

- [Migration Documentation](./docs/Upgrading%20DIGIT%20for%20React%2019%20and%20Node%2020%20Compatibility_%20Key%20Changes%20and%20Improvements.md)
- [Module Integration Guide](./docs/Module%20Integration%20Guide%20for%20React%2019%20Upgraded%20DIGIT%20Platform.md)

## 🤝 Contributing

1. Follow the existing webpack configuration patterns
2. Add peer dependencies for React, React-DOM, React Router, and TanStack Query
3. Use development builds for consistency
4. Test with both individual package builds and integrated applications

## 📄 License

MIT © eGovernments Foundation