import React from "react";
import { QueryClient, QueryClientProvider } from "react-query";
import FieldV1 from "../../hoc/FieldV1";
import { CustomDropdown } from "../../molecules";

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
  