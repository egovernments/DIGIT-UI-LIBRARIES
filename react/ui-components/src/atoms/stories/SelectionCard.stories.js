import React from "react";
import SelectionCard from "../SelectionCard";
import { SVG } from "../SVG";
import Iframe from "../Iframe";

export default {
  title: "Atoms/SelectionCard",
  component: SelectionCard,
  argTypes: {
    width: {
      control: "number",
    },
    errorMessage: {
      control: "text",
    },
    options: {
      control: "object",
    },
    onSelectionChanged: {
      action: "selectionChanged",
    },
    selected: {
      control: {
        type: "array",
        separator: ",",
      },
    },
    allowMultipleSelection: {
      control: "boolean",
    },
  },
};

const Template = (args) => <SelectionCard {...args} />;

const commonArgs = {
  width: "",
  errorMessage: "",
  selected: [],
  options: [
    { name: "Option 1", code: "option1", prefixIcon: "", suffixIcon: "" },
    { name: "Option 2", code: "option2", prefixIcon: "", suffixIcon: "" },
    { name: "Option 3", code: "option3", prefixIcon: "", suffixIcon: "" },
  ],
  allowMultipleSelection: true,
  onSelectionChanged: (selectedOptions) =>
    console.log("Selected options:", selectedOptions),
};

const prefixIconOptions = [
  { name: "Option 1", code: "option1", prefixIcon: "Edit", suffixIcon: "" },
  { name: "Option 2", code: "option2", prefixIcon: "Edit", suffixIcon: "" },
  { name: "Option 3", code: "option3", prefixIcon: "Edit", suffixIcon: "" },
];

const suffixIconOptions = [
  { name: "Option 1", code: "option1", prefixIcon: "", suffixIcon: "Edit" },
  { name: "Option 2", code: "option2", prefixIcon: "", suffixIcon: "Edit" },
  { name: "Option 3", code: "option3", prefixIcon: "", suffixIcon: "Edit" },
];

const IconOptions = [
  { name: "Option 1", code: "option1", prefixIcon: "Edit", suffixIcon: "Edit" },
  { name: "Option 2", code: "option2", prefixIcon: "Edit", suffixIcon: "Edit" },
  { name: "Option 3", code: "option3", prefixIcon: "Edit", suffixIcon: "Edit" },
];

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="SelectionCard Documentation"
  />
);

Documentation.storyName = "Docs";

export const Default = Template.bind({});
Default.args = {
  ...commonArgs,
};

export const WithPrefixIcon = Template.bind({});
WithPrefixIcon.args = {
  ...commonArgs,
  options: prefixIconOptions,
};

export const WithSuffixIcon = Template.bind({});
WithSuffixIcon.args = {
  ...commonArgs,
  options: suffixIconOptions,
};

export const WithIcons = Template.bind({});
WithIcons.args = {
  ...commonArgs,
  options: IconOptions,
};

export const SingleSelection = Template.bind({});
SingleSelection.args = {
  ...commonArgs,
  allowMultipleSelection: false,
};

export const WithInitialSelection = Template.bind({});
WithInitialSelection.args = {
  ...commonArgs,
  selected: [
    { name: "Option 1", code: "option1", prefixIcon: "", suffixIcon: "" },
  ],
};

export const WithError = Template.bind({});
WithError.args = {
  ...commonArgs,
  errorMessage: "There was an error",
};

export const CustomWidth = Template.bind({});
CustomWidth.args = {
  ...commonArgs,
  width: 300,
};
