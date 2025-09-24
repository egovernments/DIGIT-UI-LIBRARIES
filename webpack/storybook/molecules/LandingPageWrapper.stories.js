import React from "react";
import LandingPageCard from "@egovernments/digit-ui-components/molecules/LandingPageCard";
import LandingPageWrapper from "@egovernments/digit-ui-components/molecules/LandingPageWrapper";
import { Iframe } from "@egovernments/digit-ui-components/atoms";

export default {
  title: "MoleculeGroup/Landing Page Wrapper",
  component: LandingPageWrapper,
  argTypes: {
    numberOfCards: {
      control: { type: "number", min: 1 },
      defaultValue: 3,
      name: "No of Cards",
      description: "Number of LandingPageCards to display",
    },
    children: { table: { disable: true } },
    className: { table: { disable: true } },
    styles: { table: { disable: true } },
  },
};

const Template = (args) => {
  const { numberOfCards } = args;

  const generateCards = (count) => {
    return Array.from({ length: count }, (_, index) => (
      <LandingPageCard
        key={index}
        icon="SupervisorAccount"
        moduleName={`Card ${index + 1}`}
        metrics={[
          { count: 10 + index, label: `Label Metric ${index + 1}`, link: "#" },
          { count: 20 + index, label: `Label Metric ${index + 1}`, link: "#" },
        ]}
        links={[
          {
            label: `Link ${index + 1}`,
            link: "#",
            icon: "Dashboard",
          },
          {
            label: `Link ${index + 1}`,
            link: "#",
            icon: "Dashboard",
          },
        ]}
      />
    ));
  };

  return (
    <LandingPageWrapper>{generateCards(numberOfCards)}</LandingPageWrapper>
  );
};



export const Basic = Template.bind({});
Basic.args = {
  numberOfCards: 3,
};

export const Documentation = () => (
  <Iframe
    // Todo: Update the URL
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0"
    title="LandingPageWrapper Documentation"
  />
);

Documentation.storyName = "Detailed Props Definition";
Documentation.argTypes = {
  numberOfCards: {
    table: { disable: true },
  },
};

