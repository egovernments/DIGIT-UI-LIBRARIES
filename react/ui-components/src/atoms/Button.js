import React from "react";
import PropTypes from "prop-types";
import StringManipulator from "./StringManipulator";

const Button = (props) => {
  
  //To render the icon
  const IconRender = () => {
    const iconFill =
      props?.variation === "primary"
        ? "#FFFFFF"
        : props?.isDisabled
        ? "#B1B4B6"
        : "#F47738";
    const iconReq = props?.icon;
    const width = props?.variation === "link" ? "1.25" : "1.5rem";
    const height = props?.variation === "link" ? "1.25" : "1.5rem";
    try {
      const components = require("@egovernments/digit-ui-svg-components");
      const DynamicIcon = components?.[iconReq];
      if (DynamicIcon) {
        const svgElement = DynamicIcon({
          width: width,
          height: height,
          fill: iconFill,
          className: "digit-button-customIcon",
        });
        return svgElement;
      } else {
        console.log("Icon not found");
        return null;
      }
    } catch (error) {
      console.error("Icon not found");
      return null;
    }
  };

  const icon = IconRender();

  const formattedLabel =
    props?.variation === "link"
      ? props?.label
      : StringManipulator(
          "capitalizeFirstLetter",
          StringManipulator("truncateString", props?.label, {
            maxLength: 64,
          })
        );

  return (
    <button
      ref={props?.ref}
      className={`digit-button-${
        props?.variation ? props?.variation : "default"
      } ${props?.className ? props?.className : ""} ${
        props?.isDisabled ? "disabled" : ""
      }`}
      type={props?.submit ? "submit" : props.type || "button"}
      form={props.formId}
      onClick={props.onClick}
      disabled={props?.isDisabled || null}
      style={props.style ? props.style : null}
    >
      <div
        className={`icon-label-container ${
          props?.variation ? props?.variation : ""
        }`}
      >
        {!props?.isSuffix && props?.icon && icon}
        <h2 style={{ ...props?.textStyles }} className="digit-button-label">
          {formattedLabel}
        </h2>
        {props?.isSuffix && props?.icon && icon}
      </div>
    </button>
  );
};

Button.propTypes = {
  isDisabled: PropTypes.bool,
  /**
   * ButtonSelector content
   */
  label: PropTypes.string.isRequired,
  /**
   * button border theme
   */
  variation: PropTypes.string,
  /**
   * button icon if any
   */
  icon: PropTypes.string,
  /**
   * click handler
   */
  onClick: PropTypes.func.isRequired,
  /**
   * Custom classname
   */
  className: PropTypes.string,
  /**
   * Custom styles
   */
  style: PropTypes.object,
  /**
   * Custom label style or h2 style
   */
  textStyles: PropTypes.object,
  /**
   * button icon position
   */
  isSuffix: PropTypes.bool,
};

Button.defaultProps = {
  label: "TEST",
  variation: "primary",
  onClick: () => {},
};

export default Button;
