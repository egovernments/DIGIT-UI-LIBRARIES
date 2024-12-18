import React from "react";
import LabelFieldPair from "../LabelFieldPair";
import TextBlock from "../TextBlock";
import TextInput from "../TextInput";
import Iframe from "../Iframe";

export default {
  title: "Atoms/LabelFieldPair",
  component: LabelFieldPair,
  argTypes: {
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    vertical: {
      control: "boolean",
    },
  },
};

export const Documentation = () => (
  <Iframe
  //Todo:Update the url
  src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
  title="LabelFieldPair Documentation"
/>
);

Documentation.storyName = "Docs";

export const Default = () => (
  <LabelFieldPair>
    <TextBlock body={"Name"}></TextBlock>
    <TextInput type="text"></TextInput>
  </LabelFieldPair>
);

export const VerticalAlignment = () => (
  <LabelFieldPair vertical={true}>
    <TextBlock body={"Name"}></TextBlock>
    <TextInput type="text"></TextInput>
  </LabelFieldPair>
);
