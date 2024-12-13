import React from "react";
import Tooltip from "../Tooltip";

export default {
  title: "Atoms/Tooltip",
  component: Tooltip,
  argTypes: {
    content: { control: "text" },
    description: { control: "text" },
    placement: {
      control: "select",
      options: [
        "bottom-start",
        "bottom",
        "bottom-end",
        "top-start",
        "top",
        "top-end",
        "left-start",
        "left",
        "left-end",
        "right-start",
        "right",
        "right-end",
      ],
    },
    arrow: { control: "boolean" },
    style: { control: "object" },
    className: { control: "text" },
    header: { control: "text" },
    theme: {
      control: "select",
      options: [
        "dark",
        "light",
      ],
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
    title="Accordion Documentation"
  />
);

Documentation.storyName = "Docs";