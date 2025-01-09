import { useQuery } from "react-query";
import StoreData from "../services/molecules/StoreData";

const useStore = {
  getInitData: () =>
  useQuery({
    queryKey: ["STORE_DATA"],
    queryFn: () => StoreData.getInitData(),
    staleTime: Infinity,
  }),
};

export default useStore;
