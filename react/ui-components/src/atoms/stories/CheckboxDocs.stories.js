import React from "react";
import CheckBox from "../CheckBox";
import Iframe from "../Iframe";

export default {
  title: "Atoms/CheckBox",
  component: CheckBox,
  argTypes: {
    config: { control: "object" },
    inputRef: { control: false },
    onChange: { action: "onChange" },
    errorStyle: { control: "object" },
    disabled: { control: "boolean" },
    type: { control: "text" },
    props: { control: "object" },
    populators: { control: "object" },
    formData: { control: "object" },
    isIntermediate: { control: "boolean" },
  },
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Checkbox Documentation"
  />
);

Documentation.storyName = "Docs";