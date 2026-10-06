import React from "react";
import PropTypes from "prop-types";
import { COLOR_FILL } from "./constants";

export const FactCheckOutline = ({
  className,
  height = "17",
  width = "19",
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
      viewBox="0 0 19 17"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M1.80775 17C1.30258 17 0.875 16.825 0.525 16.475C0.175 16.125 0 15.6974 0 15.1923V1.80775C0 1.30258 0.175 0.875 0.525 0.525C0.875 0.175 1.30258 0 1.80775 0H17.1923C17.6974 0 18.125 0.175 18.475 0.525C18.825 0.875 19 1.30258 19 1.80775V15.1923C19 15.6974 18.825 16.125 18.475 16.475C18.125 16.825 17.6974 17 17.1923 17H1.80775ZM1.80775 15.5H17.1923C17.2693 15.5 17.3398 15.4679 17.4038 15.4038C17.4679 15.3398 17.5 15.2692 17.5 15.1923V1.80775C17.5 1.73075 17.4679 1.66025 17.4038 1.59625C17.3398 1.53208 17.2693 1.5 17.1923 1.5H1.80775C1.73075 1.5 1.66025 1.53208 1.59625 1.59625C1.53208 1.66025 1.5 1.73075 1.5 1.80775V15.1923C1.5 15.2692 1.53208 15.3398 1.59625 15.4038C1.66025 15.4679 1.73075 15.5 1.80775 15.5ZM2.75 13.25H7.25V11.75H2.75V13.25ZM12.05 11.1442L16.6443 6.55L15.575 5.48075L12.05 9.03075L10.625 7.60575L9.58075 8.675L12.05 11.1442ZM2.75 9.25H7.25V7.75H2.75V9.25ZM2.75 5.25H7.25V3.75H2.75V5.25Z"
        fill={fill}
      />
    </svg>
  );
};

FactCheckOutline.propTypes = {
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
