import React from "react";
import PropTypes from "prop-types";

const HeaderComponent = (props) => {
  // Not a <header>: that is an implicit banner landmark and this component is rendered inside
  // page content, producing nested / duplicate banners in accessibility scans.
  return (
    <div className={`digit-header-content ${props?.className || ""}`} style={props?.styles || {}}>
      {props.children}
    </div>
  );
};

HeaderComponent.propTypes = {
  className: PropTypes.string,
  styles: PropTypes.object,
  children: PropTypes.node,
};

export default HeaderComponent;
