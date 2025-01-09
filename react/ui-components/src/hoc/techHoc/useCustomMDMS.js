import { useQuery } from "@tanstack/react-query";
// import { MdmsService } from "../services/elements/MDMS";
/**
 * Custom hook which can be used to
 * make a single hook a module to get multiple masterdetails with/without filter
 *
 * @author jagankumar-egov
 *
 * @example
 * // returns useQuery object
 * Digit.Hooks.useCustomMDMS(
 *          "stateid",
 *          "modulename",
 *          [
 *              { name:"masterdetail1",filter:"[?(@.active == true)]"},
 *              { name:"masterdetail2" }
 *          ],
 *          { // all configs supported by the usequery
 *              default:(data)=>{
 *                          format
 *                          return formattedData;
 *                          }
 *          })
 *
 * @returns {Object} Returns the object of the useQuery from react-query.
 */
const useCustomMDMS = (tenantId, moduleName, masterDetails = [], config = {}) => {
  return useQuery(
    [tenantId, moduleName, ...masterDetails], // Spread masterDetails to ensure they are included in the query key.
    () =>
      window?.Digit?.MdmsService.getMultipleTypesWithFilter(tenantId, moduleName, masterDetails), // Ensure your service function is being called properly.
    config // Include any additional configuration passed to the query.
  );
};
export default useCustomMDMS;
