import React from "react";
import PropTypes from "prop-types";
import { COLOR_FILL } from "./constants";

export const ColorIcon = ({
  className,
  height = "24",
  width = "24",
  style = {},
  fill = COLOR_FILL,
  viewBox = "0 -960 960 960",
  onClick = null,
}) => {
  return (
    <svg
      width={width}
      height={height}
      className={className}
      onClick={onClick}
      style={style}
      viewBox={viewBox}
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M346-140 100-386q-10-10-15-22t-5-25q0-13 5-25t15-22l230-229-106-106 62-65 400 400q10 10 14.5 22t4.5 25q0 13-4.5 25T686-386L440-140q-10 10-22 15t-25 5q-13 0-25-5t-22-15Zm47-506L179-432h428L393-646Zm399 526q-36 0-61-25.5T706-208q0-27 13.5-51t30.5-47l42-54 44 54q16 23 30 47t14 51q0 37-26 62.5T792-120Z"
        fill={fill}
      />
    </svg>
  );
};

ColorIcon.propTypes = {
  width: PropTypes.string,
  height: PropTypes.string,
  fill: PropTypes.string,
  viewBox: PropTypes.string,
  className: PropTypes.string,
  style: PropTypes.object,
  onClick: PropTypes.func,
};