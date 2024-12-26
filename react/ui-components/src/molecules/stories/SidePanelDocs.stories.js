import React from "react";
import SidePanel from "../../atoms/SidePanel";
import Iframe from "../../atoms/Iframe";

export default {
  title: "Molecules/SidePanel",
  component: SidePanel,
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
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="SidePanel Documentation"
  />
);

Documentation.storyName = "Docs";
