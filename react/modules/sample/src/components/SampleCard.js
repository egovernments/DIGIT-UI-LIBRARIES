import {EmployeeModuleCard} from "@egovernments/digit-ui-react-components";
import React from "react";
import { useTranslation } from "react-i18next";

const SampleCard = () => {
  const { t } = useTranslation();
  const propsForModuleCard = {
    Icon: "",
    moduleName: t("Sample"),
    kpis: [
    ],
    links: [
      {
        label: t("Sample Components"),
        link: `/${window?.contextPath}/employee/sample/components`,
      },
      {
        label: t("Sample Search"),
        link: `/${window?.contextPath}/employee/sample/search`,
      },
      {
        label: t("Sample Inbox"),
        link: `/${window?.contextPath}/employee/sample/inbox`,
      },
    ],
  };
  return <EmployeeModuleCard {...propsForModuleCard} />;
};

export default SampleCard;