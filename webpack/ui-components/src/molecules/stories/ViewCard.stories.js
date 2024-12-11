import React from "react";
import ViewCard from "../ViewCard";

export default {
  title: "Molecules/Card/ViewCard",
  component: ViewCard,
  argTypes: {
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    type: { control: "select", options: ["primary", "secondary"] },
    header:{control:"text"},
    subHeader:{control:"text"},
    sections:{
      control:"array"
    },
    withDivider:{control:"boolean"},
    withSectionDivider:{control:"boolean"},
    layout:{control:"number"},
    showSectionsAsMultipleCards:{control:"boolean"},
    asSeperateCards:{control:"boolean"}
  },
};

const Template = (args) => <ViewCard {...args} />;

const sections = [
  {
    type:"DATA",
    header: "Personal Information",
    subHeader: "Basic details",
    fieldPairs: [
      { label: "Name", value: "John Doe", inline: true },
      { label: "Age", value: "28", inline: true },
    ],
    cardType:"primary"
  },
  {
    type:"DATA",
    header: "Contact Information",
    subHeader: "How to reach me",
    fieldPairs: [
      { label: "Email", value: "john.doe@example.com", inline: true },
      { label: "Phone", value: "+1 123-456-7890", inline: true },
    ],
    cardType:"primary"
  },
  {
    type:"DATA",
    header: "Address",
    subHeader: "Where I live",
    fieldPairs: [
      { label: "Street", value: "123 Main St", inline: true },
      { label: "City", value: "Los Angeles", inline: true },
      { label: "State", value: "CA", inline: true },
      { label: "Zip Code", value: "90001", inline: true },
    ],
    cardType:"primary"
  },
]

const secondaryCardSections = [
  {
    header: "Personal Information",
    subHeader: "Basic details",
    fieldPairs: [
      { label: "Name", value: "John Doe", inline: true },
      { label: "Age", value: "28", inline: false },
    ],
    cardType:"secondary"
  },
  {
    header: "Contact Information",
    subHeader: "How to reach me",
    fieldPairs: [
      { label: "Email", value: "john.doe@example.com", inline: true },
      { label: "Phone", value: "+1 123-456-7890", inline: false },
    ],
    cardType:"secondary"
  },
  {
    header: "Address",
    subHeader: "Where I live",
    fieldPairs: [
      { label: "Street", value: "123 Main St", inline: true },
      { label: "City", value: "Los Angeles", inline: false },
      { label: "State", value: "CA", inline: true },
      { label: "Zip Code", value: "90001", inline: false },
    ],
    cardType:"secondary"
  },
]

const commonArgs = {
  className: "",
  style: {},
  type:"primary",
  header:"Heading",
  subHeader:"Subheading",
  withDivider: false,
  layout:1,
  sections:sections,
  withSectionDivider:false,
  showSectionsAsMultipleCards:false,
  asSeperateCards:false
};

export const Default = Template.bind({});
Default.args = {
  ...commonArgs,
};

export const WithDivider = Template.bind({});
WithDivider.args = {
  ...commonArgs,
  withDivider: true,
};

export const TwoColumnLayout = Template.bind({});
TwoColumnLayout.args = {
  ...commonArgs,
  layout:2,
};


export const TwoColumnLayoutWithDivider = Template.bind({});
TwoColumnLayoutWithDivider.args = {
  ...commonArgs,
  layout:2,
  withDivider:true,
};

export const WithSectionDivider = Template.bind({});
WithSectionDivider.args = {
  ...commonArgs,
  withSectionDivider:true
};

export const WithDividerAndSectionDivider = Template.bind({});
WithDividerAndSectionDivider.args = {
  ...commonArgs,
  withSectionDivider:true,
  withDivider:true
};

export const TwoColumnLayoutAndSectionDivider = Template.bind({});
TwoColumnLayoutAndSectionDivider.args = {
  ...commonArgs,
  layout:2,
  withSectionDivider:true
};

export const TwoColumnLayoutWithDividerAndSectionDivider = Template.bind({});
TwoColumnLayoutWithDividerAndSectionDivider.args = {
  ...commonArgs,
  layout:2,
  withDivider:true,
  withSectionDivider:true
};

export const WithSeactionsAsCards = Template.bind({});
WithSeactionsAsCards.args = {
  ...commonArgs,
  showSectionsAsMultipleCards:true,
  withDivider:false,
  withSectionDivider:false
};

export const WithSeactionsAsCardsAndTwoColumnLayout = Template.bind({});
WithSeactionsAsCardsAndTwoColumnLayout.args = {
  ...commonArgs,
  layout:2,
  showSectionsAsMultipleCards:true,
  withDivider:false,
  withSectionDivider:false,
};

export const WithSectionsAsCardsAndOuterCardSecondary = Template.bind({});
WithSectionsAsCardsAndOuterCardSecondary.args = {
  ...commonArgs,
  showSectionsAsMultipleCards:true,
  withDivider:false,
  withSectionDivider:false,
  type:"secondary"
};

export const WithSectionsAsCardsAndSectionCardsSecondary = Template.bind({});
WithSectionsAsCardsAndSectionCardsSecondary.args = {
  ...commonArgs,
  showSectionsAsMultipleCards:true,
  withDivider:false,
  withSectionDivider:false,
  sections:secondaryCardSections
};


export const asSeperateCards= Template.bind({});
asSeperateCards.args = {
  ...commonArgs,
  showSectionsAsMultipleCards:true,
  withDivider:false,
  withSectionDivider:false,
  asSeperateCards:true
};