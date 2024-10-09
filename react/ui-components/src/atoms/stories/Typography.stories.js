import React from "react";

export default {
  title: "Foundations/Typography",
  argTypes: {
    typoName: {
      control: {
        type: "select",
        options: [
          "heading-xl",
          "heading-l",
          "heading-m",
          "heading-s",
          "heading-xs",
          "caption-l",
          "caption-m",
          "caption-s",
          "body-l",
          "body-s",
          "body-xs",
          "label",
          "link-L",
          "link-S",
          "link-XS",
          "button large",
          "button medium",
          "button small",
        ],
      },
    },
  },
};

const Template = (args) => {
  const capitalizedTypoName = args?.typoName?.replace(/\b\w/g, (char) =>
    char.toUpperCase()
  );

  return (
    <div className={`typography ${args?.typoName}`} style={args?.style}>
      {capitalizedTypoName}
    </div>
  );
};

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  color: "#363636",
  display: "flex",
  alignItems: "center",
  justifyContent: "center",
  transform: "translate(-50%, -50%)",
  lineHeight:"normal"
};

export const Playground = Template.bind({});
Playground.args = {
  typoName: "heading-xl",
  style: style
};

export const HeadingXL = () => (
  <div style={style} className={`typography heading-xl`}>Lorem ipsum dolor sit amet, consectetur adipiscing</div>
);

export const HeadingL = () => (
  <div style={style} className="typography heading-l">Lorem ipsum dolor sit amet, consectetur adipiscing</div>
);

export const HeadingM = () => (
  <div style={style} className="typography heading-m">Lorem ipsum dolor sit amet, consectetur adipiscing</div>
);

export const HeadingS = () => (
  <div style={style} className="typography heading-s">Lorem ipsum dolor sit amet, consectetur adipiscing</div>
);

export const HeadingXS = () => (
  <div style={style} className="typography heading-xs">Lorem ipsum dolor sit amet, consectetur adipiscing</div>
);

export const CaptionL = () => (
  <div style={style} className="typography caption-l">Lorem ipsum dolor sit amet, consectetur adipiscing</div>
);

export const CaptionM = () => (
  <div style={style} className="typography caption-m">Lorem ipsum dolor sit amet, consectetur adipiscing</div>
);

export const CaptionS = () => (
  <div style={style} className="typography caption-s">Lorem ipsum dolor sit amet, consectetur adipiscing</div>
);

export const BodyL = () => <div style={style} className="typography body-l">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore </div>;

export const BodyS = () => <div style={style} className="typography body-s">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore </div>;

export const BodyXS = () => <div style={style} className="typography body-xs">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore </div>;

export const Label = () => <div style={style} className="typography label">Label</div>;

export const LinkL = () => <div style={style} className="typography link-L">LinkL</div>;

export const LinkS = () => <div style={style} className="typography link-S">LinkS</div>;

export const LinkXS = () => <div style={style} className="typography link-XS">LinkXS</div>;

export const ButtonL = () => (
  <div style={style} className="typography button large">ButtonL</div>
);

export const ButtonM = () => (
  <div style={style} className="typography button medium">ButtonM</div>
);

export const ButtonS = () => (
  <div style={style} className="typography button small">ButtonS</div>
);
