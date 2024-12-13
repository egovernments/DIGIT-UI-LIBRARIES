import React, { useState } from "react";
import Stepper from "../Stepper";
import Iframe from "../Iframe";

export default {
  title: "Atoms/Stepper",
  component: Stepper,
  argTypes: {
    config: { control: "object" },
    inputRef: { control: false },
    onChange: { action: "onChange" },
    props: { control: "object" },
    populators: { control: "object" },
    formData: { control: "object" },
    onStepClick: { action: "onChange" },
    totalSteps: { action: "number" },
    customSteps: { control: "object" },
    direction: {
      control: {
        type: "select",
        options: ["vertical", "horizontal"],
      },
    },
    style: { control: "object" },
    props: { control: "object" },
    activeSteps: { action: "number" },
    hideDivider: { control: "boolean" },
  },
};

const Template = (args) => {
  const [currentStep, setCurrentStep] = useState(0);

  const onStepClick = (step) => {
    console.log("step", step);
    setCurrentStep(step);
  };

  return (
    <Stepper
      {...args}
      currentStep={currentStep + 1}
      onStepClick={onStepClick}
    />
  );
};

const t = (key) => key;

const commonArgs = {
  populators: {
    name: "stepper",
  },
  customSteps: {},
  totalSteps: 5,
  direction: "horizontal",
  onStepClick: () => {},
  style: {},
  props: {
    labelStyles: {},
  },
  activeSteps: "",
  hideDivider: false,
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Stepper Documentation"
  />
);

Documentation.storyName = "Docs";

//Default stepper
export const Default = Template.bind({});
Default.args = {
  ...commonArgs,
};

//With Active Steps stepper
export const WithIsActive = Template.bind({});
WithIsActive.args = {
  ...commonArgs,
  activeSteps: 3,
};

//Vertical stepper
export const VerticalStepperWithDivider = Template.bind({});
VerticalStepperWithDivider.args = {
  ...commonArgs,
  direction: "vertical",
};

//Vertical stepper
export const VerticalStepperWithoutDivider = Template.bind({});
VerticalStepperWithoutDivider.args = {
  ...commonArgs,
  direction: "vertical",
  hideDivider: true,
};