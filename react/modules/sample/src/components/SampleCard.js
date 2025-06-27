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
        label: t("New Sample Search"),
        link: `/${window?.contextPath}/employee/sample/new-search`,
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
      {
        label: t("InboxSearchComposer Edit"),
        link: `/${window?.contextPath}/employee/sample/search-edit`,
      },
      {
        label: t("Boundary Component"),
        link: `/${window?.contextPath}/employee/sample/filter`,
      },
      {
        label: t("Boundary with SearchComposer"),
        link: `/${window?.contextPath}/employee/sample/searchComposer`,
      },
      {
        label: t("Boundary with FormComposer"),
        link: `/${window?.contextPath}/employee/sample/FormComposer`,
      },
      {
        label: t("Boundary with SearchComposerWithFilter"),
        link: `/${window?.contextPath}/employee/sample/searchComposerWithFilter`,
      },
      {
        label: t("Sample Search"),
        link: `/${window?.contextPath}/employee/sample/search`,
      },
      {
        label: t("Sample Search with Multiple Tabs"),
        link: `/${window?.contextPath}/employee/sample/search-multiple-tabs`,
      }
    ],
  };
  return <EmployeeModuleCard {...propsForModuleCard} />;
};

export default SampleCard;