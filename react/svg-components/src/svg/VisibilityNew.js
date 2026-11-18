import React from "react";
import PropTypes from "prop-types";
import { COLOR_FILL } from "./constants";

export const VisibilityNew = ({
  className,
  height = "24",
  width = "24",
  style = {},
  fill = COLOR_FILL,
  onClick = null,
}) => {
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
        d="M4 4.5L3 2.2M7.3 2.8L6.7 0.6M10 2.2L10 0M12.7 2.8L13.3 0.6M16 4.5L17 2.2"
        stroke={fill}
        strokeWidth="1.7"
        strokeLinecap="round"
      ></path>
      <path
        d="M2 9C4 5 7 3 10 3s6 2 8 6c-2 4-5 6-8 6s-6-2-8-6z"
        stroke={fill}
        strokeWidth="1.9"
        strokeLinejoin="round"
      ></path>
      <circle cx="10" cy="9" r="2.6" fill={fill}></circle>
    </svg>
  );
};

VisibilityNew.propTypes = {
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
