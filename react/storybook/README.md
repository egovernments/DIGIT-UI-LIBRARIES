# DIGIT UI Components Storybook

This is a separate package that contains the Storybook setup for the DIGIT UI Components library.

## Live Storybook

View the live Storybook documentation at: [https://egovernments.github.io/DIGIT-UI-LIBRARIES/](https://egovernments.github.io/DIGIT-UI-LIBRARIES/?path=/docs/intro--docs)

## Structure

```
storybook/
├── package.json          # Storybook dependencies and scripts
├── .storybook/           # Storybook configuration
│   ├── main.js          # Main configuration
│   ├── preview.js       # Preview configuration
│   └── preview-head.html # HTML head content
├── atoms/                # Atomic component stories
├── molecules/            # Molecular component stories
├── foundationstories/    # Foundation stories
└── README.md            # This file
```

## Usage

### Installation

```bash
cd react/storybook
npm install --legacy-peer-deps
```

### Running Storybook

```bash
# From the storybook directory
npm run storybook

# Or directly
npm run storybook:serve
```

### Building Storybook

```bash
# From the storybook directory
npm run build-storybook
```

## GitHub Pages Deployment

The Storybook is automatically deployed to GitHub Pages when changes are pushed to the `develop` branch. The deployment is handled by the `.github/workflows/deploy-storybook.yml` workflow.

### Deployment Configuration

- **Trigger**: Pushes to `develop` branch affecting `react/storybook/**` or `react/ui-components/**`
- **Node Version**: 20
- **Build Output**: `react/storybook/storybook-static`
- **URL**: https://egovernments.github.io/DIGIT-UI-LIBRARIES/

## How it works

1. **Separate Dependencies**: All Storybook-related dependencies are isolated in this package, keeping the main ui-components package clean.

2. **Webpack Aliases**: The main.js configuration sets up webpack aliases to resolve components from the parent ui-components directory.

3. **Story Discovery**: Stories are discovered from `../ui-components/src/**/*.stories.@(js|jsx|mjs|ts|tsx)` and local story files.

4. **Package Versions**: Uses development versions of DIGIT UI packages (`2.0.0-dev-01`)

## Benefits

- ✅ Clean separation of concerns
- ✅ Reduced main package dependencies
- ✅ Isolated Storybook environment
- ✅ Easy maintenance and updates
- ✅ No interference with main build process
- ✅ Automatic deployment to GitHub Pages