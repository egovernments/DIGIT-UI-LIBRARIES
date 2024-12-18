import React from "react";
import TextBlock from "../TextBlock";
import Iframe from "../Iframe";

export default {
  title: "Atoms/TextBlock",
  component: TextBlock,
};

const Template = (args) => <TextBlock {...args} />;

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="TextBlock Documentation"
  />
);

Documentation.storyName = "Docs";

export const Default = Template.bind({});
Default.args = {
  headerContentClassName: "",
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