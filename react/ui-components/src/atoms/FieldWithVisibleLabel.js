import React from "react";
import LabelFieldPair from "./LabelFieldPair";
import HeaderComponent from "./HeaderComponent";
import StringManipulator from "./StringManipulator";

// Opt-in visible label shared by TextInput, Dropdown and MultiSelectDropdown (`label` + `showLabel` props).
// Renders the same markup as FieldV1: LabelFieldPair › label block (<label htmlFor> + "*" when required) › div.digit-field.
// When `show` is false the children are rendered unchanged, with no extra wrappers.
const FieldWithVisibleLabel = ({ show, label, labelId, htmlFor, required, disabled, nonEditable, populators, t, children }) => {
  if (!show) return <React.Fragment>{children}</React.Fragment>;

  return (
    <LabelFieldPair
      removeMargin={true}
      vertical={populators?.alignFieldPairVertically}
      className={`digit-formcomposer-fieldpair-textinput ${populators?.fieldPairClassName || ""}`}
    >
      <HeaderComponent className={`label ${disabled ? "disabled" : ""} ${nonEditable ? "noneditable" : ""}`}>
        <div className="label-container">
          <label id={labelId} htmlFor={htmlFor} className="label-styles">
            {StringManipulator(
              "TOSENTENCECASE",
              StringManipulator("TRUNCATESTRING", t ? t(label) : label, {
                maxLength: 64,
              })
            )}
          </label>
          <div style={{ color: "#B91900" }}>{required ? " * " : null}</div>
        </div>
      </HeaderComponent>
      <div className="digit-field">{children}</div>
    </LabelFieldPair>
  );
};

export default FieldWithVisibleLabel;
