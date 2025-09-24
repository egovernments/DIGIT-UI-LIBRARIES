import React from "react";
import { MemoryRouter } from "react-router-dom";
// import { initCoreLibraries } from "@egovernments/digit-ui-libraries-core";
import { initLibraries } from "@egovernments/digit-ui-libraries";

// import '../src/index.css';
//:point_down: Configures Storybook to log the actions( onArchiveTask and onPinTask ) in the UI.
/** @type { import('@storybook/react').Preview } */

export const globalTypes = {
  theme: {
    description: "Global theme for components",
    defaultValue: "light",
    toolbar: {
      // The label to show for this toolbar item
      title: "Theme",
      icon: "circlehollow",
      // Array of plain string values or MenuItem shape (see below)
      items: ["light", "dark"],
      // Change title based on selected value
      dynamicTitle: true,
    },
  },
};

const preview = {
  parameters: {
    actions: { argTypesRegex: "^on[A-Z].*" },
    controls: {
      expanded: true,
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
    backgrounds: {
      default: "light",
      values: [
        {
          name: "light",
          value: "#FFFFFF",
        },
        {
          name: "gray",
          value: "#F5F5F5",
        },
        {
          name: "dark",
          value: "#333333",
        },
      ],
    },
  },
  decorators: [
    (Story) => (
      <MemoryRouter>
        <Story />
      </MemoryRouter>
    ),
  ],
};

initLibraries().then(() => {
  console.info("DIGIT Contant, HOOKS enabled", window?.Digit);
});

export default preview;
