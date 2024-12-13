import React from "react";
import { Button } from "../../atoms";
import {ButtonGroup} from "../../atoms";

export default {
  title: "Molecules/ButtonGroup",
  component: ButtonGroup,
  argTypes: {
  },
};

const Template = (args) => <ButtonGroup {...args} />;

const buttons = [
    <Button type={"button"} size={"large"} variation={"primary"} label="ButtonPrimary" onClick={() => console.log("Clicked Button 1")} />,
    <Button type={"button"} size={"large"} variation={"primary"} label="Buttons" onClick={() => console.log("Clicked Button 2")} />,
  ];

  const sortThisbuttons = [
    <Button type={"button"} size={"large"} variation={"teritiary"} label="ButtonPrimary" onClick={() => console.log("Clicked Button 1")} />,
    <Button type={"button"} size={"large"} variation={"primary"} label="ButtonPrimary" onClick={() => console.log("Clicked Button 1")} />,
    <Button type={"button"} size={"large"} variation={"secondary"} label="Buttons" onClick={() => console.log("Clicked Button 2")} />,
  ];

  const sortThisbuttonsMedium = [
    <Button type={"button"} size={"medium"} variation={"teritiary"} label="ButtonPrimary" onClick={() => console.log("Clicked Button 1")} />,
    <Button type={"button"} size={"medium"} variation={"primary"} label="ButtonPrimary" onClick={() => console.log("Clicked Button 1")} />,
    <Button type={"button"} size={"medium"} variation={"secondary"} label="Buttons" onClick={() => console.log("Clicked Button 2")} />,
  ];

  const sortThisbuttonsSmall = [
    <Button type={"button"} size={"small"} variation={"teritiary"} label="ButtonPrimary" onClick={() => console.log("Clicked Button 1")} />,
    <Button type={"button"} size={"small"} variation={"primary"} label="ButtonPrimary" onClick={() => console.log("Clicked Button 1")} />,
    <Button type={"button"} size={"small"} variation={"secondary"} label="Buttons" onClick={() => console.log("Clicked Button 2")} />,
  ];

  export const Documentation = () => (
    <iframe
      //Todo:Update the url
      src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
      width="100%"
      height="830"
      style={{ border: "none" }}
      title="Accordion Documentation"
    />
  );

  Documentation.storyName = "Docs";

export const Default = Template.bind({});
Default.args = {
  buttonsArray: buttons,
};

export const ButtonsGroupWithUnSortedButtons = Template.bind({});
ButtonsGroupWithUnSortedButtons.args = {
  buttonsArray: sortThisbuttons,
  sortButtons:false
};

export const ButtonsGroupWithSortedButtons = Template.bind({});
ButtonsGroupWithSortedButtons.args = {
  buttonsArray: sortThisbuttons,
  sortButtons:true
};

export const ButtonsGroupWithUnSortedButtonsMedium = Template.bind({});
ButtonsGroupWithUnSortedButtonsMedium.args = {
  buttonsArray: sortThisbuttonsMedium,
  sortButtons:false
};

export const ButtonsGroupWithSortedButtonsMedium = Template.bind({});
ButtonsGroupWithSortedButtonsMedium.args = {
  buttonsArray: sortThisbuttonsMedium,
  sortButtons:true
};

export const ButtonsGroupWithUnSortedButtonsSmall= Template.bind({});
ButtonsGroupWithUnSortedButtonsSmall.args = {
  buttonsArray: sortThisbuttonsSmall,
  sortButtons:false
};

export const ButtonsGroupWithSortedButtonsSmall = Template.bind({});
ButtonsGroupWithSortedButtonsSmall.args = {
  buttonsArray: sortThisbuttonsSmall,
  sortButtons:true
};