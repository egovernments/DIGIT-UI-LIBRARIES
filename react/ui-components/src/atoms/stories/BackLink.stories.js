import React from "react";
import BackLink from "../BackLink";
import Iframe from "../Iframe";

export default {
  title: "Atoms/BackLink",
  component: BackLink,
  argTypes: {
    variant: {
      control: "select",
      options: ["primary", "secondary", "teritiary"],
    },
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    onClick: {
      control: "function",
    },
    disabled: {
      control: "boolean",
    },
    hideLabel: {
      control: "boolean",
    },
    hideIcon: {
      control: "boolean",
    },
    iconFill: {
      control: "text",
    },
    label: {
      control: "text",
    },
  },
};

const Template = (args) => <BackLink {...args} />;

const commonArgs = {
  className: "",
  style: {},
  onClick: () => console.log("clicked"),
  disabled: false,
  variant: "",
  hideIcon: false,
  hideLabel: false,
  iconFill: "",
  label: "Back",
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="BackLink Documentation"
  />
);

Documentation.storyName = "Docs";

export const Backlink1 = Template.bind({});
Backlink1.args = {
  ...commonArgs,
  variant: "primary",
};

export const Backlink2 = Template.bind({});
Backlink2.args = {
  ...commonArgs,
  variant: "secondary",
};

export const Backlink3 = Template.bind({});
Backlink3.args = {
  ...commonArgs,
  variant: "teritiary",
};

export const Disabled = Template.bind({});
Disabled.args = {
  ...commonArgs,
  variant: "primary",
  disabled: true,
};
