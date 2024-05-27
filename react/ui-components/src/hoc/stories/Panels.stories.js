import React from "react";
import { Panels } from "../../atoms";

export default {
  title: "Atom-Groups/Panels",
  component: Panels,
  argTypes: {
    type: { control: "select", options: ["success", "error"] },
    className: {
      control: "text",
    },
    message: {
      control: "text",
    },
    info: {
      control: "text",
    },
    response: {
      control: "text",
    },
    customIcon: {
        control: "text",
      },
      iconFill: {
        control: "text",
      },
    style: {
      control: { type: "object" },
    },
    multipleResponses: {
      control: {
        type: "array",
        separator: ",",
      },
    },
    showAsSvg:{
      control:"boolean"
    }
  },
};

const Template = (args) => <Panels {...args} />;

const commonArgs = {
  className: "",
  message: "Message",
  type: "success",
  info: "Ref ID ",
  response: "949749795479",
  customIcon:"",
  iconFill:"",
  style: {},
  showAsSvg:false,
  multipleResponses:[]
};

export const SuccessPanel = Template.bind({});
SuccessPanel.args = {
  ...commonArgs,
  type: "success",
  message: "Success Message!",
};

export const SuccessPanelWithMultipleResponses = Template.bind({});
SuccessPanelWithMultipleResponses.args = {
  ...commonArgs,
  type: "success",
  message: "Success Message!",
  multipleResponses:["949749795469","949749795579","949749795499"]
};

export const ErrorPanel = Template.bind({});
ErrorPanel.args = {
  ...commonArgs,
  type: "error",
  message: "Error Message!",
};
