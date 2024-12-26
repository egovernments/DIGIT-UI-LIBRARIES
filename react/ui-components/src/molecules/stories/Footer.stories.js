import React from "react";
import { Button } from "../../atoms";
import { Footer } from "../../atoms";
import { Iframe } from "../../atoms";

export default {
  title: "Molecules/Footer",
  component: Footer,
  argTypes: {
    className: {
      control: "text",
      table: { disable: true },
    },
    style: {
      control: { type: "object" },
      table: { disable: true },
    },
    actionFields: {
      control: { type: "object" },
      table: { disable: true },
    },
    setactionFieldsToRight: {
      control: { type: "boolean" },
      table: { disable: true },
    },
    setactionFieldsToLeft: {
      control: { type: "boolean" },
      table: { disable: true },
    },
    maxActionFieldsAllowed: {
      control: { type: "number" },
      table: { disable: true },
    },
    sortActionFields: {
      control: { type: "boolean" },
      table: { disable: true },
    },
    setChildrenLeft: {
      control: { type: "boolean" },
      table: { disable: true },
    },
    flex: {
      control: "select",
      options: ["Left", "Right"],
      name:"Flex"
    },
  },
};

const Template = (args) => {
  const { flex, ...rest } = args;
  return (
    <Footer
      {...rest}
      setactionFieldsToRight={flex === "Right"}
      setactionFieldsToLeft={"Left"}
    />
  );
};

const commonArgs = {
  className: "",
  style: {},
  actionFields: [],
  maxActionFieldsAllowed: 5,
  sortActionFields: true,
  setChildrenLeft: false,
};

const footeractionFields = [
  <Button
    type={"button"}
    size={"large"}
    variation={"secondary"}
    label="Back"
    icon={"ArrowBack"}
    onClick={() => console.log("Moving to previous page")}
  />,
  <Button
    type={"button"}
    size={"large"}
    variation={"primary"}
    label="Next"
    isSuffix={true}
    icon={"ArrowForward"}
    onClick={() => console.log("Moving To next page")}
  />,
];

const footeractionFieldsWithSearchableDropdown = [
  <Button
    type={"button"}
    size={"large"}
    variation={"secondary"}
    label="Back"
    icon={"ArrowBack"}
    onClick={() => console.log("Moving to previous page")}
  />,
  <Button
    type={"actionButton"}
    options={[
      { name: "Action A", code: "Actiona" },
      { name: "Action B", code: "Actionb" },
      { name: "Action C", code: "Actionc" },
    ]}
    label={"Actions"}
    variation={"primary"}
    optionsKey={"name"}
    isSearchable={true}
    onOptionSelect={(option) => {
      console.log(option);
    }}
  ></Button>,
];

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="Footer Documentation"
  />
);

Documentation.storyName = "Docs";

export const Basic = () => (
  <Footer
    className={""}
    style={{}}
    actionFields={footeractionFieldsWithSearchableDropdown}
    maxActionFieldsAllowed={5}
    sortActionFields={true}
    setChildrenLeft={false}
  />
);
Basic.argTypes = {
  flex: { table: { disable: true } },
};

export const Flex = Template.bind({});
Flex.args = {
  ...commonArgs,
  actionFields: footeractionFields,
  flex:"Right"
};
