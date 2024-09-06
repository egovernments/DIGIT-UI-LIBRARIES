import React from "react";
import LandingPageCard from "../../molecules/LandingPageCard";

export default {
  title: "Molecules/LandingPageCard",
  component: LandingPageCard,
  argTypes: {
    icon: { control: "object" },
    moduleName: { control: "text" },
    metrics: { control: "array" },
    links: { control: "array" },
    className: { control: "text" },
    styles: { control: "object" },
    moduleAlignment: { control: "select", options: ["left", "right"] },
    metricAlignment: { control: "select", options: ["left", "centre"] },
    iconBg: { control: "boolean" },
    onMetricClick: { control: "action" },
  },
};

const Template = (args) => <LandingPageCard {...args} />;

const commonArgs = {
  icon: "SupervisorAccount",
  variation: "one",
  moduleName: "Dashboards",
  moduleAlignment: "right",
  metrics: [
    {
      count: 40,
      label: "Lorem Ipsum",
      link:
        "https://unified-dev.digit.org/storybook/?path=/story/atoms-backlink--primary",
    },
    {
      count: 40,
      label: "Lorem Ipsum",
      link:
        "https://unified-dev.digit.org/storybook/?path=/story/atoms-backlink--primary",
    },
  ],
  links: [
    {
      label: "Create User",
      link:
        "https://unified-dev.digit.org/storybook/?path=/story/atoms-backlink--primary",
      icon: "Add",
    },
    {
      label: "Edit User",
      link:
        "https://unified-dev.digit.org/storybook/?path=/story/atoms-backlink--primary",
      icon: "Edit",
    },
    {
      label: "View User",
      link:
        "https://unified-dev.digit.org/storybook/?path=/story/atoms-backlink--primary",
      icon: "Preview",
    },
    {
      label: "Delete User",
      link:
        "https://unified-dev.digit.org/storybook/?path=/story/atoms-backlink--primary",
      icon: "Delete",
    },
  ],
  className: "",
  metricAlignment: "left",
  styles: {},
  iconBg: false,
  onMetricClick: (metric, count) => {
    console.log(metric, count);
  },
};

const longmetriclabel = [
  {
    count: 40,
    label: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
    link:
      "https://unified-dev.digit.org/storybook/?path=/story/atoms-backlink--primary",
  },
  {
    count: 40,
    label: "Lorem Ipsum",
    link:
      "https://unified-dev.digit.org/storybook/?path=/story/atoms-backlink--primary",
  },
]
export const RightModuleAlignment = Template.bind({});
RightModuleAlignment.args = {
  ...commonArgs,
};

export const RightModuleAlignmentWithIconBg = Template.bind({});
RightModuleAlignmentWithIconBg.args = {
  ...commonArgs,
  iconBg: true,
};

export const LeftModuleAlignment = Template.bind({});
LeftModuleAlignment.args = {
  ...commonArgs,
  moduleAlignment: "left",
};

export const LeftModuleAlignmentWithIconBg = Template.bind({});
LeftModuleAlignmentWithIconBg.args = {
  ...commonArgs,
  moduleAlignment: "left",
  iconBg: true,
};

export const LeftMetricAlignment = Template.bind({});
LeftMetricAlignment.args = {
  ...commonArgs,
};

export const CentreMetricAlignment = Template.bind({});
CentreMetricAlignment.args = {
  ...commonArgs,
  metricAlignment: "centre",
};

export const WithoutIcon = Template.bind({});
WithoutIcon.args = {
  ...commonArgs,
  icon:""
};

export const WithoutMetrics = Template.bind({});
WithoutMetrics.args = {
  ...commonArgs,
  metrics: [],
};

export const WithoutLinks = Template.bind({});
WithoutLinks.args = {
  ...commonArgs,
  links: [],
};

// export const LongText = Template.bind({});
// LongText.args = {
//   ...commonArgs,
//   moduleName:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
//   metrics:longmetriclabel
// };

export const WithCustomStyles = Template.bind({});
WithCustomStyles.args = {
  ...commonArgs,
  styles: {
    backgroundColor: "#fafafa",
    padding: "20px",
    borderRadius: "8px",
    border: "2px solid black",
  },
};
