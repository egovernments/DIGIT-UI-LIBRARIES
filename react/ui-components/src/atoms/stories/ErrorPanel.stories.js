import React from "react";
import Panels from "../Panels";

export default {
  title: "Atoms/Panels/Error",
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
    },
    animationProps:{
      control: {type :"object"}
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
  multipleResponses:[],
  animationProps:{
    noAutoplay:false,
    loop :false
  }
};

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
  type: "error",
  message: "Error Message!",
};

export const WithAnimationProperties = Template.bind({});
WithAnimationProperties.args = {
  ...commonArgs,
  type: "error",
  message: "Error Message!",
  animationProps:{
    loop :true,
    width:100,
    height:100
  }
};


export const WithoutAnimation = Template.bind({});
WithoutAnimation.args = {
  ...commonArgs,
  type: "error",
  message: "Error Message!",
  showAsSvg:true
};

export const WithMultipleResponses = Template.bind({});
WithMultipleResponses.args = {
  ...commonArgs,
  type: "error",
  message: "Success Message!",
  multipleResponses:["949749795469","949749795579","949749795499"]
};