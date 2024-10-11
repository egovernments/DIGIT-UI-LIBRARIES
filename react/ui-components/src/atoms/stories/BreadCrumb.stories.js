import React from "react";
import BreadCrumb from "../BreadCrumb";
import { BrowserRouter as Router } from "react-router-dom";
import { SVG } from "../SVG";

export default {
  title: "Atoms/BreadCrumb",
  component: BreadCrumb,
  argTypes: {
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    crumbs: {
      control: { type: "object" },
    },
    spanStyle: {
      control: { type: "object" },
    },
    maxItems: {
      control: { type: "number" },
    },
    itemsAfterCollapse: {
      control: { type: "number" },
    },
    itemsBeforeCollapse: {
      control: { type: "number" },
    },
    expandText: {
      control: { type: "text" },
    },
  },
};

const Template = (args) => (
  <Router>
    <BreadCrumb {...args} />
  </Router>
);

export const Basic = Template.bind({});
Basic.args = {
  crumbs: [
    {
      content: "Home",
      show: true,
      path: "/home",
    },
    {
      content: "Previous",
      show: true,
      path: "/previous",
    },
    {
      content: "Current",
      show: true,
      path: "/current",
    },
  ],
};

export const Collapsed = Template.bind({});
Collapsed.args = {
  crumbs: [
    {
      content: "Home",
      show: true,
      path: "/home",
    },
    {
      content: "Previous1",
      show: true,
      path: "/previous1",
    },
    {
      content: "Previous2",
      show: true,
      path: "/previous2",
    },
    {
      content: "Previous3",
      show: true,
      path: "/previous3",
    },
    {
      content: "Current",
      show: true,
      path: "/current",
    },
  ],
  maxItems: 3,
};

export const CollapsedWithCustomValues = Template.bind({});
CollapsedWithCustomValues.args = {
  crumbs: [
    {
      content: "Home",
      show: true,
      path: "/home",
    },
    {
      content: "Previous1",
      show: true,
      path: "/previous1",
    },
    {
      content: "Previous2",
      show: true,
      path: "/previous2",
    },
    {
      content: "Previous3",
      show: true,
      path: "/previous3",
    },
    {
      content: "Current",
      show: true,
      path: "/current",
    },
  ],
  maxItems: 3,
  itemsBeforeCollapse: 1,
  itemsAfterCollapse: 2,
};

export const CollapsedWithExpandText = Template.bind({});
CollapsedWithExpandText.args = {
  crumbs: [
    {
      content: "Home",
      show: true,
      path: "/home",
    },
    {
      content: "Previous1",
      show: true,
      path: "/previous1",
    },
    {
      content: "Previous2",
      show: true,
      path: "/previous2",
    },
    {
      content: "Previous3",
      show: true,
      path: "/previous3",
    },
    {
      content: "Current",
      show: true,
      path: "/current",
    },
  ],
  maxItems: 3,
  expandText: "{click here to expand}",
};

export const WithIcons = Template.bind({});
WithIcons.args = {
  crumbs: [
    {
      path: "/home",
      content: "Home",
      show: true,
      icon: <SVG.Home fill={"#C84C0E"} />,
    },
    {
      path: "/previous",
      content: "Previous",
      show: true,
      icon: <SVG.Person fill={"#C84C0E"} />,
    },
    {
      path: "/current",
      content: "Current",
      show: true,
      icon: <SVG.Edit fill={"#787878"} />,
    },
  ],
};

export const WithCustomSeparators = Template.bind({});
WithCustomSeparators.args = {
  crumbs: [
    {
      content: "Home",
      show: true,
      path: "/home",
    },
    {
      content: "Previous",
      show: true,
      path: "/previous",
    },
    {
      content: "Current",
      show: true,
      path: "/current",
    },
  ],
  customSeperator: <SVG.ArrowForward fill={"#C84C0E"} />,
};


