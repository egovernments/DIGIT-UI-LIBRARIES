import React from "react";
import { CustomDropdown } from "../../molecules";
import Iframe from "../Iframe";

export default {
  title: "Atoms/SimpleDropDown",
  component: CustomDropdown,
  argTypes: {
    t: { control: false },
    populators: { control: "object" },
    inputRef: { control: false },
    label: { control: "text" },
    onChange: { action: "onChange" },
    value: { control: "text" },
    errorStyle: { control: "object" },
    disabled: { control: "boolean" },
    isSearchable: { control: "boolean" },
    additionalWrapperClass: { control: "text" },
    props: { control: "object" },
    type: { control: "select", options: ["dropdown", "multiselectdropdown"] },
    variant: {
      control: "select",
      options: [
        "nesteddropdown",
        "treedropdown",
        "nestedtextdropdown",
        "profiledropdown",
        "profilenestedtext",
      ],
    },
  },
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Dropdown Documentation"
  />
);

Documentation.storyName = "Docs";
