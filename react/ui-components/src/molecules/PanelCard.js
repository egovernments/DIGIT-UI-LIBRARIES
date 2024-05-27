import React, { Fragment, useEffect } from "react";
import PropTypes from "prop-types";
import { Panels } from "../atoms";

const PanelCard = (props) => {
  const [isMobileView, setIsMobileView] = React.useState(
    window.innerWidth <= 480
  );
  const onResize = () => {
    if (window.innerWidth <= 480) {
      if (!isMobileView) {
        setIsMobileView(true);
      }
    } else {
      if (isMobileView) {
        setIsMobileView(false);
      }
    }
  };
  useEffect(() => {
    window.addEventListener("resize", () => {
      onResize();
    });
    return () => {
      window.addEventListener("resize", () => {
        onResize();
      });
    };
  });

  const allowedFooter = props?.footerChildren.slice(
    0,
    props?.maxFooterButtonsAllowed || 5
  );

  const sortedFooterButtons = [...allowedFooter].sort((a, b) => {
    const typeOrder = { primary: 3, secondary: 2, tertiary: 1 };
    const getTypeOrder = (button) =>
      typeOrder[(button.props.variation || "").toLowerCase()];
    return getTypeOrder(a) - getTypeOrder(b);
  });

  const finalFooterArray = props?.sortFooterButtons
    ? isMobileView
      ? sortedFooterButtons.reverse()
      : sortedFooterButtons
    : allowedFooter;

  return (
    <div
      className={`digit-panelcard-wrap ${
        props?.cardClassName ? props?.cardClassName : ""
      }`}
      style={props?.cardStyles}
    >
      <Panels {...props}></Panels>
      <div
        className={`digit-panelcard-children-wrap ${
          props?.showChildrenInline ? "inline" : ""
        }`}
      >
        {props?.description && (
          <div className="digit-panelcard-description">
            {props?.description}
          </div>
        )}
        {props?.children}
      </div>
      <div
        className={`digit-panelcard-footer ${
          props?.footerclassName ? props?.footerclassName : ""
        }`}
      >
        {finalFooterArray}
      </div>
    </div>
  );
};

PanelCard.propTypes = {
  className: PropTypes.string,
  style: PropTypes.object,
  children: PropTypes.node,
  footerChildren: PropTypes.node,
  message: PropTypes.string,
  type: PropTypes.string,
  info: PropTypes.string,
  response: PropTypes.string,
  customIcon: PropTypes.string,
  iconFill: PropTypes.string,
  panelStyles: PropTypes.object,
  multipleResponses: PropTypes.array,
};

export default PanelCard;
