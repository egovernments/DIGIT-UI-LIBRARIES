import { AppContainer,PrivateRoute,BreadCrumb, Loader } from "@egovernments/digit-ui-components";
import React from "react";
import { useTranslation } from "react-i18next";
import { Route, Switch } from "react-router-dom";
import Sample from "./Sample";
import SampleSearch from "./SampleSearch";
import IndividualSearch from "./IndividualSearch";

const ProjectBreadCrumb = ({ location }) => {
  const { t } = useTranslation();
  const crumbs = [
    // {
    //   path: `/${window?.contextPath}/employee`,
    //   content: t("HOME"),
    //   show: true,
    // },
    {
      path: `/${window?.contextPath}/employee`,
      content: t(location.pathname.split("/").pop()),
      show: true,
    },
  ];
  return <BreadCrumb crumbs={crumbs} style={{marginLeft:"16px"}} spanStyle={{ maxWidth: "min-content" }} />;
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
        <PrivateRoute path={`${path}/search`} component={() => <SampleSearch></SampleSearch>} />
        <PrivateRoute path={`${path}/ind-search`} component={() => <IndividualSearch></IndividualSearch>} />
        </AppContainer>
    </Switch>
  );
};

export default App;
