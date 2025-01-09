import React from "react";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import FieldV1 from "../../hoc/FieldV1";
import { CustomDropdown } from "../../molecules";

export default {
  title: "Atoms/DropDown/MultiSelect",
  component: CustomDropdown,
  argTypes: {
    t: { control: false },
    populators: { control: "object" },
    inputRef: { control: false },
    label: { control: "text" },
    onChange: { action: "onChange" },
    value: { control: "text" },
    errorStyle: { control: "object" },
    disabled: { control: "boolean" },
    isSearchable: { control: "boolean" },
    additionalWrapperClass: { control: "text" },
    props: { control: "object" },
    type: { control: "select", options: ["dropdown", "multiselectdropdown"] },
    variant: {
      control: "select",
      options: [
        "nestedmultiselect",
        "treemultiselect",
        "nestedtextmultiselect",
      ],
    },
  },
};
const queryClient = new QueryClient();

const Template = (args) => (
  <QueryClientProvider client={queryClient}>
    <FieldV1 {...args} />
  </QueryClientProvider>
);

const t = (key) => key;

//mock options data
const gendersOptions = [
  { code: "Option1", name: "Option1" },
  { code: "Option2", name: "Option2" },
  { code: "Option3", name: "Option3" },
];
//options with icons
const OptionsWithIcons = [
  { code: "Option1", name: "Option1", icon: "Article" },
  { code: "Option2", name: "Option2", icon: "Article" },
  { code: "Option3", name: "Option3", icon: "Article" },
];
//options with description
const OptionsWithNestedText = [
  {
    code: "Option1",
    name: "Option1",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  },
  {
    code: "Option2",
    name: "Option2",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  },
  {
    code: "Option3",
    name: "Option3",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  },
];
//options with description and icon
const NestedTextOptionWithIcons = [
  {
    code: "Option1",
    name: "Option1",
    icon: "Article",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  },
  {
    code: "Option2",
    name: "Option2",
    icon: "Article",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  },
  {
    code: "Option3",
    name: "Option3",
    icon: "Article",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna",
  },
];

//nested options
const nestedOptions = [
  {
    name: "Category A",
    options: [
      { code: "Category A.Option A", name: "Option A" },
      { code: "Category A.Option B", name: "Option B" },
      { code: "Category A.Option C", name: "Option C" },
    ],
    code: "Category A",
  },
  {
    name: "Category B",
    options: [
      { code: "Category B.Option A", name: "Option A" },
      { code: "Category B.Option 2", name: "Option 2" },
      { code: "Category B.Option 3", name: "Option 3" },
    ],
    code: "Category B",
  },
];
//nested options with icons
const nestedOptionsWithIcons = [
  {
    name: "Category A",
    options: [
      { code: "Category A.Option A", name: "Option A", icon: "Article" },
      { code: "Category A.Option B", name: "Option B", icon: "Article" },
      { code: "Category A.Option C", name: "Option C", icon: "Article" },
    ],
    code: "Category A",
  },
  {
    name: "Category B",
    options: [
      { code: "Category B.Option 1", name: "Option 1", icon: "Article" },
      { code: "Category B.Option 2", name: "Option 2", icon: "Article" },
      { code: "Category B.Option 3", name: "Option 3", icon: "Article" },
    ],
    code: "Category B",
  },
];
//tree select options
const treeDropdownOptions = [
  {
    name: "Category A",
    options: [
      {
        code: "Category A.Option A",
        name: "Option A",
        options: [
          { code: "Category A.Option A.Option 1", name: "Option 1" },
          { code: "Category A.Option A.Option 2", name: "Option 2" },
        ],
      },
      {
        code: "Category A.Option B",
        name: "Option B",
        options: [
          { code: "Category A.Option B.Option 1", name: "Option 1" },
          { code: "Category A.Option B.Option 2", name: "Option 2" },
        ],
      },
    ],
    code: "Category A",
  },
  {
    name: "Category B",
    options: [
      { code: "Category B.Option A", name: "Option A" },
      {
        code: "Category B.Option B",
        name: "Option B",
        options: [
          { code: "Category B.Option B.Option 1", name: "Option 1" },
          { code: "Category B.Option B.Option 2", name: "Option 2" },
        ],
      },
    ],
    code: "Category B",
  },
  {
    name: "Category C",
    options: [{ code: "Category C.Option A", name: "Option A" },{ code: "Category C.Option B", name: "Option B" }],
    code: "Category C",
  },
];

