import React from "react";
import { Header } from "@egovernments/digit-ui-components/atoms";
import { SVG } from "@egovernments/digit-ui-components/atoms";
import { Dropdown } from "@egovernments/digit-ui-components/atoms";
import { createDocumentationStory } from "../.storybook/DocumentationComponent";
export default {
  title: "Molecules/Header",
  component: Header,
  argTypes: {
    className: {
      control: "text",
    },
    theme: {
      control: "select",
      options: ["light", "dark"],
    },
    style: {
      control: { type: "object" },
    },
    onImageClick: {
      control: "function",
    },
    onHamburgerClick: {
      control: "function",
    },
    onLogoClick: {
      control: "function",
    },
    props: {
      control: "object",
    },
    setImageToLeft: {
      control: "boolean",
    },
    img: {
      control: "text",
    },
    logo: {
      control: "text",
    },
    ulb: {
      control: "text",
    },
    actionFields: {
      control: {
        type: "array",
        separator: ",",
      },
    },
  },
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0"
    title="Header Documentation"
  />
);

Documentation.storyName = "Detailed Props Definition";
