import React from "react";
import Button from "../Button";

export default {
  title: "Atoms/Button/Primary",
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

// Button with primary variantion
export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
  variation: "primary",
};

// Button with primary variantion and with icon
export const WithIcon = Template.bind({});
WithIcon.args = {
  ...commonArgs,
  variation: "primary",
  icon: "MyLocation",
};

// Button with primary variantion and with icon as a suffix
export const WithSuffixIcon = Template.bind({});
WithSuffixIcon.args = {
  ...commonArgs,
  variation: "primary",
  icon: "ArrowForward",
  isSuffix: true,
};

// Button with primary variantion and disabled
export const Disabled = Template.bind({});
Disabled.args = {
  ...commonArgs,
  variation: "primary",
  isDisabled: true,
};

// Button with primary variation and label with maxchars
export const LabelWithMaxLength = Template.bind({});
LabelWithMaxLength.args = {
  ...commonArgs,
  variation: "primary",
  label: "qwertyuiopasdfghjklzxcvbnmqwertyuiopasdfghjklzxcvbnmqwertyuiopas",
};

export const ActionSelectionDropDown = Template.bind({});
ActionSelectionDropDown.args = {
  ...commonArgs,
  label:"ActionButton",
  variation: "primary",
  type:"actionButton",
  optionsKey:"name",
  isSearchable:true,
    options:[
      { name: "Action A", code: "Actiona" },
      { name: "Action B", code: "Actionb" },
      { name: "Action C", code: "Actionc" },
    ],
  showBottom:true,
  onOptionSelect:(e)=>{console.log(e,"option selected")}
};

export const UnsearchableActionSelectionDropDown = Template.bind({});
UnsearchableActionSelectionDropDown.args = {
  ...commonArgs,
  label:"ActionButton",
  variation: "primary",
  type:"actionButton",
  optionsKey:"name",
  isSearchable:false,
    options:[
      { name: "Action A", code: "Actiona" },
      { name: "Action B", code: "Actionb" },
      { name: "Action C", code: "Actionc" },
    ],
  showBottom:true,
  onOptionSelect:(e)=>{console.log(e,"option selected")}
  
};

export const ActionSelectionDropUp = Template.bind({});
ActionSelectionDropUp.args = {
  ...commonArgs,
  label:"ActionButton",
  variation: "primary",
  type:"actionButton",
  optionsKey:"name",
  isSearchable:true,
    options:[
      { name: "Action A", code: "Actiona" },
      { name: "Action B", code: "Actionb" },
      { name: "Action C", code: "Actionc" },
    ],
  showBottom:false,
  menuStyles:{
    bottom:"40px"
  },
  onOptionSelect:(e)=>{console.log(e,"option selected")}
};

export const UnsearchableActionSelectionDropUp = Template.bind({});
UnsearchableActionSelectionDropUp.args = {
  ...commonArgs,
  label:"ActionButton",
  variation: "primary",
  type:"actionButton",
  optionsKey:"name",
  isSearchable:false,
    options:[
      { name: "Action A", code: "Actiona" },
      { name: "Action B", code: "Actionb" },
      { name: "Action C", code: "Actionc" },
    ],
  showBottom:false,
  menuStyles:{
    bottom:"40px"
  },
  onOptionSelect:(e)=>{console.log(e,"option selected")}
};