//mock options data for chipskey
const optionsForChipsKey = [
  { code: "Option1chip", name: "Option1" },
  { code: "Option2chip", name: "Option2" },
  { code: "Option3chip", name: "Option3" },
];

//nested options for chips key
const nestedOptionsForChipKey = [
  {
    name: "Category A",
    options: [
      { code: "Category A.Option A", name: "Option A Chipkey" },
      { code: "Category A.Option B", name: "Option B Chipkey" },
      { code: "Category A.Option C", name: "Option C Chipkey " },
    ],
    code: "Category A",
  },
  {
    name: "Category B",
    options: [
      { code: "Category B.Option A", name: "Option A Chipkey" },
      { code: "Category B.Option 2", name: "Option 2 Chipkey" },
      { code: "Category B.Option 3", name: "Option 3 Chipkey" },
    ],
    code: "Category B",
  },
];

const commonArgs = {
  t,
  populators: {
    name: "genders",
    defaultValue: "FEMALE",
    optionsCustomStyle: {},
    optionsKey: "name",
    options: gendersOptions,
    showIcon: false,
    isSearchable:true,
    clearLabel:"Clear All",
    addSelectAllCheck:false,
    addCategorySelectAllCheck:false,
    selectAllLabel: "",
    categorySelectAllLabel:"",
    chipsKey:""
  },
  error: "",
  inputRef: null,
  label: "Select Option",
  onChange: (e, name) => console.log("Selected value:", e, "Name:", name),
  errorStyle: null,
  disabled: false,
  type: "dropdown",
  additionalWrapperClass: "",
  props: {
    isLoading: false,
    data: gendersOptions,
  },
  description: "",
};

export const Basic = Template.bind({});
Basic.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    isDropdownWithChip: true,
  },
};

export const BasicWithSelectAllCheck = Template.bind({});
BasicWithSelectAllCheck.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    isDropdownWithChip: true,
    addSelectAllCheck:true,
  },
};

export const BasicWithIcons = Template.bind({});
BasicWithIcons.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "iconoptions",
    options: OptionsWithIcons,
    showIcon: true,
    isDropdownWithChip: true,
  },
};

export const BasicWithChipsKey = Template.bind({});
BasicWithChipsKey.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    options:optionsForChipsKey,
    isDropdownWithChip: true,
    chipsKey:"code"
  },
};

export const Disabled = Template.bind({});
Disabled.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  disabled: true,
};

export const Categorical = Template.bind({});
Categorical.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "nestedmultiselectoptions",
    options: nestedOptions,
    isDropdownWithChip: true,
  },
  variant: "nestedmultiselect",
};

export const CategoricalWithSelectAllCheck = Template.bind({});
CategoricalWithSelectAllCheck.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "nestedmultiselectoptions",
    options: nestedOptions,
    isDropdownWithChip: true,
    addSelectAllCheck:true,
    addCategorySelectAllCheck:true
  },
  variant: "nestedmultiselect",
};

export const CategoricalWithIcons = Template.bind({});
CategoricalWithIcons.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "nestedmultiselectoptions",
    options: nestedOptionsWithIcons,
    showIcon: true,
    isDropdownWithChip: true,
  },
  variant: "nestedmultiselect",
};

export const CategoricalWithChipskey = Template.bind({});
CategoricalWithChipskey.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "nestedmultiselectoptions",
    options: nestedOptionsForChipKey,
    isDropdownWithChip: true,
    chipsKey:"name"
  },
  variant: "nestedmultiselect",
};

export const NestedText = Template.bind({});
NestedText.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "nestedtextltiselect",
    options: OptionsWithNestedText,
    isDropdownWithChip: true,
  },
  variant: "nestedtextmultiselect",
};

export const NestedTextWithSelectAllCheck = Template.bind({});
NestedTextWithSelectAllCheck.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "nestedtextltiselect",
    options: OptionsWithNestedText,
    isDropdownWithChip: true,
    addSelectAllCheck:true
  },
  variant: "nestedtextmultiselect",
};

export const NestedTextWithIcons = Template.bind({});
NestedTextWithIcons.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "nestedtextltiselect",
    options: NestedTextOptionWithIcons,
    isDropdownWithChip: true,
    showIcon: true,
  },
  variant: "nestedtextmultiselect",
};

export const TreeMultiselect = Template.bind({});
TreeMultiselect.args = {
  ...commonArgs,
  type: "multiselectdropdown",
  populators: {
    ...commonArgs.populators,
    name: "treeoptions",
    options: treeDropdownOptions,
    isDropdownWithChip: true,
  },
  variant: "treemultiselect",
};