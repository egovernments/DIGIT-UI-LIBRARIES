import React from "react";
import Uploader from "../Uploader";

export default {
  title: "Atoms/Uploader/UploadPopup",
  component: Uploader,
  argTypes: {
    uploadedFiles: {
      control: {
        type: "object",
      },
    },
    variant: {
      control: {
        type: "select",
        options: ["uploadFile", "uploadPopup", "uploadImage"],
      },
    },
    showLabel: {
      control: "boolean",
    },
    showHint: {
      control: "boolean",
    },
    label: {
      control: "text",
    },
    hintText: {
      control: "text",
    },
    iserror: {
      control: "text",
    },
    customClass: {
      control: "text",
    },
    disabled: {
      control: "boolean",
    },
    disableButton: {
      control: "boolean",
    },
    buttonType: {
      control: {
        type: "select",
        options: ["button", "submit", "reset"],
      },
    },
    inputStyles: {
      control: "object",
    },
    extraStyles: {
      control: "object",
    },
    id: {
      control: "text",
    },
    multiple: {
      control: "boolean",
    },
    accept: {
      control: "text",
    },
    showAsTags: {
      control: "boolean",
    },
    showAsPreview: {
      control: "boolean",
    },
    additionalElements: {
      control: "array",
    },
    validations: {
      control: "object",
    },
    showErrorCard: {
      control: "boolean",
    },
    showReUploadButton: {
      control: "boolean",
    },
    showDownloadButton: {
      control: "boolean",
    },
    onUpload: {
      control: "function",
    },
  },
};

const Template = (args) => <Uploader {...args} />;


export const Basic = Template.bind({});
Basic.args = {
  uploadedFiles: [],
  variant: "uploadPopup",
  showDownloadButton: true,
  showReUploadButton: true,
  multiple: false,
};

export const WithValidations = Template.bind({});
WithValidations.args = {
  uploadedFiles: [],
  variant: "uploadPopup",
  multiple: true,
  validations: {
    maxSizeAllowedInMB: 5,
    minSizeRequiredInMB: 1,
  },
  showDownloadButton: true,
  showReUploadButton: true,
};

export const WithValidationsWithErrorCard = Template.bind({});
WithValidationsWithErrorCard.args = {
  uploadedFiles: [],
  variant: "uploadPopup",
  multiple: true,
  validations: {
    maxSizeAllowedInMB: 5,
    minSizeRequiredInMB: 1,
  },
  showErrorCard: true,
  showDownloadButton: true,
  showReUploadButton: true,
};

export const WithError = Template.bind({});
WithError.args = {
  uploadedFiles: [],
  variant: "uploadPopup",
  showDownloadButton: true,
  showReUploadButton: true,
  multiple: false,
  iserror:"Component level error!"
};