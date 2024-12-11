import React from "react";
import { InfoCard } from "../../atoms";
import { Button } from "../../atoms";
import PanelCard from "../PanelCard";

export default {
  title: "Molecules/PanelCard/Error",
  component: PanelCard,
  argTypes: {
    cardClassName: {
      control: "text",
    },
    cardStyles: {
      control: { type: "object" },
    },
    children: {
      control: "object",
    },
    props: {
      control: "object",
    },
    description: {
      control: "text",
    },
    showChildrenInline: {
      control: "boolean",
    },
    sortFooterButtons: {
      control: "boolean",
    },
    maxFooterButtonsAllowed: {
      control: "text",
    },
    type: { control: "select", options: ["success", "error"] },
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
    multipleResponses: {
      control: {
        type: "array",
        separator: ",",
      },
    },
    className: {
      control: "text",
    },
    style: {
      control: "object",
    },
    animationProps: {
      control: "object",
    },
    footerStyles: {
      control: "object",
    },
  },
};

const Template = (args) => <PanelCard {...args} />;

const commonArgs = {
  cardClassName: "",
  cardStyles: {},
  className: "",
  style: {},
  props: {},
  description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  showChildrenInline: false,
  sortFooterButtons: true,
  maxFooterButtonsAllowed: 5,
  message: "Message",
  type: "success",
  info: "Ref ID ",
  response: "949749795479",
  customIcon: "",
  iconFill: "",
  multipleResponses: [],
  animationProps:{
    loop:false,
    noAutoplay:false
  },
  footerStyles:{}
};

const footerChildrenWithTwoButtons = [
  <Button
    type={"button"}
    size={"large"}
    variation={"secondary"}
    label="Button"
    onClick={() => console.log("Clicked Button 1")}
  />,
  <Button
    type={"button"}
    size={"large"}
    variation={"primary"}
    label="Button"
    onClick={() => console.log("Clicked Button 2")}
  />,
];

const footerChildrenWithOneButton = [
  <Button
    type={"button"}
    size={"large"}
    variation={"primary"}
    label="OK"
    onClick={() => console.log("Clicked Button")}
  />,
];

const footerChildrenSix = [
  <Button
    type={"button"}
    size={"large"}
    variation={"secondary"}
    label="Button"
    onClick={() => console.log("Clicked Button 1")}
  />,
  <Button
    type={"button"}
    size={"large"}
    variation={"primary"}
    label="Button"
    onClick={() => console.log("Clicked Button 2")}
  />,
  <Button
    type={"button"}
    size={"large"}
    variation={"secondary"}
    label="Button"
    onClick={() => console.log("Clicked Button 1")}
  />,
  <Button
    type={"button"}
    size={"large"}
    variation={"primary"}
    label="Button"
    onClick={() => console.log("Clicked Button 2")}
  />,
  <Button
    type={"button"}
    size={"large"}
    variation={"secondary"}
    label="Button"
    onClick={() => console.log("Clicked Button 1")}
  />,
  <Button
    type={"button"}
    size={"large"}
    variation={"primary"}
    label="Button"
    onClick={() => console.log("Clicked Button 2")}
  />,
];

const children = [
  <InfoCard
    variant={"success"}
    className={"panelcard-infocard"}
    text={"This is success"}
  />,
];

const errorchildren = [
    <InfoCard
      variant={"error"}
      className={"panelcard-infocard"}
      text={"This is error"}
    />,
  ];

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
  children: errorchildren,
  footerChildren: footerChildrenWithTwoButtons,
  maxFooterButtonsAllowed: 5,
  message: "Error Message!",
  type: "error",
};

export const WithOneButton = Template.bind({});
WithOneButton.args = {
  ...commonArgs,
  children: errorchildren,
  footerChildren: footerChildrenWithOneButton,
  maxFooterButtonsAllowed: 5,
  message: "Error Message!",
  type: "error",
};

export const WithMoreButtons = Template.bind({});
WithMoreButtons.args = {
  ...commonArgs,
  children: errorchildren,
  footerChildren: footerChildrenSix,
  maxFooterButtonsAllowed: 5,
  message: "Error Message!",
  type: "error",
};

export const WithoutAnimation = Template.bind({});
WithoutAnimation.args = {
  ...commonArgs,
  children: errorchildren,
  footerChildren: footerChildrenWithTwoButtons,
  maxFooterButtonsAllowed: 5,
  message: "Error Message!",
  type: "error",
  showAsSvg:true
};

export const WithCustomStyles = Template.bind({});
WithCustomStyles.args = {
  ...commonArgs,
  children: children,
  footerChildren: footerChildrenWithTwoButtons,
  maxFooterButtonsAllowed: 5,
  message: "Error Message!",
  type: "error",
  showAsSvg:true,
  cardStyles: { width: "620px", height: "590px" },
};

export const WithFooterStyles = Template.bind({});
WithFooterStyles.args = {
  ...commonArgs,
  children: errorchildren,
  footerChildren: footerChildrenWithTwoButtons,
  maxFooterButtonsAllowed: 5,
  message: "Error Message!",
  type: "error",
  footerStyles:{
    marginLeft:"unset"
  }
};

export const WithOutFooter = Template.bind({});
WithOutFooter.args = {
  ...commonArgs,
  children: errorchildren,
  maxFooterButtonsAllowed: 5,
  message: "Error Message!",
  type: "error",
};