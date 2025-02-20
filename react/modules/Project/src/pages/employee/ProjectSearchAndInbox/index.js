import React from "react";
import { useTranslation } from "react-i18next";
import { HeaderComponent, Loader,InboxSearchComposer} from "@egovernments/digit-ui-components";
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
              <HeaderComponent styles={{ fontSize: "32px" }}>{t(configs?.label)}</HeaderComponent>
              <div className="inbox-search-wrapper">
                <InboxSearchComposer configs={configs}></InboxSearchComposer>
              </div>
          </React.Fragment>
      );
}

export default ProjectSearchAndInboxComponent;