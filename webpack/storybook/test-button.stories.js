import React from "react";

import Button from "@egovernments/digit-ui-components/atoms/Button.js";

export default {
  title: "Test/Button",
  component: Button,
  argTypes: {
    label: {
      control: "text",
      defaultValue: "Click Me",
    },
    variant: {
      control: "select",
      options: ["primary", "secondary", "tertiary"],
      defaultValue: "primary",
    },
  },
};

export const Primary = (args) => <Button {...args} />;

Primary.args = {
  label: "Primary Button",
  variant: "primary",
};

export const Secondary = (args) => <Button {...args} />;

Secondary.args = {
  label: "Secondary Button", 
  variant: "secondary",
};

export const Tertiary = (args) => <Button {...args} />;

Tertiary.args = {
  label: "Tertiary Button",
  variant: "tertiary", 
};