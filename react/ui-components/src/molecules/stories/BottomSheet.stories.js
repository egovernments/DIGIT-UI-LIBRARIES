import React from "react";
import BottomSheet from "../BottomSheet";
import {Button} from "../../atoms";
import { IMAGES } from "../../constants/images/images";

export default {
  title: "Molecules/BottomSheet",
  component: BottomSheet,
  argTypes: {
    initialState: {
      control: "select",
      options: ["closed", "fixed", "quarter", "intermediate", "full"],
    },
    enableActions: {
      control: "boolean",
    },
    equalWidthButtons: {
      control: "boolean",
    },
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
  },
};

const Template = (args) => <BottomSheet {...args}>{args.children}</BottomSheet>;

const commonArgs = {
  initialState: "closed",
  enableActions: false,
  className: "",
  style: {},
  equalWidthButtons: false,
};

const getImageUrl = (imageKey) => {
  return IMAGES[imageKey];
};

const digitImg = getImageUrl("DIGIT_LIGHT");

const additionalElements = [
  <div key="1" className="typography heading-l" style={{color:"#363636"}}>BottomSheet</div>,
  <div key="1" className="typography body-xs" style={{color:"#363636"}}>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</div>,
  <img key="2" alt="Powered by DIGIT" src={digitImg} />,
];

const actions = [
  <Button
    key="2"
    label={"Action 1"}
    size="large"
    variation={"primary"}
    isDisabled={false}
  />,
];

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
  initialState: "closed",
  children: additionalElements,
};

export const WithActions = Template.bind({});
WithActions.args = {
  ...commonArgs,
  initialState: "closed",
  enableActions: true,
  children: additionalElements,
  actions: actions,
};

export const Custom = Template.bind({});
Custom.args = {
  ...commonArgs,
  initialState: "closed",
  enableActions: true,
  children: additionalElements,
  actions: actions,
  equalWidthButtons: true,
};