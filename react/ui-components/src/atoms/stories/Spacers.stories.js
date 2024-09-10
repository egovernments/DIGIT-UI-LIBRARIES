import React from "react";
import { Spacers } from "../../constants/spacers/spacers";

export default {
  title: "Spacers",
  argTypes: {
    spacer: {
      control: {
        type: "select",
        options: [
          "spacer0",
          "spacer1",
          "spacer2",
          "spacer3",
          "spacer4",
          "spacer5",
          "spacer6",
          "spacer7",
          "spacer8",
          "spacer9",
          "spacer10",
          "spacer11",
          "spacer12",
        ],
      },
    },
  },
};

const Template = (args) => {
  return (
    <div
      style={{
        width: "100%",
        height:Spacers?.[args?.spacer],
        background:"#d6d5d4"
      }}
    ></div>
  );
};

export const Playground = Template.bind({});
Playground.args = {
  spacer: "spacer1",
};
