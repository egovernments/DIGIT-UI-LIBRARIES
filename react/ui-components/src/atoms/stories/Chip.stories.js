import React from "react";
import { action } from "@storybook/addon-actions";
import Chip from "../Chip";
import Iframe from "../Iframe";

export default {
  title: "Atoms/Chip",
  component: Chip,
  argTypes: {
    className: {
      control: "text",
      table: { disable: true }
    },
    text: {
      control: "text",
    },
    onClick: {
      control: "function",
      table: { disable: true }
    },
    onTagClick: {
      control: "function",
      table: { disable: true }
    },
    extraStyles: {
      control: { type: "object" },
      table: { disable: true }
    },
    disabled: {
      control: "boolean",
      table: { disable: true }
    },
    isErrorTag: {
      control: "boolean",
      table: { disable: true }
    },
    hideClose: {
      control: "boolean",
      name:"With Close",
      mapping:{
        true:false,
        false:true
      }
    },
    error: {
      control: "text",
      // table: { disable: true }
    },
    WithIcon: {
      control: "boolean",
      name:"With Icon"
    },
  },
};

const Template = (args) => {
  const { WithIcon, ...restArgs } = args;

  return (
    <div className="digit-tag-container">
    <Chip {...restArgs} iconReq={WithIcon ? "Edit" : ""} />
  </div>
  );
};


const commonArgs = {
  text: "Chip",
  className: "",
  extraStyles: {},
  onClick: () => console.log("Close icon is clicked"),
  onTagClick: () => console.log("Tag is clicked"),
  disabled: false,
  isErrorTag: false,
  error: "",
  hideClose: false,
  WithIcon:false
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Chip Documentation"
  />
);

Documentation.storyName = "Docs";

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
};

export const Error = Template.bind({});
Error.args = {
  ...commonArgs,
  text: "ErrorChipWithError",
  isErrorTag: true,
  error: "ErrorMessage",
  hideClose: false,
};