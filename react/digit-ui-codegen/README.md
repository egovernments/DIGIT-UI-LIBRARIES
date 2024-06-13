<!-- TODO: update this -->

# digit-ui-codegen

## Install

```bash
npm install --save @egovernments/digit-ui-module-{{kebabCase moduleName}}
```

## Limitation

```bash
This Package is more specific to DIGIT-UI's can be used across mission's
It is the base css for all Digit UI's
```

# Plop Generator for Modules

This Plop generator helps you create a new module with a service structure. It automates the creation of files and folders required for the module, ensuring a consistent and organized project structure.

## Features

- Generates a new module with a defined service structure.
- Creates necessary configuration, service, hook, page, utility, and component files.
- Uses Handlebars templates for file content.

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) installed.
- [Plop.js](https://plopjs.com/) installed globally.

### Installation

1. Install Plop globally if you haven't already:

    ```bash
    npm install -g plop
    ```

2. Clone or download the repository containing this generator.

3. Navigate to the directory containing the `plopfile.js`:

    ```bash
    cd path-to-your-repo
    ```

## Usage

To generate a new module, run the following command in the terminal:

```bash
plop module
```

You will be prompted to provide the module name. Based on the input, the generator will create the following structure:

```
modules/
  └── your-module-name/
      ├── package.json
      ├── README.md
      ├── CHANGELOG.md
      ├── src/
      │   ├── Module.js
      │   ├── configs/
      │   │   ├── UICustomizations.js
      │   │   ├── your-module-nameCreateConfig.js
      │   │   ├── your-module-nameSearchConfig.js
      │   ├── hooks/
      │   │   ├── services/
      │   │   │   ├── searchYourModuleName.js
      │   │   │   ├── searchTestResultData.js
      │   │   ├── index.js
      │   │   ├── useIndividualView.js
      │   ├── pages/
      │   │   ├── employee/
      │   │   │   ├── index.js
      │   │   │   ├── YourModuleNameCreate.js
      │   │   │   ├── YourModuleNameSearch.js
      │   │   │   ├── YourModuleNameResponse.js
      │   ├── utils/
      │   │   ├── createUtils.js
      │   │   ├── index.js
      │   ├── components/
      │   │   ├── YourModuleNameCard.js
      │   │   ├── YourModuleNameTestComponent.js
```

## File Descriptions

- **package.json**: Contains metadata and dependencies for the module.
- **README.md**: Documentation for the module.
- **CHANGELOG.md**: Keeps track of changes and version history.
- **src/Module.js**: Main module file.
- **src/configs/**: Configuration files for UI customizations and module-specific settings.
- **src/hooks/**: Custom hooks and service files for data fetching and manipulation.
- **src/pages/employee/**: Page components related to employee management.
- **src/utils/**: Utility functions used within the module.
- **src/components/**: React components specific to the module.

## Customization

You can customize the templates used for generating files. The templates are located in the `plop-templates/module/` directory. Modify these templates to fit your specific needs.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

By using this Plop generator, you ensure that your modules have a consistent structure and adhere to best practices. Happy coding!