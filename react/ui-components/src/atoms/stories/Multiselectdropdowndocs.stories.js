import React from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import FieldV1 from "../../hoc/FieldV1";
import { CustomDropdown } from "../../molecules";
import Iframe from "../Iframe";

export default {
  title: "Atoms/DropDown/MultiSelect",
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
        "nestedmultiselect",
        "treemultiselect",
        "nestedtextmultiselect",
      ],
    },
  },
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Multiselectdropdown Documentation"
  />
);

Documentation.storyName = "Docs";
