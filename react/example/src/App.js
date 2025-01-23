import React from "react";
import { initLibraries } from "@egovernments/digit-ui-libraries";

import { UICustomizations } from "./UICustomizations";

import {
  DigitUI,
  initCoreComponents,
} from "@egovernments/digit-ui-module-core";
import { initProjectComponents } from "@egovernments/digit-ui-module-project";
import { initSampleComponents } from "@egovernments/digit-ui-module-sample";

import "@egovernments/digit-ui-components-css/dist/index.css";


window.contextPath = window?.globalConfigs?.getConfig("CONTEXT_PATH");
var Digit = window.Digit || {};
const enabledModules = [
  // "DSS",
  // "NDSS",
  // "Utilities",
  // "HRMS",
  // "Engagement",
  // "Workbench",
  // "Project", 
  "Sample",
  // "Microplan"
];
const moduleReducers = (initData) => ({
  initData,
});

const initTokens = (stateCode) => {
    const userType =
      window.sessionStorage.getItem("userType") ||
      process.env.REACT_APP_USER_TYPE ||
      "CITIZEN";
    const token =
      window.localStorage.getItem("token") ||
      process.env[`REACT_APP_${userType}_TOKEN`];
    const citizenInfo = window.localStorage.getItem("Citizen.user-info");
    const citizenTenantId =
      window.localStorage.getItem("Citizen.tenant-id") || stateCode;
    const employeeInfo = window.localStorage.getItem("Employee.user-info");
    const employeeTenantId = window.localStorage.getItem("Employee.tenant-id");
    const userTypeInfo =
      userType === "CITIZEN" || userType === "QACT" ? "citizen" : "employee";
    window.Digit.SessionStorage.set("user_type", userTypeInfo);
    window.Digit.SessionStorage.set("userType", userTypeInfo);
    if (userType !== "CITIZEN") {
      window.Digit.SessionStorage.set("User", {
        access_token: token,
        info: userType !== "CITIZEN" ? JSON.parse(employeeInfo) : citizenInfo,
      });
    } else {
      // if (!window.Digit.SessionStorage.get("User")?.extraRoleInfo) window.Digit.SessionStorage.set("User", { access_token: token, info: citizenInfo });
    }
    window.Digit.SessionStorage.set("Citizen.tenantId", citizenTenantId);
    if (employeeTenantId && employeeTenantId.length)
      window.Digit.SessionStorage.set("Employee.tenantId", employeeTenantId);
  };

const initDigitUI = () => {
  window.Digit.ComponentRegistryService.setupRegistry({
    
  });
  initCoreComponents();
  initProjectComponents();
  initSampleComponents();


  window.Digit.Customizations = {
    PGR: {},
    commonUiConfig: UICustomizations,
  };
};

initLibraries().then(() => {
  initDigitUI();
});

function App() {
  window.contextPath = window?.globalConfigs?.getConfig("CONTEXT_PATH");
  const stateCode =
    window.globalConfigs?.getConfig("STATE_LEVEL_TENANT_ID") ||
    process.env.REACT_APP_STATE_LEVEL_TENANT_ID;
    initTokens(stateCode);
  if (!stateCode) {
    return <h1>stateCode is not defined</h1>;
  }
  return (
    <DigitUI
      stateCode={stateCode}
      enabledModules={enabledModules}
      moduleReducers={moduleReducers}
      defaultLanding="employee"
    />
  );
}

export default App;