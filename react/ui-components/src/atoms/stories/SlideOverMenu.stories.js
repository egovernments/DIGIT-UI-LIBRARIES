import React from "react";
import SlideOverMenu from "../SlideOverMenu";
import Button from "../Button";
import { SVG } from "../SVG";

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
    bgActive: { control: "boolean" },
    isOverlay: { control: "boolean" },
    hideArrow: { control: "boolean" },
    hideScrollIcon: { control: "boolean" },
    isDraggable: { control: "boolean" },
    defaultClosedWidth: { control: "text" },
    defaultOpenWidth: { control: "text" },
    addClose:{control:"boolean"},
    closedContents:{control:"object"},
    closedHeader:{control:"object"},
    closedFooter:{control:"object"}
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
  bgActive: true,
  isOverlay: false,
  isDraggable: false,
  hideScrollIcon: true,
  sections: [],
  defaultClosedWidth: "",
  defaultOpenWidth: "",
  addClose:false,
  closedContents:[],
  closedSections:[],
  closedHeader:[],
  closedFooter:[],
  hideArrow:false
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

const closedSections = [
  <div style={{ display: "flex", alignItems: "center" ,flexDirection:"column",gap:"4px"}}>
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
      R1
    </div>
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
      R2
    </div>
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
      R3
    </div>
  </div>,
    <div style={{ display: "flex", alignItems: "center" ,flexDirection:"column",gap:"4px"}}>
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
      R1
    </div>
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
      R2
    </div>
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
      R3
    </div>
  </div>,
    <div style={{ display: "flex", alignItems: "center" ,flexDirection:"column",gap:"4px"}}>
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
      R1
    </div>
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
      R2
    </div>
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
      R3
    </div>
  </div>,
];

const closedContents = [
  <div style={{ display: "flex", alignItems: "center" }}>
    <div
      style={{
        border: "1px solid #d6d5d4",
        borderTopLeftRadius: "2px",
        borderBottomLeftRadius: "2px",
        backgroundColor: "#eeeeee",
        color: "#363636",
        padding: "4px",
      }}
      className="typography heading-s"
    >
      R1
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
        padding: "4px",
      }}
      className="typography heading-s"
    >
      R2
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
        padding: "4px",
      }}
      className="typography heading-s"
    >
      R3
    </div>
  </div>
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
    size={"medium"}
    style={{ width: "100%" }}
    label={"Customize Sandbox"}
    icon={"Edit"}
    variation={"secondary"}
  />,
];

const closedFooter = [
<SVG.Edit></SVG.Edit>
];

const closedHeader = [
  <div
  style={{
    border: "1px solid #d6d5d4",
    borderTopLeftRadius: "2px",
    borderBottomLeftRadius: "2px",
    backgroundColor: "#eeeeee",
    color: "#0B4B66",
    width:"100%",
    lineHeight:"normal",
    height:"fit-content",
    display: "flex",
    alignItems: "center",
    justifyContent: "center"
  }}
  className="typography heading-l"
>
  H
</div>
]

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

export const StaticRightWithClose = Template.bind({});
StaticRightWithClose.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  addClose:true,
  closedContents:closedContents
};

export const StaticRightWithSectionsAndClose = Template.bind({});
StaticRightWithSectionsAndClose.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
  closedSections:closedSections,
  addClose:true,
  closedHeader:closedHeader
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

export const StaticLeftWithClose = Template.bind({});
StaticLeftWithClose.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  addClose:true,
  closedContents:closedContents,
  closedHeader:closedHeader
};

export const StaticLeftWithSectionsAndClose = Template.bind({});
StaticLeftWithSectionsAndClose.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  header: header,
  footer: footer,
  sections: sections,
  closedSections:closedSections,
  addClose:true,
  closedHeader:closedHeader
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
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedFooter:closedFooter
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
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedFooter:closedFooter
};

export const DynamicRightWithSections = Template.bind({});
DynamicRightWithSections.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
  closedContents:closedContents,
  closedSections:closedSections,
  closedHeader:closedHeader,
  closedFooter:closedFooter
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
  closedSections:closedSections,
  closedHeader:closedHeader,
  closedFooter:closedFooter
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
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedFooter:closedFooter
};

export const DynamicRightWithClose = Template.bind({});
DynamicRightWithClose.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  addClose:true,
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedFooter:closedFooter
};

export const DynamicRightWithSectionsAndClose = Template.bind({});
DynamicRightWithSectionsAndClose.args = {
  ...commonArgs,
  type: "dynamic",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
  closedSections:closedSections,
  addClose:true,
  closedHeader:closedHeader,
  closedFooter:closedFooter
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
  closedSections:closedSections,
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedFooter:closedFooter
};

export const DynamicLeft = Template.bind({});
DynamicLeft.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedFooter:closedFooter
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
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedFooter:closedFooter
};

export const DynamicLeftWithSections = Template.bind({});
DynamicLeftWithSections.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  header: header,
  footer: footer,
  sections: sections,
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedSections:closedSections,
  closedFooter:closedFooter
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
  closedHeader:closedHeader,
  closedSections:closedSections,
  closedFooter:closedFooter
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
  closedHeader:closedHeader,
  closedFooter:closedFooter
};

export const DynamicLeftWithClose = Template.bind({});
DynamicLeftWithClose.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  addClose:true,
  closedContents:closedContents,
  closedHeader:closedHeader,
  closedFooter:closedFooter
};

export const DynamicLeftWithSectionsAndClose = Template.bind({});
DynamicLeftWithSectionsAndClose.args = {
  ...commonArgs,
  type: "dynamic",
  position: "left",
  header: header,
  footer: footer,
  sections: sections,
  addClose:true,
  closedSections:closedSections,
  closedHeader:closedHeader,
  closedFooter:closedFooter
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
  closedHeader:closedHeader,
  closedFooter:closedFooter
};
