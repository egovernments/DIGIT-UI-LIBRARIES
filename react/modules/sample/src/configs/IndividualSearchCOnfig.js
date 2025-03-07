const defaultSearchValues = {
    individualName: "",
    mobileNumber: "",
    IndividualID: ""
  };
export const searchconfig = () => 
{
  return {
    label: "Individual Search",
    type: "search",
    apiDetails: {
      serviceName: "/egov-mdms-service/v2/_search",
      requestParam: {
          "tenantId":Digit.ULBService.getCurrentTenantId()
      },
      requestBody: {
        apiOperation: "SEARCH",
        Individual: {
          "tenantId": Digit.ULBService.getCurrentTenantId(),
        },
      },
     masterName: "commonUiConfig",
      moduleName: "SearchIndividualConfig",
      minParametersForSearchForm: 0,
      tableFormJsonPath: "requestParam",
      filterFormJsonPath: "requestBody.Individual",
      searchFormJsonPath: "requestBody.Individual",
    },
    sections: {
      search: {
        uiConfig: {
          formClassName: "custom-both-clear-search",
          primaryLabel: "ES_COMMON_SEARCH",
          secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
          minReqFields: 0,
          defaultValues: defaultSearchValues, // Set default values for search fields
          fields: [
            {
              label: "Applicant name ",
              isMandatory: false,
              key: "individualName",
              type: "text",
              populators: { 
                name: "individualName", 
                error: "Required", 
                validation: { pattern: /^[A-Za-z]+$/i } 
              },
            },
            {
              label: "Phone number",
              isMandatory: false,
              key: "Phone number",
              type: "number",
              disable: false,
              populators: { name: "mobileNumber", error: "sample error message", validation: { min: 0, max: 999999999} },
            },
            {
              label: "Individual Id ",
              isMandatory: false,
              type: "text",
              disable: false,
              populators: { 
                name: "individualId",
              },
            },
          ],
        },

        show: true
      },
      searchResult: {
        tenantId: Digit.ULBService.getCurrentTenantId(),
        uiConfig: {
          columns: [
            {
              label: "IndividualID",
              jsonPath: "uniqueIdentifier",
              additionalCustomization:true
            },
            
            {
              label: "Name",
              jsonPath: "data.displayName",
              additionalCustomization:true              
            },
            {
              label: "Address",
              jsonPath: "data.path",
            },
          ],

          enableColumnSort: true,
          resultsJsonPath: "mdms"
        },
        show: true,
      },
    },
  };
};