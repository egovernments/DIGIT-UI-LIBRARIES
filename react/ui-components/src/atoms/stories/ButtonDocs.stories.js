import React from "react";
import Button from "../Button";
import Iframe from "../Iframe";

export default {
  title: "Atoms/Button",
  component: Button,
  argTypes: {
    isDisabled: {
      control: "boolean",
    },
    label: {
      control: "text",
    },
    variation: {
      control: "select",
      options: ["primary", "secondary", "teritiary", "link"],
    },
    size: { control: "select", options: ["large", "medium", "small"] },
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    onClick: {
      control: "function",
    },
    isSuffix: {
      control: "boolean",
    },
    title: {
      control: "text",
    },
    options: {
      control: {
        type: "array",
        separator: ",",
      },
    },
    isSearchable: {
      control: "boolean",
    },
    showBottom: {
      control: "boolean",
    },
    optionsKey: {
      control: "text",
    },
  },
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Button Documentation"
  />
);

Documentation.storyName = "Docs";
