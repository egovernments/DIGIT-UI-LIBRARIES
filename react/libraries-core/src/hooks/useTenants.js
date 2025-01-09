import { useQuery } from "@tanstack/react-query";

const alphabeticalSortFunctionForTenantsBasedOnName = (firstEl, secondEl) =>{
    if (firstEl.name.toUpperCase() < secondEl.name.toUpperCase() ) {
        return -1
    }
    if (firstEl.name.toUpperCase() > secondEl.name.toUpperCase() ) {
        return 1
    }
        return 0
}

export const useTenants = () => {
    return useQuery(
      ["ALL_TENANTS"], 
      () => {
        const tenants = Digit.SessionStorage.get("initData")?.tenants;
        return tenants ? tenants.sort(alphabeticalSortFunctionForTenantsBasedOnName) : [];
      }
    );
  };