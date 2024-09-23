import React from "react";
import TableMolecule from "../TableMolecule";
import { Button } from "../../atoms";
import { Chip } from "../../atoms";

export default {
  title: "Molecules/TableMolecule",
  component: TableMolecule,
  argTypes: {
    headerData: { control: "array" },
    rows: { control: "array" },
    footerContent: { control: "text" },
    initialRowsPerPage: { control: "number" },
    frozenColumns: { control: "number" },
    withRowDivider: { control: "boolean" },
    withBorder: { control: "boolean" },
    withAlternateBg: { control: "boolean" },
    withHeaderDivider: { control: "boolean" },
    withColumnDivider: { control: "boolean" },
    isStickyHeader: { control: "boolean" },
    isStickyFooter: { control: "boolean" },
    rowsPerPageOptions: { control: "array" },
    addCheckbox: { control: "boolean" },
    checkboxLabel: { control: "text" },
    initialSelectedRows: { control: "array" },
    onSelectedRowsChange: { control: "onchange" },
    addStickyFooter: { control: "boolean" },
    showSelectedState: { control: "boolean" },
    tableTitle: { control: "text" },
    tableDescription: { control: "text" },
    stickyFooterContent: { control: "object" },
    onRowClick: { control: "onchange" },
    hideFooter: { control: "boolean" },
    actionButtonLabel: { control: "text" },
    actions: { control: "array" },
    headerStyles:{control:"object"},
    footerStyles:{control:"object"},
    bodyStyles:{control:"object"},
    tableStyles:{control:"object"},
    className:{control:"text"},
    addFilter:{control:"boolean"},
    onFilter:{control:"onchange"},
    scrollableStickyFooterContent:{control:"boolean"},
    isTableSortable:{control:"boolean"},
    initialSortOrder:{control:"text"}
  },
};

const Template = (args) => <TableMolecule {...args} />;

const headerData = [
  { label: "S.No", type: "serialno" },
  { label: "Text", type: "text"},
  { label: "Numeric", type: "numeric" },
  { label: "Description", type: "description" },
  { label: "Tag", type: "tag" },
  { label: "Switch", type: "switch" },
  { label: "Button", type: "button" },
  { label: "Checkbox", type: "checkbox" },
  { label: "TextInput", type: "textinput" },
  { label: "Dropdown", type: "dropdown" },
  { label: "Multiselectdropdown", type: "multiselectdropdown" },
  { label: "Custom", type: "custom" },
];

const headerDataWithSort = [
  { label: "S.No", type: "serialno"},
  { label: "Text", type: "text" },
  { label: "Numeric", type: "numeric" },
  { label: "Description", type: "description" },
  { label: "Tag", type: "tag" },
  { label: "Switch", type: "switch" },
  { label: "Button", type: "button" },
  { label: "Checkbox", type: "checkbox" },
  { label: "TextInput", type: "textinput" },
  { label: "Dropdown", type: "dropdown" },
  { label: "Multiselectdropdown", type: "multiselectdropdown" },
  { label: "Custom", type: "custom" },
];

const headerDataWithDescription = [
  { label: "S.No", description: "Serialno column", type: "serialno" },
  { label: "Text", description: "Text column", type: "text" },
  { label: "Numeric", description: "Numeric column", type: "numeric" },
  {
    label: "Description",
    description: "Description column",
    type: "description",
  },
  { label: "Tag", description: "Tag column", type: "tag" },
  { label: "Switch", description: "Switch column", type: "switch" },
  { label: "Button", description: "Button column", type: "button" },
  { label: "Checkbox", description: "Checkbox column", type: "checkbox" },
  { label: "TextInput", description: "Textinput column", type: "textinput" },
  { label: "Dropdown", description: "Dropdown column", type: "dropdown" },
  {
    label: "Multiselectdropdown",
    description: "Multiselectdropdown column",
    type: "multiselectdropdown",
  },
  { label: "Custom", description: "Custom component column", type: "custom" },
];

const options = [
  { name: "English", code: "English1" },
  { name: "Hindi", code: "Hindi2" },
];

