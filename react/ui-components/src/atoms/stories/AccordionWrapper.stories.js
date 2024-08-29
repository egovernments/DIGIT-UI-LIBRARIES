import React from "react";
import { AccordionWrapper } from "../Accordion";
import { Accordion } from "../Accordion";

export default {
  title: "Atoms/AccordionWrapper",
  component: AccordionWrapper,
  argTypes: {
    className: { control: "text" },
    styles: { control: "object" },
    allowMultipleOpen: { control: "boolean" },
    addDivider: { control: "boolean" },
  },
};

const Template = (args) => <AccordionWrapper {...args} />;

const children = [
  <Accordion
    number={1}
    isOpenInitially={false}
    title={"Accordion 1"}
    content={
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    }
  ></Accordion>,
  <Accordion
    number={2}
    isOpenInitially={false}
    title={"Accordion 2"}
    content={
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    }
  ></Accordion>,
  <Accordion
    number={3}
    isOpenInitially={false}
    title={"Accordion 3"}
    content={
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    }
  ></Accordion>,
  <Accordion
    number={4}
    isOpenInitially={false}
    title={"Accordion 4"}
    content={
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    }
  ></Accordion>,
];

const commonArgs = {
  className: "",
  style: {},
  allowMultipleOpen: false,
  addDivider: true,
};

export const Default = Template.bind({});
Default.args = {
  ...commonArgs,
  children: children,
};

export const WithoutDivider = Template.bind({});
WithoutDivider.args = {
  ...commonArgs,
  children: children,
  addDivider: false,
};

export const WithMultipleOpen = Template.bind({});
WithMultipleOpen.args = {
  ...commonArgs,
  children: children,
  allowMultipleOpen:true
};

export const CustomStyles = Template.bind({});
CustomStyles.args = {
  ...commonArgs,
  children: children,
  styles: {
    backgroundColor: "#FFFFFF",
    border: "1px solid #d6d5d4",
    borderRadius: "4px",
    padding: "24px",
  },
};
