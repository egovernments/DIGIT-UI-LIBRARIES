import React from "react";
import Divider from "../Divider";

export default {
  title: "Atoms/Divider",
  component: Divider,
  argTypes: {
    className: {
      control: "boolean",
    },
    style: {
      control: { type: "object" },
    },
    variant: {
        control: "select",
        options: ["small", "medium", "large"],
      },
  },
};

const Template = (args) => (
  <div>
    <Divider {...args}></Divider>
</div>
);

const commonArgs = {
    variant:"",
  className: "",
  style: {},
};

export const DividerSmall = Template.bind({});
DividerSmall.args = {
  ...commonArgs,
  variant:"small"
};

export const DividerMedium = Template.bind({});
DividerMedium.args = {
  ...commonArgs,
  variant:"medium"
};

export const DividerLarge = Template.bind({});
DividerLarge.args = {
  ...commonArgs,
  variant:"large"
};