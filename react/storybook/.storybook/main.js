import { join, dirname, resolve } from 'path';
import { fileURLToPath } from 'url';
import { createRequire } from 'module';

const require = createRequire(import.meta.url);

/**
 * This function is used to resolve the absolute path of a package.
 * It is needed in projects that use Yarn PnP or are set up within a monorepo.
 */
function getAbsolutePath(value) {
  return dirname(require.resolve(join(value, 'package.json')));
}

/** @type { import('@storybook/react-webpack5').StorybookConfig } */
const config = {
  stories: [
    '../test-*.stories.@(js|jsx|mjs|ts|tsx)',
    '../atoms/**/*.stories.@(js|jsx|mjs|ts|tsx)',
    '../molecules/**/*.stories.@(js|jsx|mjs|ts|tsx)',
  ],
  addons: [
    getAbsolutePath('@storybook/addon-webpack5-compiler-swc'),
    getAbsolutePath('@storybook/addon-essentials'),
    getAbsolutePath('@storybook/addon-onboarding'),
    getAbsolutePath('@storybook/addon-interactions'),
    '@storybook/addon-a11y',
    '@storybook/addon-docs',
  ],
  docs: {
    autodocs: true,
  },
  framework: {
    name: getAbsolutePath('@storybook/react-webpack5'),
    options: {},
  },
  webpackFinal: async (config) => {
    const uiComponentsPath = resolve(__dirname, '../../ui-components/src');
    console.log('UI Components path:', uiComponentsPath);
    
    config.resolve.alias = {
      ...config.resolve.alias,
      '@egovernments/digit-ui-components/atoms': resolve(uiComponentsPath, 'atoms'),
      '@egovernments/digit-ui-components/molecules': resolve(uiComponentsPath, 'molecules'),
      '@egovernments/digit-ui-components/constants': resolve(uiComponentsPath, 'constants'),
      '@egovernments/digit-ui-components/hoc': resolve(uiComponentsPath, 'hoc'),
      '@egovernments/digit-ui-components/utils': resolve(uiComponentsPath, 'utils'),
      '@egovernments/digit-ui-components': uiComponentsPath,
      '@egovernments/digit-ui-svg-components': resolve(__dirname, '../node_modules/@egovernments/digit-ui-svg-components'),
      '@egovernments/digit-ui-libraries': resolve(__dirname, '../node_modules/@egovernments/digit-ui-libraries'),
      '@egovernments/digit-ui-components-css': resolve(__dirname, '../node_modules/@egovernments/digit-ui-components-css'),
      // Fallback for dependencies to use storybook's node_modules
      'react-datepicker': resolve(__dirname, '../node_modules/react-datepicker'),
      'react-webcam': resolve(__dirname, '../node_modules/react-webcam'),
      'react-drag-drop-files': resolve(__dirname, '../node_modules/react-drag-drop-files'),
      'react-data-table-component': resolve(__dirname, '../node_modules/react-data-table-component'),
    };
    
    // Add fallback module resolution
    config.resolve.modules = [
      resolve(__dirname, '../node_modules'),
      resolve(__dirname, '../../ui-components/node_modules'),
      'node_modules'
    ];
    
    return config;
  },
};

export default config;
