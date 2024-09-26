import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import MobileSidebar from "../MobileSidebar"; 


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
    onSelect:{ action: "onChange" },
    onLogout:{action:"onChange"},
    reopenOnLogout:{control:"boolean"},
    closeOnClickOutside:{control:"boolean"},
    onOutsideClick:{action:"onChange"}
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
    isSearchable:false,
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
    isSearchable:false,
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
    isSearchable:true,
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
    isSearchable:false,
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
    isSearchable:false,
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
    isSearchable:true,
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
            children:[
              {
                path: "/",
                label: "SubChildModule 1",
                icon: "Lock",
              },
            ]
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

const onLogout = () => {
  console.log("clicked on Logout")
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
  onSelect:onSelect,
  onLogout:onLogout,
  reopenOnLogout:false,
  closeOnClickOutside:false
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

export const LightThemeWithCloseOnClickOutside = Template.bind({});
LightThemeWithCloseOnClickOutside.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  closeOnClickOutside:true
};

export const LightThemeWithOnOutsideClickLogic = Template.bind({});
LightThemeWithOnOutsideClickLogic.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  closeOnClickOutside:false,
  onOutsideClick:(e)=>{console.log(e)}
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

export const DarkThemeWithCloseOnClickOutside = Template.bind({});
DarkThemeWithCloseOnClickOutside.args = {
  ...commonArgs,
  theme: "dark",
  items: darkThemeItems,
  closeOnClickOutside:true
};

export const DarkThemeWithOnOutsideClickLogic = Template.bind({});
DarkThemeWithOnOutsideClickLogic.args = {
  ...commonArgs,
  theme: "dark",
  items: darkThemeItems,
  closeOnClickOutside:false,
  onOutsideClick:(e)=>{console.log(e)}
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