import React from "react";
import TextBlock from "@egovernments/digit-ui-components/atoms/TextBlock";
import Iframe from "@egovernments/digit-ui-components/atoms/Iframe";
import { createDocumentationStory } from "../.storybook/DocumentationComponent";

export default {
  title: "Atoms/Text Block",
  component: TextBlock,
  argTypes: {
    headerContentClassName: {
      table: { disable: true },
    },
    headerClassName: {
      table: { disable: true },
    },
    captionClassName: {
      table: { disable: true },
    },
    subHeaderClassName: {
      table: { disable: true },
    },
    bodyClassName: {
      table: { disable: true },
    },
    wrapperClassName: {
      table: { disable: true },
    },
    style: {
      table: { disable: true },
    },
    caption: {
      control: "boolean",name:"Caption"
    },
    header: {
      control: "boolean",name:"Heading"
    },
    subHeader: {
      control: "boolean",name:"Subheading"
    },
    body: {
      control: "boolean",name:"Body"
    },
  },
};

const Template = (args) => {
  const { caption, body, header, subHeader, ...rest } = args;
  return (
    <TextBlock
      {...rest}
      caption={caption ? "Caption" : ""}
      body={
        body
          ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
          : ""
      }
      header={header ? "Heading" : ""}
      subHeader={subHeader ? "Subheading" : ""}
    />
  );
};



const commonArgs = {
  headerContentClassName: "",
  caption: true,
  captionClassName: "",
  header: true,
  headerClassName: "",
  subHeader: true,
  subHeaderClassName: "",
  body: true,
  bodyClassName: "",
};

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
};

export const Custom = Template.bind({});
Custom.args = {
  ...commonArgs,
  style:{
    border:"1px solid black",
    padding:"24px",
    backgroundColor:"#fafafa",
    textColor:"red"
  }
};

export const Documentation = createDocumentationStory("TextBlock", "atoms");
