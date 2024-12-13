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
    style: { control: "object" },
    moduleAlignment: { control: "select", options: ["left", "right"] },
    metricAlignment: { control: "select", options: ["left", "centre"] },
    iconBg: { control: "boolean" },
    onMetricClick: { control: "action" },
    buttonSize:{ control: "select", options: ["large","medium", "small"] },
  },
};

const Template = (args) => <LandingPageCard {...args} />;

const commonArgs = {
  icon: "SupervisorAccount",
  variation: "one",
  moduleName: "Dashboards",
  moduleAlignment: "right",
  buttonSize:"medium",
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
      icon: "Person",
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
  style: {},
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

export const Documentation = () => (
  <iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    width="100%"
    height="830"
    style={{ border: "none" }}
    title="LandingPageCard Documentation"
  />
);

Documentation.storyName = "Docs";


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

export const LongText = Template.bind({});
LongText.args = {
  ...commonArgs,
  moduleName:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
  metrics:longmetriclabel
};

export const WithChildren = Template.bind({});
WithChildren.args = {
  ...commonArgs,
  centreChildren:[
    <div>{"Here you can add any text content between metrics and links"}</div>
  ],
  endChildren:[
    <div>{"Here you can add any text content below links"}</div>
  ],
};

export const WithCustomStyles = Template.bind({});
WithCustomStyles.args = {
  ...commonArgs,
  style: {
    backgroundColor: "#fafafa",
    padding: "20px",
    borderRadius: "8px",
    border: "2px solid black",
  },
};

export const WithoutIcon = Template.bind({});
WithoutIcon.args = {
  ...commonArgs,
  icon:""
};

export const WithOnlyModuleName = Template.bind({});
WithOnlyModuleName.args = {
  ...commonArgs,
  links:[],
  metrics:[],
  centreChildren:[],
  hideDivider:true
};

export const WithModuleAndMetrics = Template.bind({});
WithModuleAndMetrics.args = {
  ...commonArgs,
  links:[],
  centreChildren:[]
};

export const WithModuleAndLinks = Template.bind({});
WithModuleAndLinks.args = {
  ...commonArgs,
  metrics: [],
};

export const WithModuleAndChildren = Template.bind({});
WithModuleAndChildren.args = {
  ...commonArgs,
  metrics:[],
  links:[],
  centreChildren:[
    <div>{"Here you can add any text content"}</div>
  ]
};

export const WithModuleAndChildrenAndMetrics = Template.bind({});
WithModuleAndChildrenAndMetrics.args = {
  ...commonArgs,
  links:[],
  centreChildren:[
    <div>{"Here you can add any text content"}</div>
  ]
};

export const WithModuleAndChildrenAndLinks = Template.bind({});
WithModuleAndChildrenAndLinks.args = {
  ...commonArgs,
  metrics:[],
  centreChildren:[
    <div>{"Here you can add any text content"}</div>
  ]
};

export const WithModuleAndEndChildrenAndLinks = Template.bind({});
WithModuleAndEndChildrenAndLinks.args = {
  ...commonArgs,
  metrics:[],
  endChildren:[
    <div>{"Here you can add any text content"}</div>
  ]
};