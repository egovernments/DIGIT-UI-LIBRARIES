import React from "react";
import { BrowserRouter as Router } from "react-router-dom";
import MobileSidebar from "../../atoms/MobileSidebar";


export default {
  title: "Molecules/Hamburger",
  component: MobileSidebar,
  argTypes: {
    items: { control: "object" },
    usermanuals: { control: "object" },
    theme: { control: "select", options: ["dark", "light"] },
    variant: { control: "select", options: ["primary", "secondary"] },
    transitionDuration: { control: "number" },
    isSearchable:{control:"boolean"},
    hideUserManuals:{control:"boolean"},
    userManualLabel:{control:"text"},
    profile:{control:"text"},
    onSelect:{ action: "onChange" },
    onLogout:{action:"onChange"},
    reopenOnLogout:{control:"boolean"},
    closeOnClickOutside:{control:"boolean"},
    onOutsideClick:{action:"onChange"}
  },
};

export const Documentation = () => (
    <iframe
      //Todo:Update the url
      src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
      width="100%"
      height="830"
      style={{ border: "none" }}
      title="Hamburger Documentation"
    />
  );

  Documentation.storyName = "Docs";