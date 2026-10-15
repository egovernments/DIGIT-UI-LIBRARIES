import React from "react";
import PropTypes from "prop-types";
import { SVG } from "./SVG";
import ErrorMessage from "./ErrorMessage";
import { Colors} from "../constants/colors/colorconstants";
import { iconRender } from "../utils/iconRender";

const Chip = ({
  className,
  text,
  onTagClick,
  onClick,
  extraStyles,
  disabled = false,
  isErrorTag,
  error,
  hideClose,
  onErrorClick,
  iconReq
}) => {
  const tagStyles = extraStyles ? extraStyles?.tagStyles : {};
  const textStyles = extraStyles ? extraStyles?.textStyles : {};
  const closeIconStyles = extraStyles ? extraStyles?.closeIconStyles : {};
  const IconColor = Colors.lightTheme.paper.primary;

  const IconRender = (iconReq,isErrorTag) => {
    const iconFill = isErrorTag ? "#B91900" : "#787878";
    return iconRender(
      iconReq,
      iconFill,
      "1.25rem",
      "1.25rem",
      ""
    );
  };

  return (
    <div
      className={`digit-tag-error-container ${
        !disabled && onTagClick ? "cp" : ""
      }`}
      // Opening the chip and removing it are two separate actions, so they must be two separate
      // controls. This wrapper stays a plain clickable container - as a role="button" it would
      // contain the remove button and the error button (axe nested-interactive), and ARIA would
      // discard their labels into its own name. The semantics live on the text below instead;
      // the onClick stays here so clicking anywhere on the chip still opens it.
      onClick={disabled ? null : onTagClick}
      aria-disabled={disabled ? "true" : undefined}
    >
      <div
        className={`digit-tag ${isErrorTag ? "errortag" : ""} ${hideClose ? "noClose" : ""} ${!iconReq ? "noIcon" : ""} ${onTagClick || onClick ? "clickable" : ""} ${
          className ? className : ""
        }`}
        style={tagStyles}
        role="group"
        aria-label={`${text}${isErrorTag ? " error" : ""} chip${!hideClose ? " with remove button" : ""}`}
      >
        {iconReq && IconRender(iconReq,isErrorTag)}
        {/* The control that opens the chip. A sibling of the remove button below rather than its
            ancestor, so neither sits inside the other. Still a span with the same class, so the
            styling is untouched; the keyboard handler is the one moved off the wrapper. */}
        <span
          className="digit-text"
          style={textStyles}
          role={onTagClick ? "button" : undefined}
          tabIndex={onTagClick && !disabled ? 0 : undefined}
          onKeyDown={(e) => {
            if ((e.key === "Enter" || e.key === " ") && onTagClick && !disabled) {
              e.preventDefault();
              onTagClick(e);
            }
          }}
          aria-label={onTagClick ? `${text} chip` : undefined}
        >
          {text}
        </span>
        {!hideClose && (
          <span
            onClick={disabled ? null : onClick}
            role="button"
            tabIndex={disabled ? -1 : 0}
            onKeyDown={(e) => {
              if ((e.key === "Enter" || e.key === " ") && onClick && !disabled) {
                e.preventDefault();
                onClick(e);
              }
            }}
            className={`close-icon ${disabled ? "disabled" : ""} ${hideClose ? "hideClose" : ""}`}
            aria-label={`Remove ${text}`}
            aria-disabled={disabled ? "true" : undefined}
          >
            <SVG.Close fill={IconColor} className="close" style={closeIconStyles} />
        </span>
        )}
      </div>
      {error && (
        <div
          className={`${onErrorClick ? "cp" : "nonclickable"}`}
          onClick={onErrorClick}
          role={onErrorClick ? "button" : "alert"}
          tabIndex={onErrorClick ? 0 : undefined}
          onKeyDown={(e) => {
            if ((e.key === "Enter" || e.key === " ") && onErrorClick) {
              e.preventDefault();
              onErrorClick(e);
            }
          }}
          aria-label={onErrorClick ? "View error message" : undefined}
          aria-live="assertive"
        >
          <ErrorMessage
            message={error}
            truncateMessage={true}
            maxLength={256}
            className="digit-tag-error-message"
            wrapperClassName="digit-tag-error"
            showIcon={true}
          />
        </div>
      )}
    </div>
  );
};

Chip.propTypes = {
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
  hideClose:PropTypes.bool
};


Chip.defaultProps = {
  hideClose:true
};


export default Chip;
