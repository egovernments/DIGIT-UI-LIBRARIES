const inboxConfig = () => {
    return {
      label: "ES_COMMON_INBOX",
      postProcessResult: true,
      type: "inbox",
      apiDetails: {
        serviceName: "/inbox/v2/_search",
        requestParam: {},
        requestBody: {
          inbox: {
            processSearchCriteria: {
              businessService: ["muster-roll-approval"],
              moduleName: "muster-roll-service",
            },
            moduleSearchCriteria: {},
          },
        },
        minParametersForSearchForm: 0,
        minParametersForFilterForm: 0,
        masterName: "commonUiConfig",
        moduleName: "AttendanceInboxConfig",
        tableFormJsonPath: "requestBody.inbox",
        filterFormJsonPath: "requestBody.inbox.moduleSearchCriteria",
        searchFormJsonPath: "requestBody.inbox.moduleSearchCriteria",
      },
      sections: {
        search: {
          uiConfig: {
            headerStyle: null,
            primaryLabel: "ES_COMMON_SEARCH",
            secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
            minReqFields: 1,
            defaultValues: {
              attendanceRegisterName: "",
              orgId: "",
              musterRollNumber: "",
            },
            fields: [
              {
                label: "Search field 1",
                type: "text",
                isMandatory: false,
                disable: false,
                preProcess: {
                  convertStringToRegEx: ["populators.validation.pattern"],
                },
                populators: {
                  name: "musterRollNumber",
                  error: "COMMON_PATTERN_ERR_MSG_MUSTER_ID",
                  validation: {
                    pattern: "MR\\/[0-9]+-[0-9]+\\/[0-9]+\\/[0-9]+",
                    minlength: 2,
                  },
                },
              },
              {
                label: "Search field 2",
                type: "date",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "attendanceRegisterName",
                  error: "PROJECT_PATTERN_ERR_MSG",
                },
              },
              {
                label: "Search field 3",
                type: "dropdown",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "dropdown",
                  optionsKey: "name",
                  error: "Error!",
                  required: false,
                  options: [
                    {
                      code: "Option1",
                      name: "Option 1",
                    },
                    {
                      code: "Option2",
                      name: "Option 2",
                    },
                    {
                      code: "Option3",
                      name: "Option 3",
                    },
                  ],
                },
              },
            ],
          },
          label: "",
          children: {},
          show: true,
        },
        links: {
          uiConfig: {
            links: [
              {
                text: "Menu1",
                url: "/employee/sample/components",
                roles: ["SYSTEM_ADMINISTRATOR","MICROPLAN_ADMIN"],
                hyperlink:false
              },
              {
                text: "Menu2",
                url: "/employee/sample/search",
                roles: ["SYSTEM_ADMINISTRATOR","MICROPLAN_ADMIN"],
                hyperlink:false
              },
            ],
            label: "Module Name",
            logoIcon: {
              component: "Opacity",
              customClass: "search-icon--projects",
            },
          },
          children: {},
          show: true,
        },
        filter: {
          uiConfig: {
            type: "filter",
            headerStyle: null,
            primaryLabel: "Apply Filters",
            secondaryLabel: "Clear Filters",
            minReqFields: 1,
            defaultValues: {
              dropdown: "",
              apidropdown: [],
              status: "",
              radio: {
                code: "ASSIGNED_TO_ME",
                name: "Assigned to me",
              },
            },
            fields: [
              {
                label: "",
                type: "radio",
                isMandatory: false,
                disable: false,
                addDivider:true,
                populators: {
                  alignVertical:true,
                  name: "radio",
                  options: [
                    {
                      code: "ASSIGNED_TO_ALL",
                      name: "Assigned to all",
                    },
                    {
                      code: "ASSIGNED_TO_ME",
                      name: "Assigned to me",
                    },
                  ],
                  optionsKey: "name",
                },
              },
              {
                label: "Dropdown",
                type: "dropdown",
                isMandatory: false,
                addDivider:true,
                disable: false,
                populators: {
                  name: "dropdown",
                  options: [
                    {
                      code: "Option1",
                      name: "Option 1",
                    },
                    {
                      code: "Option2",
                      name: "Option 2",
                    },
                  ],
                  optionsKey: "name",
                },
              },
              {
                label: "ApiDropdown",
                type: "apidropdown",
                addDivider:true,
                isMandatory: false,
                disable: false,
                populators: {
                  name: "apidropdown",
                  optionsKey: "code",
                  allowMultiSelect: true,
                  masterName: "commonUiConfig",
                  moduleName: "FacilityMappingConfig",
                  customfn: "getFacilitySearchRequest",
                }
              },
              // {
              //   label: "Status",
              //   type: "workflowstatesfilter",
              //   labelClassName:"checkbox-status-filter-label" ,
              //   isMandatory: false,
              //   disable: false,
              //   populators: {
              //     name: "status",
              //     labelPrefix: "WF_MUSTOR_",
              //     businessService: "muster-roll-approval",
              //   },
              // },
            ],
          },
          label: "ES_COMMON_FILTERS",
          show: true,
        },
        searchResult: {
          label: "",
          uiConfig: {
            columns: [
              {
                label: "Application Number",
                jsonPath: "businessObject.musterRollNumber",
                additionalCustomization: true,
              },
              {
                label: "Consumer Number",
                jsonPath: "businessObject.additionalDetails.attendanceRegisterName",
              },
              {
                label: "Owner",
                jsonPath: "businessObject.additionalDetails.orgName",
              },
              {
                label: "Status",
                jsonPath: "ProcessInstance.assignes[0].name",
                key: "assignee",
              },
              {
                label: "SLA",
                jsonPath: "ProcessInstance.state.state",
                additionalCustomization: true,
                key: "state",
              },
            ],
            enableGlobalSearch: false,
            enableColumnSort: true,
            resultsJsonPath: "items",
          },
          children: {},
          show: true,
        },
      },
      additionalSections: {},
    };
  };
  
  export default inboxConfig;
  