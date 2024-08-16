import React, { useState } from "react";

const Switch = ({
  isLabelFirst = false,
  label = "",
  shapeOnOff = false,
  isCheckedInitially = false,
  onToggle = () => {},
  className,
  style,
  disable = false,
}) => {
  const [isChecked, setIsChecked] = useState(isCheckedInitially);

  const handleToggle = () => {
    if (!disable) {
      setIsChecked(!isChecked);
      onToggle(!isChecked);
    }
  };

  return (
    <div
      className={`digit-switch-container ${className || ""} ${
        disable ? "switch-disabled" : ""
      }`}
      style={style}
    >
      {isLabelFirst && (
        <span className={`digit-switch-label ${"labelFirst"}`}>{label}</span>
      )}
      <div
        className={`digit-switch ${isChecked ? "checked" : ""} ${
          shapeOnOff ? "shape-onoff" : ""
        } ${disable ? "switch-disabled" : ""}`}
        onClick={handleToggle}
      >
        {shapeOnOff && isChecked && (
          <div className="digit-switch-shape-on"></div>
        )}
        <div className="digit-switch-toggle"></div>
        {shapeOnOff && !isChecked && (
          <div className="digit-switch-shape-off"></div>
        )}
      </div>
      {!isLabelFirst && (
        <span className={`digit-switch-label ${"labelLast"}`}>{label}</span>
      )}
    </div>
  );
};

export default Switch;
