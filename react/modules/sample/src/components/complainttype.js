import { Button, Dropdown, LabelFieldPair, TextInput, CustomSVG, Card, HeaderComponent } from "@egovernments/digit-ui-components";
import React, { Fragment, useEffect, useState } from "react";
import { useTranslation } from "react-i18next";

const ComplaintType = ({ onSelect, ...props }) => {
  const { t } = useTranslation();

  const [documentData, setDocumentData] = useState([
    {
      key: 1,
      code: null,
      names: null,
    },
  ]);

  const options = [
    {
      code: "3461",
      name: "UNRELIABLE_WATER_SUPPLY"
    },
    {
      code: "6892",
      name: "FREQUENT_POWER_CUT"
    },
    {
      code:"4575",
      name:"INADEQUATE_MEDICAL_STAFF"
    }
  ];

  const handleUpdateField = ({ type, value, item, index }) => {
    if (type === "VALUE") {
      setDocumentData((prev) => {
        return prev?.map((i) => {
          if (i.key === item.key) {
            return {
              ...i, 
              names: value.name,
              code: value.code,
            };
          }
          return i;
        });
      });      
    }
  };

  const add = () => {
    setDocumentData((prev) => [
      ...prev,
      {
        key: prev?.length + 1,
        code: null,
        names: null,
      },
    ]);
  };

  const deleteItem = (data) => {
    const fil = documentData.filter((i) => i.key !== data.key);
    const up = fil.map((item, index) => ({ ...item, key: index + 1 }));
    setDocumentData(up);
  };

  useEffect(() => {
    onSelect("complaintType", documentData);
  }, [documentData]);

  return (
    <>
      {documentData?.map((item, index) => (
        <Card type="secondary" style={{ marginBottom: "1.5rem", gap: "1.5rem" }}>
          {documentData?.length > 1 ? (
            <div className="delete-resource-icon" style={{ textAlign: "right" }} onClick={() => deleteItem(item, index)}>
              <CustomSVG.DustbinIcon />
            </div>
          ) : null}
          <LabelFieldPair removeMargin={true} vertical={true}>
            <HeaderComponent className={`label`}>
              <div className={`label-container`}>
                <label className={`label-styles`}>{`${t("Code")}`}</label>
              </div>
            </HeaderComponent>
            <TextInput
              disabled={true}
              name="code"
              value={item?.code || ""}
            />
          </LabelFieldPair>
          <LabelFieldPair removeMargin={true}  vertical={true}>
            <HeaderComponent className={`label`}>
              <div className={`label-container`}>
                <label className={`label-styles`}>{`${t("Name")}`}</label>
              </div>
            </HeaderComponent>
            <Dropdown
              name="name"
              value={item?.names}
              option={options}
              optionKey="name"
              select={(value) => handleUpdateField({ type: "VALUE", value, item: item, index: index })}
            />
          </LabelFieldPair>
        </Card>
      ))}
      <Button variation="secondary" label={t(`Add more`)} className={""} icon={"AddIconNew"} onClick={add} style={{ marginLeft: "auto" }} />
    </>
  );
};

export default ComplaintType;