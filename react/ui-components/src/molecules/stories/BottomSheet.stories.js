import React from "react";
import BottomSheet from "../BottomSheet";
import {Button} from "../../atoms";
import { IMAGES } from "../../constants/images/images";

export default {
  title: "Molecules/BottomSheet",
  component: BottomSheet,
  argTypes: {
    initialState: {
      control: "select",
      options: ["closed", "fixed", "quarter", "intermediate", "full"],
    },
    enableActions: {
      control: "boolean",
    },
    equalWidthButtons: {
      control: "boolean",
    },
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
  },
};

const Template = (args) => <BottomSheet {...args}>{args.children}</BottomSheet>;

const commonArgs = {
  initialState: "closed",
  enableActions: false,
  className: "",
  style: {},
  equalWidthButtons: false,
};

const getImageUrl = (imageKey) => {
  return IMAGES[imageKey];
};

const digitImg = getImageUrl("DIGIT_LIGHT");

const additionalElements = [
  <div key="1" className="typography heading-l" style={{color:"#363636"}}>BottomSheet</div>,
  <div key="1" className="typography body-xs" style={{color:"#363636"}}>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</div>,
  <img key="2" alt="Powered by DIGIT" src={digitImg} />,
];

const actions = [
  <Button
    key="2"
    label={"Action 1"}
    size="large"
    variation={"primary"}
    isDisabled={false}
  />,
];

export const Closed = Template.bind({});
Closed.args = {
  ...commonArgs,
  initialState: "closed",
  children: additionalElements,
};

export const Fixed = Template.bind({});
Fixed.args = {
  ...commonArgs,
  initialState: "fixed",
  children: additionalElements,
};

export const Quarter = Template.bind({});
Quarter.args = {
  ...commonArgs,
  initialState: "quarter",
  children: additionalElements,
};

export const Intermediate = Template.bind({});
Intermediate.args = {
  ...commonArgs,
  initialState: "intermediate",
  children: additionalElements,
};

export const Full = Template.bind({});
Full.args = {
  ...commonArgs,
  initialState: "full",
  children: additionalElements,
};

export const ClosedWithActions = Template.bind({});
ClosedWithActions.args = {
  ...commonArgs,
  initialState: "closed",
  enableActions: true,
  children: additionalElements,
  actions: actions,
};

export const FixedWithActions = Template.bind({});
FixedWithActions.args = {
  ...commonArgs,
  initialState: "fixed",
  enableActions: true,
  children: additionalElements,
  actions: actions,
};

export const QuarterWithActions = Template.bind({});
QuarterWithActions.args = {
  ...commonArgs,
  initialState: "quarter",
  enableActions: true,
  children: additionalElements,
  actions: actions,
};

export const IntermediateWithActions = Template.bind({});
IntermediateWithActions.args = {
  ...commonArgs,
  initialState: "intermediate",
  enableActions: true,
  children: additionalElements,
  actions: actions,
};

export const FullWithActions = Template.bind({});
FullWithActions.args = {
  ...commonArgs,
  initialState: "full",
  enableActions: true,
  children: additionalElements,
  actions: actions,
};

export const ClosedWithActionsEqualWidthButtons = Template.bind({});
ClosedWithActionsEqualWidthButtons.args = {
  ...commonArgs,
  initialState: "closed",
  enableActions: true,
  children: additionalElements,
  actions: actions,
  equalWidthButtons: true,
};