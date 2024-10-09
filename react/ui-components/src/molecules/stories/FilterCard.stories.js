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
  title: "Molecules/Card/FilterCard",
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

const horizontalChildren = [
  <LabelFieldPair vertical={true}>
    <TextBlock body={"Name"}></TextBlock>
    <TextInput type="text"></TextInput>
  </LabelFieldPair>,
  <LabelFieldPair vertical={true}>
    <TextBlock body={"Value"}></TextBlock>
    <TextInput type="text"></TextInput>
  </LabelFieldPair>
];

export const VerticalDefault = Template.bind({});
VerticalDefault.args = {
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

export const VerticalWithClose = Template.bind({});
VerticalWithClose.args = {
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

export const VerticalWithoutHeaderAndFooter = Template.bind({});
VerticalWithoutHeaderAndFooter.args = {
  addClose: false,
  children: children,
  layoutType: "vertical",
  hideIcon: true,
};

export const VerticalWithCustomStyles = Template.bind({});
VerticalWithCustomStyles.args = {
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

export const VerticalWithCloseAsPopup = () => {
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


export const VerticalWithCloseAsPopupWithMoreChildren = () => {
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


export const HorizontalDefault = Template.bind({});
HorizontalDefault.args = {
  title: "Filter",
  addClose: false,
  children: horizontalChildren,
  primaryActionLabel: "ApplyFilters",
  secondaryActionLabel: "Clear Filters",
  onPrimaryPressed: () => alert("Primary action clicked!"),
  onSecondaryPressed: () => alert("Secondary action clicked!"),
  layoutType: "horizontal",
  equalWidthButtons: false,
  hideIcon: false,
};

export const HorizontalWithClose = Template.bind({});
HorizontalWithClose.args = {
  title: "Filter",
  addClose: true,
  children: horizontalChildren,
  primaryActionLabel: "ApplyFilters",
  secondaryActionLabel: "Clear Filters",
  onPrimaryPressed: () => alert("Primary action clicked!"),
  onSecondaryPressed: () => alert("Secondary action clicked!"),
  layoutType: "horizontal",
  equalWidthButtons: false,
  hideIcon: false,
};

export const HorizontalWithoutHeader = Template.bind({});
HorizontalWithoutHeader.args = {
  children: horizontalChildren,
  primaryActionLabel: "ApplyFilters",
  secondaryActionLabel: "Clear Filters",
  onPrimaryPressed: () => alert("Primary action clicked!"),
  onSecondaryPressed: () => alert("Secondary action clicked!"),
  layoutType: "horizontal",
  equalWidthButtons: false,
  hideIcon: true,
};

export const HorizontalWithCustomStyles = Template.bind({});
HorizontalWithCustomStyles.args = {
  title: "Filter",
  addClose: true,
  children: horizontalChildren,
  primaryActionLabel: "ApplyFilters",
  secondaryActionLabel: "Clear Filters",
  onPrimaryPressed: () => alert("Primary action clicked!"),
  onSecondaryPressed: () => alert("Secondary action clicked!"),
  layoutType: "horizontal",
  equalWidthButtons: false,
  hideIcon: false,
  style: {
    width: "1000px",
    backgroundColor:"#fafafa",
    border:"1px solid black"
  },
};

export const HorizontalWithCloseAsPopup = () => {
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
          layoutType={"horizontal"}
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


export const HorizontalWithCloseAsPopupWithMoreChildren = () => {
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
          layoutType={"horizontal"}
          equalWidthButtons={true}
          hideIcon={false}
          isPopup={true}
          onClose={onClose}
          onOverlayClick={onOverlayClick}
        >
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name1"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value2"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name3"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value4"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name5"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value6"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name7"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value8"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name9"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value10"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name11"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value12"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name13"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value14"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name15"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value16"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name17"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value18"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Name19"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
          <LabelFieldPair vertical={true}>
            <TextBlock body={"Value20"}></TextBlock>
            <TextInput type="text"></TextInput>
          </LabelFieldPair>
        </FilterCard>
      )}
    </>
  );
};