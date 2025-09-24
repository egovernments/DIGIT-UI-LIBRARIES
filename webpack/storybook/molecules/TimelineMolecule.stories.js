import React from "react";
import TimelineMolecule from "@egovernments/digit-ui-components/molecules/TimelineMolecule";
import { Button } from "@egovernments/digit-ui-components/atoms";
import Timeline from "@egovernments/digit-ui-components/atoms";
import { createDocumentationStory } from "../.storybook/DocumentationComponent";
export default {
  title: "Molecules/Timeline Molecule",
  component: TimelineMolecule,
  argTypes: {
    initialVisibleCount: { table: { disable: true } },
    additionalWidgets: {
      control: "boolean",
      name: "Additional Widgets",
      defaultValue: false,
    },
  },
};

const subElements = [
  "26 / 03 / 2024",
  "11:00 PM",
  "26 / 03 / 2024 11:00 PM",
  "26 / 03 / 2024 11:00 PM Mon",
  "+91 **********",
];

const additionalElements = [
  <div key="1">
    Lorem Ipsum is simply dummy text of the printing and typesetting industry.
    Lorem Ipsum has been the industry's
  </div>,
  <Button variation="link" label={"Click on the link"} type="button" />,
  <img
    key="2"
    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s"
    alt="Additional Element 2"
  />,
  <img
    key="3"
    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s"
    alt="Additional Element 3"
  />,
  <img
    key="4"
    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s"
    alt="Additional Element 4"
  />,
  <img
    key="5"
    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s"
    alt="Additional Element 5"
  />,
  <img
    key="6"
    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s"
    alt="Additional Element 6"
  />,
  <img
    key="7"
    src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIGMLufj86aep95KwMzr3U0QShg7oxdAG8gBPJ9ALIFQ&s"
    alt="Additional Element 7"
  />,
  <img
    key="8"
    src="https://digit.org/wp-content/uploads/2023/06/Digit-Logo-1.png"
    alt="Additional Element 8"
  />,
  <Button
    variation="primary"
    label={"Button"}
    type="button"
    icon="MyLocation"
  />,
  <Button
    variation="secondary"
    label={"Button"}
    type="button"
    icon="MyLocation"
    isSuffix={true}
  />,
];



const Template = (args) => {
  return <Wrapper {...args} />;
};

export const Basic = Template.bind({});
Basic.args = {};

export const Collapsible = Template.bind({});
Collapsible.args = {
  initialVisibleCount: 3,
};

export const Documentation = createDocumentationStory("TimelineMolecule", "molecules");