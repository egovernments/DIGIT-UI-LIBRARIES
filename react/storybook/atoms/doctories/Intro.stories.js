import React from "react";
import Iframe from "@egovernments/digit-ui-components/atoms/Iframe";

export default {
  title: "Intro",
  component: "Iframe",
};

export const Intro = () => (
  <Iframe
    //Todo : Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation"
    title="Iframe Example"
  />
);
