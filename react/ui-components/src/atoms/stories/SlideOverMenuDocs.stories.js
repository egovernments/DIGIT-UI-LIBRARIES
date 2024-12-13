import React from "react";
import SlideOverMenu from "../SlideOverMenu";

export default {
  title: "Atoms/SlideOverMenu",
  component: SlideOverMenu,
  argTypes: {
    className: { control: "text" },
    styles: { control: "object" },
    type: { control: "select", options: ["static", "dynamic"] },
    position: { control: "select", options: ["left", "right"] },
    children: {
      control: "object",
    },
    header: {
      control: "object",
    },
    footer: {
      control: "object",
    },
    bgActive: { control: "boolean" },
    isOverlay: { control: "boolean" },
    hideArrow: { control: "boolean" },
    hideScrollIcon: { control: "boolean" },
    isDraggable: { control: "boolean" },
    defaultClosedWidth: { control: "text" },
    defaultOpenWidth: { control: "text" },
    addClose: { control: "boolean" },
    closedContents: { control: "object" },
    closedHeader: { control: "object" },
    closedFooter: { control: "object" },
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
