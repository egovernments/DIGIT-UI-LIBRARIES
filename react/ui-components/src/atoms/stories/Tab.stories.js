import React, { useState } from "react";
import Tab from "../Tab";

export default {
  title: "Atoms/Tab",
  component: Tab,
  argTypes: {
    configNavItems: { control: "object" },
    activeLink: { control: "text" },
    configItemKey: { control: "text" },
    setActiveLink: { action: "setActiveLink" },
    showNav: { control: "boolean" },
    style: { control: "object" },
    className: { control: "text" },
    inFormComposer: { control: "boolean" },
    navClassName: { control: "text" },
    navStyles: { control: "object" },
    itemStyle:{control:"object"},
    onTabClick: { action: "onChange" },
  },
};

const Template = (args) => {
  const [activeLink, setActiveLink] = useState(args.activeLink);

  return (
    <Tab
      {...args}
      activeLink={activeLink}
      setActiveLink={setActiveLink}
    />
  );
};

export const Documentation = () => (
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field" 
    width="100%"
    height="830"
    style={{ border: "none" }}
    title="Tab Documentation"
  />
);

Documentation.storyName = "Docs";


// Default Tab
export const Default = Template.bind({});
Default.args = {
  configNavItems: [
    { name: "Tab 1", code: "Tab 1" },
    { name: "Tab 2", code: "Tab 2" },
    { name: "Tab 3", code: "Tab 3" },
    { name: "Tab 4", code: "Tab 4" },
  ],
  activeLink: "Tab 2",
  showNav: true,
  style: {},
  className: "",
  navClassName: "",
  configItemKey:"code",
  navStyles: {},
  onTagClick:(item)=>{console.log(item)},
  itemStyle:{}
};

export const WithConfigItemKey = Template.bind({});
WithConfigItemKey.args = {
  configNavItems: [
    { name: "Tab one", code: "1" },
    { name: "Tab two", code: "2" },
    { name: "Tab three", code: "3" },
    { name: "Tab four", code: "4" },
  ],
  activeLink: "Tab one",
  showNav: true,
  style: {},
  className: "",
  navClassName: "",
  configItemKey:"name",
  navStyles: {},
  itemStyle:{}
};

export const DifferentLabels = Template.bind({});
DifferentLabels.args = {
  configNavItems: [
    { name: "home", code: "H" },
    { name: "about", code: "About" },
    { name: "services", code: "Ss" },
    { name: "contact", code: "Con" },
  ],
  activeLink: "H",
  showNav: true,
  style: {},
  className: "",
  navClassName: "",
  configItemKey:"code",
  navStyles: {},
  itemStyle:{}
};

// Tab with custom styles
export const CustomStyledNav = Template.bind({});
CustomStyledNav.args = {
  ...Default.args,
  style: { backgroundColor: "#FFFFFF" },
  itemStyle:{backgroundColor:"#FAFAFA",border:"1px solid black"},

};


export const WithIcons = Template.bind({});
WithIcons.args = {
  configNavItems: [
    { name: "Tab 1", code: "Tab 1" ,icon:"Home"},
    { name: "Tab 2", code: "Tab 2" ,icon:"MyLocation"},
    { name: "Tab 3", code: "Tab 3" ,icon:"Article"},
    { name: "Tab 4", code: "Tab 4" ,icon:"AccountCircle"},
  ],
  activeLink: "Tab 2",
  showNav: true,
  style: {},
  className: "",
  navClassName: "",
  configItemKey:"code",
  navStyles: {},
  itemStyle:{}
};

export const WithLargeLabel = Template.bind({});
WithLargeLabel.args = {
  configNavItems: [
    { name: "Tab 1", code: "Tab with the large label given as the name" },
    { name: "Tab 2", code: "Tab 2" },
    { name: "Tab 3", code: "Tab 3" },
    { name: "Tab 4", code: "Tab 4" },
  ],
  activeLink: "Tab 2",
  showNav: true,
  style: {},
  className: "",
  navClassName: "",
  configItemKey:"code",
  navStyles: {},
  itemStyle:{}
};