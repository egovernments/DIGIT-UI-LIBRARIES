import React from "react";
import { Card } from "@egovernments/digit-ui-components/atoms";
import { Iframe } from "@egovernments/digit-ui-components/atoms";

export default {
  title: "Molecules/Filter Card",
  component: Card,
  argTypes: {},
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0"
    title="Card Documentation"
  />
);

Documentation.storyName = "Detailed Props Definition";
Documentation.argTypes = {
  type: { table: { disable: true } },
  variant: { table: { disable: true } },
  onClick: { table: { disable: true } },
  style: { table: { disable: true } },
  className: { table: { disable: true } },
  children: { table: { disable: true } },
};