import React from "react";
import Tooltip from "../Tooltip";
import { IMAGES } from "../../constants/images/images";

export default {
  title: "Atoms/Tooltip/LightTheme",
  component: Tooltip,
  argTypes: {
    content: { control: "text" },
    description: { control: "text" },
    placement: {
      control: "select",
      options: [
        "bottom-start",
        "bottom",
        "bottom-end",
        "top-start",
        "top",
        "top-end",
        "left-start",
        "left",
        "left-end",
        "right-start",
        "right",
        "right-end",
      ],
    },
    arrow: { control: "boolean" },
    style: { control: "object" },
    className: { control: "text" },
    header: { control: "text" },
    theme: {
      control: "select",
      options: [
        "dark",
        "light",
      ],
    },
  },
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

const Template = (args) => (
  <div style={commonStyles}>
    <Tooltip {...args} />
  </div>
);

export const Basic = Template.bind({});
Basic.args = {
  content: "Tooltip",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "",
  description: "",
  theme: "light",
};

export const MaxLabel = Template.bind({});
MaxLabel.args = {
  content:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  theme: "light",
};

export const WithArrow = Template.bind({});
WithArrow.args = {
  content: "Tooltip",
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
  theme: "light",
};

export const MaxLabelWithArrow = Template.bind({});
MaxLabelWithArrow.args = {
  content:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
  theme: "light",
};

export const CustomStyles = Template.bind({});
CustomStyles.args = {
  content: "Tooltip",
  arrow: false,
  placement: "bottom",
  style: {
    backgroundColor: "#FFFFFF",
    border: "3px solid black",
    width: "200px",
    textAlign: "center",
  },
  className: "",
  theme: "light",
};

export const WithHeaderAndDescription = Template.bind({});
WithHeaderAndDescription.args = {
  content: "Tooltip",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "Header",
  theme: "light",
  description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
};

const getImageUrl = (imageKey) => {
  return IMAGES[imageKey];
};

const digitlightthemeImg = getImageUrl("DIGIT_LIGHT");

const htmlTooltipForLighttheme = (
  <React.Fragment>
    {"And here's some amazing content It's very engaging. Right?"}
    <hr></hr>
    <img alt="here is your logo" src={digitlightthemeImg}></img>
  </React.Fragment>
);

export const HtmlTooltip = Template.bind({});
HtmlTooltip.args = {
  content: htmlTooltipForLighttheme,
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "Header",
  theme: "light",
  description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
};

export const HtmlTooltipWithArrow = Template.bind({});
HtmlTooltipWithArrow.args = {
  content: htmlTooltipForLighttheme,
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
  theme: "light",
};
