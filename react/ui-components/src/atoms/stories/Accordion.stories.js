import React from "react";
import {Accordion} from "../Accordion";
import { IMAGES } from "../../constants/images/images";

export default {
  title: "Atoms/Accordion",
  component: Accordion,
  argTypes: {
    title: { control: "text" },
    content: { control: "text" },
    icon: { control: "text" },
    number: { control: "number" },
    isOpenInitially: { control: "boolean" },
    onToggle: { action: "onToggle" },
    customClassName: { control: "text" },
    customStyles: { control: "object" },
    hideCardBorder: { control: "boolean" },
    hideDivider: { control: "boolean" },
    hideCardBg: { control: "boolean" },
    hideBorderRadius: { control: "boolean" },
  },
};

const Template = (args) => <Accordion {...args} />;

const getImageUrl = (imageKey) => {
  return IMAGES[imageKey];
};

const digitImg = getImageUrl("DIGIT_LIGHT");

export const Default = Template.bind({});
Default.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  content:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const WithOnlyCardBg = Template.bind({});
WithOnlyCardBg.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  content:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: true,
  hideDivider: true,
  hideCardBg: false,
  hideBorderRadius: true,
};

export const WithOnlyCardBorder = Template.bind({});
WithOnlyCardBorder.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  content:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: true,
  hideCardBg: true,
  hideBorderRadius: true,
};

export const WithOnlyBorderRadius = Template.bind({});
WithOnlyBorderRadius.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  content:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: true,
  hideCardBg: true,
  hideBorderRadius: false,
};

export const WithOnlyDivider = Template.bind({});
WithOnlyDivider.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  content:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: true,
  hideDivider: false,
  hideCardBg: true,
  hideBorderRadius: true,
};

export const WithHidden = Template.bind({});
WithHidden.args = {
  title:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
  content:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  isOpenInitially: false,
  hideCardBorder: true,
  hideDivider: true,
  hideCardBg: true,
  hideBorderRadius: true,
};

export const WithIcon = Template.bind({});
WithIcon.args = {
  title: "Accordion with Icon",
  content: "This accordion has an icon.",
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
  content: "This accordion has a number.",
  number: 1,
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const WithIconAndNumber = Template.bind({});
WithIconAndNumber.args = {
  title: "Accordion with Icon and Number",
  content: "This accordion has both an icon and a number.",
  icon: "AccountCircle",
  number: 2,
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const InitiallyOpen = Template.bind({});
InitiallyOpen.args = {
  title: "Initially Open Accordion",
  content: "This accordion is open by default.",
  isOpenInitially: true,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const CustomStyledAccordion = Template.bind({});
CustomStyledAccordion.args = {
  title: "Custom Styled Accordion",
  content: "This accordion has custom styles.",
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

export const onToggleLogic = Template.bind({});
onToggleLogic.args = {
  title: "Toggle Logic Accordion",
  content: "This accordion logs when toggled.",
  isOpenInitially: false,
  onToggle: (isOpen) =>
    console.log("Accordion is now", isOpen ? "Open" : "Closed"),
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export const Content = Template.bind({});
Content.args = {
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
  title: (
    <React.Fragment>
      <em>{"And here's"}</em> <b>{"some"}</b> <u>{"amazing content"}</u>.{" "}
      {"Toggle the Accordion"}{" "}
    </React.Fragment>
  ),
  content: <img alt="Powered by DIGIT" src={digitImg} />,
};


export const NestedAccordion = Template.bind({});
NestedAccordion.args = {
  isOpenInitially: false,
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
  title: "NestedAccordion",
  content: <Accordion title={"Nested One"} content={"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."} ></Accordion>
};