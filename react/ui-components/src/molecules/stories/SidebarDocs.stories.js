import React, { Children } from "react";
import { BrowserRouter as Router } from "react-router-dom";
import { Sidebar } from "../../atoms";

export default {
  title: "Molecules/Sidebar",
  component: Sidebar,
  argTypes: {
    items: { control: "object" },
    collapsedWidth: { control: "text" },
    expandedWidth: { control: "text" },
    transitionDuration: { control: "number" },
    theme: { control: "select", options: ["dark", "light"] },
    variant: { control: "select", options: ["primary", "secondary"] },
    hideAccessbilityTools: { control: "boolean" },
    onSelect:{ action: "onChange" },
    onBottomItemClick:{action:"onChange"}
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