import React from "react";
import { useTranslation } from "react-i18next";
import {
  Tag,
  Button,
  Card,
  SummaryCardFieldPair,
} from "@egovernments/digit-ui-components";

const ResultsDataCard = ({
  key,
  tabData,
  tagElements = {},
  actionButtons = {},
  rowData,
  showButton
}) => {
  const { t } = useTranslation();
  return (
    <Card className={"digit-results-card-component"}>
      {/* Heading and Tags */}
      <div className="digit-results-card-heading-tags-wrapper">
        <div className="digit-results-card-heading">
          {rowData?.campaignName}
        </div>
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
      <div className="digit-results-card-content">
        <SummaryCardFieldPair
          className=""
          inline
          label={"Start Date"}
          style={{}}
          value={rowData?.startDate}
        />
        <SummaryCardFieldPair
          className=""
          inline
          label={"End Date"}
          style={{}}
          value={rowData?.endDate}
        />
        <SummaryCardFieldPair
          className=""
          inline
          label={"Duration"}
          style={{}}
          value={rowData?.startDate}
        />
        <SummaryCardFieldPair
          className=""
          inline
          label={"Number of cycles"}
          style={{}}
          value={rowData?.startDate}
        />
        <SummaryCardFieldPair
          className=""
          inline
          label={"Resources"}
          style={{}}
          value={rowData?.startDate}
        />
        <SummaryCardFieldPair
          className=""
          inline
          label={"Status"}
          style={{}}
          value={rowData?.status}
        />
      </div>

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
