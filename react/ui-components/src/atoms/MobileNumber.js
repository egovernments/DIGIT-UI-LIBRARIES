import React, { useState, useEffect, useMemo } from "react";
import PropTypes from "prop-types";
import TextInput from "./TextInput";
import Dropdown from "./Dropdown";
import { getUserType } from "../utils/digitUtils";

// Default fallback values when countryCodeConfig is not provided
const FALLBACK_MODULE_NAME = "common-masters";
const FALLBACK_MASTER_NAME = "CountryCodes";
const FALLBACK_DEFAULT_COUNTRY_CODE = "+91";

const MobileNumber = (props) => {
  const user_type = getUserType();
  const { showCountryCodeDropdown, countryCodeConfig } = props;

  // Resolving config with fallback values
  const resolvedModuleName = countryCodeConfig?.moduleName || FALLBACK_MODULE_NAME;
  const resolvedMasterName = countryCodeConfig?.masterName || FALLBACK_MASTER_NAME;
  const resolvedDefaultCode = countryCodeConfig?.defaultCountryCode || FALLBACK_DEFAULT_COUNTRY_CODE;

  // Get stateId
  let stateId = "";
  try {
    stateId = Digit?.ULBService?.getStateId?.() || window?.globalConfigs?.getConfig?.("STATE_LEVEL_TENANT_ID") || "";
  } catch (e) {
    stateId = "";
  }

  // Only enabling MDMS call when dropdown is requested and stateId is available
  const isMdmsEnabled = Boolean(showCountryCodeDropdown && stateId);

  const mdmsResult = Digit?.Hooks?.useCustomMDMS?.(
    stateId,
    resolvedModuleName,
    [{ name: resolvedMasterName }],
    {
      select: (data) => {
          const optionsData =
            data?.[resolvedModuleName]?.[resolvedMasterName] || [];
          return optionsData
            .filter((opt) =>opt?.hasOwnProperty("active") ? opt.active : true)
            .map((opt) => ({
              ...opt,
              displayLabel: `${opt.dialCode} ${opt.name}`,
            }));
        },
        enabled: isMdmsEnabled,
      staleTime: 300000,
    }
  ) || { isLoading: false, data: [] };

  const countryCodeOptions = mdmsResult?.data || [];

  const [selectedCountryCode, setSelectedCountryCode] = useState(null);

  // Parse country code from a combined value like "+919876543210"
  const parseCountryCodeFromValue = (combinedValue, options) => {
    if (!combinedValue || !options?.length) return null;
    const valStr = String(combinedValue);
    // Sort by dialCode length descending to match longest first (e.g., "+355" before "+3")
    const sorted = [...options].sort((a, b) => b.dialCode.length - a.dialCode.length);
    for (const opt of sorted) {
      if (valStr.startsWith(opt.dialCode)) {
        return opt;
      }
    }
    return null;
  };

  // Find the default country code object from options
  const defaultOption = useMemo(() => {
    return (countryCodeOptions?.find((opt) => opt.dialCode === resolvedDefaultCode) || null);
  }, [countryCodeOptions, resolvedDefaultCode]);

  // Initialize selected country code once options load
  useEffect(() => {
    if (showCountryCodeDropdown && countryCodeOptions?.length > 0 && !selectedCountryCode) {
      const existingCode = parseCountryCodeFromValue(props.value, countryCodeOptions);
      setSelectedCountryCode(existingCode || defaultOption);
    }
  }, [countryCodeOptions, defaultOption, showCountryCodeDropdown]);

  // Extract the raw number part (without country code) for display in the input
  const getRawNumber = () => {
    if (!showCountryCodeDropdown || !selectedCountryCode) {
      return props.value || "";
    }
    const valStr = String(props.value || "");
    if (valStr.startsWith(selectedCountryCode.dialCode)) {
      return valStr.slice(selectedCountryCode.dialCode.length);
    }
    return valStr;
  };

  const onChange = (e) => {
    let val = e.target.value;
    if (isNaN(val) || [" ", "e", "E"].some((ch) => val.includes(ch)) || val.length > (props.maxLength || 10)) {
      val = val.slice(0, -1);
    }
    if (showCountryCodeDropdown && selectedCountryCode) {
      props?.onChange?.(selectedCountryCode.dialCode + val);
    } else {
      props?.onChange?.(val);
    }
  };

  const onCountryCodeChange = (selectedOption) => {
    setSelectedCountryCode(selectedOption);
    const rawNumber = getRawNumber();
    props?.onChange?.(selectedOption.dialCode + rawNumber);
  };

  // Determining if we should render the dropdown
  // Only show if enabled AND we have options loaded
  const shouldShowDropdown = showCountryCodeDropdown && countryCodeOptions?.length > 0;

  return (
    <React.Fragment>
      <div
        className={`digit-mobile-number-container ${shouldShowDropdown ? "has-country-dropdown" : ""} ${props?.className ? props?.className : ""}`}
        style={props?.style}
      >
        {shouldShowDropdown && (
          <div className="digit-country-code-dropdown">
            <Dropdown
              option={countryCodeOptions || []}
              optionKey="displayLabel"
              selected={selectedCountryCode}
              select={onCountryCodeChange}
              isSearchable={true}
              disabled={props.disable}
              placeholder={resolvedDefaultCode}
              t={(text) => text}
              disablePortal={true}
              optionCardStyles={{
                width: "max-content",
                minWidth: "12rem",
                maxHeight: "20rem",
                overflow: "auto",
                zIndex: 999,
              }}
            />
          </div>
        )}
        <div
          className={`digit-text-input-field ${user_type === "employee" ? "" : "digit-text-mobile-input-width"} ${props.className ? props.className : ""}`}
        >
          <TextInput
            userType={props.userType}
            isMandatory={props.isMandatory}
            name={props.name}
            placeholder={props.placeholder}
            onChange={onChange}
            inputRef={props.inputRef}
            value={shouldShowDropdown ? getRawNumber() : props.value}
            id={props?.id}
            className={props.className}
            style={{ ...props.style }}
            maxLength={props.maxLength}
            minlength={props.minlength}
            max={props.max}
            pattern={props.pattern}
            min={props.min}
            disabled={props.disable}
            hideSpan={shouldShowDropdown ? true : props.hideSpan}
            title={props.title}
            step={props.step}
            autoFocus={props.autoFocus}
            onBlur={props.onBlur}
            variant={props?.variant}
            populators={
              !shouldShowDropdown && !props.hideSpan
                ? { prefix: props?.prefix || "" }
                : {}
            }
            screenPath={props?.screenPath}
            composerType={props?.composerType}
            composerId={props?.composerId}
            sectionId={props?.sectionId}
          />
        </div>
      </div>
    </React.Fragment>
  );
};

MobileNumber.propTypes = {
  userType: PropTypes.string,
  isMandatory: PropTypes.bool,
  name: PropTypes.string,
  placeholder: PropTypes.string,
  onChange: PropTypes.func,
  inputRef: PropTypes.oneOfType([PropTypes.func, PropTypes.shape({ current: PropTypes.instanceOf(Element) })]),
  value: PropTypes.any,
  className: PropTypes.string,
  style: PropTypes.object,
  maxLength: PropTypes.number,
  minlength: PropTypes.number,
  max: PropTypes.number,
  pattern: PropTypes.string,
  min: PropTypes.number,
  disable: PropTypes.bool,
  errorStyle: PropTypes.bool,
  hideSpan: PropTypes.bool,
  title: PropTypes.string,
  step: PropTypes.string,
  autoFocus: PropTypes.bool,
  onBlur: PropTypes.func,
  showCountryCodeDropdown: PropTypes.bool,
  countryCodeConfig: PropTypes.shape({
    moduleName: PropTypes.string,
    masterName: PropTypes.string,
    defaultCountryCode: PropTypes.string,
  }),
};

MobileNumber.defaultProps = {
  isMandatory: false,
  showCountryCodeDropdown: false,
};

export default MobileNumber;
