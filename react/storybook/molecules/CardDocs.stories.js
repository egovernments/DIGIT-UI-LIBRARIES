import React from "react";
import { Card } from "@egovernments/digit-ui-components/atoms";
import { createDocumentationStory } from "../.storybook/DocumentationComponent";
export default {
  title: "Molecules/Card",
  component: Card,
  argTypes: {},
};

export const Documentation = createDocumentationStory("Card", "molecules");