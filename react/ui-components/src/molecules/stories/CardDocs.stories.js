import React from "react";
import { Card } from "../../atoms";
import {Iframe} from "../../atoms";

export default {
  title: "Molecules/Card",
  component: Card,
  argTypes: {},
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Card Documentation"
  />
  );

  Documentation.storyName = "Docs";