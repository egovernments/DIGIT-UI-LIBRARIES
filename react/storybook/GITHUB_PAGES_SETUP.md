# DIGIT UI Components Storybook

This package contains the Storybook configuration for DIGIT UI Components, set up as a separate package to keep dependencies isolated from the main ui-components package.

## 🚀 Local Development

```bash
# Install dependencies
npm install

# Start Storybook development server
npm run storybook

# Build static Storybook
npm run build-storybook
```

## 📖 GitHub Pages Deployment

This repository is configured to automatically deploy Storybook to GitHub Pages when changes are made to the `webpack/storybook/` or `webpack/ui-components/` directories.

### Setup Instructions

1. **Enable GitHub Pages** in your repository settings:
   - Go to Settings → Pages
   - Set Source to "GitHub Actions"

2. **Push changes** to the `master` or `main` branch

3. **Monitor deployment** in the Actions tab

4. **Access your Storybook** at: `https://[your-username].github.io/DIGIT-UI-LIBRARIES/`

### Manual Deployment

You can also trigger deployment manually:
- Go to Actions tab in GitHub
- Select "Deploy Storybook to GitHub Pages" workflow
- Click "Run workflow"

## 📁 Structure

```
webpack/storybook/
├── .storybook/          # Storybook configuration
├── atoms/               # Copied atom stories
├── molecules/           # Copied molecule stories
├── constants/           # Animation files and constants
├── package.json         # Isolated dependencies
└── README.md           # This file
```

## 🔧 Configuration

The Storybook configuration includes:
- Webpack aliases for component imports
- Support for all DIGIT UI component stories
- Isolated dependency management
- Optimized build configuration for GitHub Pages

## 🐛 Troubleshooting

If you encounter issues:

1. **Build fails**: Check that ui-components dependencies are installed
2. **Stories not loading**: Verify webpack aliases in `.storybook/main.js`
3. **Pages not deploying**: Ensure GitHub Pages is enabled and source is set to "GitHub Actions"

## 📝 Notes

- This package maintains its own `node_modules` to avoid conflicts
- Stories are copied locally for better path resolution
- Animation files are included for proper component rendering