import React from "react";
import BottomSheet from "../BottomSheet";
import InfoCard from "../InfoCard";
import Button from "../Button";

export default {
  title: "Atoms/BottomSheet",
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

const additionalElements = [
  <InfoCard
    key="1"
    populators={{
      name: "infocard",
    }}
    variant="default"
    text={
      "Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect the service to get completed in 24 hrs from the time of payment."
    }
    label={"Info"}
  />,
  <img
    key="2"
    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s"
    alt="Additional Element 2"
  />,
  <InfoCard
    key="3"
    populators={{
      name: "infocard",
    }}
    variant="default"
    text={
      "Application process will take a minute to complete. It might cost around Rs.500/- to Rs.1000/- to clean your septic tank and you can expect the service to get completed in 24 hrs from the time of payment."
    }
    label={"Info"}
  />,
];

const actions = [
  <Button
    key="1"
    label={"Cancel"}
    size="large"
    variation={"secondary"}
    isDisabled={false}
  />,
  <Button
    key="2"
    label={"Submit"}
    size="large"
    variation={"primary"}
    isDisabled={false}
  />,
];

export const WithoutInitialState = Template.bind({});
WithoutInitialState.args = {
  ...commonArgs,
  children: additionalElements,
};

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