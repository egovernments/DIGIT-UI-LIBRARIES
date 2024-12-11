import React from "react";
import {Accordion} from "../Accordion";

export default {
  title: "Atoms/Accordion",
  component: Accordion,
  argTypes: {
    title: { control: "text" },
    children: { control: "text" },
    isOpenInitially: { control: "boolean" },
    customClassName: { control: "text" },
    customStyles: { control: "object" },
    onToggle: { action: "onToggle" },
    icon: { control: "text" },
    number: { control: "number" },
    hideCardBorder: { control: "boolean" },
    hideDivider: { control: "boolean" },
    hideCardBg: { control: "boolean" },
    hideBorderRadius: { control: "boolean" },
  },
};

const Template = (args) => <Accordion {...args} />;

export const Basic = Template.bind({});
Basic.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  children:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: true,
  hideDivider: true,
  hideCardBg: false,
  hideBorderRadius: true,
};

export const WithStroke = Template.bind({});
WithStroke.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  children:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: true,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const WithDivider = Template.bind({});
WithDivider.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  children:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: true,
  hideDivider: false,
  hideCardBg: true,
  hideBorderRadius: true,
};

export const WithStrokeAndDivider = Template.bind({});
WithStrokeAndDivider.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  children:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const WithIcon = Template.bind({});
WithIcon.args = {
  title: "Accordion with Icon",
  children: "This accordion has an icon.",
  icon: "AccountCircle",
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const WithNumber = Template.bind({});
WithNumber.args = {
  title: "Accordion with Number",
  children: "This accordion has a number.",
  number: 1,
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const NestedAccordion = Template.bind({});
NestedAccordion.args = {
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
  title: "Main Accordion",
  children: (
    <Accordion
      title="Nested Accordion"
      isChild={true}
    >
      This is a nested accordion demonstrating component composition. The isChild prop ensures proper styling and behavior.
    </Accordion>
  ),
};

export const Custom = Template.bind({});
Custom.args = {
  title: "Custom Styled Accordion",
  children: "This accordion has custom styles.",
  customClassName: "custom-accordion",
  customStyles: {
    borderColor: "#C84C0E",
    backgroundColor: "#FFFFFF",
  },
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};