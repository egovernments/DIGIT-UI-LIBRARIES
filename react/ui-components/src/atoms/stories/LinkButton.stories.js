import React from "react";
import Button from "../Button";

export default {
  title: "Atoms/Button/Link",
  component: Button,
  argTypes: {
    isDisabled: {
      control: "boolean",
    },
    label: {
      control: "text",
    },
    variation: {
      control: "select",
      options: ["primary", "secondary", "teritiary", "link"],
    },
    size: { control: "select", options: ["large", "medium", "small"] },
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    onClick: {
      control: "function",
    },
    isSuffix: {
      control: "boolean",
    },
    title: {
      control: "text",
    },
    options: {
      control: {
        type: "array",
        separator: ",",
      },
    },
    isSearchable: {
      control: "boolean",
    },
    showBottom: {
      control: "boolean",
    },
    optionsKey: {
      control: "text",
    },
  },
};

const commonStyles = {
  position: "absolute",
  top: "50%",
  left: "50%",
  color: "#363636",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  transform: "translate(-50%, -50%)",
};

const Template = (args) => (
  <div style={commonStyles}>
    <Button {...args} />
  </div>
);

const commonArgs = {
  label: "Button",
  className: "custom-class",
  style: {},
  onClick: () => {console.log("clicked"); } ,
  isDisabled: false,
  variation: "",
  isSuffix: false,
  size: "",
  title:"",
  iconFill:"",
  options:[],
  optionsKey:"",
  isSearchable:false
};

// Button with link variantion
export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
  variation: "link",
  label: "Link",
};

// Button with link variantion and with icon
export const WithIcon = Template.bind({});
WithIcon.args = {
  ...commonArgs,
  variation: "link",
  label: "Link",
  icon: "MyLocation",
};

// Button with link variantion and with icon as a suffix
export const WithSuffixIcon = Template.bind({});
WithSuffixIcon.args = {
  ...commonArgs,
  variation: "link",
  label: "Link",
  icon: "ArrowForward",
  isSuffix: true,
};

// Button with link variantion and disabled
export const Disabled = Template.bind({});
Disabled.args = {
  ...commonArgs,
  variation: "link",
  label: "Link",
  isDisabled: true,
};

// Button with link variation and label with maxchars
export const LabelWithMaxLength = Template.bind({});
LabelWithMaxLength.args = {
  ...commonArgs,
  variation: "link",
  label: "qwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjklzxcvbnmqwertyuiopas",
};