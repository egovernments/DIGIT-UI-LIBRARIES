import { InboxSearchComposer } from "@egovernments/digit-ui-components";
import React, { useState, useEffect } from "react";
import { myCampaignConfig } from "../../configs/NewSampleSearchConfig";

const NewSampleSearch = () => {
  const [config, setConfig] = useState(myCampaignConfig?.myCampaignConfig?.[0]);
    const [selectedTabIndex, setSelectedTabIndex] = useState(null);
  const [tabData, setTabData] = useState(
    myCampaignConfig?.myCampaignConfig?.map((configItem, index) => ({
      key: index,
      label: configItem.label,
      active: index === 0 ? true : false,
    }))
  );

  useEffect(() => {
    const savedIndex = parseInt(sessionStorage.getItem("HCM_SELECTED_TAB_INDEX")) || 0;

    const configList = myCampaignConfig?.myCampaignConfig || [];

    setSelectedTabIndex(savedIndex);
    setConfig(configList[savedIndex]);
    setTabData(
      configList.map((item, idx) => ({
        key: idx,
        label: item.label,
        active: idx === savedIndex,
      }))
    );
  }, []);


  const onTabChange = (n) => {
    sessionStorage.setItem("HCM_SELECTED_TAB_INDEX", n); // Save to sessionStorage
    setSelectedTabIndex(n);
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
