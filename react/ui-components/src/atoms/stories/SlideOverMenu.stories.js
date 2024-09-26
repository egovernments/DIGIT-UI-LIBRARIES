import React from "react";
import SlideOverMenu from "../SlideOverMenu";
import Button from "../Button";

export default {
  title: "Atoms/SlideOverMenu",
  component: SlideOverMenu,
  argTypes: {
    className: { control: "text" },
    styles: { control: "object" },
    type: { control: "select", options: ["static", "dynamic"] },
    position: { control: "select", options: ["left", "right"] },
    children: {
      control: "object",
    },
    header: {
      control: "object",
    },
    footer: {
      control: "object",
    },
    onClose: { control: "boolean" },
    bgActive: { control: "boolean" },
    isOverlay: { control: "boolean" },
    hideArrowIcon: { control: "boolean" },
    hideScrollIcon: { control: "boolean" },
    isDraggable: { control: "boolean" },
    defaultClosedWidth: { control: "text" },
    defaultOpenWidth: { control: "text" },
  },
};

const Template = (args) => <SlideOverMenu {...args} />;

const commonArgs = {
  className: "",
  styles: {},
  type: "dynamic",
  position: "right",
  children: [],
  header: [],
  footer: [],
  onClose: () => {},
  bgActive: true,
  isOverlay: false,
  isDraggable: false,
  hideScrollIcon: true,
  sections: [],
  hideArrowIcon: false,
  defaultClosedWidth: "",
  defaultOpenWidth: "",
};

const children = [
  <div>This is static content on the right!</div>,
  <div
    style={{
      display: "flex",
      alignItems: "center",
      justifyContent: "space-between",
    }}
  >
    <div className="typography heading-m" style={{ color: "#0B4B66" }}>
      Roles
    </div>
    <Button
      onClick={() => {
        console.log("clicked");
      }}
      label={"Customize Roles"}
      variation={"link"}
      size={"medium"}
    />
  </div>,
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role1
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Complaint
    </div>
  </div>,
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role2
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Helpdesk
    </div>
  </div>,
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role3
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Complaint Resolver
    </div>
  </div>,

  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role4
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Complaint
    </div>
  </div>,
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role5
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Helpdesk
    </div>
  </div>,
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role6
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Complaint Resolver
    </div>
  </div>,
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role7
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Complaint
    </div>
  </div>,
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role8
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Helpdesk
    </div>
  </div>,
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "10px",
      }}
      className="typography heading-s"
    >
      Role9
    </div>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopRightRadius: "2px",
        borderBottomRightRadius: "2px",
        color: "#363636",
        padding: "10px",
        width: "100%",
      }}
      className="typography body-xs"
    >
      Complaint Resolver
    </div>
  </div>,
];

const sections = [
  [
    <div
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
      }}
    >
      <div className="typography heading-m" style={{ color: "#0B4B66" }}>
        Roles1
      </div>
      <Button
        onClick={() => {
          console.log("clicked");
        }}
        label={"Customize Roles"}
        variation={"link"}
        size={"medium"}
      />
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role1
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Complaint
      </div>
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role2
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Helpdesk
      </div>
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role3
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Complaint Resolver
      </div>
    </div>,
  ],
  [
    <div
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
      }}
    >
      <div className="typography heading-m" style={{ color: "#0B4B66" }}>
        Roles2
      </div>
      <Button
        onClick={() => {
          console.log("clicked");
        }}
        label={"Customize Roles"}
        variation={"link"}
        size={"medium"}
      />
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role1
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Complaint
      </div>
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role2
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Helpdesk
      </div>
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role3
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Complaint Resolver
      </div>
    </div>,
  ],
  [
    <div
      style={{
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
      }}
    >
      <div className="typography heading-m" style={{ color: "#0B4B66" }}>
        Roles3
      </div>
      <Button
        onClick={() => {
          console.log("clicked");
        }}
        label={"Customize Roles"}
        variation={"link"}
        size={"medium"}
      />
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role1
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Complaint
      </div>
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role2
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Helpdesk
      </div>
    </div>,
    <div style={{ display: "flex", alignItems: "center" }}>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopLeftRadius: "2px",
          borderBottomLeftRadius: "2px",
          backgroundColor: "#eeeeee",
          color: "#363636",
          padding: "10px",
        }}
        className="typography heading-s"
      >
        Role3
      </div>
      <div
        style={{
          border: "1px solid #d6d5d4",
          borderTopRightRadius: "2px",
          borderBottomRightRadius: "2px",
          color: "#363636",
          padding: "10px",
          width: "100%",
        }}
        className="typography body-xs"
      >
        Complaint Resolver
      </div>
    </div>,
  ],
];

