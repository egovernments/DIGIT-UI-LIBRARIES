import React from "react";
import PropTypes from "prop-types";

const ButtonSelector = (props) => {
  let theme = "selector-button-primary";
  switch (props.theme) {
    case "border":
      theme = "selector-button-border";
      break;
    default:
      theme = "selector-button-primary";
      break;
  }
  // Use generateUniqueId for stable ID generation (single source of truth)
  // ID Pattern: screenPath + composerType + composerId + sectionId + name + type
  const fieldId = Digit?.Utils?.generateUniqueId?.({
    screenPath: props?.screenPath || "",
    composerType: props?.composerType || "standalone",
    composerId: props?.composerId || "",
    sectionId: props?.sectionId || "",
    name: props?.name || props?.className || "selector",
    type: "btn",
    id: props?.id
  }) || props?.id || "NA";
  
  return (
    <button
      className={props.isDisabled ? "selector-button-primary-disabled" : theme}
      type={props.type || "submit"}
      form={props.formId}
      id={fieldId}
      onClick={props.onSubmit}
      disabled={props.isDisabled}
      style={props.style ? props.style : null}
    >
      <h2 style={{ ...props?.textStyles, ...{ width: "100%" } }}>{props.label}</h2>
      {props.ButtonBody ? props.ButtonBody : ""}
    </button>
  );
};

ButtonSelector.propTypes = {
  /**
   * ButtonSelector content
   */
  label: PropTypes.string.isRequired,
  /**
   * button border theme
   */
  theme: PropTypes.string,
  /**
   * click handler
   */
  onSubmit: PropTypes.func,
  /**
   * CustomBody
   */
  ButtonBody: PropTypes.any
};

ButtonSelector.defaultProps = {
  label: "",
  theme: "",
  onSubmit: undefined,
  ButtonBody: undefined
};

export default ButtonSelector;
