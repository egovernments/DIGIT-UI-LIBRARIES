import React from "react";

export default {
  title: "Intro",
  component: "iframe",
};

export const Intro = () => (
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation"
    width="100%"
    height="500px"
    style={{ border: "none" }}
    title="Iframe Example"
  />
);
