import { useQuery } from "@tanstack/react-query";
import { StoreService } from "../services/molecules/Store/service";

export const useStore = ({ stateCode, moduleCode, language }) => {
  return useQuery({
    queryKey: ["store", stateCode, moduleCode, language],
    queryFn: () => StoreService.defaultData(stateCode, moduleCode, language),
  });
};

export const useInitStore = (stateCode, enabledModules) => {
  const { isLoading, error, isError, data } = useQuery({
    queryKey: ["initStore", stateCode, enabledModules],
    queryFn: () => StoreService.digitInitData(stateCode, enabledModules),
    staleTime: Infinity,
  });
  return { isLoading, error, isError, data };
};