const headerDataForCustomStyles = [
  { label: "S.No", type: "serialno" },
  { label: "Text", type: "text" },
  { label: "Text", type: "text" },
  { label: "Text", type: "text" },
  { label: "Numeric", type: "numeric" },
]
const samplerows = [
  [1, "Row1", "Description1", "Example1", 455666],
  [2, "Row2", "Description2", "Example2", 4553232666],
  [3, "Row3", "Description3", "Example3", 6666],
  [4, "Row4", "Description4", "Example4", 32323],
  [5, "Row5", "Description5", "Example5", 4556266],
  [6, "Row6", "Description6", "Example6", 455333666],
  [7, "Row7", "Description7", "Example7", 455666],
  [8, "Row8", "Description8", "Example8", 343434],
  [9, "Row9", "Description9", "Example9", 400],
  [10, "Row10", "Description10", "Example10", 455666],
];

const rows = [
  [
    1,
    {
      label:
        "ALorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    10000,
    {
      label:
        "ALorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag1",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "success",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch1",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button1",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox1",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link1"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    2,
    {
      label:
        "BLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    20000,
    {
      label:
        "BLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag2",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "monochrome",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch2",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button2",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox2",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link2"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    3,
    {
      label:
        "CLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    30000,
    {
      label:
        "CLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag3",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "error",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch3",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button3",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox3",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link3"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    4,
    {
      label:
        "DLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    40000,
    {
      label:
        "DLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag4",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "warning",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch4",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button4",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox4",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link4"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    5,
    {
      label:
        "ELorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    50000,
    {
      label:
        "ELorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag5",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "monochrome",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch5",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button5",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox5",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link5"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    6,
    {
      label:
        "FLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    60000,
    {
      label:
        "FLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag6",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "success",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch6",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button6",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link6"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    7,
    {
      label:
        "GLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    70000,
    {
      label:
        "GLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag7",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "success",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch7",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button7",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox7",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link7"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    8,
    {
      label:
        "HLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    80000,
    {
      label:
        "HLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag8",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "success",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch8",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button8",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox8",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link8"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    9,
    {
      label:
        "ILorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    90000,
    {
      label:
        "ILorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag9",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "error",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch9",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button9",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox9",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link9"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
  [
    10,
    {
      label:
        "JLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneanp",
      maxLength: 64,
    },
    100000,
    {
      label:
        "JLorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisppp",
      maxLength: 256,
    },
    {
      icon: "",
      label: "Tag10",
      labelStyle: {},
      showIcon: false,
      style: {},
      type: "warning",
      className: "",
      stroke: true,
      onClick: () => {},
      alignment: "",
      iconClassName: "",
      iconColor: "",
    },
    {
      isLabelFirst: false,
      label: "Switch10",
      labelStyle: {},
      shapeOnOff: true,
      style: {},
      disable: false,
      className: "",
      isCheckedInitially: false,
      onToggle: () => {},
    },
    {
      variation: "primary",
      type: "button",
      isDisabled: false,
      showBottom: true,
      icon: "",
      size: "medium",
      label: "Button10",
      onClick: () => {},
      style: {},
      isSuffix: false,
      textStyles: {},
      hideDefaultActionIcon: false,
      options: [],
      isSearchable: true,
      optionsKey: "name",
      onSelect: () => {},
      menuStyles: {},
    },
    {
      onChange: () => {},
      label: "Checkbox10",
      disabled: false,
      checked: false,
      style: {},
      isLabelFirst: false,
      hideLabel: false,
      mainClassName: "table-checkbox",
      props: {},
    },
    {
      type: "text",
    },
    {
      optionKey: "name",
      option: options,
      select: (option) => {
        console.log(option, "selected");
      },
    },
    {
      optionsKey: "name",
      options: options,
      onSelect: (option) => {
        console.log(option, "selected");
      },
    },
    <div
      style={{
        display: "flex",
        flexDirection: "column",
        gap: "4px",
        justifyContent: "flex-start",
      }}
    >
      <Button
        label={"link10"}
        variation={"link"}
        size={"medium"}
        style={{ padding: "0px", justifyContent: "flex-start" }}
      />
      <div className="typography body-s">{"Description"}</div>
    </div>,
  ],
];

const actions = [
  <div
    style={{
      display: "flex",
      gap: "8px",
      alignItems: "center",
      flexWrap: "wrap",
    }}
  >
    <div className="digit-tag-container" style={{ margin: "0px" }}>
      <Chip text={"Action1"} />
      <Chip text={"Action2"} />
    </div>
    <Button
      variation="primary"
      label={"ButtonAction1"}
      type="button"
      onClick={() => console.log("clicked")}
      size={"medium"}
    />
    <Button
      variation="primary"
      label={"ButtonAction2"}
      type="button"
      onClick={() => console.log("clicked")}
      size={"medium"}
    />
  </div>,
];

const commonArgs = {
  headerData: [],
  rows: [],
  footerContent:"",
  initialRowsPerPage: 5,
  frozenColumns: 0,
  withRowDivider: false,
  withBorder:false,
  withAlternateBg: false,
  withHeaderDivider: false,
  withColumnDivider: false,
  isStickyHeader: false,
  isStickyFooter: false,
  rowsPerPageOptions:[5,10,15,20],
  addCheckbox: false,
  checkboxLabel: "",
  initialSelectedRows: [],
  onSelectedRowsChange: ()=>{},
  addStickyFooter: false,
  showSelectedState: false,
  tableTitle: "",
  tableDescription: "",
  stickyFooterContent: {},
  onRowClick:()=>{},
  hideFooter: false,
  actionButtonLabel: "",
  actions:[],
  headerStyles:{},
  footerStyles:{},
  bodyStyles:{},
  tableStyles:{},
  className:"",
  addFilter:false,
  onFilter:()=>{},
  scrollableStickyFooterContent:false
}

export const Default = Template.bind({});
Default.args = {
  ...commonArgs,
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  rows: rows,
  initialRowsPerPage: 2,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  onRowClick:undefined,
  withHeaderDivider:true,
  withRowDivider:true,
  withBorder:true
};

export const HeadersWithDescription = Template.bind({});
HeadersWithDescription.args = {
  ...commonArgs,
  headerData: headerDataWithDescription,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  rows: rows,
  initialRowsPerPage: 2,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  onRowClick:undefined
};

export const WithBorder = Template.bind({});
WithBorder.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  withBorder: true,
};

export const WithHeaderDivider = Template.bind({});
WithHeaderDivider.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  onRowClick: (row, index) => {
    console.log(row, index, "this row is clicked");
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  withBorder: true,
  withHeaderDivider: true,
};

export const WithOnlyColumnDivider = Template.bind({});
WithOnlyColumnDivider.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  withBorder: true,
  withHeaderDivider: false,
  withColumnDivider: true,
};

export const WithColumnDividerAndHeaderDivider = Template.bind({});
WithColumnDividerAndHeaderDivider.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  withBorder: true,
  withHeaderDivider: true,
  withColumnDivider: true,
};

export const WithRowDivider = Template.bind({});
WithRowDivider.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  withBorder: true,
  withHeaderDivider: false,
  withColumnDivider: false,
  withRowDivider: true,
};

export const WithAlternateBg = Template.bind({});
WithAlternateBg.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  withAlternateBg:true,
  withBorder: true,
};

export const WithAll = Template.bind({});
WithAll.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  withBorder: true,
  withHeaderDivider: true,
  withColumnDivider: true,
  withRowDivider: true,
  withAlternateBg:true
};

export const WithStickyHeader = Template.bind({});
WithStickyHeader.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  onRowClick: (row, index) => {
    console.log(row, index, "this row is clicked");
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: true,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithStickyFooter = Template.bind({});
WithStickyFooter.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: true,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithStickyFooterAndHeader = Template.bind({});
WithStickyFooterAndHeader.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: true,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: true,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithFrozenColumns = Template.bind({});
WithFrozenColumns.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 2,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  withBorder: true,
  withHeaderDivider: false,
  withColumnDivider: true,
};

export const WithTitle = Template.bind({});
WithTitle.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "Table Title",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithTableDescription = Template.bind({});
WithTableDescription.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "Table Title",
  tableDescription: "Table Description",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithAddCheckbox = Template.bind({});
WithAddCheckbox.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: true,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithAddCheckboxAndSelectionState = Template.bind({});
WithAddCheckboxAndSelectionState.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: true,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: true,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  actionButtonLabel: "",
};

export const WithAddChecboxAndSelectionStateAndInitialSelectedRows = Template.bind(
  {}
);
WithAddChecboxAndSelectionStateAndInitialSelectedRows.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: true,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: true,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [0, 1],
  hideFooter: false,
  actionButtonLabel: "",
};

export const WithAddChecboxAndSelectionStateAndInitialSelectedRowsWithActions = Template.bind(
  {}
);
WithAddChecboxAndSelectionStateAndInitialSelectedRowsWithActions.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "Table Title",
  tableDescription: "Description",
  showSelectedState: true,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: true,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [0, 1],
  hideFooter: false,
  actionButtonLabel: "",
};

export const WithAddChecboxAndSelectionStateAndCustomActions = Template.bind(
  {}
);
WithAddChecboxAndSelectionStateAndCustomActions.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "Table Title",
  tableDescription: "Description",
  showSelectedState: true,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: true,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  actionButtonLabel: "",
  actions: actions,
};

export const WithoutFooter = Template.bind({});
WithoutFooter.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: true,
};

export const WithDefaultRowsPerPage = Template.bind({});
WithDefaultRowsPerPage.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  frozenColumns: 0,
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithCustomRowsPerPage = Template.bind({});
WithCustomRowsPerPage.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithCustomFooterContent = Template.bind({});
WithCustomFooterContent.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: <div>{"Here you can add any content"}</div>,
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
};

export const WithStickyFooterContent = Template.bind({});
WithStickyFooterContent.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: true,
  initialSelectedRows: [],
  hideFooter: false,
  addStickyFooter: true,
  scrollableStickyFooterContent:false
};


export const WithScrollableStickyFooterContent = Template.bind({});
WithScrollableStickyFooterContent.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: 
  <tr> 
  <td>GrandTotal</td>
  <td >₹34,000.00</td>
  <td>₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  <td >₹34,000.00</td>
  </tr>,
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: true,
  initialSelectedRows: [],
  hideFooter: false,
  addStickyFooter: true,
  scrollableStickyFooterContent:true
};

export const WithOnRowClick = Template.bind({});
WithOnRowClick.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  onRowClick: (row, index) => {
    console.log(row, index, "this row is clicked");
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  addStickyFooter: true,
};

export const WithFilter = Template.bind({});
WithFilter.args = {
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: rows,
  footerContent: "",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  onFilter:(e)=>{console.log(e,"filter clicked")},
  addFilter:true
};

export const WithCustomStyles = Template.bind({});
WithCustomStyles.args = {
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  headerData:headerDataForCustomStyles,
  onRowClick: (row, index) => {
    console.log(row, index, "this row is clicked");
  },
  tableTitle: "",
  tableDescription: "",
  showSelectedState: false,
  rows: samplerows,
  footerContent: "Footer Content",
  stickyFooterContent: "Sticky Footer Content",
  initialRowsPerPage: 2,
  frozenColumns: 0,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  isStickyHeader: false,
  addCheckbox: false,
  checkboxLabel: "Select All",
  isStickyFooter: false,
  initialSelectedRows: [],
  hideFooter: false,
  addStickyFooter: true,
  headerStyles:{
    backgroundColor:"#0B4B66",
    color:"#FFFFFF"
  },
  bodyStyles:{
    backgroundColor:"#FFFFFF",
    color:"#0B4B66"
  },
  footerStyles:{
    color:"#363636"
  }
};


export const WithAscendingAsInitialSortOrder = Template.bind({});
WithAscendingAsInitialSortOrder.args = {
  ...commonArgs,
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  rows: rows,
  initialRowsPerPage: 2,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  onRowClick:undefined,
  initialSortOrder: "ascending",
  isTableSortable:true,
};

export const WithDescendingAsInitialSortOrder = Template.bind({});
WithDescendingAsInitialSortOrder.args = {
  ...commonArgs,
  headerData: headerData,
  onSelectedRowsChange: (e) => {
    console.log("These are the selected rows", e);
  },
  rows: rows,
  initialRowsPerPage: 2,
  rowsPerPageOptions: [2, 4, 6, 8, 10],
  onRowClick:undefined,
  initialSortOrder: "descending",
  isTableSortable:true,
};