import React from "react";
import PropTypes from "prop-types";

const Tooltip = ({ tooltipRef, content, placement, arrow, style, className,header ,description}) => {
  return (
    <div
      className={`tooltip-content tooltip-${placement} ${
        arrow ? "with-arrow" : ""
      } ${className || ""}`}
      style={style}
      ref={tooltipRef}
    >
      <div className={`tooltip-header`}>{header}</div>
      <div className={`tooltip-data`}>{content}</div>
      <div className={`tooltip-description`}>{description}</div>
    </div>
  );
};

Tooltip.propTypes = {
  header:PropTypes.string,
  content: PropTypes.node.isRequired,
  description:PropTypes.string,
  placement: PropTypes.oneOf([
    "bottom",
    "bottom-end",
    "bottom-start",
    "left",
    "right",
    "top",
    "top-end",
    "top-start",
    "left-end",
    "left-start",
    "right-end",
    "right-start",
  ]),
  arrow: PropTypes.bool,
  style: PropTypes.object,
  className: PropTypes.string,
};

Tooltip.defaultProps = {
  arrow: true,
  placement: "bottom",
};

export default Tooltip;
