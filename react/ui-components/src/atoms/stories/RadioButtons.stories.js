import React, { useState } from "react";
import { QueryClient, QueryClientProvider } from "react-query";
import Iframe from "../Iframe";
import RadioButtons from "../RadioButtons";

export default {
  title: "Atoms/RadioButton",
  component: RadioButtons,
  argTypes: {
    optionsKey: {
      control: "text",
      table: { disable: true },
    },
    options: {
      table: { disable: true },
    },
    inputRef: {
      table: { disable: true },
    },
    errorStyle: {
      table: { disable: true },
    },
    State: {
      control: "select",
      options: ["Default", "Disabled", "NonEditable"],
    },
    additionalWrapperClass: { control: "text", table: { disable: true } },
    error: { control: "text", table: { disable: true } },
    style: { control: "object", table: { disable: true } },
    innerStyles: { control: "object", table: { disable: true } },
    selectedOption: { table: { disable: true } },
    onSelect: { action: "onChange", table: { disable: true } },
    alignVertical: { table: { disable: true } },
    isLabelFirst: {
      control: "select",
      name:"Alignment",
      options:[
        "Right","Left"
      ],
      mapping:{
        Right:false,
        Left:true
      }
    },
  },
};
const queryClient = new QueryClient();

const commonStyles = {
  position: "absolute",
  top: "50%",
  left: "50%",
  color: "#363636",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  transform: "translate(-50%, -50%)",
};

const Template = (args) => {
  const { State, ...rest } = args;

  const [selectedOption, setSelectedOption] = useState(
    State === "NonEditable" ? "Option" : args.value
  );

  const handleSelectOption = (e) => {
    const selectedValue = e.code;
    if (selectedValue !== undefined) {
      setSelectedOption(e);
    }
  };

  return (
    <QueryClientProvider client={queryClient}>
      <div style={commonStyles}>
        <RadioButtons
          {...rest}
          disabled={State === "Disabled" || State === "NonEditable"}
          onSelect={handleSelectOption}
          selectedOption={State === "NonEditable" ? "Option" : selectedOption}
          value={State === "NonEditable" ? "Option" : selectedOption}
        />
      </div>
    </QueryClientProvider>
  );
};

const commonArgs = {
  optionsKey: "name",
  options: [{ code: "Option", name: "Option" }],
  inputRef: null,
  errorStyle: null,
  additionalWrapperClass: "",
  error: "",
  alignVertical: false,
  isLabelFirst:"Right",
  State: "Default",
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="RadioButton Documentation"
  />
);

Documentation.storyName = "Docs";

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
};