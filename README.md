# DIGIT UI Libraries

<div align="center">
  <img src="https://s3.ap-south-1.amazonaws.com/works-dev-asset/mseva-white-logo.png" alt="DIGIT Logo" width="300"/>
  
  [![Storybook](https://img.shields.io/badge/Storybook-Live-ff4785?logo=storybook)](https://egovernments.github.io/DIGIT-UI-LIBRARIES/?path=/docs/intro--docs)
  [![React](https://img.shields.io/badge/React-19.0.0-61dafb?logo=react)](https://reactjs.org/)
  [![Flutter](https://img.shields.io/badge/Flutter-Latest-02569b?logo=flutter)](https://flutter.dev/)
  [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
</div>

## Overview

DIGIT UI Libraries is a comprehensive collection of reusable, accessible, and customizable UI components designed for building modern government digital services. This monorepo contains component libraries for both **React** and **Flutter** platforms, ensuring consistent user experiences across web and mobile applications.

## 🚀 Quick Links

- 📚 **[Live Storybook Documentation](https://egovernments.github.io/DIGIT-UI-LIBRARIES/?path=/docs/intro--docs)** - Interactive component playground
- 📖 **[React Components Guide](https://core.digit.org/v/2.9-lts/guides/developer-guide/ui-developer-guide/digit-ui/ui-components/ui-components-standardisation/digit-ui-core-react-components)**
- 📱 **[Flutter Components Guide](https://core.digit.org/v/2.9-lts/guides/developer-guide/ui-developer-guide/digit-ui/ui-components/ui-components-standardisation/digit-ui-core-flutter-components)**
- 🎨 **[Flutter Storybook](https://unified-dev.digit.org/digit-ui-flutter/)** - Flutter component showcase

## 📦 Package Structure

```
DIGIT-UI-LIBRARIES/
├── react/                    # React component libraries
│   ├── ui-components/        # Core React components
│   ├── storybook/           # Storybook documentation
│   └── ...                  # Other React packages
├── flutter/                 # Flutter component libraries
│   └── digit_ui_components/ # Core Flutter components
└── .github/                 # GitHub workflows and CI/CD
```

## 🎯 Features

### Component Libraries
- **Atomic Design Principles** - Components organized into atoms, molecules, and organisms
- **Accessibility First** - WCAG compliant components with proper ARIA attributes
- **Theme Support** - Built-in support for light/dark themes and custom branding
- **Responsive Design** - Mobile-first approach with responsive layouts
- **TypeScript Support** - Full TypeScript definitions for type safety

### Developer Experience
- **Interactive Documentation** - Live component playground with Storybook
- **Comprehensive Examples** - Real-world usage examples and best practices
- **Automated Deployment** - GitHub Pages deployment for documentation
- **Version Management** - Semantic versioning with controlled releases

## 🛠️ React Components

### Installation

```bash
npm install @egovernments/digit-ui-components
# or
yarn add @egovernments/digit-ui-components
```

### Basic Usage

```jsx
import { Button, Card, Input } from '@egovernments/digit-ui-components';

function App() {
  return (
    <Card>
      <Input label="Name" placeholder="Enter your name" />
      <Button variant="primary" onClick={() => alert('Clicked!')}>
        Submit
      </Button>
    </Card>
  );
}
```

### Available Components

#### Atoms
- Buttons (Primary, Secondary, Tertiary)
- Input fields (Text, Number, Date, File)
- Checkboxes and Radio buttons
- Chips and Tags
- Loaders and Spinners
- Icons and Images

#### Molecules
- Cards (Basic, Form, Summary, Metric)
- Headers and Footers
- Navigation (Side nav, Breadcrumbs)
- Modals and Popups
- Forms and Form composers
- Tables and Data grids

### Development

```bash
# Navigate to React storybook
cd react/storybook

# Install dependencies (use legacy peer deps for React 19)
npm install --legacy-peer-deps

# Start development server
npm run storybook

# Build for production
npm run build-storybook
```

## 📱 Flutter Components

### Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  digit_ui_components:
    git:
      url: https://github.com/egovernments/DIGIT-UI-LIBRARIES.git
      path: flutter/digit_ui_components
```

### Basic Usage

```dart
import 'package:digit_ui_components/digit_ui_components.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DigitButton(
      label: 'Submit',
      onPressed: () => print('Button pressed'),
      variant: ButtonVariant.primary,
    );
  }
}
```

### Available Components
- Form controls (Input, Select, Checkbox)
- Navigation components
- Cards and containers
- Feedback components (Toast, Alert)
- Data display (Tables, Lists)

## 🚀 Deployment

### GitHub Pages (Storybook)

The React Storybook is automatically deployed to GitHub Pages through GitHub Actions when changes are pushed to the `develop` branch.

**Deployment Workflow:**
- Triggers on push to `develop` branch
- Monitors changes in `react/storybook/**` and `react/ui-components/**`
- Builds with Node.js 20
- Deploys to: https://egovernments.github.io/DIGIT-UI-LIBRARIES/

## 🤝 Contributing

We welcome contributions to enhance the DIGIT UI Libraries! Here's how you can help:

### Getting Started

1. **Fork the repository**
   ```bash
   git clone https://github.com/egovernments/DIGIT-UI-LIBRARIES.git
   cd DIGIT-UI-LIBRARIES
   ```

2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow existing code patterns and conventions
   - Ensure components are accessible
   - Add/update stories for new components
   - Write comprehensive documentation

4. **Test your changes**
   ```bash
   # For React components
   cd react/storybook
   npm run storybook
   
   # Verify build works
   npm run build-storybook
   ```

5. **Submit a Pull Request**
   - Provide clear description of changes
   - Reference any related issues
   - Include screenshots for UI changes

### Guidelines

- **Code Style**: Follow existing patterns and linting rules
- **Documentation**: Update README and add Storybook stories
- **Testing**: Ensure all components work as expected
- **Accessibility**: Maintain WCAG compliance
- **Performance**: Keep bundle sizes minimal

## 📄 License

This project is licensed under the [MIT License](LICENSE) - you are free to use, modify, and distribute the code for both personal and commercial purposes with attribution.

## 🆘 Support

Need help or found an issue?

- 📝 **[Report Issues](https://github.com/egovernments/DIGIT-UI-LIBRARIES/issues)** - Report bugs or request features
- 💬 **[Discussions](https://github.com/egovernments/DIGIT-UI-LIBRARIES/discussions)** - Ask questions and share ideas
- 📧 **Contact** - Reach out to the maintainers for critical issues

## 🏆 Acknowledgments

Built with ❤️ by the DIGIT team for digital governance transformation.

<div align="center">
  <img src="https://s3.ap-south-1.amazonaws.com/works-dev-asset/mseva-lightPaperPrimary-logo.png" alt="DIGIT Logo" width="200"/>
</div>