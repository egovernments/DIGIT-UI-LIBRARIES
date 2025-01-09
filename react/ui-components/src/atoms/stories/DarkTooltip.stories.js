import React from "react";
import Tooltip from "../Tooltip";
import { Colors } from "../../constants/colors/colorconstants";
import { IMAGES } from "../../constants/images/images";

export default {
  title: "Atoms/Tooltip/DarkTheme",
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

export const Basic = Template.bind({});
Basic.args = {
  content: "Tooltip",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "",
  description: "",
};

export const MaxLabel = Template.bind({});
MaxLabel.args = {
  content:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
};

export const WithArrow = Template.bind({});
WithArrow.args = {
  content: "Tooltip",
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
};

export const MaxLabelWithArrow = Template.bind({});
MaxLabelWithArrow.args = {
  content:
    "Tooltip Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
};

export const CustomStyles = Template.bind({});
CustomStyles.args = {
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

export const WithHeaderAndDescription = Template.bind({});
WithHeaderAndDescription.args = {
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

export const HtmlTooltip = Template.bind({});
HtmlTooltip.args = {
  content: htmlTooltipForDarktheme,
  arrow: false,
  placement: "bottom",
  style: {},
  className: "",
  header: "Header",
  description:
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ",
};

export const TooltipWithArrow = Template.bind({});
TooltipWithArrow.args = {
  content: htmlTooltipForDarktheme,
  arrow: true,
  placement: "bottom",
  style: {},
  className: "",
};