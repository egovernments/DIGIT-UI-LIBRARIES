import React from "react";
import { SVG } from "./SVG";
import PropTypes from "prop-types";
import Animation from "./Animation";
import successAnimation from "../animations/success.json";
import errorAnimation from "../animations/error.json";

const Panels = (props) => {
  const IconRender = (iconReq, iconFill) => {
    const fill = iconFill || "#FFFFFF";

    try {
      const components = require("@egovernments/digit-ui-svg-components");
      const DynamicIcon = components?.[iconReq];
      if (DynamicIcon) {
        const svgElement = DynamicIcon({
          width: "56px",
          height: "56px",
          fill: fill,
          className: "digit-panel-customIcon",
        });
        return svgElement;
      } else {
        console.error("Icon not found");
        return null;
      }
    } catch (error) {
      console.error("Icon not found");
      return null;
    }
  };

  const icon = IconRender(props?.customIcon, props?.iconFill);

  return (
    <div
      className={`digit-panel-wrapper ${
        props?.className ? props?.className : ""
      } ${props?.type ? props?.type : ""}`}
      style={props?.style}
    >
      <div className="digit-panel-message-wrapper">
        {props?.type === "success" ? (
          props?.customIcon ? (
            icon
          ) : props?.showAsSvg ? (
            <SVG.CheckCircleOutline
              fill={"#FFFFFF"}
              width={"56px"}
              height={"56px"}
            ></SVG.CheckCircleOutline>
          ) : (
            <Animation
              animationData={successAnimation}
              width={props?.animationProps?.width || 56}
              height={props?.animationProps?.height || 56}
              loop={props?.animationProps?.loop}
              autoplay={props?.animationProps?.autoplay}
            ></Animation>
          )
        ) : props?.customIcon ? (
          icon
        ) : props?.showAsSvg ? (
          <SVG.ErrorOutline
            fill={"#FFFFFF"}
            width={"56px"}
            height={"56px"}
          ></SVG.ErrorOutline>
        ) : (
          <Animation
            animationData={errorAnimation}
            width={props?.animationProps?.width || 56}
            height={props?.animationProps?.height || 56}
            loop={props?.animationProps?.loop}
            autoplay={props?.animationProps?.autoplay}
          ></Animation>
        )}
        <div className="digit-panel-message">{props?.message}</div>
      </div>
      <div className="digit-panel-info-wrapper">
        <div className="digit-panel-info">{props?.info}</div>
        <div className="digit-panel-response">{props?.response}</div>
        {props?.multipleResponses && (
          <div className="digit-panel-multiple-responses">
            {props?.multipleResponses.map((response) => (
              <div className="digit-panel-response">{response}</div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

Panels.propTypes = {
  className: PropTypes.string,
  message: PropTypes.string,
  type: PropTypes.string,
  info: PropTypes.string,
  response: PropTypes.string,
  customIcon: PropTypes.string,
  iconFill: PropTypes.string,
  style: PropTypes.object,
  multipleResponses: PropTypes.array,
};

Panels.defaultProps = {
  type: "success",
};

export default Panels;
