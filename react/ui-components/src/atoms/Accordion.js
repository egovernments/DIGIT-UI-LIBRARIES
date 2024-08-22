import React, { useState } from "react";
import PropTypes from "prop-types";
import { SVG } from "./SVG";
import { Colors } from "../constants/colors/colorconstants";
import { iconRender } from "../utils/iconRender";
import { Spacers } from "../constants/spacers/spacers";

const Accordion = ({
  title,
  content,
  icon,
  iconFill,
  iconWidth,
  iconHeight,
  number,
  isOpenInitially,
  onToggle,
  customClassName,
  customStyles,
  hideCardBorder,
  hideDivider,
  hideCardBg,
  hideBorderRadius
}) => {
  const [isOpen, setIsOpen] = useState(isOpenInitially);

  const iconColor = Colors.lightTheme.text.primary;
  const toggleiconSize = Spacers.spacer8;
  const iconSize = Spacers.spacer6;
  const handleToggle = () => {
    setIsOpen(!isOpen);
    onToggle && onToggle(!isOpen);
  };

  return (
    <div
      className={`digit-accordion-container ${customClassName} ${
        !hideCardBorder ? "border" : ""
      } ${!hideBorderRadius ? "borderRadius" : ""} ${
        !hideCardBg ? "cardBg" : ""
      } ${!hideDivider ? "divider" : ""} ${
        hideDivider && isOpen ? "no-divider" : ""
      }`}
      style={customStyles}
    >
      <div className="digit-accordion-header" onClick={handleToggle}>
        {icon && (
          <div className="digit-accordion-icon">
            {iconRender(
              icon,
              iconFill || iconColor,
              iconWidth || iconSize,
              iconHeight || iconSize,
              `digit-accordion-icon`
            )}
          </div>
        )}
        {number && (
          <div className="digit-accordion-number">
            {number}
            {"."}
          </div>
        )}
        <div className="digit-accordion-title">{title}</div>
        <div className="digit-accordion-toggle">
          {isOpen ? (
            <SVG.ChevronLeft
              fill={iconColor}
              width={toggleiconSize}
              height={toggleiconSize}
              style={{ transform: "rotate(90deg)" }}
            ></SVG.ChevronLeft>
          ) : (
            <SVG.ChevronLeft
              fill={iconColor}
              width={toggleiconSize}
              height={toggleiconSize}
              style={{ transform: "rotate(-90deg)" }}
            ></SVG.ChevronLeft>
          )}
        </div>
      </div>
      {isOpen && <div className="digit-accordion-content">{content}</div>}
    </div>
  );
};

Accordion.propTypes = {
  title: PropTypes.string.isRequired,
  content: PropTypes.node.isRequired,
  icon: PropTypes.string,
  iconFill:PropTypes.string,
  iconWidth:PropTypes.string,
  iconHeight:PropTypes.string,
  number: PropTypes.node,
  isOpenInitially: PropTypes.bool,
  hideCardBorder: PropTypes.bool,
  hideDivider: PropTypes.bool,
  hideCardBg: PropTypes.bool,
  hideBorderRadius: PropTypes.bool,
  onToggle: PropTypes.func,
  customClassName: PropTypes.string,
  customStyles: PropTypes.object,
};

Accordion.defaultProps = {
  icon: null,
  number: null,
  isOpenInitially: false,
  customClassName: "",
  customStyles: {},
  hideCardBorder: false,
  hideDivider: false,
  hideCardBg: false,
  hideBorderRadius: false,
};

export default Accordion;
