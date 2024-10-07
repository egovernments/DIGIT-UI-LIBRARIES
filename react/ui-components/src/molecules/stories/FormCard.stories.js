import React, { useEffect, useState } from "react";
import Button from "../../atoms/Button";
import TextInput from "../../atoms/TextInput";
import Uploader from "../../atoms/Uploader";
import Chip from "../../atoms/Chip";
import {
  Card,
  CheckBox,
  Dropdown,
  LabelFieldPair,
  RadioButtons,
  TextBlock,
} from "../../atoms";
import FormCard from "../FormCard";

export default {
  title: "Molecules/Card/FormCard",
  component: FormCard,
  argTypes: {
    className: {
      control: "text",
    },
    style: {
      control: { type: "object" },
    },
    children: {
      control: "object",
    },
    type: { control: "select", options: ["primary", "secondary"] },
    layout: { control: "text" },
    props: {
      control: "object",
    },
  },
};

const Template = (args) => <FormCard {...args} />;

const tags = ["Dolo 650", "SPAQ  1", "SPAQ 2", "Elbendazol"];

export const SimpleLayout = () => {
  const [selectedGender, setSelectedGender] = useState(null);
  const [selectedGuardian, setSelectedGuardian] = useState(null);
  const [isSameAsPropertyAddress, setIsSameAsPropertyAddress] = useState(false);

  const [isMobileView, setIsMobileView] = React.useState(
    window.innerWidth / window.innerHeight <= 9 / 16
  );
  const onResize = () => {
    if (window.innerWidth / window.innerHeight <= 9 / 16) {
      if (!isMobileView) {
        setIsMobileView(true);
      }
    } else {
      if (isMobileView) {
        setIsMobileView(false);
      }
    }
  };
  React.useEffect(() => {
    window.addEventListener("resize", () => {
      onResize();
    });
    return () => {
      window.addEventListener("resize", () => {
        onResize();
      });
    };
  });

  const genderOptions = [
    { code: "M", name: "Male" },
    { code: "F", name: "Female" },
    { code: "O", name: "Others" },
  ];

  const guardianOptions = [
    { code: "H", name: "Husband" },
    { code: "F", name: "Father" },
  ];

  const handleGenderSelect = (option) => {
    setSelectedGender(option.code);
  };

  const handleGuardianSelect = (option) => {
    setSelectedGuardian(option.code);
  };

  const handleCheckboxChange = (event) => {
    setIsSameAsPropertyAddress(event.target.checked);
  };

  const textBlockStyle = {
    width: isMobileView ? "100%" : "30%",
  };

  const headerData = [<TextBlock header={"Enter Details"}></TextBlock>];

  const FooterChild1 = [
    <Button
      type={"submit"}
      size={"large"}
      variation={"primary"}
      icon={""}
      label="Submit"
      onClick={() => console.log("Clicked submit")}
    />,
  ];

  const FooterChild = [
    <Button
      type={"button"}
      size={"large"}
      variation={"secondary"}
      icon={""}
      label="Cancel"
      onClick={() => console.log("Clicked cancel")}
    />,
    <Button
      type={"submit"}
      size={"large"}
      variation={"primary"}
      icon={""}
      label="Submit"
      onClick={() => console.log("Clicked submit")}
    />,
  ];

  return (
    <FormCard
      type={"primary"}
      variant={"form"}
      headerData={headerData}
      footerData={FooterChild1}
      equalWidthButtons={true}
    >
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Name"}></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Gender"}></TextBlock>
        <RadioButtons
          options={genderOptions}
          optionsKey="name"
          name="gender"
          selectedOption={selectedGender}
          onSelect={handleGenderSelect}
          style={{
            width: "100%",
            justifyContent: "unset",
            ...(isMobileView ? {} : { gap: "24px" }),
          }}
        />
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Mobile Number"}></TextBlock>
        <TextInput
          type="text"
          populators={{
            prefix: "+91",
          }}
        />
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock
          style={textBlockStyle}
          body={"Alternate Mobile number"}
        ></TextBlock>
        <TextInput
          type="text"
          populators={{
            prefix: "+91",
          }}
        />
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Guardian"}></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Special Category"}></TextBlock>
        <div style={{ width: "100%" }}>
          <Dropdown
            option={[
              { code: "1", name: "Below Poverty Line" },
              { code: "2", name: "Above Poverty Line" },
            ]}
            optionKey={"name"}
            selected={{ code: "1", name: "Below Poverty Line" }}
          ></Dropdown>
        </div>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Document ID"}></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Document Type"}></TextBlock>
        <div style={{ width: "100%" }}>
          <Dropdown
            option={[
              { code: "1", name: "BPL Certificate" },
              { code: "2", name: "CertificateTwo" },
            ]}
            optionKey={"name"}
            selected={{ code: "1", name: "BPL Certificate" }}
          ></Dropdown>
        </div>
      </LabelFieldPair>
      {/* <Uploader
        style={{ marginBottom: "24px" }}
        variant={"uploadFile"}
        multiple={false}
        label={"Choose Document"}
        showLabel={true}
        inline={true}
      ></Uploader> */}
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Email ID"}></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock
          style={textBlockStyle}
          body={"Correspondance Address"}
        ></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <CheckBox
        label={"Same as Property Address"}
        checked={isSameAsPropertyAddress}
        onChange={handleCheckboxChange}
      ></CheckBox>
    </FormCard>
  );
};

