import React from "react";
import MenuCard from "@egovernments/digit-ui-components/molecules/MenuCard";
import { createDocumentationStory } from "../.storybook/DocumentationComponent";
export default {
  title: "Molecules/Menu Card",
  component: MenuCard,
  argTypes: {
    icon: { control: "boolean" ,name:"Show Icon",mapping:{true:"Article",false:""}},
    menuName: { control: "text" ,name:'Heading'},
    description: { control: "text",name:"Description" },
    className: { control: "text" ,table:{disable:true}},
    styles: { control: "object" ,table:{disable:true}},
    onClick: { action: "clicked",table:{disable:true} },
  },
};

const Template = (args) => <MenuCard {...args} />;



const commonArgs = {
  icon: true,
  menuName: "Menu Header",
  description:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",  className: "",
  styles: {},
  onClick:(e)=>{console.log(e)}
}
// Default story for MenuCard
export const Menu1 = Template.bind({});
Menu1.args = {
...commonArgs,
};

// MenuCard with custom styles
export const Custom = Template.bind({});
Custom.args = {
...commonArgs,
  styles: {
    backgroundColor: "#f9f9f9",
    padding: "30px",
    borderRadius: "12px",
    border: "2px solid #333",
  },
};

export const Documentation = createDocumentationStory("MenuCard", "molecules");