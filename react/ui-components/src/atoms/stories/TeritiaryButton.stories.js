import React from "react";
import Button from "../Button";

export default {
  title: "Atoms/Button/Teritiary",
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

// Button with Teritiary variantion
export const Teritiary = Template.bind({});
Teritiary.args = {
  ...commonArgs,
  variation: "teritiary",
};

// Button with Teritiary variantion and with icon
export const TeritiaryWithIcon = Template.bind({});
TeritiaryWithIcon.args = {
  ...commonArgs,
  variation: "teritiary",
  icon: "MyLocation",
};

// Button with Teritiary variantion and with icon as a suffix
export const TeritiaryWithSuffixIcon = Template.bind({});
TeritiaryWithSuffixIcon.args = {
  ...commonArgs,
  variation: "teritiary",
  icon: "ArrowForward",
  isSuffix: true,
};

// Button with Teritiary variantion and disabled
export const TeritiaryDisabled = Template.bind({});
TeritiaryDisabled.args = {
  ...commonArgs,
  variation: "teritiary",
  isDisabled: true,
};

// Button with Teritiary variation and label with maxchars
export const TeritiaryLabelWithMaxLength = Template.bind({});
TeritiaryLabelWithMaxLength.args = {
  ...commonArgs,
  variation: "teritiary",
  label: "qwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjklzxcvbnmqwertyuiopas",
};