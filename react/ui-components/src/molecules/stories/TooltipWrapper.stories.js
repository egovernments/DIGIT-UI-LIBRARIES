import React from "react";
import { Colors } from "../../constants/colors/colorconstants";
import { Button } from "../../atoms";
import TooltipWrapper from "../TooltipWrapper";

export default {
  title: "Molecules/TooltipWrapper",
  component: TooltipWrapper,
  argTypes: {
    title: { control: "text" },
    wrapperClassName: { control: "text" },
    ClassName: { control: "text" },
    arrow: { control: "boolean" },
    placement: {
      control: "select",
      options: [
        "bottom-start",
        "bottom",
        "bottom-end",
        "top-start",
        "top",
        "top-end",
        "left-start",
        "left",
        "left-end",
        "right-start",
        "right",
        "right-end",
      ],
    },
    enterDelay: { control: "number" },
    leaveDelay: { control: "number" },
    followCursor: { control: "boolean" },
    open: { control: "boolean" },
    disableFocusListener: { control: "boolean" },
    disableHoverListener: { control: "boolean" },
    disableInteractive: { control: "boolean" },
    disableTouchListener: { control: "boolean" },
    style: { control: "object" },
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

const Color = Colors.lightTheme.primary[2];

const Template = (args) => (
  <div style={commonStyles}>
    <TooltipWrapper {...args} />
  </div>
);

export const Basic = Template.bind({});
Basic.args = {
  title: "Tooltip",
  arrow: false,
  placement: "bottom",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: <Button label={"Basic..."} variation={"primary"}></Button>,
  style: {},
};

export const MaxLabel = Template.bind({});
MaxLabel.args = {
  title:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: false,
  placement: "bottom",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: <Button label={"MaxLabel..."} variation={"primary"}></Button>,
  style: {},
};

export const Positioned = Template.bind({});
Positioned.args = {
  title: "Tooltip",
  arrow: false,
  placement: "top",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: <Button label={"Positioned..."} variation={"primary"}></Button>,
  style: {},
};

export const BasicWithArrow = Template.bind({});
BasicWithArrow.args = {
  title: "Tooltip",
  arrow: true,
  placement: "bottom",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: <Button label={"BasicWithArrow..."} variation={"primary"}></Button>,
  style: {},
};

export const MaxLabelWithArrow = Template.bind({});
MaxLabelWithArrow.args = {
  title:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: true,
  placement: "bottom",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: (
    <Button label={"MaxLabelWithArrow..."} variation={"primary"}></Button>
  ),
  style: {},
};

export const PositionedWithArrow = Template.bind({});
PositionedWithArrow.args = {
  title: "Tooltip",
  arrow: true,
  placement: "top",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: (
    <Button label={"PositionedWithArrow..."} variation={"primary"}></Button>
  ),
  style: {},
};

export const WithCustomStyles = Template.bind({});
WithCustomStyles.args = {
  title: "Tooltip",
  arrow: false,
  placement: "bottom",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: (
    <Button label={"WithCustomStyles..."} variation={"primary"}></Button>
  ),
  style: {
    backgroundColor: Color,
    border: "3px solid #C84C0E",
    width: "200px",
    textAlign: "center",
  },
};

const htmlTooltip = (
  <React.Fragment>
    <em>{"And here's"}</em> <b>{"some"}</b> <u>{"amazing content"}</u>.{" "}
    {"It's very engaging. Right?"}{" "}
    <img
      alt="here is your logo"
      src="https://cdn.prod.website-files.com/5c7d318eeaea1d6e1198d906/628d4fa7695fe641bef4c60a_CTA-Tooltip.png"
    ></img>
  </React.Fragment>
);

export const HtmlTooltip = Template.bind({});
HtmlTooltip.args = {
  title: htmlTooltip,
  arrow: false,
  placement: "bottom",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: <Button label={"HtmlTooltip..."} variation={"primary"}></Button>,
};

export const HtmlTooltipWithArrow = Template.bind({});
HtmlTooltipWithArrow.args = {
  title: htmlTooltip,
  arrow: true,
  placement: "bottom",
  enterDelay: 100,
  leaveDelay: 0,
  followCursor: false,
  open: false,
  disableFocusListener: false,
  disableHoverListener: false,
  disableInteractive: false,
  disableTouchListener: false,
  children: <Button label={"HtmlTooltip..."} variation={"primary"}></Button>,
};