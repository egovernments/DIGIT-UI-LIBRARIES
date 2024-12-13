import React from "react";
import Uploader from "../Uploader";

export default {
  title: "Atoms/Uploader",
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
