import React from "react";

export const Mobile = ({
  className,
  styles,
  width = "24",
  height = "24",
  fill = "currentColor",
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
    <path
      d="M17 1.01L7 1c-1.1 0-2 .9-2 2v18c0 1.1.9 2 2 2h10c1.1 0 2-.9 2-2V3c0-1.1-.9-1.99-2-1.99zM17 19H7V5h10v14z"
      fill={fill}
    />
  </svg>
);
