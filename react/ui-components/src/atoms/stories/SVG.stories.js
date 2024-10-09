import React from "react";
import { SVG } from "../SVG";

export default {
  tags: ["autodocs"],
  argTypes: {
    className: {
      options: ["custom-class"],
      control: { type: "check" },
    },
  },
  title: "Foundations/Iconography",
  component: SVG,
  icon:""
};


const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  transform: "translate(-50%, -50%)"
};


const Template = (args) => {
  const IconComponent = SVG[args.icon];
  return (
    <div style={style}>
      {IconComponent ? <IconComponent {...args} /> : "Icon not found"}
    </div>
  );
};

export const Playground = Template.bind({});
Playground.args = {
  className: "custom-class",
  style: {},
  fill: "#C84C0E",
  height: "50",
  width: "50",
  onClick: () => {},
  icon:"Accessibility"
};