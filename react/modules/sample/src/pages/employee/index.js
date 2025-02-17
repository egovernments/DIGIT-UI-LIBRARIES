import { AppContainer,PrivateRoute,BreadCrumb, Loader } from "@egovernments/digit-ui-components";
import React from "react";
import { useTranslation } from "react-i18next";
import { Route, Switch } from "react-router-dom";
import Sample from "./Sample";
import SampleSearch from "./SampleSearch";
import SampleInbox from "./SampleInbox";
import IndividualSearch from "./IndividualSearch";

const ProjectBreadCrumb = ({ location }) => {
  const { t } = useTranslation();
  const crumbs = [
    {
      internalLink: `/${window?.contextPath}/employee`,
      content: t("HOME"),
      show: true,
    },
    {
      internalLink: `/${window?.contextPath}/employee/microplan/inbox`,
      content: t("Sample Inbox"),
      show: location.pathname.split("/").pop() === "inbox",
    },
    {
      internalLink: `/${window?.contextPath}/employee/microplan/search`,
      content: t("Sample Search"),
      show: location.pathname.split("/").pop() === "search",
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
          <ProjectBreadCrumb location={location} />
        </React.Fragment>
        <PrivateRoute path={`${path}/components`} component={() => <Sample></Sample>} />
        <PrivateRoute path={`${path}/test`} component={() => <Loader></Loader>} />
        {/* <PrivateRoute path={`${path}/search`} component={() => <SampleSearch></SampleSearch>} /> */}
        <PrivateRoute path={`${path}/inbox`} component={() => <SampleInbox></SampleInbox>} />
        <PrivateRoute path={`${path}/search`} component={() => <IndividualSearch></IndividualSearch>} />
        </AppContainer>
    </Switch>
  );
};

export default App;
