# DIGIT UI Components Storybook

This is a separate package that contains the Storybook setup for the DIGIT UI Components library.

## Structure

```
storybook/
├── package.json          # Storybook dependencies and scripts
├── .storybook/           # Storybook configuration
│   ├── main.js          # Main configuration
│   ├── preview.js       # Preview configuration
│   └── preview-head.html # HTML head content
└── README.md            # This file
```

## Usage

### Installation

```bash
cd storybook
npm install
```

### Running Storybook

```bash
# From the storybook directory
npm run storybook

# From the ui-components directory (using proxy scripts)
npm run storybook
```

### Building Storybook

```bash
# From the storybook directory
npm run build-storybook

# From the ui-components directory (using proxy scripts)
npm run build-storybook
```

## How it works

1. **Separate Dependencies**: All Storybook-related dependencies are isolated in this package, keeping the main ui-components package clean.

2. **Webpack Aliases**: The main.js configuration sets up webpack aliases to resolve components from the parent ui-components directory.

3. **Story Discovery**: Stories are discovered from `../ui-components/src/**/*.stories.@(js|jsx|mjs|ts|tsx)`.

4. **Proxy Scripts**: The ui-components package.json contains proxy scripts that delegate to this package.

## Benefits

- ✅ Clean separation of concerns
- ✅ Reduced main package dependencies
- ✅ Isolated Storybook environment
- ✅ Easy maintenance and updates
- ✅ No interference with main build process