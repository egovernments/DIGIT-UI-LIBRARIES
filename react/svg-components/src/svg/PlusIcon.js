import React from "react";

export const PlusIcon = ({
  className,
  styles,
  width = "24",
  height = "24",
  fill = "#C84C0E",
  viewBox = "0 0 24 24",
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
    <rect x="10.5" y="4" width="3" height="16" rx="1.5" fill={fill} />
    <rect x="4" y="10.5" width="16" height="3" rx="1.5" fill={fill} />
  </svg>
);
