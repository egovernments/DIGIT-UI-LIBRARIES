import React from "react";
import MenuCardWrapper from "@egovernments/digit-ui-components/molecules/MenuCardWrapper";
import MenuCard from "@egovernments/digit-ui-components/molecules/MenuCard";
import { createDocumentationStory } from "../.storybook/DocumentationComponent";
export default {
  title: "MoleculeGroup/Menu Card Wrapper",
  component: MenuCardWrapper,
  argTypes: {
    numberOfCards: {
      control: { type: "number", min: 1 },
      defaultValue: 3,
      name: "No of Cards",
      description: "Number of LandingPageCards to display",
    },
    className: { table: { disable: true } },
    styles: { table: { disable: true } },
    children: { table: { disable: true } },
  },
};

const Template = (args) => {
  const { numberOfCards, ...rest } = args;

  const generateCards = (count) => {
    return Array.from({ length: count }, (_, index) => (
      <MenuCard
        icon={"Article"}
        menuName={`Card ${index + 1}`}
        description={
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        }
        className={""}
        styles={{}}
        onClick={(e) => {
          console.log(e);
        }}
        key={index}
      />
    ));
  };

  return (
    <MenuCardWrapper {...rest}>{generateCards(numberOfCards)}</MenuCardWrapper>
  );
};



// Default story showing a group of MenuCards
export const Basic = Template.bind({});
Basic.args = {};

// MenuCardWrapper with custom styles
export const Custom = Template.bind({});
Custom.args = {
  styles: {
    display: "flex",
    flexDirection: "column",
    gap: "32px",
    padding: "16px",
    backgroundColor: "#f4f4f4",
  },
};

export const Documentation = createDocumentationStory("MenuCardWrapper", "molecules");