import React, {useMemo,useState,useEffect} from "react";
import { InboxSearchComposer } from "@egovernments/digit-ui-components";
import inboxConfig1 from "../../configs/InboxConfig1";

const InboxScreen1 = () => {
 
  const config=inboxConfig1();
  return (
    <div className="digit-inbox-search-wrapper">
        <InboxSearchComposer configs={config} headerLabel={"Inbox"}/>
    </div>

  ) 
}

export default InboxScreen1