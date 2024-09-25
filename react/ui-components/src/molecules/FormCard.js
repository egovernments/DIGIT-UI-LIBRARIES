import React, { Children } from "react";
import PropTypes from "prop-types";
import { useLocation } from "react-router-dom";
import { Card, StringManipulator, Divider, CustomSVG } from "../atoms";

const FormCard = ({
  type,
  style = {},
  children,
  className,
  layout,
  headerData,
  euqalWidthButtons,
  withDivider,
  footerData,
  ...props
}) => {
  // Parse the layout prop to determine rows and columns
  const [rows, columns] = layout ? layout.split("*").map(Number) : "1*1";

  // Create grid template strings dynamically
  const gridTemplateColumns = `repeat(${columns}, 1fr)`;
  const gridTemplateRows = `repeat(${rows}, 1fr)`;

  // Inline styles for the grid layout
  const gridStyles = {
    display: "grid",
    gridTemplateColumns,
    gridTemplateRows,
    ...style,
  };

    const childrenWithDividers = React.Children.map(children, (child, index) => {
      const isEndOfRow = (index + 1) % columns === 0; 
      return (
        <React.Fragment key={index}>
          {child}
          {!isEndOfRow && withDivider && (
            <div
              className="vertical-formcard-divider"
              style={{
                left: `calc(100% / ${columns} * ${(index % columns) + 1})`,
              }}
            />
          )}
        </React.Fragment>
      );
    });

  return (
    <div className={`digit-form-card ${className || ""}`}>
      {headerData && (
        <div className={`digit-form-card-header`}>{headerData}</div>
      )}
      <div
        className={`digit-form-card-content ${
          !footerData || footerData.length <= 0 || footerData === undefined
            ? "withoutFooter"
            : ""
        }`}
        style={gridStyles}
      >
        {/* {children} */}
        {childrenWithDividers}
      </div>
      {footerData && (
        <div className={`digit-form-card-footer`}>
          {/* {footerData} */}
          <div
            className={`digit-form-card-buttons ${
              props?.equalButtons ? "equal-buttons" : ""
            }`}
          >
            {footerData}
          </div>
        </div>
      )}
    </div>
  );
};

FormCard.propTypes = {
  type: PropTypes.string,
  style: PropTypes.object,
  className: PropTypes.string,
  children: PropTypes.node,
};
export default FormCard;
