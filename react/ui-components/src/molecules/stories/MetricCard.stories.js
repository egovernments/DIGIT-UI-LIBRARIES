import React from "react";
import MetricCard from "../MetricCard";
import { Iframe } from "../../atoms";

export default {
  title: "Molecules/MetricCard",
  component: MetricCard,
  argTypes: {
    metrics: { control: "array" },
    layout: { control: "text" },
    withDivider: { control: "boolean" },
    className: { control: "text" },
    styles: { control: "object" },
    withBottomDivider: { control: "boolean" },
  },
};

const Template = (args) => <MetricCard {...args} />;

const commonArgs = {
  metrics: [],
  className: "",
  styles: {},
  withDivider: false,
  withBottomDivider: false,
};

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="MetricCard Documentation"
  />
);

Documentation.storyName = "Docs";

// Default story for MetricCard
export const Default = Template.bind({});
Default.args = {
  ...commonArgs,
  metrics: [
    {
      value: "3%",
      description: "Test Compilance",
      statusmessage: "10% than state average",
      status: "Decreased",
    },
    {
      value: "60%",
      description: "Quality Tests Passed",
      statusmessage: "80% than state average",
      status: "Increased",
    },
    {
      value: "90%",
      description: "description",
      statusmessage: "15% than state average",
      status: "Nochange",
    },
    {
      value: "26%",
      description: "description",
      statusmessage: "6% than state average",
      status: "Increased",
    },
  ],
};

// Default story for MetricCard
export const WithLayout = Template.bind({});
WithLayout.args = {
  ...commonArgs,
  layout: "2*2",
  metrics: [
    {
      value: "3%",
      description: "Test Compilance",
      statusmessage: "10% than state average",
      status: "Decreased",
    },
    {
      value: "60%",
      description: "Quality Tests Passed",
      statusmessage: "80% than state average",
      status: "Increased",
    },
    {
      value: "90%",
      description: "description",
      statusmessage: "15% than state average",
      status: "Nochange",
    },
    {
      value: "26%",
      description: "description",
      statusmessage: "6% than state average",
      status: "Increased",
    },
  ],
};

// Default story for MetricCard
export const WithDivider = Template.bind({});
WithDivider.args = {
  ...commonArgs,
  layout: "2*2",
  withDivider: true,
  metrics: [
    {
      value: "3%",
      description: "Test Compilance",
      statusmessage: "10% than state average",
      status: "Decreased",
    },
    {
      value: "60%",
      description: "Quality Tests Passed",
      statusmessage: "80% than state average",
      status: "Increased",
    },
    {
      value: "90%",
      description: "description",
      statusmessage: "15% than state average",
      status: "Nochange",
    },
    {
      value: "26%",
      description: "description",
      statusmessage: "6% than state average",
      status: "Increased",
    },
  ],
};

export const WithBottomDivider = Template.bind({});
WithBottomDivider.args = {
  ...commonArgs,
  layout: "2*2",
  withDivider: false,
  withBottomDivider: true,
  metrics: [
    {
      value: "3%",
      description: "Test Compilance",
      statusmessage: "10% than state average",
      status: "Decreased",
    },
    {
      value: "60%",
      description: "Quality Tests Passed",
      statusmessage: "80% than state average",
      status: "Increased",
    },
    {
      value: "90%",
      description: "description",
      statusmessage: "15% than state average",
      status: "Nochange",
    },
    {
      value: "26%",
      description: "description",
      statusmessage: "6% than state average",
      status: "Increased",
    },
  ],
};

export const WithBothDividers = Template.bind({});
WithBothDividers.args = {
  ...commonArgs,
  layout: "2*2",
  withDivider: true,
  withBottomDivider: true,
  metrics: [
    {
      value: "3%",
      description: "Test Compilance",
      statusmessage: "10% than state average",
      status: "Decreased",
    },
    {
      value: "60%",
      description: "Quality Tests Passed",
      statusmessage: "80% than state average",
      status: "Increased",
    },
    {
      value: "90%",
      description: "description",
      statusmessage: "15% than state average",
      status: "Nochange",
    },
    {
      value: "26%",
      description: "description",
      statusmessage: "6% than state average",
      status: "Increased",
    },
  ],
};

// MetricCard with custom styles
export const CustomStyles = Template.bind({});
CustomStyles.args = {
  className: "",
  layout: "2*2",
  metrics: [
    {
      value: "3%",
      description: "Test Compilance",
      statusmessage: "10% than state average",
      status: "Decreased",
    },
    {
      value: "60%",
      description: "Quality Tests Passed",
      statusmessage: "80% than state average",
      status: "Increased",
    },
    {
      value: "90%",
      description: "description",
      statusmessage: "15% than state average",
      status: "Nochange",
    },
    {
      value: "26%",
      description: "description",
      statusmessage: "6% than state average",
      status: "Increased",
    },
  ],
  styles: {
    backgroundColor: "#f9f9f9",
    borderRadius: "12px",
    border: "2px solid #333",
  },
};
