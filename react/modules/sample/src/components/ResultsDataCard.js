import React from "react";
import { useTranslation } from "react-i18next";
import { Tag, Button, Card } from "@egovernments/digit-ui-components";

const ResultsDataCard = ({
  key,
  heading,
  tagElements = {},
  actionButtons = {},
  children,
  rowData,
}) => {
  const { t } = useTranslation();
  console.log("column", rowData, key);

  return (
    <Card className={"digit-results-card-component"}>
      {/* Heading and Tags */}
      <div className="digit-results-card-heading-tags-wrapper">
        <div className="digit-results-card-heading">{rowData?.campaignName}</div>
        <div className="digit-results-card-tags">
          {tagElements &&
            Object.entries(tagElements).map(([key, tag]) => (
              <Tag
                key={key}
                icon={tag.icon || ""}
                label={tag.label}
                showIcon={!!tag.icon}
                labelStyle={tag.labelStyle || {}}
                style={tag.style || {}}
                type={tag.type || "monochrome"}
              />
            ))}
        </div>
      </div>
      {/* Center Content (children) */}
      <div className="digit-results-card-content">{children}</div>

      {/* Action Buttons */}
      {actionButtons && Object.keys(actionButtons).length > 0 && (
        <div
          className="digit-results-card-buttons"
          style={{
            display: "flex",
            justifyContent: "flex-end",
            gap: "16px",
            alignItems: "center",
            height: "64px",
            borderTop: "1px solid #d6d5d4",
            boxShadow: "0px 0px 10.4px 0px #00000026",
            paddingLeft: "24px",
            paddingRight: "24px",
          }}
        >
          {Object.entries(actionButtons).map(([key, btn]) => (
            <Button
              key={key}
              className={btn.className || "custom-class"}
              icon={btn.icon || ""}
              iconFill={btn.iconFill || ""}
              label={btn.label}
              onClick={btn.onClick}
              options={btn.options || []}
              optionsKey={btn.optionsKey || ""}
              showBottom={btn.showBottom}
              title={btn.title || ""}
            />
          ))}
        </div>
      )}
    </Card>
  );
};

export default ResultsDataCard;
