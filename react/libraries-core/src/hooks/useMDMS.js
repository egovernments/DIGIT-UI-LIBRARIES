import { MdmsService } from "../services/elements/MDMS";
import { useQuery } from "@tanstack/react-query";

const useMDMS = (tenantId, moduleCode, type, config = {}, payload = []) => {
  
  // Payment Gateway query function
  const usePaymentGateway = () => {
    return useQuery({
      queryKey: ["PAYMENT_GATEWAY"],
      queryFn: () => MdmsService.getPaymentGateway(tenantId, moduleCode, type),
      select: (data) => data?.[moduleCode]?.[type]?.filter((e) => e.active).map(({ gateway }) => gateway),
      ...config,
    });
  };

  // Receipt Key query function
  const useReceiptKey = () => {
    return useQuery({
      queryKey: ["RECEIPT_KEY"],
      queryFn: () => MdmsService.getReceiptKey(tenantId, moduleCode, type),
      ...config,
    });
  };

  // Bills Genie Key query function
  const useBillsGenieKey = () => {
    return useQuery({
      queryKey: ["BILLS_GENIE_KEY"],
      queryFn: () => MdmsService.getBillsGenieKey(tenantId, moduleCode, type),
      ...config,
    });
  };

  // FSTP Plant Info query function
  const useFSTPPlantInfo = () => {
    return useQuery({
      queryKey: ["FSTP_PLANTINFO"],
      queryFn: () => MdmsService.getFSTPPlantInfo(tenantId, moduleCode, type),
      ...config,
    });
  };

  // Default query function for other types
  const _default = () => {
    return useQuery({
      queryKey: [tenantId, moduleCode, type],
      queryFn: () => MdmsService.getMultipleTypes(tenantId, moduleCode, type),
      ...config,
    });
  };

  // Switch based on the `type` to return the corresponding query function
  switch (type) {
    case "PaymentGateway":
      return usePaymentGateway();
    case "ReceiptKey":
      return useReceiptKey();
    case "FSTPPlantInfo":
      return useFSTPPlantInfo();
    case "BillsGenieKey":
      return useBillsGenieKey();
    default:
      return _default();
  }
};

export default useMDMS;
