import React, { useState, useEffect } from "react";

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

  const handleStateChange = () => {
    switch (state) {
      case "closed":
        setState("fixed");
        break;
      case "fixed":
        setState("quarter");
        break;
      case "quarter":
        setState("intermediate");
        break;
      case "intermediate":
        setState("full");
        break;
      case "full":
        setState("closed");
        break;
      default:
        setState("closed");
    }
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
            equalWidthButtons ? "euqalButtons" : ""
          }`}
        >
          {actions}
        </div>
      )}
    </div>
  );
};

export default BottomSheet;
