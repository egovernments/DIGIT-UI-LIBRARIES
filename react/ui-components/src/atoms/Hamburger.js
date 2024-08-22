import React from "react";
import { CustomSVG } from "./CustomSVG";

const Hamburger = ({ handleClick, color ,className}) => (
  <div className={`digit-hamburger-span ${className || ""}`} onClick={handleClick}>
    <CustomSVG.HamburgerIcon className="digit-hamburger" color={color} />
  </div>
);

export default Hamburger;
