import React from "react";
import { InboxSearchComposer, Loader } from "@egovernments/digit-ui-components";
import inboxConfig from "../../configs/SampleInboxConfig";

const SampleInbox = () => {
    const config = inboxConfig();

    if(!config)  return <Loader variant={"PageLoader"}/>
    return (
        <React.Fragment>
            <div className="digit-inbox-search-wrapper">
                <InboxSearchComposer configs={config}></InboxSearchComposer>
            </div>
        </React.Fragment>
    )
}

export default SampleInbox;