import React, { useState, useEffect } from "react";
import FilterCard from "../FilterCard";
import { LabelFieldPair } from "../../atoms";
import { RadioButtons } from "../../atoms";
import { TextBlock } from "../../atoms";
import { TextInput } from "../../atoms";
import { Dropdown } from "../../atoms";
import { CheckBox } from "../../atoms";
import { MultiSelectDropdown } from "../../atoms";
import { Button } from "../../atoms";

// Story metadata
export default {
  title: "Molecules/Card/FilterCard/Vertical",
  component: FilterCard,
  argTypes: {
    title: { control: "text" },
    titleIcon: { control: "text" },
    primaryActionLabel: { control: "text" },
    secondaryActionLabel: { control: "text" },
    layoutType: {
      control: {
        type: "select",
        options: ["horizontal", "vertical"],
      },
    },
    equalWidthButtons: { control: "boolean" },
    addClose: { control: "boolean" },
    className: { control: "text" },
    style: { control: "object" },
    hideIcon: { control: "boolean" },
    isPopup: { control: "boolean" },
    onClose: { action: "onChange" },
    onOverlayClick: {
      control: "function",
    }
  },
};

// Template for the story
const Template = (args) => <FilterCard {...args} />;

const genderOptions = [
  { code: "M", name: "Male" },
  { code: "F", name: "Female" },
  { code: "O", name: "Others" },
];

const children = [
  <LabelFieldPair vertical={true}>
    <TextBlock body={"Name"}></TextBlock>
    <TextInput type="text"></TextInput>
  </LabelFieldPair>,
  <LabelFieldPair vertical={true}>
    <TextBlock body={"Value"}></TextBlock>
    <TextInput type="text"></TextInput>
  </LabelFieldPair>,
  <LabelFieldPair vertical={true}>
    <TextBlock body={"Gender"}></TextBlock>
    <RadioButtons
      alignVertical={true}
      options={genderOptions}
      optionsKey="name"
      name="gender"
      onSelect={(e) => {
        console.log(e);
      }}
      style={{
        width: "100%",
      }}
    />
  </LabelFieldPair>,
];

export const Default = Template.bind({});
Default.args = {
  title: "Filter",
  addClose: false,
  children: children,
  primaryActionLabel: "ApplyFilters",
  secondaryActionLabel: "Clear Filters",
  onPrimaryPressed: () => alert("Primary action clicked!"),
  onSecondaryPressed: () => alert("Secondary action clicked!"),
  layoutType: "vertical",
  equalWidthButtons: true,
  hideIcon: false,
};

export const WithClose = Template.bind({});
WithClose.args = {
  title: "Filter",
  addClose: true,
  children: children,
  primaryActionLabel: "ApplyFilters",
  secondaryActionLabel: "Clear Filters",
  onPrimaryPressed: () => alert("Primary action clicked!"),
  onSecondaryPressed: () => alert("Secondary action clicked!"),
  layoutType: "vertical",
  equalWidthButtons: true,
  hideIcon: false,
  onClose: (e) => {
    console.log(e);
  },
};

export const WithoutHeaderAndFooter = Template.bind({});
WithoutHeaderAndFooter.args = {
  addClose: false,
  children: children,
  layoutType: "vertical",
  hideIcon: true,
};

export const WithCustomStyles = Template.bind({});
WithCustomStyles.args = {
  title: "Filter",
  addClose: true,
  children: children,
  primaryActionLabel: "ApplyFilters",
  secondaryActionLabel: "Clear Filters",
  onPrimaryPressed: () => alert("Primary action clicked!"),
  onSecondaryPressed: () => alert("Secondary action clicked!"),
  layoutType: "vertical",
  equalWidthButtons: true,
  hideIcon: false,
  style: {
    width: "500px",
    backgroundColor:"#fafafa",
    border:"1px solid black"
  },
};

export const WithCloseAsPopup = () => {
  const [showPopup, setShowPopup] = useState(false);

  const onClose = () => {
    setShowPopup(false);
  };

  const onOverlayClick = () => {
    setShowPopup(false);
  };

  const commonStyles = {
    position: "absolute",
    top: "50%",
    left: "50%",
    color: "#363636",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    transform: "translate(-50%, -50%)",
  };

  return (
    <>
      <div style={commonStyles}>
        {
          <Button
            label={"Show FilterCard"}
            variation={"secondary"}
            onClick={() => setShowPopup(true)}
          />
        }
      </div>
      {showPopup && (
        <FilterCard
          title={"Filter"}
          addClose={true}
          primaryActionLabel={"ApplyFilters"}
          secondaryActionLabel={"Clear Filters"}
          onPrimaryPressed={() => alert("Primary action clicked!")}
          onSecondaryPressed={() => alert("Secondary action clicked!")}
          layoutType={"vertical"}
          equalWidthButtons={true}
          hideIcon={false}
          isPopup={true}
          onClose={onClose}
          onOverlayClick={onOverlayClick}
        >
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Gender"}></TextBlock>
            <RadioButtons
              options={genderOptions}
              optionsKey="name"
              name="gender"
              onSelect={(e) => {
                console.log(e);
              }}
              style={{
                width: "100%",
              }}
            />
          </LabelFieldPair>
        </FilterCard>
      )}
    </>
  );
};


export const WithCloseAsPopupWithMoreChildren = () => {
  const [showPopup, setShowPopup] = useState(false);

  const onClose = () => {
    setShowPopup(false);
  };

  const onOverlayClick = () => {
    setShowPopup(false);
  };

  const commonStyles = {
    position: "absolute",
    top: "50%",
    left: "50%",
    color: "#363636",
    display: "flex",
    alignItems: "center",
    justifyContent: "center",
    transform: "translate(-50%, -50%)",
  };

  return (
    <>
      <div style={commonStyles}>
        {
          <Button
            label={"Show FilterCard"}
            variation={"secondary"}
            onClick={() => setShowPopup(true)}
          />
        }
      </div>
      {showPopup && (
        <FilterCard
          title={"Filter"}
          addClose={true}
          primaryActionLabel={"ApplyFilters"}
          secondaryActionLabel={"Clear Filters"}
          onPrimaryPressed={() => alert("Primary action clicked!")}
          onSecondaryPressed={() => alert("Secondary action clicked!")}
          layoutType={"vertical"}
          equalWidthButtons={true}
          hideIcon={false}
          isPopup={true}
          onClose={onClose}
          onOverlayClick={onOverlayClick}
        >
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
        </FilterCard>
      )}
    </>
  );
};