import { useQuery } from "react-query";

const useGetFAQsJSON = (tenantId) => {
  return useQuery({
    queryKey: ["FAQ_S", tenantId],
    queryFn: () => Digit.MDMSService.getFAQsJSONData(tenantId),
  });
};

export default useGetFAQsJSON;