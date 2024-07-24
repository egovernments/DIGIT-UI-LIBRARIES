console.log("index.js file");
import { AppContainer, PrivateRoute, BreadCrumb } from "@egovernments/digit-ui-components";
import React from "react";
import { useTranslation } from "react-i18next";
import { BrowserRouter as Router, Route, Switch} from "react-router-dom";
import Sample from "./Sample";
import ReactDOM from 'react-dom/client';
console.log("window.contextPath", window?.contextPath);
// Define ProjectBreadCrumb directly in index.js
const ProjectBreadCrumb = ({ location }) => {
  console.log("ProjectBreadCrumb location:", location);
  console.log("location",location);
  const { t } = useTranslation();
  const crumbs = [
    {
      path: `/${window?.contextPath}/employee`,
      content: t("HOME"),
      show: true,
    },
    {
      path: `/${window?.contextPath}/employee`,
      content: t(location.pathname.split("/").pop()),
      show: true,
    },
  ];
  return <BreadCrumb crumbs={crumbs} style={{ marginLeft: "16px" }} spanStyle={{ maxWidth: "min-content" }} />;
};


// Define App component
const App = ({ path, stateCode, userType, tenants }) => {
  console.log("App path:", path);
  const commonProps = { stateCode, userType, tenants, path };
  return (
    <AppContainer className="ground-container">
      <ProjectBreadCrumb location={window.location} />
     
        <Route path={`${path}/components`} element={<PrivateRoute><Sample /></PrivateRoute>} />
      
    </AppContainer>
  );
};
const rootElement = document.getElementById('root');
// Create root and render the app
const root = ReactDOM.createRoot(document.getElementById('rootElement'));

root.render(
  <Router>
    <App path="/" /> {/* Pass the path prop if needed */}
  </Router>
);
export default App;