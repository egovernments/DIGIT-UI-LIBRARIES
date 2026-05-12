import React from "react";

export const Workflow = ({
  className,
  styles,
  width = "20",
  height = "16",
  fill = "#C84C0E",
  viewBox = "0 0 20 16",
  ...rest
}) => (
  <svg
    className={className}
    style={styles}
    width={width}
    height={height}
    viewBox={viewBox}
    fill="none"
    xmlns="http://www.w3.org/2000/svg"
    {...rest}
  >
    <path
      d="M13 16V14H9V9H7V11H0V5H7V7H9V2H13V0H20V6H13V4H11V12H13V10H20V16H13ZM15 14H18V12H15V14ZM2 9H5V7H2V9ZM15 4H18V2H15V4Z"
      fill={fill}
    />
  </svg>
);
