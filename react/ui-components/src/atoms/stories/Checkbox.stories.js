import React from "react";
import CheckBox from "../CheckBox";
import Iframe from "../Iframe";

export default {
  title: "Atoms/CheckBox",
  component: CheckBox,
  argTypes: {
    onChange: { action: "onChange", table: { disable: true } },
    value: { control: "text", table: { disable: true } },
    checked: { control: "boolean", table: { disable: true } },
    isIntermediate: { control: "boolean", table: { disable: true } },
    styles: { control: "object", table: { disable: true } },
    style: { control: "object", table: { disable: true } },
    ref: { table: { disable: true } },
    userType: { table: { disable: true } },
    hideLabel: { table: { disable: true } },
    disabled: {
      control: "select",
      options: ["Default","Disabled"],
      name:"state",
      mapping: {
        Default: false, 
        Disabled: true, 
      },
    },
    isLabelFirst: { control: "boolean" },
    label: { control: "text"},
  },
};

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
  const [isChecked, setIsChecked] = React.useState(args?.checked);

  const handleCheckboxChange = (event) => {
    setIsChecked(event.target.checked);
  };

  return (
    <div style={commonStyles}>
      <CheckBox
        {...args}
        checked={isChecked}
        onChange={handleCheckboxChange}
      ></CheckBox>
    </div>
  );
};

const commonArgs = {
  onChange: () => {},
  value: "",
  checked: true,
  isLabelFirst: false,
  label: "Label",
  isIntermediate: false,
  styles: {},
  style: {},
  disabled: "Default",
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Checkbox Documentation"
  />
);

Documentation.storyName = "Docs";

export const UnChecked = Template.bind({});
UnChecked.args = {
  ...commonArgs,
  checked:false
};

export const Intermediate = Template.bind({});
Intermediate.args = {
  ...commonArgs,
  checked:false,
  isIntermediate:true
};

export const Checked = Template.bind({});
Checked.args = {
  ...commonArgs,
  checked:true
};