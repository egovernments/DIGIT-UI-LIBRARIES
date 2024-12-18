import React from "react";
import PanelCard from "../PanelCard";
import {Iframe} from "../../atoms";

export default {
  title: "Molecules/PanelCard",
  component: PanelCard,
  argTypes: {
    cardClassName: {
      control: "text",
    },
    cardStyles: {
      control: { type: "object" },
    },
    children: {
      control: "object",
    },
    props: {
      control: "object",
    },
    description: {
      control: "text",
    },
    showChildrenInline: {
      control: "boolean",
    },
    sortFooterButtons: {
      control: "boolean",
    },
    maxFooterButtonsAllowed: {
      control: "text",
    },
    type: { control: "select", options: ["success", "error"] },
    message: {
      control: "text",
    },
    info: {
      control: "text",
    },
    response: {
      control: "text",
    },
    customIcon: {
      control: "text",
    },
    iconFill: {
      control: "text",
    },
    multipleResponses: {
      control: {
        type: "array",
        separator: ",",
      },
    },
    className: {
      control: "text",
    },
    style: {
      control: "object",
    },
    animationProps: {
      control: "object",
    },
    footerStyles: {
      control: "object",
    },
  },
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="PanelCard Documentation"
  />
);

Documentation.storyName = "Docs";
