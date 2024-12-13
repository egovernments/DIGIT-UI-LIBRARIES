import React from "react";
import { Card } from "../../atoms";

export default {
  title: "Molecules/Card",
  component: Card,
  argTypes: {},
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