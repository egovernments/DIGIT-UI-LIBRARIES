import React from "react";
import SlideOverMenu from "../SlideOverMenu";
import Button from "../Button";
import { SVG } from "../SVG";

export default {
  title: "Atoms/SlideOverMenu/Static",
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
  type: "static",
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

export const Right = Template.bind({});
Right.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  children: children,
  header: header,
  footer: footer,
};

export const RightWithoutBgActive = Template.bind({});
RightWithoutBgActive.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  bgActive: false,
};

export const RightWithSections = Template.bind({});
RightWithSections.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
};

export const RightWithSectionsAndWithoutBgActive = Template.bind({});
RightWithSectionsAndWithoutBgActive.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  header: header,
  footer: footer,
  sections: sections,
  bgActive: false,
};

export const RightWithClose = Template.bind({});
RightWithClose.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  addClose:true,
  closedContents:closedContents
};

export const RightWithSectionsAndClose = Template.bind({});
RightWithSectionsAndClose.args = {
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

export const RightWithCustomWidth = Template.bind({});
RightWithCustomWidth.args = {
  ...commonArgs,
  type: "static",
  position: "right",
  children: children,
  header: header,
  footer: footer,
  defaultOpenWidth: 600,
};

export const Left = Template.bind({});
Left.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  children: children,
  header: header,
  footer: footer,
};

export const LeftWithoutBgActive = Template.bind({});
LeftWithoutBgActive.args = {
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

export const LeftWithSectionsWithoutBgActive = Template.bind({});
LeftWithSectionsWithoutBgActive.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  header: header,
  footer: footer,
  sections: sections,
  bgActive: false,
};

export const LeftWithClose = Template.bind({});
LeftWithClose.args = {
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

export const LeftWithSectionsAndClose = Template.bind({});
LeftWithSectionsAndClose.args = {
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

export const LeftWithCustomWidth = Template.bind({});
LeftWithCustomWidth.args = {
  ...commonArgs,
  type: "static",
  position: "left",
  children: children,
  header: header,
  footer: footer,
  defaultOpenWidth: 600,
};