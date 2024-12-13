import React from "react";
import LoaderComponent from "../LoaderComponent";
import theLoaderPrimary from "../../constants/animations/theLoaderPrimary.json";


export default {
  title: "Atoms/Loader",
  component: LoaderComponent,
  argTypes: {
    variant: {
      control: "select",
      options: ["Basic", "PageLoader", "OverlayLoader"],
    },
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    animationStyles: {
      control: { type: "object" },
    },
    loaderText: {
      control: "text",
    },
  },
};


const Template = (args) => (
    <LoaderComponent {...args} />
);

const commonArgs = {
  className: "",
  style: {},
  variant:"Basic",
  animationStyles:{}
};

export const Documentation = () => (
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field" 
    width="100%"
    height="830"
    style={{ border: "none" }}
    title="Accordion Documentation"
  />
);

Documentation.storyName = "Docs";

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
  variant: "Basic",
};

export const PageLoader = Template.bind({});
PageLoader.args = {
  ...commonArgs,
  variant: "PageLoader",
};

export const OverlayLoader = Template.bind({});
OverlayLoader.args = {
  ...commonArgs,
  variant: "OverlayLoader",
};

export const Custom = Template.bind({});
Custom.args = {
  ...commonArgs,
  variant: "Basic",
  style:{
    width:"100%",
    height:"300px",
    alignItems:"center"
  },
  loaderText:"This page is loading",
  animationStyles:{
    width:"50px",
    height:"50px",
    animationData:theLoaderPrimary
  },
  className:"custom-loader-example"
};