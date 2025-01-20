import React from "react";
import { CustomSVG } from "./CustomSVG";

const HamburgerButton = ({ handleClick, color ,className}) => (
  <div className={`digit-hamburger-span ${className || ""}`} onClick={handleClick}>
    <CustomSVG.HamburgerIcon className="digit-hamburger" fill={color} />
  </div>
);

export default HamburgerButton;
