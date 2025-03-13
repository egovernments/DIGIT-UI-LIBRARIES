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
        label: t("Sample Create"),
        link: `/${window?.contextPath}/employee/sample/create`,
      },
      {
        label: t("Sample Search"),
        link: `/${window?.contextPath}/employee/sample/search`,
      },
      {
        label: t("Sample Inbox"),
        link: `/${window?.contextPath}/employee/sample/inbox`,
      },
      {
        label: t("Sample View"),
        link: `/${window?.contextPath}/employee/sample/view`,
      },
      {
        label: t("Sample Components"),
        link: `/${window?.contextPath}/employee/sample/components`,
      },
    ],
  };
  return <EmployeeModuleCard {...propsForModuleCard} />;
};

export default SampleCard;