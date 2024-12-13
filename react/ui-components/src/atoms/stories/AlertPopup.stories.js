import React, { useState } from "react";
import PopUp from "../PopUp";
import Button from "../Button";
import InfoCard from "../InfoCard";

export default {
  title: "Atoms/PopUp/Alert",
  component: PopUp,
  argTypes: {
    className: {
      control: "text",
    },
    type: { control: "select", options: ["default", "alert"] },
    overlayClassName: {
      control: "text",
    },
    onOverlayClick: {
      control: "function",
    },
    headerclassName: {
      control: "text",
    },
    footerclassName: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    children: {
      control: "object",
    },
    footerChildren: {
      control: "object",
    },
    onClose: {
      control: "function",
    },
    props: {
      control: "object",
    },
    showIcon: {
      control: "boolean",
    },
    heading: {
      control: "text",
    },
    subheading: {
      control: "text",
    },
    description: {
      control: "text",
    },
    alertHeading: {
      control: "text",
    },
    alertMessage: {
      control: "text",
    },
    iconFill: {
      control: "text",
    },
    customIcon: {
      control: "text",
    },
    showChildrenInline: {
      control: "boolean",
    },
    headerMaxLength: {
      control: "text",
    },
    subHeaderMaxLength: {
      control: "text",
    },
    sortFooterButtons: {
      control: "boolean",
    },
    maxFooterButtonsAllowed: {
      control: "text",
    },
    footerStyles: {
      control: "object",
    },
    showAlertAsSvg: {
      control: "boolean",
    },
    equalWidthButtons: {
      control: "boolean",
    },
  },
};

const Template = (args) => {
  const [showPopup, setShowPopup] = useState(false);

  const onClose = () => {
    setShowPopup(false);
  };

  const onOverlayClick = () => {
    setShowPopup(false);
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

  return (
    <>
      <div style={commonStyles}>
        {
          <Button
            label={args.type === "default" ? "Show PopUp" : "Show Alert Popup"}
            variation={"secondary"}
            onClick={() => setShowPopup(true)}
          />
        }
      </div>
      {showPopup && (
        <PopUp {...args} onClose={onClose} onOverlayClick={onOverlayClick} />
      )}
    </>
  );
};

const commonArgs = {
  type: "default",
  className: "",
  overlayClassName: "",
  headerclassName: "",
  footerclassName: "",
  style: {},
  props: {},
  showIcon: true,
  heading: "",
  subheading: "",
  description: "",
  alertHeading: "",
  alertMessage: "",
  iconFill: "",
  customIcon: "",
  showChildrenInline: false,
  headerMaxLength: "",
  subHeaderMaxLength: "",
  sortFooterButtons: true,
  maxFooterButtonsAllowed: 5,
  footerStyles: {},
  showAlertAsSvg: false,
  equalWidthButtons: false,
};

const footerChildrenWithTwoButtons = [
  <Button
    type={"button"}
    size={"large"}
    variation={"secondary"}
    label="Button"
    onClick={() => console.log("Clicked Button 1")}
  />,
  <Button
    type={"button"}
    size={"large"}
    variation={"primary"}
    label="Button"
    onClick={() => console.log("Clicked Button 2")}
  />,
];

const footerChildrenWithOneButton = [
  <Button
    type={"button"}
    size={"large"}
    variation={"primary"}
    label="OK"
    onClick={() => console.log("Clicked Button")}
  />,
];

const lessChildren = [
  <div>This is the content of the Popup</div>,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
];

const moreChildren = [
  <div>This is the content of the Popup</div>,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
  <InfoCard text={"This is an infocard"} className={"popup-info-card"} />,
];

export const Alert = Template.bind({});
Alert.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  footerChildren: footerChildrenWithTwoButtons,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
};

export const WithSingleButton = Template.bind({});
WithSingleButton.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  footerChildren: footerChildrenWithOneButton,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
};

export const WithCustomIcon = Template.bind({});
WithCustomIcon.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  footerChildren: footerChildrenWithTwoButtons,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
  customIcon: "CheckCircle",
  iconFill: "green",
};

export const WithCustomStyles = Template.bind({});
WithCustomStyles.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  footerChildren: footerChildrenWithTwoButtons,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
  style: { width: "620px", height: "500px" },
};

export const WithCustomStylesAndMoreChildren = Template.bind({});
WithCustomStylesAndMoreChildren.args = {
  ...commonArgs,
  type: "alert",
  children: moreChildren,
  footerChildren: footerChildrenWithTwoButtons,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
  style: { width: "620px", height: "500px" },
};

export const WithFooterStyles = Template.bind({});
WithFooterStyles.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  footerChildren: footerChildrenWithTwoButtons,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
  footerStyles: {
    marginLeft: "unset",
  },
};

export const WithOutFooter = Template.bind({});
WithOutFooter.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
};

export const AsSvg = Template.bind({});
AsSvg.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  footerChildren: footerChildrenWithTwoButtons,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
  showAlertAsSvg: true,
};

export const WithSingleButtonTotalWidth = Template.bind({});
WithSingleButtonTotalWidth.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  footerChildren: footerChildrenWithOneButton,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
  equalWidthButtons: true,
};

export const WithEqualButtonsWidth = Template.bind({});
WithEqualButtonsWidth.args = {
  ...commonArgs,
  type: "alert",
  children: lessChildren,
  footerChildren: footerChildrenWithTwoButtons,
  alertHeading: "Alert!",
  alertMessage:
    "Please contact the administrator if you have forgotten your password.",
  equalWidthButtons: true,
};
