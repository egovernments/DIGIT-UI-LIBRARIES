import React from "react";
import BreadCrumb from "../BreadCrumb";
import { BrowserRouter as Router } from "react-router-dom";
import { SVG } from "../SVG";
import Iframe from "../Iframe";

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

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Breadcrumb Documentation"
  />
);

Documentation.storyName = "Docs";

export const Basic = Template.bind({});
Basic.args = {
  crumbs: [
    {
      content: "Home",
      show: true,
      internalLink: "/home",
    },
    {
      content: "Previous",
      show: true,
      internalLink: "/previous",
    },
    {
      content: "Current",
      show: true,
      internalLink: "/current",
    },
  ],
};

export const Collapsed = Template.bind({});
Collapsed.args = {
  crumbs: [
    {
      content: "Home",
      show: true,
      internalLink: "/home",
    },
    {
      content: "Previous1",
      show: true,
      internalLink: "/previous1",
    },
    {
      content: "Previous2",
      show: true,
      internalLink: "/previous2",
    },
    {
      content: "Previous3",
      show: true,
      internalLink: "/previous3",
    },
    {
      content: "Current",
      show: true,
      internalLink: "/current",
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
      internalLink: "/home",
    },
    {
      content: "Previous1",
      show: true,
      internalLink: "/previous1",
    },
    {
      content: "Previous2",
      show: true,
      internalLink: "/previous2",
    },
    {
      content: "Previous3",
      show: true,
      internalLink: "/previous3",
    },
    {
      content: "Current",
      show: true,
      internalLink: "/current",
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
      internalLink: "/home",
    },
    {
      content: "Previous1",
      show: true,
      internalLink: "/previous1",
    },
    {
      content: "Previous2",
      show: true,
      internalLink: "/previous2",
    },
    {
      content: "Previous3",
      show: true,
      internalLink: "/previous3",
    },
    {
      content: "Current",
      show: true,
      internalLink: "/current",
    },
  ],
  maxItems: 3,
  expandText: "{click here to expand}",
};

export const WithIcons = Template.bind({});
WithIcons.args = {
  crumbs: [
    {
      internalLink: "/home",
      content: "Home",
      show: true,
      icon: <SVG.Home fill={"#C84C0E"} />,
    },
    {
      internalLink: "/previous",
      content: "Previous",
      show: true,
      icon: <SVG.Person fill={"#C84C0E"} />,
    },
    {
      internalLink: "/current",
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
      internalLink: "/home",
    },
    {
      content: "Previous",
      show: true,
      internalLink: "/previous",
    },
    {
      content: "Current",
      show: true,
      internalLink: "/current",
    },
  ],
  customSeparator: <SVG.ArrowForward fill={"#C84C0E"} />,
};
