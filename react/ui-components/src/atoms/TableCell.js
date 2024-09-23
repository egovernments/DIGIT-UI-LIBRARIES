import React, { useEffect, useRef } from "react";
import PropTypes from "prop-types";
import Switch from "./Switch";
import CheckBox from "./CheckBox";
import StringManipulator from "./StringManipulator";
import Tag from "./Tag";
import Button from "./Button";
import TextInput from "./TextInput";
import Dropdown from "./Dropdown";
import MultiSelectDropdown from "./MultiSelectDropdown";

const TableCell = ({
  isHeader,
  isFooter,
  colSpan,
  className,
  columnType,
  cellData,
  children,
  style,
  cellref
}) => {

  const renderTableCell = () => {
    switch (columnType) {
      case "serialno":
        return cellData;
      case "numeric":
        return cellData;
      case "text":
      case "description":
        {
          const defaultmaxChars = columnType === "text" ? 64 : 256;
          if (typeof(cellData) === "object"){
            return (
              <div>
                {StringManipulator(
                  "TOSENTENCECASE",
                  StringManipulator("TRUNCATESTRING", cellData?.label, {
                    maxLength: cellData?.maxLength || defaultmaxChars,
                  })
                )}
              </div>
            );
          }
          return cellData;
        }
      case "tag":
        return (
          <Tag
            icon={cellData?.icon}
            label={cellData?.label}
            labelStyle={cellData?.labelStyle}
            showIcon={cellData?.showIcon}
            style={cellData?.style}
            type={cellData?.type}
            className={cellData?.className}
            stroke={cellData?.stroke}
            onClick={cellData?.onClick}
            alignment={cellData?.alignment}
            iconClassName={cellData?.iconClassName}
            iconColor={cellData?.iconColor}
          />
        );
      case "switch":
        return (
          <Switch
            isLabelFirst={cellData?.isLabelFirst}
            label={cellData?.label}
            labelStyle={cellData?.labelStyle}
            shapeOnOff={cellData?.shapeOnOff}
            style={cellData?.style}
            disable={cellData?.disable}
            className={cellData?.className}
            isCheckedInitially={cellData?.isCheckedInitially}
            onToggle={cellData?.onToggle}
          />
        );
      case "checkbox":
        return (
          <CheckBox
            onChange={cellData?.onChange}
            label={cellData?.label}
            value={cellData?.value}
            disabled={cellData?.disabled}
            ref={cellData?.ref}
            checked={cellData?.checked}
            inputRef={cellData?.inputRef}
            pageType={cellData?.pageType}
            style={cellData?.style}
            index={cellData?.index}
            isLabelFirst={cellData?.isLabelFirst}
            customLabelMarkup={cellData?.customLabelMarkup}
            hideLabel={cellData?.hideLabel}
            props={cellData?.props}
            mainClassName={cellData?.mainClassName}
          />
        );
      case "button":
        return (
          <Button
            iconFill={cellData?.iconFill}
            variation={cellData?.variation}
            type={cellData?.type}
            isDisabled={cellData?.isDisabled}
            showBottom={cellData?.showBottom}
            icon={cellData?.icon}
            size={cellData?.size}
            label={cellData?.label}
            ref={cellData?.ref}
            className={cellData?.className}
            submit={cellData?.submit}
            formId={cellData?.formId}
            onClick={cellData?.onClick}
            title={cellData?.title}
            style={cellData?.style}
            isSuffix={cellData?.isSuffix}
            textStyles={cellData?.textStyles}
            hideDefaultActionIcon={cellData?.hideDefaultActionIcon}
            options={cellData?.options}
            isSearchable={cellData?.isSearchable}
            optionsKey={cellData?.optionsKey}
            onSelect={cellData?.onOptionSelect}
            menuStyles={cellData?.menuStyles}
          />
        );
      case "textinput":
        return <TextInput {...cellData}></TextInput>;
      case "dropdown":
        return <Dropdown {...cellData}></Dropdown>;
      case "multiselectdropdown":
        return <MultiSelectDropdown {...cellData}></MultiSelectDropdown>;
      case "custom":
      default:
        return cellData;
    }
  };

  if (isHeader) {
    return (
      <th ref={cellref} colSpan={colSpan} className={className} style={style}>
        {children}
      </th>
    );
  }

  if (isFooter) {
    return (
      <td ref={cellref} colSpan={colSpan} className={className} style={style}>
        {children}
      </td>
    );
  }

  return (
    <td ref={cellref} colSpan={colSpan} className={`${className} ${columnType}`} style={style}>
      {renderTableCell()}
    </td>
  );
};


TableCell.propTypes = {
  className: PropTypes.string,
  style: PropTypes.object,
  children: PropTypes.node,
  isHeader: PropTypes.bool,
  isFooter: PropTypes.bool,
  colSpan: PropTypes.number,
  columnType: PropTypes.string,
  cellData: PropTypes.any,
  cellref: PropTypes.oneOfType([
    PropTypes.func,
    PropTypes.shape({ current: PropTypes.instanceOf(Element) }),
  ]),
};

TableCell.defaultProps = {
  className: "",
  style: {},
  children: []
};

export default TableCell;