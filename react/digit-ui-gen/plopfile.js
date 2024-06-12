module.exports = function (plop) {
  plop.setGenerator('module', {
    description: 'Generate a new module with service',
    prompts: [
      {
        type: 'input',
        name: 'moduleName',
        message: 'Module name?',
      },
      {
        type: 'input',
        name: 'serviceName',
        message: 'Service name?',
      },
    ],
    actions: [
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/package.json',
        templateFile: 'plop-templates/module/package.json.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/Module.js',
        templateFile: 'plop-templates/module/src/Module.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/configs/UICustomisations.js',
        templateFile: 'plop-templates/module/src/configs/UICustomizations.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/configs/{{kebabCase moduleName}}CreateConfig.js',
        templateFile: 'plop-templates/module/src/configs/SampleCreateConfig.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/configs/{{kebabCase moduleName}}SearchConfig.js',
        templateFile: 'plop-templates/module/src/configs/SampleSearchConfig.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/hooks/services/search{{properCase serviceName}}.js',
        templateFile: 'plop-templates/module/src/hooks/services/searchService.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/hooks/index.js',
        templateFile: 'plop-templates/module/src/hooks/index.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/pages/employee/index.js',
        templateFile: 'plop-templates/module/src/pages/employee/index.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/pages/employee/{{properCase serviceName}}Create.js',
        templateFile: 'plop-templates/module/src/pages/employee/SampleCreate.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/pages/employee/{{properCase serviceName}}Search.js',
        templateFile: 'plop-templates/module/src/pages/employee/SampleSearch.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/components/{{properCase moduleName}}Card.js',
        templateFile: 'plop-templates/module/src/components/SampleCard.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/components/{{properCase moduleName}}TestComponent.js',
        templateFile: 'plop-templates/module/src/components/SampleTestComponent.js.hbs',
      },
    ],
  });
};