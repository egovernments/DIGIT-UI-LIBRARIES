import useCustomMDMS from "./useCustomMDMS";
const useSSOConfig = (tenantId, config = {}) => {
  return useCustomMDMS(
    tenantId,
    "SSO",
    [{ name: "IdentityProviders", filter: "[?(@.active == true)]" }],
    config,
  );
};

export default useSSOConfig;
