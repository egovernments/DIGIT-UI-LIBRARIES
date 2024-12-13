import React from "react";
import { TopBar } from "../../atoms";
import { SVG } from "../../atoms";
import { Dropdown } from "../../atoms";

export default {
  title: "Molecules/Header",
  component: TopBar,
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
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    width="100%"
    height="830"
    style={{ border: "none" }}
    title="Header Documentation"
  />
);

Documentation.storyName = "Docs";
