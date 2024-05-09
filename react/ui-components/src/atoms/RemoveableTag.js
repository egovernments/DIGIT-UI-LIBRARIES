import React from "react";
import PropTypes from "prop-types";
import { SVG } from "./SVG";
import ErrorMessage from "./ErrorMessage";
import StringManipulator from "./StringManipulator";

const RemoveableTag = ({
  className,
  text,
  onTagClick,
  onClick,
  extraStyles,
  disabled = false,
  isErrorTag,
  error,
}) => {
  const tagStyles =
    extraStyles && extraStyles.tagStyles ? extraStyles.tagStyles : {};
  const textStyles =
    extraStyles && extraStyles.textStyles ? extraStyles.textStyles : {};
  const closeIconStyles =
    extraStyles && extraStyles.closeIconStyles
      ? extraStyles.closeIconStyles
      : {};

  return (
    <div className={`digit-tag-error-container ${onTagClick ? "cp" : ""}`} onClick={onTagClick}>
      <div
        className={`digit-tag ${isErrorTag ? "errortag" : ""} ${
          className ? className : ""
        }`}
        style={tagStyles}
      >
        <span className="digit-text" style={textStyles}>
          {text}
        </span>
        <span onClick={disabled ? null : onClick} className="close-icon">
          <SVG.Close fill="#FFFFFF" className="close" style={closeIconStyles} />
        </span>
      </div>

      {error && (
        <div
          className="digit-tag-error"
          style={{
            whiteSpace: "pre-wrap",
            wordBreak: "break-word",
          }}
        >
          <div className="digit-error-icon" style={{ display: "flex" }}>
            <SVG.Info width="1rem" height="1rem" fill="#B91900" />
          </div>
          <ErrorMessage
            message={StringManipulator(
              "TOSENTENCECASE",
              StringManipulator("TRUNCATESTRING", error, { maxLength: 256 })
            )}
            className="digit-tag-error-message"
          />
        </div>
      )}
    </div>
  );
};

RemoveableTag.propTypes = {
  className: PropTypes.string,
  text: PropTypes.string.isRequired,
  onClick: PropTypes.func.isRequired,
  extraStyles: PropTypes.shape({
    tagStyles: PropTypes.object,
    textStyles: PropTypes.object,
    closeIconStyles: PropTypes.object,
  }),
  disabled: PropTypes.bool,
  isErrorTag: PropTypes.bool,
  error: PropTypes.string,
};

export default RemoveableTag;
