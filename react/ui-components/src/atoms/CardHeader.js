import React from "react";

const CardHeader = (props) => {
  const variant = props?.variant ? props?.variant : "";
  const className = props?.className ? props?.className : "";
  // A <header> element is an implicit "banner" landmark. Cards render this many times per page and
  // often inside other landmarks, which fails axe's landmark-no-duplicate-banner and
  // landmark-banner-is-top-level checks, so use a neutral element instead.
  return (
    <div className={`digit-card-header ${variant} ${className}`} style={props.styles ? props.styles : {}}>
      {props.children}
    </div>
  );
};

export default CardHeader;
