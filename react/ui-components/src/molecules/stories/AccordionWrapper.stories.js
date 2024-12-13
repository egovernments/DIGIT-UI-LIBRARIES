import React from "react";
import { Accordion } from "../../atoms";
import { AccordionWrapper } from "../../atoms";
import {Iframe} from "../../atoms";

export default {
  title: "Molecules/AccordionWrapper",
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
    children={
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    }
  ></Accordion>,
  <Accordion
    number={2}
    isOpenInitially={false}
    title={"Accordion 2"}
    children={
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    }
  ></Accordion>,
  <Accordion
    number={3}
    isOpenInitially={false}
    title={"Accordion 3"}
    children={
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    }
  ></Accordion>,
  <Accordion
    number={4}
    isOpenInitially={false}
    title={"Accordion 4"}
    children={
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    }
  ></Accordion>,
];

const commonArgs = {
  className: "",
  style: {},
  allowMultipleOpen: true,
  addDivider: true,
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="AccordionWrapper Documentation"
  />
);

Documentation.storyName = "Docs";

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

export const WithOnlySingleOpen = Template.bind({});
WithOnlySingleOpen.args = {
  ...commonArgs,
  children: children,
  allowMultipleOpen: false,
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
