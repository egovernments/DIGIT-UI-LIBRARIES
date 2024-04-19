import React from "react";
import { useTranslation } from "react-i18next";
import { Header, Loader} from "@egovernments/digit-ui-components";
import InboxSearchComposerV2 from "../../../../../../ui-components/src/hoc/InboxSearchComposerV2";
import inboxConfig from "../../../configs/InboxConfig";

const ProjectSearchAndInboxComponent = () => {
    const { t } = useTranslation();

    const configs = inboxConfig();
    const tenant = Digit.ULBService.getStateId();
    // const { isLoading, data } = Digit.Hooks.useCustomMDMS(
    //     tenant,
    //     Digit.Utils.getConfigModuleName(),
    //     [
    //         {
    //             "name": "InboxProjectConfig"
    //         }
    //     ]
    // );
   
    // const configs = data?.[Digit.Utils.getConfigModuleName()]?.InboxProjectConfig?.[0]

    // if(isLoading) return <Loader />
      return (
           <React.Fragment>
              <Header styles={{ fontSize: "32px" }}>{t(configs?.label)}</Header>
              <div className="inbox-search-wrapper">
                <InboxSearchComposerV2 configs={configs}></InboxSearchComposerV2>
              </div>
          </React.Fragment>
      );
}

export default ProjectSearchAndInboxComponent;