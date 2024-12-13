import React from "react";
import Switch from "../Switch";
import Iframe from "../Iframe";

export default {
  title: "Atoms/Switch",
  component: Switch,
  argTypes: {
    isLabelFirst: { control: "boolean" },
    label: { control: "text" },
    shapeOnOff: { control: "boolean" },
    isCheckedInitially: { control: "boolean" },
    onToggle: { action: "onToggle" },
    className: { control: "text" },
    style: { control: "object" },
    disable: { control: "boolean" },
  },
};

const Template = (args) => <Switch {...args} />;

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Switch Documentation"
  />
);

Documentation.storyName = "Docs";

export const Default = Template.bind({});
Default.args = {
  label: "",
  isLabelFirst: false,
  shapeOnOff: false,
  isCheckedInitially: false,
};

export const LabelOnRight = Template.bind({});
LabelOnRight.args = {
  label: "Toggle me",
  isLabelFirst: false,
  shapeOnOff: false,
  isCheckedInitially: false,
};

export const LabelOnLeft = Template.bind({});
LabelOnLeft.args = {
  label: "Toggle me",
  isLabelFirst: true,
  shapeOnOff: false,
  isCheckedInitially: false,
};

export const OffShape = Template.bind({});
OffShape.args = {
  label: "Off Shape",
  isLabelFirst: false,
  shapeOnOff: true,
  isCheckedInitially: false,
};

export const Checked = Template.bind({});
Checked.args = {
  label: "",
  isLabelFirst: false,
  shapeOnOff: false,
  isCheckedInitially: true,
};

export const CheckedLabelOnRight = Template.bind({});
CheckedLabelOnRight.args = {
  label: "Toggle me",
  isLabelFirst: false,
  shapeOnOff: false,
  isCheckedInitially: true,
};

export const CheckedLabelOnLeft = Template.bind({});
CheckedLabelOnLeft.args = {
  label: "Toggle me",
  isLabelFirst: true,
  shapeOnOff: false,
  isCheckedInitially: true,
};

export const OnShape = Template.bind({});
OnShape.args = {
  label: "On Shape",
  isLabelFirst: false,
  shapeOnOff: true,
  isCheckedInitially: true,
};

export const Disabled = Template.bind({});
Disabled.args = {
  label: "Disabled",
  isLabelFirst: false,
  shapeOnOff: false,
  isCheckedInitially: false,
  disable: true,
};

export const onToggleLogic = Template.bind({});
onToggleLogic.args = {
  label: "",
  isLabelFirst: false,
  shapeOnOff: false,
  isCheckedInitially: false,
  onToggle: (e) => {
    console.log(e, "event");
  },
};