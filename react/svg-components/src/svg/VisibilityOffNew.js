import React from "react";
import PropTypes from "prop-types";
import { COLOR_FILL } from "./constants";

export const VisibilityOffNew = ({ className, height = "24", width = "24", style = {}, fill = COLOR_FILL, onClick = null }) => {
  return (
    <svg
      width={width}
      height={height}
      className={className}
      onClick={onClick}
      style={style}
      viewBox="0 0 20 16"
      fill="none"
    >
      <path
        d="M2 8c2 3 5 4.5 8 4.5s6-1.5 8-4.5"
        stroke={fill}
        strokeWidth="2"
        strokeLinecap="round"
      ></path>
      <path
        d="M4 11.5L3 13.8M7.3 13L6.7 15.2M10 13.5L10 16M12.7 13L13.3 15.2M16 11.5L17 13.8"
        stroke={fill}
        strokeWidth="1.7"
        strokeLinecap="round"
      ></path>
    </svg>
  );
};

VisibilityOffNew.propTypes = {
  /** custom width of the svg icon */
  width: PropTypes.string,
  /** custom height of the svg icon */
  height: PropTypes.string,
  /** custom colour of the svg icon */
  fill: PropTypes.string,
  /** custom class of the svg icon */
  className: PropTypes.string,
  /** custom style of the svg icon */
  style: PropTypes.object,
  /** Click Event handler when icon is clicked */
  onClick: PropTypes.func,
};
