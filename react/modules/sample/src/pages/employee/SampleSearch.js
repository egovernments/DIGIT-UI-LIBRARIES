import { Header, InboxSearchComposer } from "@egovernments/digit-ui-components";
import React, { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { Config } from "../../configs/SampleSearchConfig";

const SampleSearch = () => {
  const { t } = useTranslation();

  return (
    <React.Fragment>
      <div className="digit-inbox-search-wrapper">
        <InboxSearchComposer configs={Config} headerLabel={t("Search")}></InboxSearchComposer>
      </div>
    </React.Fragment>
  );
};
export default SampleSearch;
