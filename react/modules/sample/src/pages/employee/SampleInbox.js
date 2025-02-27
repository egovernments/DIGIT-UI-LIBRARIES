import React from "react";
import { useTranslation } from "react-i18next";
import { InboxSearchComposer, Loader } from "@egovernments/digit-ui-components";
import inboxConfig from "../../configs/SampleInboxConfig";

const SampleInbox = () => {
    const { t } = useTranslation();
    const config = inboxConfig();

    if(!config)  return <Loader variant={"PageLoader"}/>
    return (
        <React.Fragment>
            <div className="digit-inbox-search-wrapper">
                <InboxSearchComposer configs={config} headerLabel={t("Inbox")}></InboxSearchComposer>
            </div>
        </React.Fragment>
    )
}

export default SampleInbox;