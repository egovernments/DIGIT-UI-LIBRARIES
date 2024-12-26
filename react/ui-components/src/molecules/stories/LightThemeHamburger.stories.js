import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import MobileSideNav from "../../atoms/MobileSideNav";


export default {
  title: "Molecules/Hamburger/Light",
  component: MobileSideNav,
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
    <MobileSideNav {...args} />
  </Router>
);

const lightThemeItems = [
  {
    label: "City",
    icon:"Home",
    isSearchable:false,
    children: [
      {
        path: "/",
        label: "City 1",
        icon: "",
      },
      {
        path: "/",
        label: "City 2",
        icon: "",
      },
    ],
  },
  {
    label: "Language",
    isSearchable:false,
    icon: "DriveFileMove",
    children: [
      {
        path: "/",
        label: "Language 1",
        icon: "",
      },
      {
        path: "/",
        label: "Language 2",
        icon: "",
      },
    ],
  },
  {
    label: "SideNav",
    isSearchable:true,
    icon: "Accessibility",
    children: [
      {
        path: "/",
        label: "SubModule 1",
        icon: "",
        children: [
          {
            path: "/",
            label: "InnerModule 1",
            icon: "",
            children:[
              {
                path: "/",
                label: "SubChildModule 1",
                icon: "",
              },
            ]
          },
          {
            path: "/",
            label: "InnerModule 2",
            icon: "",
          },
        ],
      },
      {
        path: "/",
        label: "SubModule 2",
        icon: "",
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
  items: lightThemeItems,
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

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
};

export const WithProfile = Template.bind({});
WithProfile.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  profile:"https://cdn1.iconfinder.com/data/icons/website-internet/48/website_-_male_user-512.png"
};

export const WithCloseOnClickOutside = Template.bind({});
WithCloseOnClickOutside.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  closeOnClickOutside:true
};

export const WithOnOutsideClickLogic = Template.bind({});
WithOnOutsideClickLogic.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  closeOnClickOutside:false,
  onOutsideClick:(e)=>{console.log(e)}
};

export const WithoutUserManuals = Template.bind({});
WithoutUserManuals.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  hideUserManuals:true
};

export const WithCustomUserManuals = Template.bind({});
WithCustomUserManuals.args = {
  ...commonArgs,
  theme: "light",
  items: lightThemeItems,
  usermanuals:exampleusermanuals
};