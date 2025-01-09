import React from "react";
import { SVG } from "../SVG";
import { CustomSVG } from "../CustomSVG";
import { iconRender } from "../../utils/iconRender";

export default {
  title: "Foundations",
};

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  transform: "translate(-50%, -50%)",
  "flex-direction": "column",
  gap: "16px",
};

const Template = (args) => {
  const IconComponent =
    SVG[args.icon] || CustomSVG[args.icon];

  return (
    <div style={style}>
      <div
        className="typography caption-s"
        style={{
          gap: "8px",
          display: "flex",
          flexDirection: "column",
          color: "#0B4B66",
        }}
      >
        {args.icon}
      </div>
      {IconComponent ? <IconComponent {...args} /> : "Icon not found"}
    </div>
  );
};

export const Iconography = Template.bind({});
Iconography.args = {
  className: "",
  style: {},
  fill: "#C84C0E",
  height: "50",
  width: "50",
  onClick: () => {},
  icon: "Accessibility",
};