const header = [
  <div className="typography heading-l" style={{ color: "#0B4B66" }}>
    Header
  </div>,
];

const footer = [
  <Button
    onClick={() => {
      console.log("clicked");
    }}
    style={{ width: "100%" }}
    label={"Customize Sandbox"}
    icon={"Edit"}
    variation={"secondary"}
  />,
];

export const StaticRight = Template.bind({});
StaticRight.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  children: children,
  header: header,
  footer: footer,
};

export const StaticRightWithoutBgActive = Template.bind({});
StaticRightWithoutBgActive.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  bgActive: false,
};

export const StaticRightWithSections = Template.bind({});
StaticRightWithSections.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
};

export const StaticRightWithSectionsAndWithoutBgActive = Template.bind({});
StaticRightWithSectionsAndWithoutBgActive.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
  bgActive: false,
};

export const StaticRightWithCustomWidth = Template.bind({});
StaticRightWithCustomWidth.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  defaultOpenWidth: 600,
};

export const StaticLeft = Template.bind({});
StaticLeft.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  children: children,
  header: header,
  footer: footer,
};

export const StaticLeftWithoutBgActive = Template.bind({});
StaticLeftWithoutBgActive.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  bgActive: false,
};

export const StaticLeftWithSections = Template.bind({});
StaticLeftWithSections.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  header: header,
  footer: footer,
  sections: sections,
};

export const StaticLeftWithSectionsWithoutBgActive = Template.bind({});
StaticLeftWithSectionsWithoutBgActive.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  header: header,
  footer: footer,
  sections: sections,
  bgActive: false,
};

export const StaticLeftWithCustomWidth = Template.bind({});
StaticLeftWithCustomWidth.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  defaultOpenWidth: 600,
};

export const DynamicRight = Template.bind({});
DynamicRight.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  children: children,
  header: header,
  footer: footer,
};

export const DynamicRightWithoutBgActive = Template.bind({});
DynamicRightWithoutBgActive.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  bgActive: false,
};

export const DynamicRightWithSections = Template.bind({});
DynamicRightWithSections.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
};

export const DynamicRightWithSectionsAndWithoutBgActive = Template.bind({});
DynamicRightWithSectionsAndWithoutBgActive.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
  bgActive: false,
};

export const DynamicRightWithDragging = Template.bind({});
DynamicRightWithDragging.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  isDraggable: true,
};

export const DynamicRightWithCustomWidths = Template.bind({});
DynamicRightWithCustomWidths.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  defaultClosedWidth: 100,
  defaultOpenWidth: 600,
};

export const DynamicLeft = Template.bind({});
DynamicLeft.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  children: children,
  header: header,
  footer: footer,
};

export const DynamicLeftWithoutBgActive = Template.bind({});
DynamicLeftWithoutBgActive.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  bgActive: false,
};

export const DynamicLeftWithSections = Template.bind({});
DynamicLeftWithSections.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  header: header,
  footer: footer,
  sections: sections,
};

export const DynamicLeftWithSectionsAndWithoutBgACtive = Template.bind({});
DynamicLeftWithSectionsAndWithoutBgACtive.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  header: header,
  footer: footer,
  sections: sections,
  bgActive: false,
};

export const DynamicLeftWithDragging = Template.bind({});
DynamicLeftWithDragging.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  isDraggable: true,
};

export const DynamicLeftWithCustomWidths = Template.bind({});
DynamicLeftWithCustomWidths.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  defaultClosedWidth: 100,
  defaultOpenWidth: 600,
};
