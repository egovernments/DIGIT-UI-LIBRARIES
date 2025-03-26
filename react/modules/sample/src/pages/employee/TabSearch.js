import { InboxSearchComposer } from "@egovernments/digit-ui-components";
import React, { useState } from "react";
import { TabSearchconfig } from "../../configs/TabSearchConfig";

const TabSearch = () => {
  const [config, setConfig] = useState(TabSearchconfig?.TabSearchconfig?.[0]); // initially setting first index config as default from jsonarray
  const [tabData, setTabData] = useState(
    TabSearchconfig?.TabSearchconfig?.map((configItem, index) => ({
      key: index,
      label: configItem.label,
      active: index === 0 ? true : false,
    }))
  ); // setting number of tab component and making first index enable as default

  const onTabChange = (n) => {
    setTabData((prev) =>
      prev.map((i, c) => ({ ...i, active: c === n ? true : false }))
    ); //setting tab enable which is being clicked
    setConfig(TabSearchconfig?.TabSearchconfig?.[n]); // as per tab number filtering the config
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
export default TabSearch;
