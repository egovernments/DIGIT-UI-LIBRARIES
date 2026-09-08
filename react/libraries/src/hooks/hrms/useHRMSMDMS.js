import { MdmsService } from "../../services/elements/MDMS";
import { useQuery } from "@tanstack/react-query";

const useHrmsMDMS = (tenantId, moduleCode, type, config = {}) => {
  const useHrmsRolesandDesignations = () => {
    return useQuery({
      queryKey: ["HRMS_EMP_RD", tenantId],
      queryFn: () => MdmsService.getHrmsEmployeeRolesandDesignation(tenantId),
      ...config
    });
  };

  const useHrmsEmployeeTypes = () => {
    return useQuery({
      queryKey: ["HRMS_EMP_TYPE", tenantId],
      queryFn: () => MdmsService.getHrmsEmployeeTypes(tenantId, moduleCode, type),
      ...config
    });
  };

  const useHrmsEmployeeReasons = () => {
    // type must be part of the query key - DeactivationReason and ReactivationReason are
    // different masters, and without it React Query would treat both as the same cached
    // query, returning whichever loaded first for both regardless of which was requested.
    return useQuery({
      queryKey: ["HRMS_EMP_REASON", tenantId, moduleCode, type],
      queryFn: () => MdmsService.getHrmsEmployeeReason(tenantId, moduleCode, type),
      ...config
    });
  };

  switch (type) {
    case "HRMSRolesandDesignation":
      return useHrmsRolesandDesignations();
    case "EmployeeType":
      return useHrmsEmployeeTypes();
    case "DeactivationReason":
    case "ReactivationReason":
      return useHrmsEmployeeReasons();
    default:
      return null; // return null for unmatched types to avoid returning nothing
  }
};
export default useHrmsMDMS;
