import React from "react";

const LinkLabel = (props) => {
  const handleKeyDown = (e) => {
    if (e.key === "Enter" || e.key === " ") {
      e.preventDefault();
      props.onClick?.(e);
    }
  };
  // A <label> may not carry a role (axe aria-allowed-role), and this one labels no form control.
  // <span> takes role="button" legitimately and renders identically - .link-label is a plain class
  // selector, so the styling is untouched.
  return (
    <span className="link-label" onClick={props.onClick} style={{ ...props.style }} onKeyDown={handleKeyDown} tabIndex={0} role="button">
      {props.children}
    </span>
  );
};

export default LinkLabel;