export const WithLayoutExample1 = () => {
  const [selectedGender, setSelectedGender] = useState(null);
  const [selectedGuardian, setSelectedGuardian] = useState(null);
  const [isSameAsPropertyAddress, setIsSameAsPropertyAddress] = useState(false);

  const [isMobileView, setIsMobileView] = React.useState(
    window.innerWidth / window.innerHeight <= 9 / 16
  );
  const onResize = () => {
    if (window.innerWidth / window.innerHeight <= 9 / 16) {
      if (!isMobileView) {
        setIsMobileView(true);
      }
    } else {
      if (isMobileView) {
        setIsMobileView(false);
      }
    }
  };
  React.useEffect(() => {
    window.addEventListener("resize", () => {
      onResize();
    });
    return () => {
      window.addEventListener("resize", () => {
        onResize();
      });
    };
  });

  const genderOptions = [
    { code: "M", name: "Male" },
    { code: "F", name: "Female" },
    { code: "O", name: "Others" },
  ];

  const guardianOptions = [
    { code: "H", name: "Husband" },
    { code: "F", name: "Father" },
  ];

  const handleGenderSelect = (option) => {
    setSelectedGender(option.code);
  };

  const handleGuardianSelect = (option) => {
    setSelectedGuardian(option.code);
  };

  const handleCheckboxChange = (event) => {
    setIsSameAsPropertyAddress(event.target.checked);
  };

  const textBlockStyle = {
    width: isMobileView ? "100%" : "30%",
  };

  const headerData = [<TextBlock header={"Enter Details"}></TextBlock>];
  const FooterChild = [
    <Button
      type={"button"}
      size={"large"}
      variation={"secondary"}
      icon={""}
      label="Cancel"
      onClick={() => console.log("Clicked cancel")}
    />,
    <Button
      type={"submit"}
      size={"large"}
      variation={"primary"}
      icon={""}
      label="Submit"
      onClick={() => console.log("Clicked submit")}
    />,
  ];

  return (
    <FormCard
      type={"primary"}
      variant={"form"}
      layout={"2*2"}
      headerData={headerData}
      footerData={FooterChild}
      equalWidthButtons={true}
      withDivider={true}
    >
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Name"}></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Gender"}></TextBlock>
        <RadioButtons
          options={genderOptions}
          optionsKey="name"
          name="gender"
          selectedOption={selectedGender}
          onSelect={handleGenderSelect}
          style={{
            width: "100%",
            justifyContent: "unset",
            ...(isMobileView ? {} : { gap: "24px" }),
          }}
        />
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Mobile Number"}></TextBlock>
        <TextInput
          type="text"
          populators={{
            prefix: "+91",
          }}
        />
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock
          style={textBlockStyle}
          body={"Alternate Mobile number"}
        ></TextBlock>
        <TextInput
          type="text"
          populators={{
            prefix: "+91",
          }}
        />
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Guardian"}></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Special Category"}></TextBlock>
        <div style={{ width: "100%" }}>
          <Dropdown
            option={[
              { code: "1", name: "Below Poverty Line" },
              { code: "2", name: "Above Poverty Line" },
            ]}
            optionKey={"name"}
            selected={{ code: "1", name: "Below Poverty Line" }}
          ></Dropdown>
        </div>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Document ID"}></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Document Type"}></TextBlock>
        <div style={{ width: "100%" }}>
          <Dropdown
            option={[
              { code: "1", name: "BPL Certificate" },
              { code: "2", name: "CertificateTwo" },
            ]}
            optionKey={"name"}
            selected={{ code: "1", name: "BPL Certificate" }}
          ></Dropdown>
        </div>
      </LabelFieldPair>
      {/* <Uploader
        style={{ marginBottom: "24px" }}
        variant={"uploadFile"}
        multiple={false}
        label={"Choose Document"}
        showLabel={true}
        inline={true}
      ></Uploader> */}
      <LabelFieldPair>
        <TextBlock style={textBlockStyle} body={"Email ID"}></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <LabelFieldPair>
        <TextBlock
          style={textBlockStyle}
          body={"Correspondance Address"}
        ></TextBlock>
        <TextInput type="text"></TextInput>
      </LabelFieldPair>
      <CheckBox
        label={"Same as Property Address"}
        checked={isSameAsPropertyAddress}
        onChange={handleCheckboxChange}
      ></CheckBox>
    </FormCard>
  );
};

