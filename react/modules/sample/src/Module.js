import { Loader} from "@egovernments/digit-ui-components";
import React from "react";
import { useRouteMatch } from "react-router-dom";
import { default as EmployeeApp } from "./pages/employee";
import SampleCard from "./components/SampleCard";
import { BoundaryFilter } from "@egovernments/digit-ui-components/src/atoms";

export const SampleModule = ({ stateCode, userType, tenants }) => {
  // debugger
  const { path, url } = useRouteMatch();
  const tenantId = Digit.ULBService.getCurrentTenantId();
  const moduleCode = ["sample", "common","workflow", tenantId];
  const language = Digit.StoreData.getCurrentLanguage();
  const { isLoading, data: store } = Digit.Services.useStore({
    stateCode,
    moduleCode,
    language,
  });

  if (isLoading) {
    return <Loader />;
  }
  return <EmployeeApp path={path} stateCode={stateCode} userType={userType} tenants={tenants} />;
};

const componentsToRegister = {
  MicroplanModule:SampleModule,
  MicroplanCard:SampleCard,
  BoundaryFilter
};

export const initSampleComponents = () => {
  Object.entries(componentsToRegister).forEach(([key, value]) => {
    Digit.ComponentRegistryService.setComponent(key, value);
  });
};
