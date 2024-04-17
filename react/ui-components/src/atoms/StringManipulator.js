import React from "react";
import PropTypes from "prop-types";

const StringManipulator = (functionName, string, props) => {
  const manipulateString = () => {
    if (!string) return null;

    switch (functionName) {
      case "toSentenceCase":
        return toSentenceCase(string);
      case "capitalizeFirstLetter":
        return capitalizeFirstLetter(string);
      case "toTitleCase":
        return toTitleCase(string);
      case "truncateString":
        return truncateString(string, props?.maxLength);
      default:
        return string;
    }
  };

  const toSentenceCase = (str) => {
    return str.toLowerCase().replace(/(^\s*\w|[\.\!\?]\s*\w)/g, (c) => {
      return c.toUpperCase();
    });
  };

  const capitalizeFirstLetter = (str) => {
    return str.replace(/\b\w/g, char => char.toUpperCase());
  };

  const toTitleCase = (str) => {
    return str.toLowerCase().replace(/\b\w|\b[^a-zA-Z0-9\s]*\w/g, (c) => {
      return c.toUpperCase();
    });
  };

  const truncateString = (str, maxLength) => {
    if (str.length > maxLength) {
      return str.slice(0, maxLength) + "...";
    }
    return str;
  };

  return manipulateString();
};

StringManipulator.propTypes = {
  functionName: PropTypes.func,
  string: PropTypes.string,
  props: PropTypes.object,
};

export default StringManipulator;