export const WithLayoutExample2 = () => {
  const [selectedGender, setSelectedGender] = useState(null);
  const [selectedGuardian, setSelectedGuardian] = useState(null);
  const [isSameAsPropertyAddress, setIsSameAsPropertyAddress] = useState(false);

  const [isMobileView, setIsMobileView] = React.useState(
    window.innerWidth / window.innerHeight <= 9 / 16
  );
  const onResize = () => {
    if (window.innerWidth / window.innerHeight <= 9 / 16) {
      if (!isMobileView) {
        setIsMobileView(true);
      }
    } else {
      if (isMobileView) {
        setIsMobileView(false);
      }
    }
  };
  React.useEffect(() => {
    window.addEventListener("resize", () => {
      onResize();
    });
    return () => {
      window.addEventListener("resize", () => {
        onResize();
      });
    };
  });

  const genderOptions = [
    { code: "M", name: "Male" },
    { code: "F", name: "Female" },
    { code: "O", name: "Others" },
  ];

  const guardianOptions = [
    { code: "H", name: "Husband" },
    { code: "F", name: "Father" },
  ];

  const handleGenderSelect = (option) => {
    setSelectedGender(option.code);
  };

  const handleGuardianSelect = (option) => {
    setSelectedGuardian(option.code);
  };

  const handleCheckboxChange = (event) => {
    setIsSameAsPropertyAddress(event.target.checked);
  };

  const textBlockStyle = {
    width: isMobileView ? "100%" : "30%",
  };

  const headerData = [<TextBlock header={"Enter Details"}></TextBlock>];
  const FooterChild = [
    <Button
      type={"button"}
      size={"large"}
      variation={"secondary"}
      icon={""}
      label="Cancel"
      onClick={() => console.log("Clicked cancel")}
    />,
    <Button
      type={"submit"}
      size={"large"}
      variation={"primary"}
      icon={""}
      label="Submit"
      onClick={() => console.log("Clicked submit")}
    />,
  ];

  return (
    <FormCard
      type={"primary"}
      variant={"form"}
      layout={"1*2"}
      headerData={headerData}
      footerData={FooterChild}
      equalWidthButtons={true}
      withDivider={false}
    >
      <Card type={"secondary"}>
        <LabelFieldPair>
          <TextBlock style={textBlockStyle} body={"Name"}></TextBlock>
          <TextInput type="text"></TextInput>
        </LabelFieldPair>
        <LabelFieldPair>
          <TextBlock style={textBlockStyle} body={"Gender"}></TextBlock>
          <RadioButtons
            options={genderOptions}
            optionsKey="name"
            name="gender"
            selectedOption={selectedGender}
            onSelect={handleGenderSelect}
            style={{
              width: "100%",
              justifyContent: "unset",
              ...(isMobileView ? {} : { gap: "24px" }),
            }}
          />
        </LabelFieldPair>
        <LabelFieldPair>
          <TextBlock style={textBlockStyle} body={"Mobile Number"}></TextBlock>
          <TextInput
            type="text"
            populators={{
              prefix: "+91",
            }}
          />
        </LabelFieldPair>
        <LabelFieldPair>
          <TextBlock
            style={textBlockStyle}
            body={"Alternate Mobile number"}
          ></TextBlock>
          <TextInput
            type="text"
            populators={{
              prefix: "+91",
            }}
          />
        </LabelFieldPair>
        <LabelFieldPair>
          <TextBlock style={textBlockStyle} body={"Guardian"}></TextBlock>
          <TextInput type="text"></TextInput>
        </LabelFieldPair>
      </Card>
      <Card type={"secondary"}>
        <LabelFieldPair>
          <TextBlock
            style={textBlockStyle}
            body={"Special Category"}
          ></TextBlock>
          <div style={{ width: "100%" }}>
            <Dropdown
              option={[
                { code: "1", name: "Below Poverty Line" },
                { code: "2", name: "Above Poverty Line" },
              ]}
              optionKey={"name"}
              selected={{ code: "1", name: "Below Poverty Line" }}
            ></Dropdown>
          </div>
        </LabelFieldPair>
        <LabelFieldPair>
          <TextBlock style={textBlockStyle} body={"Document ID"}></TextBlock>
          <TextInput type="text"></TextInput>
        </LabelFieldPair>
        <LabelFieldPair>
          <TextBlock style={textBlockStyle} body={"Document Type"}></TextBlock>
          <div style={{ width: "100%" }}>
            <Dropdown
              option={[
                { code: "1", name: "BPL Certificate" },
                { code: "2", name: "CertificateTwo" },
              ]}
              optionKey={"name"}
              selected={{ code: "1", name: "BPL Certificate" }}
            ></Dropdown>
          </div>
        </LabelFieldPair>
        <LabelFieldPair>
          <TextBlock style={textBlockStyle} body={"Email ID"}></TextBlock>
          <TextInput type="text"></TextInput>
        </LabelFieldPair>
        <LabelFieldPair>
          <TextBlock
            style={textBlockStyle}
            body={"Correspondance Address"}
          ></TextBlock>
          <TextInput type="text"></TextInput>
        </LabelFieldPair>
      </Card>
    </FormCard>
  );
};
