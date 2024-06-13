module.exports = function (plop) {
  plop.setGenerator('module', {
    description: 'Generate a new module with service',
    prompts: [
      {
        type: 'input',
        name: 'moduleName',
        message: 'Module name?',
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
        path: 'modules/{{kebabCase moduleName}}/src/hooks/services/search{{properCase moduleName}}.js',
        templateFile: 'plop-templates/module/src/hooks/services/sampleService.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/hooks/services/searchTestResultData.js',
        templateFile: 'plop-templates/module/src/hooks/services/searchTestResultData.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/hooks/index.js',
        templateFile: 'plop-templates/module/src/hooks/index.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/hooks/useIndividualView.js',
        templateFile: 'plop-templates/module/src/hooks/useIndividualView.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/pages/employee/index.js',
        templateFile: 'plop-templates/module/src/pages/employee/index.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/pages/employee/{{properCase moduleName}}Create.js',
        templateFile: 'plop-templates/module/src/pages/employee/SampleCreate.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/pages/employee/{{properCase moduleName}}Search.js',
        templateFile: 'plop-templates/module/src/pages/employee/SampleSearch.js.hbs',
      },  {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/pages/employee/{{properCase moduleName}}Response.js',
        templateFile: 'plop-templates/module/src/pages/employee/SampleResponse.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/utils/createUtils.js',
        templateFile: 'plop-templates/module/src/utils/createUtils.js.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/src/utils/index.js',
        templateFile: 'plop-templates/module/src/utils/index.js.hbs',
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
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/README.md',
        templateFile: 'plop-templates/module/README.md.hbs',
      },
      {
        type: 'add',
        path: 'modules/{{kebabCase moduleName}}/CHANGELOG.md',
        templateFile: 'plop-templates/module/CHANGELOG.md.hbs',
      },
    ],
  });
};