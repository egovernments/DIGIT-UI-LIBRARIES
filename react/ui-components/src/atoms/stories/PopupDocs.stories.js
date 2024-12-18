import React, { useState } from "react";
import PopUp from "../PopUp";
import Iframe from "../Iframe";

export default {
  title: "Atoms/PopUp",
  component: PopUp,
  argTypes: {
    className: {
      control: "text",
    },
    type: { control: "select", options: ["default", "alert"] },
    overlayClassName: {
      control: "text",
    },
    onOverlayClick: {
      control: "function",
    },
    headerclassName: {
      control: "text",
    },
    footerclassName: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    children: {
      control: "object",
    },
    footerChildren: {
      control: "object",
    },
    onClose: {
      control: "function",
    },
    props: {
      control: "object",
    },
    showIcon: {
      control: "boolean",
    },
    heading: {
      control: "text",
    },
    subheading: {
      control: "text",
    },
    description: {
      control: "text",
    },
    alertHeading: {
      control: "text",
    },
    alertMessage: {
      control: "text",
    },
    iconFill: {
      control: "text",
    },
    customIcon: {
      control: "text",
    },
    showChildrenInline: {
      control: "boolean",
    },
    headerMaxLength: {
      control: "text",
    },
    subHeaderMaxLength: {
      control: "text",
    },
    sortFooterButtons: {
      control: "boolean",
    },
    maxFooterButtonsAllowed: {
      control: "text",
    },
    footerStyles: {
      control: "object",
    },
    showAlertAsSvg: {
      control: "boolean",
    },
    equalWidthButtons: {
      control: "boolean",
    },
  },
  parameters: {
    options: {
      storySort: {
        order: ["Docs", "Basic", "Alert"],
      },
    },
  },
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Popup Documentation"
  />
);

Documentation.storyName = "Docs";
