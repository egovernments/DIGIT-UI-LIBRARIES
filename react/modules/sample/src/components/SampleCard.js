import {EmployeeModuleCard} from "@egovernments/digit-ui-react-components";
import React from "react";
import { useTranslation } from "react-i18next";

const SampleCard = () => {
  console.log("samplecard")
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
        label: t("Sample Inbox Seach Screen"),
        link: `/${window?.contextPath}/employee/sample/search`,
      },
    ],
  };
  return <EmployeeModuleCard {...propsForModuleCard} />;
};

export default SampleCard;