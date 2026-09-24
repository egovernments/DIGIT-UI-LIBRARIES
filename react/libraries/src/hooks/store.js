import { useState, useEffect } from "react";
import { useQuery } from "@tanstack/react-query";
// import mergeConfig from "../../config/mergeConfig";
import { StoreService } from "../services/molecules/Store/service";

export const useStore = ({ stateCode, moduleCode, language ,modulePrefix = "rainmaker", enabled, config }) => {
  // Callers use two conventions across the codebase - a top-level `enabled` or a nested
  // `config: { enabled }` - support both. Default to true (the old, unconditional behaviour)
  // when neither is passed, so existing hardcoded-moduleCode callers are unaffected.
  const resolvedEnabled = config && config.enabled != null ? config.enabled : enabled != null ? enabled : true;
  return useQuery({
    queryKey : ['store', stateCode, moduleCode, language, modulePrefix], // queryKey
    queryFn : () => StoreService.defaultData(stateCode, moduleCode, language, modulePrefix), // query function
    enabled: resolvedEnabled,
    // {
    //   // You can add other options here if needed, such as `enabled`, `staleTime`, etc.
    // }
  }
  );
};

export const useInitStore = (stateCode, enabledModules,modulePrefix = "rainmaker" ) => {
  const { isLoading, error, isError, data } = useQuery({
    queryKey: ["initStore", stateCode, enabledModules, modulePrefix],
    queryFn: () => StoreService.digitInitData(stateCode, enabledModules, modulePrefix),
    staleTime: Infinity,
  });
  return { isLoading, error, isError, data };
};

export const useInitTenantConfig = (stateCode, enabledModules) => {
  const { isLoading, error, isError, data } = useQuery({
    queryKey: ["initTenantConfig", stateCode, enabledModules],
    queryFn: () => StoreService.getTenantConfig(stateCode, enabledModules),
    staleTime: Infinity,
    enabled: Digit.Utils.getMultiRootTenant(),
  });
  return { isLoading, error, isError, data };
};
