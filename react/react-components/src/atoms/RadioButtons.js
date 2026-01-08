import React, { useEffect, useState } from "react";
import PropTypes from "prop-types";
import isEqual from "lodash/isEqual";
import { useTranslation } from "react-i18next";

const RadioButtons = (props) => {
  const { t } = useTranslation();
  var selected = props.selectedOption;
  function selectOption(value) {
    //selected = value;
    props.onSelect(value);
  }

  // Generate unique ID for tracking (single source of truth)
  // ID Pattern: screenPath + composerType + composerId + sectionId + name + type + optionIndex
  const generateRadioId = (optionIndex, optionCode) => {
    return Digit?.Utils?.generateUniqueId?.({
      screenPath: props?.screenPath || "",
      composerType: props?.composerType || "standalone",
      composerId: props?.composerId || "",
      sectionId: props?.sectionId || "",
      name: props?.name || "radio",
      type: `radio-${optionCode || optionIndex}`,
      id: props?.id ? `${props.id}-${optionIndex}` : ""
    }) || `${props?.name || "radio"}-${optionIndex}`;
  };

  return (
    <div style={props.style} className={`radio-wrap ${props?.additionalWrapperClass}`}>
      {props?.options?.map((option, ind) => {
        if (props?.optionsKey && !props?.isDependent) {
          return (
            <div style={props.innerStyles} key={ind}>
              <span className="radio-btn-wrap">
                <input
                  id={generateRadioId(ind, option?.code)}
                  className="radio-btn"
                  type="radio"
                  value={option}
                  checked={(props.isPTFlow && selected?.code === option.code) || isEqual(selected, option) ? 1 : 0}
                  onChange={() => selectOption(option)}
                  disabled={props?.disabled || props?.disable}
                  name={props.name}
                  ref={props.inputRef}
                />
                <span className="radio-btn-checkmark"></span>
              </span>
              <label style={props.inputStyle}>{t(option[props.optionsKey])}</label>
            </div>
          );
        } else if (props?.optionsKey && props?.isDependent) {
          return (
            <div style={props.innerStyles} key={ind}>
              <span className="radio-btn-wrap">
                <input
                  id={generateRadioId(ind, option?.code)}
                  className="radio-btn"
                  type="radio"
                  value={option}
                  checked={selected?.code === option.code ? 1 : 0}
                  onChange={() => selectOption(option)}
                  disabled={props?.disabled || props?.disable}
                  name={props.name}
                  ref={props.inputRef}
                />
                <span className="radio-btn-checkmark"></span>
              </span>
              <label style={props.inputStyle}>{t(props.labelKey ? `${props.labelKey}_${option.code}` : option.code)}</label>
            </div>
          );
        } else {
          return (
            <div style={props.innerStyles} key={ind}>
              <span className="radio-btn-wrap">
                <input
                  id={generateRadioId(ind, option)}
                  className="radio-btn"
                  type="radio"
                  value={option}
                  checked={selected === option ? 1 : 0}
                  onChange={() => selectOption(option)}
                  disabled={props?.disabled || props?.disable}
                  name={props.name}
                  ref={props.inputRef}
                />
                <span className="radio-btn-checkmark"></span>
              </span>
              <label style={props.inputStyle}>{t(option)}</label>
            </div>
          );
        }
      })}
    </div>
  );
};

RadioButtons.propTypes = {
  selectedOption: PropTypes.any,
  onSelect: PropTypes.func,
  options: PropTypes.any,
  optionsKey: PropTypes.string,
  innerStyles: PropTypes.any,
  style: PropTypes.any,
};

RadioButtons.defaultProps = {};

export default RadioButtons;
