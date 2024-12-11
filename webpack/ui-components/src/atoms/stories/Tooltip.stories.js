import React from "react";
import Tooltip from "../Tooltip";
import { Colors } from "../../constants/colors/colorconstants";
import { IMAGES } from "../../constants/images/images";

export default {
  title: "Atoms/Tooltip",
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

const Color = Colors.lightTheme.primary[2];

const Template = (args) => (
  <div style={commonStyles}>
    <Tooltip {...args} />
  </div>
);

export const DarkThemeBasic = Template.bind({});
DarkThemeBasic.args = {
  content: "Tooltip",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "",
  description: "",
};

export const DarkThemeMaxLabel = Template.bind({});
DarkThemeMaxLabel.args = {
  content:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
};

export const DarkThemeWithArrow = Template.bind({});
DarkThemeWithArrow.args = {
  content: "Tooltip",
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
};

export const DarkThemeMaxLabelWithArrow = Template.bind({});
DarkThemeMaxLabelWithArrow.args = {
  content:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
};

export const DarkThemeCustomStyles = Template.bind({});
DarkThemeCustomStyles.args = {
  content: "Tooltip",
  arrow: false,
  placement: "bottom",
  style: {
    backgroundColor: Color,
    border: "3px solid #C84C0E",
    width: "200px",
    textAlign: "center",
  },
  className: "",
};

export const DarkThemeWithHeaderAndDescription = Template.bind({});
DarkThemeWithHeaderAndDescription.args = {
  content: "Tooltip",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "Header",
  description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
};

const getImageUrl = (imageKey) => {
  return IMAGES[imageKey];
};

const digitdarkthemeImg = getImageUrl("DIGIT_DARK");

const htmlTooltipForDarktheme = (
  <React.Fragment>
    {"And here's some amazing content It's very engaging. Right?"}
    <hr></hr>
    <img alt="here is your logo" src={digitdarkthemeImg}></img>
  </React.Fragment>
);

export const DarkThemeHtmlTooltip = Template.bind({});
DarkThemeHtmlTooltip.args = {
  content: htmlTooltipForDarktheme,
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "Header",
  description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
};

export const DarkThemeHtmlTooltipWithArrow = Template.bind({});
DarkThemeHtmlTooltipWithArrow.args = {
  content: htmlTooltipForDarktheme,
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
};

export const LightThemeBasic = Template.bind({});
LightThemeBasic.args = {
  content: "Tooltip",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "",
  description: "",
  theme: "light",
};

export const LightThemeMaxLabel = Template.bind({});
LightThemeMaxLabel.args = {
  content:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  theme: "light",
};

export const LightThemeWithArrow = Template.bind({});
LightThemeWithArrow.args = {
  content: "Tooltip",
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
  theme: "light",
};

export const LightThemeMaxLabelWithArrow = Template.bind({});
LightThemeMaxLabelWithArrow.args = {
  content:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
  theme: "light",
};

export const LightThemeCustomStyles = Template.bind({});
LightThemeCustomStyles.args = {
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

export const LightThemeWithHeaderAndDescription = Template.bind({});
LightThemeWithHeaderAndDescription.args = {
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

const digitlightthemeImg = getImageUrl("DIGIT_LIGHT");

const htmlTooltipForLighttheme = (
  <React.Fragment>
    {"And here's some amazing content It's very engaging. Right?"}
    <hr></hr>
    <img alt="here is your logo" src={digitlightthemeImg}></img>
  </React.Fragment>
);

export const LightThemeHtmlTooltip = Template.bind({});
LightThemeHtmlTooltip.args = {
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

export const LightThemeHtmlTooltipWithArrow = Template.bind({});
LightThemeHtmlTooltipWithArrow.args = {
  content: htmlTooltipForLighttheme,
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
  theme: "light",
};
