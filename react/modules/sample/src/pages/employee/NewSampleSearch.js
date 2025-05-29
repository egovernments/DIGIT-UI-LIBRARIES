import { InboxSearchComposer } from "@egovernments/digit-ui-components";
import React, { useState, useEffect } from "react";
import { myCampaignConfig } from "../../configs/NewSampleSearchConfig";

const NewSampleSearch = () => {
  const [config, setConfig] = useState(myCampaignConfig?.myCampaignConfig?.[0]);
  const [tabData, setTabData] = useState(
    myCampaignConfig?.myCampaignConfig?.map((configItem, index) => ({
      key: index,
      label: configItem.label,
      active: index === 0 ? true : false,
    }))
  );

  const onTabChange = (n) => {
    setTabData((prev) =>
      prev.map((i, c) => ({ ...i, active: c === n ? true : false }))
    );
    setConfig(myCampaignConfig?.myCampaignConfig?.[n]);
  };

  return (
    <React.Fragment>
      <div className="digit-inbox-search-wrapper">
        <InboxSearchComposer
          configs={config}
          showTab={true}
          tabData={tabData}
          onTabChange={onTabChange}
        ></InboxSearchComposer>
      </div>
    </React.Fragment>
  );
};
export default NewSampleSearch;
