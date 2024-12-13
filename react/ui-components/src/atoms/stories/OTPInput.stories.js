import React, { useState } from "react";
import OTPInput from "../OTPInput";

export default {
  title: "Atoms/OTPInput",
  component: OTPInput,
  argTypes: {
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    inline: {
      control: "boolean",
    },
    label: {
      control: "text",
    },
  },
};

const Template = (args) => {
  const [otp, setOtp] = useState("");

  const handleOtpChange = (value) => {
    setOtp(value);
    if (value.length === args.length) {
      const isValid = value.includes(1); 
      if (isValid) {
        console.log("OTP is correct");
        return null; 
      } else {
        console.log("Invalid OTP");
        return "Invalid OTP";
      }
    }
    return null; 
  };

  return <OTPInput {...args} onChange={handleOtpChange} />;
};

const commonArgs = {
  length: 6,
  type: "numeric",
  inline: false,
  label: "Enter OTP",
};

export const Documentation = () => (
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field" 
    width="100%"
    height="830"
    style={{ border: "none" }}
    title="OTPInput Documentation"
  />
);

Documentation.storyName = "Docs";

export const Default = Template.bind({});
Default.args = {
  ...commonArgs,
};

export const Inline = Template.bind({});
Inline.args = {
  ...commonArgs,
  inline: true,
};

export const Alphanumeric = Template.bind({});
Alphanumeric.args = {
  ...commonArgs,
  length: 6,
  type: "alphanumeric",
};

export const CustomLength = Template.bind({});
CustomLength.args = {
  ...commonArgs,
  length: 8,
  type: "numeric",
};

export const WithPlaceholder = Template.bind({});
WithPlaceholder.args = {
  ...commonArgs,
  length: 6,
  type: "numeric",
  placeholder: "123456",
};
