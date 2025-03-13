import { AppContainer,PrivateRoute,BreadCrumb, Loader } from "@egovernments/digit-ui-components";
import React from "react";
import { useTranslation } from "react-i18next";
import { Route, Switch } from "react-router-dom";
import Sample from "./Sample";
import SampleSearch from "./SampleSearch";
import SampleInbox from "./SampleInbox";
import IndividualSearch from "./IndividualSearch";
import SampleComponents from "./SampleComponents";
import SampleView from "./SampleView";

const SampleBreadCrumbs = ({ location }) => {
  const { t } = useTranslation();
  const crumbs = [
    {
      internalLink: `/${window?.contextPath}/employee`,
      content: t("HOME"),
      show: true,
    },
    {
      internalLink: `/${window?.contextPath}/employee/microplan/create`,
      content: t("Sample Create"),
      show: location.pathname.split("/").pop() === "create",
    },
    {
      internalLink: `/${window?.contextPath}/employee/microplan/search`,
      content: t("Sample Search"),
      show: location.pathname.split("/").pop() === "search",
    },
    {
      internalLink: `/${window?.contextPath}/employee/microplan/inbox`,
      content: t("Sample Inbox"),
      show: location.pathname.split("/").pop() === "inbox",
    },
    {
      internalLink: `/${window?.contextPath}/employee/microplan/view`,
      content: t("Sample View"),
      show: location.pathname.split("/").pop() === "view",
    },
    {
      internalLink: `/${window?.contextPath}/employee/microplan/components`,
      content: t("Sample Components"),
      show: location.pathname.split("/").pop() === "components",
    },
  ];
  return <BreadCrumb crumbs={crumbs}/>;
};

const App = ({ path, stateCode, userType, tenants }) => {
  const commonProps = { stateCode, userType, tenants, path };

  return (
    <Switch>
      <AppContainer className="ground-container">
        <React.Fragment>
          <SampleBreadCrumbs location={location} />
        </React.Fragment>
        <PrivateRoute path={`${path}/components`} component={() => <SampleComponents></SampleComponents>} />
        <PrivateRoute path={`${path}/create`} component={() => <Sample></Sample>} />
        <PrivateRoute path={`${path}/search`} component={() => <SampleSearch></SampleSearch>} />
        <PrivateRoute path={`${path}/inbox`} component={() => <SampleInbox></SampleInbox>} />
        <PrivateRoute path={`${path}/view`} component={() => <SampleView></SampleView>} />
        <PrivateRoute path={`${path}/ind-search`} component={() => <IndividualSearch></IndividualSearch>} />
        <PrivateRoute path={`${path}/test`} component={() => <Loader></Loader>} />
        </AppContainer>
    </Switch>
  );
};

export default App;
