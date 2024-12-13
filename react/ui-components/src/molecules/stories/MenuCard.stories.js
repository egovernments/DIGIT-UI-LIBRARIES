import React from "react";
import MenuCard from "../MenuCard";

export default {
  title: "Molecules/MenuCard",
  component: MenuCard,
  argTypes: {
    icon: { control: "text" },
    menuName: { control: "text" },
    description: { control: "text" },
    className: { control: "text" },
    styles: { control: "object" },
    onClick: { action: "clicked" },
  },
};

const Template = (args) => <MenuCard {...args} />;

export const Documentation = () => (
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    width="100%"
    height="830"
    style={{ border: "none" }}
    title="MenuCard Documentation"
  />
);

Documentation.storyName = "Docs";


// Default story for MenuCard
export const Default = Template.bind({});
Default.args = {
  icon: "Article",
  menuName: "Menu",
  description:
    "Use this checklist to supervise the team formation for Registration & Distribution",
  className: "",
  styles: {},
  onClick:(e)=>{console.log(e)}
};

// MenuCard without description
export const WithoutDescription = Template.bind({});
WithoutDescription.args = {
  icon: "Article",
  menuName: "Menu",
  className: "",
  styles: {},
};

// Default story for MenuCard
export const WithLongMenuName = Template.bind({});
WithLongMenuName.args = {
  icon: "Article",
  menuName:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  description:
    "Use this checklist to supervise the team formation for Registration & Distribution",
  className: "",
  styles: {},
};

// MenuCard with a longer description
export const WithLongDescription = Template.bind({});
WithLongDescription.args = {
  icon: "Article",
  menuName: "Menu",
  description:
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  className: "profile-class",
  styles: {},
};

// MenuCard with custom styles
export const CustomStyles = Template.bind({});
CustomStyles.args = {
  icon: "Article",
  menuName: "Menu",
  description:
    "Use this checklist to supervise the team formation for Registration & Distribution",
  className: "",
  styles: {
    backgroundColor: "#f9f9f9",
    padding: "30px",
    borderRadius: "12px",
    border: "2px solid #333",
  },
};
