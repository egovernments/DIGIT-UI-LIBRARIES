import React, { useState} from "react";
import PropTypes from "prop-types";
import TextInput from "./TextInput";

const translateDummy = (text) => {
  return text;
};

const Menu = (props) => {
  const [searchTerm, setSearchTerm] = useState("");
  const [optionIndex, setOptionIndex] = useState(-1);
  const [isActive, setIsActive] = useState(-1);
  const t = props.t || translateDummy;

  const handleSearch = (e) => {
    setSearchTerm(e.target.value);
  };

  const searchFilteredOptions = props?.options.filter((option) =>
    option[props?.optionsKey].toLowerCase().includes(searchTerm.toLowerCase())
  );

  const onSelect = (val) => {
    props.onSelect(val);
    props.setDropdownStatus(false); 
  };

  const IconRender = (iconReq, isActive) => {
    const iconFill = isActive ? "#FFFFFF" : "#505A5F";
    try {
      const components = require("@egovernments/digit-ui-svg-components");
      const DynamicIcon = components?.[iconReq];
      if (DynamicIcon) {
        const svgElement = DynamicIcon({
          width: "1.25rem",
          height: "1.25rem",
          fill: iconFill,
          className: "",
        });
        return svgElement;
      } else {
        console.log("Icon not found");
        return null;
      }
    } catch (error) {
      console.error("Icon not found");
      return null;
    }
  };


  return (
    <div
      className={`header-dropdown-menu ${
        props?.footerdropdown ? "footer-dropdown" : ""
      } ${props?.showBottom ? "showBottom" : ""}`}
      ref={props?.ref}
      style={props?.style}
    >
      {props?.isSearchable && (
        <div className="header-dropdown-search-container">
          <TextInput
            type="search"
            className="header-dropdown-search"
            value={searchTerm}
            onChange={handleSearch}
            placeholder="Search"
            autoFocus={true}
          ></TextInput>
        </div>
      )}
      <div className="header-dropdown-options" id="header-dropdown-unique">
        {searchFilteredOptions.length !== 0 ? (
          searchFilteredOptions.map((option, index) => (
            <div
              key={index}
              className={`header-dropdown-option ${
                index === isActive ? "activeIndex" : ""
              } ${index === optionIndex ? "keyChange" : ""}`}
              onClick={() => onSelect(option)}
            >
              {IconRender(option?.icon, index === isActive)}
              {option[props?.optionsKey]}
            </div>
          ))
        ) : (
          <div className="header-dropdown-nooption">{t("No Results Found")}</div>
        )}
      </div>
    </div>
  );
};

Menu.propTypes = {
  options: PropTypes.array,
  showBottom: PropTypes.bool,
  isSearchable: PropTypes.bool,
  style: PropTypes.object,
  optionsKey: PropTypes.string.isRequired,
  onSelect: PropTypes.func.isRequired
};

Menu.defaultProps = {
  options: [],
  onSelect: () => {},
};

export default Menu;
