import React, { Children } from "react";
import { BrowserRouter as Router } from "react-router-dom";
import { SideNav } from "../../atoms";

export default {
  title: "Molecules/SideNav/Dark",
  component: SideNav,
  argTypes: {
    items: { control: "object" },
    collapsedWidth: { control: "text" },
    expandedWidth: { control: "text" },
    transitionDuration: { control: "number" },
    theme: { control: "select", options: ["dark", "light"] },
    variant: { control: "select", options: ["primary", "secondary"] },
    hideAccessbilityTools: { control: "boolean" },
    onSelect:{ action: "onChange" },
    onBottomItemClick:{action:"onChange"}
  },
};

const Template = (args) => (
  <Router>
    <SideNav {...args} />
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

const onSelect = (e)  =>{
  console.log(e,"selected")
}
const onBottomItemClick =(e) => {
  console.log(e,"onAccessibilityClick")
}

const commonArgs = {
  items: darkThemeitems,
  transitionDuration: 0.5,
  theme: "dark",
  onSelect:onSelect,
  onBottomItemClick:onBottomItemClick
};

export const Primary = Template.bind({});
Primary.args = {
  ...commonArgs,
};

export const Secondary = Template.bind({});
Secondary.args = {
  ...commonArgs,
  variant: "secondary",
};

export const WithHiddenAccessbilityTools = Template.bind({});
WithHiddenAccessbilityTools.args = {
  ...commonArgs,
  variant: "primary",
  hideAccessbilityTools: true,
};