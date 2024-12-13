import React from "react";
import TextBlock from "../TextBlock";

export default {
  title: "Atoms/TextBlock",
  component: TextBlock,
};

const Template = (args) => <TextBlock {...args} />;

export const Documentation = () => (
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field" 
    width="100%"
    height="830"
    style={{ border: "none" }}
    title="TextBlock Documentation"
  />
);

Documentation.storyName = "Docs";


export const Default = Template.bind({});
Default.args = {
  headerContentClassName:"",
  caption: "Caption",
  captionClassName: "",
  header: "Heading",
  headerClassName: "",
  subHeader: "Subheading",
  subHeaderClassName: "",
  body:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
  bodyClassName: "",
};
