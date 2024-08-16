import React, { useState, useEffect } from "react";
import PropTypes from 'prop-types';

const BottomSheet = ({
  children,
  initialState = "closed",
  enableActions,
  actions,
  equalWidthButtons,
  className,
  style
}) => {
  const [state, setState] = useState(initialState);

  useEffect(() => {
    setState(initialState);
  }, [initialState]);

  const stateTransitions = {
    closed: 'fixed',
    fixed: 'quarter',
    quarter: 'intermediate',
    intermediate: 'full',
    full: 'closed',
  };
  
  const handleStateChange = () => {
    setState(stateTransitions[state] || 'closed');
  };

  return (
    <div
      className={`digit-bottom-sheet ${state} ${
        enableActions ? "actionsEnabled" : ""
      } ${className || ""}`}
      style={style}
    >
      {state !== "full" && (
        <div
          className={`digit-bottom-sheet-header ${state} ${
            enableActions ? "actionsEnabled" : ""
          }`}
          onClick={handleStateChange}
        >
          <div
            className={`digit-bottom-sheet-handle-indicator ${
              enableActions ? "actionsEnabled" : ""
            }`}
          ></div>
        </div>
      )}
      {state !== "closed" && (
        <div
          className={`digit-bottom-sheet-content ${
            enableActions ? "actionsEnabled" : ""
          }`}
        >
          {children}
        </div>
      )}
      {enableActions && (
        <div
          className={`digit-bottom-sheet-actions ${
            equalWidthButtons ? "equalButtons" : ""
          }`}
        >
          {actions}
        </div>
      )}
    </div>
  );
};

export default BottomSheet;

BottomSheet.propTypes = {
  children: PropTypes.node,
  initialState: PropTypes.oneOf(['closed', 'fixed', 'quarter', 'intermediate', 'full']),
  enableActions: PropTypes.bool,
  actions: PropTypes.node,
  equalWidthButtons: PropTypes.bool,
  className: PropTypes.string,
  style: PropTypes.object,
};