import React from "react";
import { action } from "@storybook/addon-actions";
import Chip from "../Chip";

export default {
  title: "Atoms/Chip",
  component: Chip,
  argTypes: {
    className: {
      control: "text",
    },
    text: {
      control: "text",
    },
    onClick: {
      control: "function",
    },
    onTagClick: {
      control: "function",
    },
    extraStyles: {
      control: { type: "object" },
    },
    disabled: {
      control: "boolean",
    },
    isErrorTag: {
      control: "boolean",
    },
    hideClose: {
      control: "boolean",
    },
    error: {
      control: "text",
    },
    iconReq:{
      control:"text"
    }
  },
};

const Template = (args) => (
  <div className="digit-tag-container">
    <Chip {...args} />
  </div>
);

const commonArgs = {
  text: "Chip",
  className: "",
  extraStyles: {},
  onClick: () => console.log("Close icon is clicked"),
  onTagClick: () => console.log("Tag is clicked"),
  disabled: false,
  isErrorTag: false,
  error: "",
  hideClose:true,
  iconReq:""
};

export const Documentation = () => (
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field" 
    width="100%"
    height="830"
    style={{ border: "none" }}
    title="Chip Documentation"
  />
);

Documentation.storyName = "Docs";

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
};

export const WithClose = Template.bind({});
WithClose.args = {
  ...commonArgs,
  text: "Chip",
  hideClose:false
};

export const WithIcon = Template.bind({});
WithIcon.args = {
  ...commonArgs,
  text: "Chip",
  iconReq:"Edit"
};

export const Error = Template.bind({});
Error.args = {
  ...commonArgs,
  text: "ErrorChipWithError",
  isErrorTag:true,
  error:"ErrorMessage",
  iconReq:"Edit",
  hideClose:false
};