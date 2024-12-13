import React,{Fragment} from "react";
import MenuCardWrapper from "../MenuCardWrapper";
import MenuCard from "../MenuCard";
import {Iframe} from "../../atoms";

export default {
  title: "MoleculeGroup/MenuCardWrapper",
  component: MenuCardWrapper,
};

const Template = (args) => <MenuCardWrapper {...args} />;

export const Documentation = () => (
  <Iframe
    //Todo:Update the url
    src="https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-core-react-components/input-field"
    title="MenuCardWrapper Documentation"
  />
);

Documentation.storyName = "Docs";


// Default story showing a group of MenuCards
export const GroupOfMenuCards = Template.bind({});
GroupOfMenuCards.args = {
  children: (
    <>
      <MenuCard
        icon={"Article"}
        menuName={"Menu"}
        description={
          "Use this checklist to supervise the team formation for Registration & Distribution"
        }
        className={""}
        styles={{}}
        onClick={(e) => {
          console.log(e);
        }}
      />
      <MenuCard
        icon={"Article"}
        menuName={"Menu"}
        description={
          "Use this checklist to supervise the team formation for Registration & Distribution"
        }
        className={""}
        styles={{}}
        onClick={(e) => {
          console.log(e);
        }}
      />
      <MenuCard
        icon={"Article"}
        menuName={"Menu"}
        description={
          "Use this checklist to supervise the team formation for Registration & Distribution"
        }
        className={""}
        styles={{}}
        onClick={(e) => {
          console.log(e);
        }}
      />
    </>
  ),
};

// MenuCardWrapper with custom styles
export const CustomStyledWrapper = Template.bind({});
CustomStyledWrapper.args = {
  className: "",
  styles: {
    display: "flex",
    flexDirection: "column",
    gap: "32px",
    padding: "16px",
    backgroundColor: "#f4f4f4",
  },
  children: (
    <>
      <MenuCard
        icon={"Article"}
        menuName={"Menu"}
        description={
          "Use this checklist to supervise the team formation for Registration & Distribution"
        }
        className={""}
        styles={{}}
        onClick={(e) => {
          console.log(e);
        }}
      />
      <MenuCard
        icon={"Article"}
        menuName={"Menu"}
        description={
          "Use this checklist to supervise the team formation for Registration & Distribution"
        }
        className={""}
        styles={{}}
        onClick={(e) => {
          console.log(e);
        }}
      />
    </>
  ),
};
