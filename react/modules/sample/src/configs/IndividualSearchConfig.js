const defaultSearchValues = {
    individualName: "",
    mobileNumber: "",
    IndividualID: ""
  };
export const searchconfig = () => 
{
  return {
    label: "MDMS Search",
    type: "search",
    apiDetails: {
      serviceName: "/egov-mdms-service/v2/_search",
      mutationUrl:"/egov-mdms-service/v2/_update/test.projectconfig",
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
              label: "Id",
              jsonPath: "uniqueIdentifier",
              // additionalCustomization:true,
              editable:true,
              editableFieldConfig: {
                inline: true,
                label: "Id",
                isMandatory: true,
                type: "text",
                disable: false,
                populators: { name: "row.uniqueIdentifier", error: "Error!",styles:{
                  "width":"10vw",
                  "margin-top":"2rem"
                }, },
                withoutLabel:true
              },
            },
            {
              label: "Name",
              jsonPath: "data.name",
              // additionalCustomization:true,
              editable:true,
              editableFieldConfig: {
                inline: true,
                isMandatory: false,
                type: "text",
                label:"Name",
                disable: false,
                populators: { name: "row.name", error: "Error!",styles:{
                  "width":"10vw",
                  "margin-top":"2rem"
                },
                validation:{minlength:2} },
                withoutLabel:true
              },
            },
            {
              label: "Observation Strategy",
              jsonPath: "data.observationStrategy",
              // additionalCustomization:true,
              editable:true,
              editableFieldConfig: {
                inline:true,
                inline: true,
                isMandatory: false,
                type: "text",
                disable: false,
                populators: { name: "row.observationStrategy", error: "Error!",styles:{
                  "width":"10vw",
                  "margin-top":"2rem"
                }, },
                withoutLabel:true,
                label:"Observation Strategy"
              },
            },
            {
              label: "Project Type",
              jsonPath: "data.code",
              editable:true,
              editableFieldConfig:{
                inline:true,
                withoutLabel:true,
                label:"Project Type",
                isMandatory: false,
                type: "dropdown",
                key: "row.code",
                disable: false,
                populators: {
                  styles:{
                    "width":"10vw",
                    "margin-top":"2rem"
                  },
                  name: "row.code",
                  optionsKey: "code",
                  error: "",
                  required: true,
                  mdmsConfig: {
                    masterName: "projectTypes",
                    moduleName: "HCM-PROJECT-TYPES",
                    localePrefix: "HCM_PROJECT_TYPE",
                  },
                },
              }
            },
            // {
            //   label: "Popup",
            //   jsonPath: "data.displayName",
            //   additionalCustomization:true              
            // },
            // {
            //   label: "Address",
            //   jsonPath: "data.path",
            //   editable:true,
            //   editableFieldConfig:{
            //     withoutLabel:true,
            //     isMandatory: false,
            //     type: "dropdown",
            //     key: "row.genders",
            //     label: "Default",
            //     disable: false,
            //     populators: {
            //       styles:{
            //         "width":"10vw",
            //         "margin-top":"2rem"
            //       },
            //       name: "row.genders",
            //       optionsKey: "name",
            //       error: "",
            //       required: true,
            //       mdmsConfig: {
            //         masterName: "GenderType",
            //         moduleName: "common-masters",
            //         localePrefix: "COMMON_GENDER",
            //       },
            //     },
            //   }
            // },
            // {
            //   label: "Path",
            //   jsonPath: "data.id",
            //   editable:true,
            //   editableFieldConfig:{
            //     withoutLabel:true,
            //     isMandatory: false,
            //     type: "dropdown",
            //     key: "row.id",
            //     label: "Default",
            //     disable: false,
            //     populators: {
            //       styles:{
            //         "width":"10vw",
            //         "margin-top":"2rem"
            //       },
            //       name: "row.id",
            //       optionsKey: "name",
            //       error: "",
            //       required: true,
            //       mdmsConfig: {
            //         masterName: "GenderType",
            //         moduleName: "common-masters",
            //         localePrefix: "COMMON_GENDER",
            //       },
            //     },
            //   }
            // },
            {
              label: "isActive",
              jsonPath: "isActive",
              editable:true,
              editableFieldConfig:{
                inline:true,
                withoutLabel:true,
                isMandatory: false,
                type: "toggle",
                key: "row.isActive",
                label: "Active",
                disable: false,
                populators: {
                  styles:{
                    "width":"10vw",
                    "margin-top":"2rem"
                  },
                  name: "row.isActive",
                  optionsKey: "name",
                  error: "",
                  required: false,
                  // showIcon: true,
                  options: [
                    {
                      code: "true",
                      name: true,
                      // icon: "Article",
                    },
                    {
                      code: "false",
                      name: false,
                      // icon: "Article",
                    },
                    // {
                    //   code: "3",
                    //   name: "Option3",
                    //   icon: "Article",
                    // },
                  ],
                },
              }
            },
            // {
            //   label: "Edit",
            //   jsonPath: "data.paths",
            //   additionalCustomization:true
            // },
          ],
          enableColumnSort: true,
          resultsJsonPath: "mdms",
          editableRows:true,//this should automatically add a button at the end for editing rows
          editablePopup:false,
          additionalPopupColumns:[
            {
              label: "Group",
              jsonPath: "data.group",
              // additionalCustomization:true,
              editable:true,
              editableFieldConfig: {
                inline: true,
                label: "Group",
                isMandatory: true,
                type: "text",
                disable: false,
                populators: { name: "row.data.group", error: "Error!",styles:{
                  "width":"10vw",
                  "margin-top":"2rem"
                }, },
                withoutLabel:true
              },
            },
          ]
          // both of the above cannot be true
          // editableRowsList:["Id","Address"],//this can store the labels of rows that are editable
        },
        show: true,
      },
    },
  };
};