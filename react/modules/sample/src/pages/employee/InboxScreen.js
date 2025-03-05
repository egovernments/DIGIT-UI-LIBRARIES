import React, {useMemo,useState,useEffect} from "react";
import { InboxSearchComposer } from "@egovernments/digit-ui-components";
import inboxConfig from "../../configs/InboxConfig";


const InboxScreen = () => {
 
  const config=inboxConfig;
  return (
    <div className="digit-inbox-search-wrapper">
        <InboxSearchComposer configs={config} headerLabel={"Inbox"}/>
    </div>

  ) 
}

export default InboxScreen