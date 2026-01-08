import React, { forwardRef } from "react";
import PropTypes from "prop-types";

const SubmitBar = forwardRef((props, ref) => {
  // Use generateUniqueId for stable ID generation (single source of truth)
  // ID Pattern: screenPath + composerType + composerId + sectionId + name + type
  const fieldId = Digit?.Utils?.generateUniqueId?.({
    screenPath: props?.screenPath || "",
    composerType: props?.composerType || "standalone",
    composerId: props?.composerId || "",
    sectionId: props?.sectionId || "",
    name: props?.name || props?.className || "submit",
    type: "btn",
    id: props?.id
  }) || props?.id || "NA";
  
  return (
    <span className="spanWrapper">
      <button
        ref={ref}
        id={fieldId}
        disabled={props.disabled ? true : false}
        className={`${props.disabled ? "submit-bar-disabled" : "submit-bar"} ${props.className ? props.className : ""}`}
        type={props.submit ? "submit" : "button"}
        style={{ ...props.style }}
        onClick={props.onSubmit}
        {... props.form ? {form: props.form} : {}}
      >
        <header style={{...props?.headerStyle}}>{props.label}</header>
        {props?.submitIcon}
      </button>
    </span>
  );
});

SubmitBar.propTypes = {
  /**
   * Is it a normal button or submit button?
   */
  submit: PropTypes.any,
  /**
   * style for the button
   */
  style: PropTypes.object,
  /**
   * SubmitButton contents
   */
  label: PropTypes.string,
  /**
   * Optional click handler
   */
  onSubmit: PropTypes.func,
  /**
   * Submit icon
   */
  submitIcon: PropTypes.node,
};

SubmitBar.defaultProps = {};

export default SubmitBar;
