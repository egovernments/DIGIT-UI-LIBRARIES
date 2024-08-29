import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import MobileSidebar from "../MobileSidebar"; 
import { SVG } from "../SVG"; 


export default {
  title: "Atoms/Hamburger",
  component: MobileSidebar,
  argTypes: {
    items: { control: "object" },
    usermanuals: { control: "object" },
    theme: { control: "select", options: ["dark", "light"] },
    variant: { control: "select", options: ["primary", "secondary"] },
    transitionDuration: { control: "number" },
    isSearchable:{control:"boolean"},
    hideUserManuals:{control:"boolean"},
    userManualLabel:{control:"text"},
    profile:{control:"text"},
    onSelect:{ action: "onChange" }
  },
};

const Template = (args) => (
  <Router>
    <MobileSidebar {...args} />
  </Router>
);

const darkThemeItems = [
  {
    label: "City",
    icon:"Home",
    children: [
      {
        path: "/",
        label: "City 1",
        icon: "Lightbulb",
      },
      {
        path: "/",
        label: "City 2",
        icon: "Label",
      },
    ],
  },
  {
    label: "Language",
    children: [
      {
        path: "/",
        label: "Language 1",
        icon: "DriveFileMove",
      },
      {
        path: "/",
        label: "Language 2",
        icon: "Delete",
      },
    ],
  },
  {
    label: "SideNav",
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: "Accessibility",
        children: [
          {
            path: "/",
            label: "InnerModule 1",
            icon: "Lock",
          },
          {
            path: "/",
            label: "InnerModule 2",
            icon: "LabelImportant",
          },
        ],
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: "CheckCircle",
      },
    ],
  },
];

const lightThemeItems = [
  {
    label: "City",
    icon:"Home",
    children: [
      {
        path: "/",
        label: "City 1",
        icon: "Lightbulb",
      },
      {
        path: "/",
        label: "City 2",
        icon: "Label",
      },
    ],
  },
  {
    label: "Language",
    children: [
      {
        path: "/",
        label: "Language 1",
        icon: "DriveFileMove",
      },
      {
        path: "/",
        label: "Language 2",
        icon: "Delete",
      },
    ],
  },
  {
    label: "SideNav",
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: "Accessibility",
        children: [
          {
            path: "/",
            label: "InnerModule 1",
            icon: "Lock",
          },
          {
            path: "/",
            label: "InnerModule 2",
            icon: "LabelImportant",
          },
        ],
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: "CheckCircle",
      },
    ],
  },
];

const exampleusermanuals = [
  {
    label:"Example1",
    icon:"Help"
  },
  {
    label:"Example2",
    icon:"Settings"
  }
]

const onSelect = (e) => {
  console.log(e,"event")
}

const commonArgs = {
  items: darkThemeItems,
  transitionDuration: 0.3,
  theme: "dark",
  profileName:"ProfileName",
  profileNumber:'+258 6387387',
  isSearchable:true,
  hideUserManuals:false,
  userManualLabel:"UserManual",
  profile:"",
  usermanuals:[],
  onSelect:onSelect
};

export const LightTheme = Template.bind({});
LightTheme.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
};

export const LightThemeWithProfile = Template.bind({});
LightThemeWithProfile.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  profile:"https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_male_user-512.png"
};

export const LightThemeWithoutSearch = Template.bind({});
LightThemeWithoutSearch.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  isSearchable:false
};

export const LightThemeWithoutUserManuals = Template.bind({});
LightThemeWithoutUserManuals.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  hideUserManuals:true
};

export const LightThemeWithCustomUserManuals = Template.bind({});
LightThemeWithCustomUserManuals.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  usermanuals:exampleusermanuals
};

export const DarkTheme = Template.bind({});
DarkTheme.args = {
  ...commonArgs,
  theme: "dark",
  items: darkThemeItems,
};

export const DarkThemeWithProfile = Template.bind({});
DarkThemeWithProfile.args = {
  ...commonArgs,
  theme: "dark",
  items: darkThemeItems,
  profile:"https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_male_user-512.png"
};

export const DarkThemeWithoutSearch = Template.bind({});
DarkThemeWithoutSearch.args = {
  ...commonArgs,
  theme: "dark",
  items: darkThemeItems,
  isSearchable:false
};

export const DarkThemeWithoutUsermanuals = Template.bind({});
DarkThemeWithoutUsermanuals.args = {
  ...commonArgs,
  theme: "dark",
  items: darkThemeItems,
  hideUserManuals:true
};

export const DarkThemeWithCustomUsermanuals = Template.bind({});
DarkThemeWithCustomUsermanuals.args = {
  ...commonArgs,
  theme: "dark",
  items: darkThemeItems,
  usermanuals:exampleusermanuals
};