import React, { useEffect, useState } from "react";
import PropTypes from "prop-types";

const Switch = ({
  isLabelFirst = false,
  label = "",
  shapeOnOff = false,
  isCheckedInitially = false,
  onToggle = () => {},
  className,
  style,
  disable = false,
  switchStyle,
  ariaLabel,
}) => {
  const [isChecked, setIsChecked] = useState(isCheckedInitially);
  useEffect(() => {
    setIsChecked(isCheckedInitially);
  }, [isCheckedInitially]);

  const handleToggle = () => {
    if (!disable) {
      setIsChecked(!isChecked);
      onToggle(!isChecked);
    }
  };

  const handleKeyDown = (e) => {
    if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      handleToggle();
    }
  };

  return (
    <div
      className={`digit-switch-container ${className || ""} ${
        disable ? "switch-disabled" : ""
      }`}
      style={style || {}}
    >
      {isLabelFirst && (
        <span className={`digit-switch-label ${"labelFirst"}`}>{label}</span>
      )}
      <div
        className={`digit-switch ${isChecked ? "checked" : ""} ${
          shapeOnOff ? "shape-onoff" : ""
        } ${disable ? "switch-disabled" : ""}`}
        onClick={handleToggle}
        tabIndex={disable ? -1 : 0}
        style={switchStyle || {}}
        onKeyDown={handleKeyDown}
        role="switch"
        aria-checked={isChecked}
        aria-disabled={disable}
        // The visible label is a sibling span, not associated with the switch, so the switch
        // itself needs an accessible name in every case (axe: aria-toggle-field-name).
        aria-label={ariaLabel || label || `Toggle switch ${isChecked ? "on" : "off"}`}
      >
        {shapeOnOff && isChecked && (
          <div className="digit-switch-shape-on" aria-hidden="true"></div>
        )}
        <div className="digit-switch-toggle" aria-hidden="true"></div>
        {shapeOnOff && !isChecked && (
          <div className="digit-switch-shape-off" aria-hidden="true"></div>
        )}
      </div>
      {!isLabelFirst && (
        <span className={`digit-switch-label ${"labelLast"}`}>{label}</span>
      )}
    </div>
  );
};

export default Switch;

Switch.propTypes = {
  isLabelFirst: PropTypes.bool,
  label: PropTypes.string,
  shapeOnOff: PropTypes.bool,
  isCheckedInitially: PropTypes.bool,
  onToggle: PropTypes.func,
  className: PropTypes.string,
  style: PropTypes.object,
  switchStyle: PropTypes.object,
  disable: PropTypes.bool,
  /** Accessible name for the switch when no visible label is rendered (label="") */
  ariaLabel: PropTypes.string,
};
