import React from "react";
import { Colors } from "../../constants/colors/colorconstants";

export default {
  title: "Foundations/ColorLibrary",
  argTypes: {
    color: {
      control: {
        type: "select",
        options: [
            "primary-1",
            "primary-bg",
            "primary-2",
            "text-primary",
            "text-secondary",
            "text-disabled",
            "alert-error",
            "alert-errorbg",
            "alert-success",
            "alert-successbg",
            "alert-warning",
            "alert-warning-bg",
            "alert-info",
            "alert-infobg",
            "generic-background",
            "generic-divider",
            "generic-inputborder",
            "paper-primary",
            "paper-secondary",
        ],
      },
    },
  },
};

const hexCodes = {
  "primary-1": "#C84C0E",
  "primary-bg": "#FBEEE8",
  "primary-2": "#0B4B66",
  "text-primary": "#363636",
  "text-secondary": "#787878",
  "text-disabled": "#C5C5C5",
  "alert-error": "#B91900",
  "alert-errorbg": "#FFF5F4",
  "alert-success": "#00703C",
  "alert-successbg": "#F1FFF8",
  "alert-warning": "#9E5F00",
  "alert-warning-bg": "#FFF9F0",
  "alert-info": "#0057BD",
  "alert-infobg": "#DEEFFF",
  "generic-background": "#EEEEEE",
  "generic-divider": "#D6D5D4",
  "generic-inputborder": "#505A5F",
  "paper-primary": "#FFFFFF",
  "paper-secondary": "#FAFAFA",
}


const Template = (args) => {

  const capitalizedColorName = args?.color?.replace(/\b\w/g, (char) =>
    char.toUpperCase()
  );

  return (
    <div>
      <div style={{...args?.style,top:"25%",border:"none"}} className={`typography body-l`}>{`${capitalizedColorName} : ${hexCodes[args?.color]}`}</div>
      <button className={`color-constants-story ${args?.color}`} style={args?.style}></button>
    </div>
  );
};

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  transform: "translate(-50%, -50%)",
  width:"50%",
  height:"25%",
  border:"1px solid #363636"
};

export const Playground = Template.bind({});
Playground.args = {
  color: "primary-1",
  style: style
};