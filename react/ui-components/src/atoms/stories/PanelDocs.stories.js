import React from "react";
import Panels from "../Panels";
import Iframe from "../Iframe";

export default {
  title: "Atoms/Panels",
  component: Panels,
  argTypes: {
    type: { control: "select", options: ["success", "error"] },
    className: {
      control: "text",
    },
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
    style: {
      control: { type: "object" },
    },
    multipleResponses: {
      control: {
        type: "array",
        separator: ",",
      },
    },
    showAsSvg: {
      control: "boolean",
    },
    animationProps: {
      control: { type: "object" },
    },
  },
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Panel Documentation"
  />
);

Documentation.storyName = "Docs";
