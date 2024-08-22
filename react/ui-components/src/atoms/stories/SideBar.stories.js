import React, { Children } from "react";
import { BrowserRouter as Router } from "react-router-dom";
import { SVG } from "../SVG";
import Sidebar from "../Sidebar";

export default {
  title: "Atoms/Sidebar",
  component: Sidebar,
  argTypes: {
    items: { control: "object" },
    collapsedWidth: { control: "text" },
    expandedWidth: { control: "text" },
    transitionDuration: { control: "number" },
    theme: { control: "select", options: ["dark", "light"] },
    variant: { control: "select", options: ["primary", "secondary"] },
    hideAccessbilityTools: { control: "boolean" },
  },
};

const Template = (args) => (
  <Router>
    <Sidebar {...args} />
  </Router>
);

const darkThemeitems = [
  {
    label: "Home",
    icon: {
      icon: "Home",
    },
  },
  {
    label: "Module 1",
    icon: {
      icon: "ChatBubble",
    },
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: {
          icon: "Work",
        },
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: {
          icon: "Person",
        },
      },
    ],
  },
  {
    label: "Module 2",
    icon: {
      icon: "CheckCircle",
    },
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: {
          icon: "Info",
        },
        children: [
          {
            path: "/",
            label: "InnerModule 1",
            icon: {
              icon: "LabelImportant",
            },
          },
          {
            path: "/",
            label: "InnerModule 2",
            icon: {
              icon: "Lock",
            },
          },
        ],
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: {
          icon: "Accessibility",
        },
      },
    ],
  },
  {
    label: "Module 3",
    icon: {
      icon: "Delete",
    },
  },
  {
    label: "Module 4",
    icon: {
      icon: "DriveFileMove",
    },
  },
  {
    label: "Module 5",
    icon: {
      icon: "Label",
    },
  },
  {
    label: "Module 6",
    icon: {
      icon: "Lightbulb",
    },
  },
];

const lightThemeprimaryitems = [
  {
    label: "Home",
    icon: {
      icon: "Home",
    },
  },
  {
    label: "Module 1",
    icon: {
      icon: "ChatBubble",
    },
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: {
          icon: "Work",
        },
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: {
          icon: "Person",
        },
      },
    ],
  },
  {
    label: "Module 2",
    icon: {
      icon: "CheckCircle",
    },
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: {
          icon: "Info",
        },
        children: [
          {
            path: "/",
            label: "InnerModule 1",
            icon: {
              icon: "LabelImportant",
            },
          },
          {
            path: "/",
            label: "InnerModule 2",
            icon: {
              icon: "Lock",
            },
          },
        ],
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: {
          icon: "Accessibility",
        },
      },
    ],
  },
  {
    label: "Module 3",
    icon: {
      icon: "Delete",
    },
  },
  {
    label: "Module 4",
    icon: {
      icon: "DriveFileMove",
    },
  },
  {
    label: "Module 5",
    icon: {
      icon: "Label",
    },
  },
  {
    label: "Module 6",
    icon: {
      icon: "Lightbulb",
    },
  },
];

const lightThemesecondaryitems = [
  {
    label: "Home",
    icon: {
      icon: "Home",
    },
  },
  {
    label: "Module 1",
    icon: {
      icon: "ChatBubble",
    },
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: {
          icon: "Work",
        },
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: {
          icon: "Person",
        },
      },
    ],
  },
  {
    label: "Module 2",
    icon: {
      icon: "CheckCircle",
    },
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: {
          icon: "Info",
        },
        children: [
          {
            path: "/",
            label: "InnerModule 1",
            icon: {
              icon: "LabelImportant",
            },
          },
          {
            path: "/",
            label: "InnerModule 2",
            icon: {
              icon: "Lock",
            },
          },
        ],
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: {
          icon: "Accessibility",
        },
      },
    ],
  },
  {
    label: "Module 3",
    icon: {
      icon: "Delete",
    },
  },
  {
    label: "Module 4",
    icon: {
      icon: "DriveFileMove",
    },
  },
  {
    label: "Module 5",
    icon: {
      icon: "Label",
    },
  },
  {
    label: "Module 6",
    icon: {
      icon: "Lightbulb",
    },
  },
];

const commonArgs = {
  items: darkThemeitems,
  transitionDuration: 0.3,
  theme: "dark",
};

export const DarkThemePrimarySideBar = Template.bind({});
DarkThemePrimarySideBar.args = {
  ...commonArgs,
};

export const DarkThemeSecondarySideBar = Template.bind({});
DarkThemeSecondarySideBar.args = {
  ...commonArgs,
  variant: "secondary",
};

export const DarkThemeSideBarWithHiddenAccessbilityTools = Template.bind({});
DarkThemeSideBarWithHiddenAccessbilityTools.args = {
  ...commonArgs,
  variant: "primary",
  hideAccessbilityTools: true,
};

export const LightThemePrimarySideBar = Template.bind({});
LightThemePrimarySideBar.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeprimaryitems,
};

export const LightThemeSecondarySideBar = Template.bind({});
LightThemeSecondarySideBar.args = {
  ...commonArgs,
  theme: "light",
  variant: "secondary",
  items: lightThemesecondaryitems,
};

export const LightThemeSideBarWithHiddenAccessbilityTools = Template.bind({});
LightThemeSideBarWithHiddenAccessbilityTools.args = {
  ...commonArgs,
  variant: "primary",
  hideAccessbilityTools: true,
};

export const CustomCollapsedAndExpandedWidths = Template.bind({});
CustomCollapsedAndExpandedWidths.args = {
  ...commonArgs,
  collapsedWidth: "80px",
  expandedWidth: "250px",
};
