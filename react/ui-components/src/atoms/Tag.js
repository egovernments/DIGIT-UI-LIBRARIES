import React from "react";
import PropTypes from "prop-types";
import { SVG } from "./SVG";
import { Colors } from "../constants/colors/colorconstants";

const Tag = ({
  className,
  label,
  style,
  type,
  icon,
  stroke,
  showIcon,
  labelStyle,
  onClick,
  alignment,
}) => {
  const MonochromeIconColor = Colors.lightTheme.primary[2];
  const SuccessIconColor = Colors.lightTheme.alert.success;
  const ErrorIconColor = Colors.lightTheme.alert.error;
  const WarningIconColor = Colors.lightTheme.alert.warning;

  //To render the icon
  const IconRender = () => {
    const iconFill = MonochromeIconColor;
    const iconReq = icon;
    let width = "1rem";
    let height = "1rem";
    try {
      const components = require("@egovernments/digit-ui-svg-components");
      const DynamicIcon = components?.[iconReq];
      if (DynamicIcon) {
        const svgElement = DynamicIcon({
          width: width,
          height: height,
          fill: iconFill,
          className: `digit-tag-customIcon`,
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

  let iconToShow;
  if (icon) {
    iconToShow = IconRender();
  } else {
    switch (type) {
      case "error":
        iconToShow = (
          <SVG.Error fill={ErrorIconColor} width={"1rem"} height={"1rem"} />
        );
        break;
      case "warning":
        iconToShow = (
          <SVG.Warning fill={WarningIconColor} width={"1rem"} height={"1rem"} />
        );
        break;
      default:
        iconToShow = (
          <SVG.CheckCircle
            fill={type==="success" ? SuccessIconColor : MonochromeIconColor}
            width={"1rem"}
            height={"1rem"}
          />
        );
    }
  }

  return (
    <div
      className={`digit-tag-wrapper ${className ? className : ""} ${
        type || ""
      } ${stroke ? "stroke" : ""} ${onClick ? "cp" : ""} ${
        alignment ? alignment : ""
      }`}
      style={style}
      onClick={onClick}
    >
      {showIcon && iconToShow}
      <span className="digit-tag-text" style={labelStyle}>
        {label}
      </span>
    </div>
  );
};

Tag.propTypes = {
  className: PropTypes.string,
  label: PropTypes.string.isRequired,
  style: PropTypes.object,
  stroke: PropTypes.bool,
  type: PropTypes.string,
};

Tag.defaultProps = {
  className: "",
  style: {},
  type: "monochrome",
  stroke: false,
  showIcon: true,
  labelStyle: {},
  alignment: "center",
};

export default Tag;
