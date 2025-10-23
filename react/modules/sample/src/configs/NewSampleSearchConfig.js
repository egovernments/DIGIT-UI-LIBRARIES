export const myCampaignConfig = {
  tenantId: "mz",
  moduleName: "commonCampaignUiConfig",
  showTab: true,
  myCampaignConfig: [
    {
      label: "CAMPAIGN_DRAFTS_NEW",
      type: "search",
      apiDetails: {
        serviceName: "/project-factory/v1/project-type/search",
        requestParam: {},
        requestBody: {},
        minParametersForSearchForm: 0,
        minParametersForFilterForm: 0,
        masterName: "commonUiConfig",
        moduleName: "MyCampaignConfigDraftsNew",
        tableFormJsonPath: "requestBody.inbox",
        filterFormJsonPath: "requestBody.custom",
        searchFormJsonPath: "requestBody.custom",
      },
      sections: {
        search: {
          uiConfig: {
            headerLabel: "ES_COMMON_SEARCH",
            type: "search",
            typeMobile: "filter",
            headerStyle: null,
            primaryLabel: "Filter",
            primaryLabelVariation: "teritiary",
            primaryLabelIcon: "FilterListAlt",
            secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
            minReqFields: 0,
            defaultValues: {
              campaignName: "",
              campaignType: "",
            },
            sortConfig: {
              initialSortOrder: "desc",
              label: "Sort",
              variation: "teritiary",
              icon: "ImportExport",
            },
            fields: [
              {
                label: "CAMPAIGN_SEARCH_NAME",
                type: "text",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "campaignName",
                  error: "TQM_ERR_VALID_CAMPAIGN_NAME",
                  style: {
                    marginBottom: "0px",
                  },
                },
              },
                {
                  label: "CAMPAIGN_SEARCH_TYPE",
                  type: "apidropdown",
                  isMandatory: false,
                  disable: false,
                  populators: {
                    optionsCustomStyle: {
                      top: "2.3rem",
                    },
                    name: "campaignType",
                    optionsKey: "name",
                    allowMultiSelect: false,
                    masterName: "commonUiConfig",
                    moduleName: "MyCampaignConfigDraftsNew",
                    customfn: "populateCampaignTypeReqCriteria",
                  },
                },
            ],
          },
          label: "",
          labelMobile: "ES_COMMON_SEARCH",
          children: {},
          show: true,
        },
        searchResult: {
          uiConfig: {
            columns: [
              {
                label: "CAMPAIGN_NAME",
                jsonPath: "campaignName",
                additionalCustomization: true,
              },
              {
                label: "CM_DRAFT_TYPE",
                jsonPath: "parentId",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_TYPE",
                jsonPath: "projectType",
                prefix: "CAMPAIGN_PROJECT_",
                translate: true,
              },
              {
                label: "CAMPAIGN_LAST_UPDATE",
                jsonPath: "lastModified",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_START_DATE",
                jsonPath: "startDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              // {
              //   label: "CAMPAIGN_END_DATE",
              //   jsonPath: "endDate",
              //   additionalCustomization: true,
              //   // disableSortBy: true,
              // },
              {
                label: "LAST_MODIFIED_TIME",
                jsonPath: "auditDetails.lastModifiedTime",
                additionalCustomization: true,
              },
            ],
            totalCountJsonPath:"totalCount",
            customRow: {
              overRideRowWithCustomRowComponent: true,
              customRowComponent: "ResultsDataCard",
              customRowProps:{
                showButton:true
              }
            },
            enableGlobalSearch: false,
            enableColumnSort: true,
            resultsJsonPath: "CampaignDetails",
            tableClassName: "table campaign-table",
          },
          children: {},
          show: true,
        },
        links: {
          show: false,
        },
        filter: {
          show: false,
        },
      },
      additionalSections: {},
      persistFormData: true,
      showAsRemovableTagsInMobile: true,
    },
     {
      label: "CAMPAIGN_DRAF",
      type: "search",
      apiDetails: {
        serviceName: "/project-factory/v1/project-type/search",
        requestParam: {},
        requestBody: {},
        minParametersForSearchForm: 0,
        minParametersForFilterForm: 0,
        masterName: "commonUiConfig",
        moduleName: "MyCampaignConfigDraftsNew",
        tableFormJsonPath: "requestBody.inbox",
        filterFormJsonPath: "requestBody.custom",
        searchFormJsonPath: "requestBody.custom",
      },
      sections: {
        search: {
          uiConfig: {
            headerLabel: "ES_COMMON_SEARCH",
            type: "search",
            typeMobile: "filter",
            headerStyle: null,
            primaryLabel: "Filter",
            primaryLabelVariation: "teritiary",
            primaryLabelIcon: "FilterListAlt",
            secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
            minReqFields: 0,
            defaultValues: {
              campaignName: "",
              campaignType: "",
            },
            sortConfig: {
              initialSortOrder: "desc",
              label: "Sort",
              variation: "teritiary",
              icon: "ImportExport",
            },
            fields: [
              {
                label: "CAMPAIGN_SEARCH_NAME",
                type: "text",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "campaignName",
                  error: "TQM_ERR_VALID_CAMPAIGN_NAME",
                  style: {
                    marginBottom: "0px",
                  },
                },
              },
                {
                  label: "CAMPAIGN_SEARCH_TYPE",
                  type: "apidropdown",
                  isMandatory: false,
                  disable: false,
                  populators: {
                    optionsCustomStyle: {
                      top: "2.3rem",
                    },
                    name: "campaignType",
                    optionsKey: "name",
                    allowMultiSelect: false,
                    masterName: "commonUiConfig",
                    moduleName: "MyCampaignConfigDraftsNew",
                    customfn: "populateCampaignTypeReqCriteria",
                  },
                },
            ],
          },
          label: "",
          labelMobile: "ES_COMMON_SEARCH",
          children: {},
          show: true,
        },
        searchResult: {
          uiConfig: {
            columns: [
              {
                label: "CAMPAIGN_NAME",
                jsonPath: "campaignName",
                additionalCustomization: true,
              },
              {
                label: "CM_DRAFT_TYPE",
                jsonPath: "parentId",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_TYPE",
                jsonPath: "projectType",
                prefix: "CAMPAIGN_PROJECT_",
                translate: true,
              },
              {
                label: "CAMPAIGN_LAST_UPDATE",
                jsonPath: "lastModified",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_START_DATE",
                jsonPath: "startDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              // {
              //   label: "CAMPAIGN_END_DATE",
              //   jsonPath: "endDate",
              //   additionalCustomization: true,
              //   // disableSortBy: true,
              // },
              {
                label: "LAST_MODIFIED_TIME",
                jsonPath: "auditDetails.lastModifiedTime",
                additionalCustomization: true,
              },
            ],
            totalCountJsonPath:"totalCount",
            customRow: {
              overRideRowWithCustomRowComponent: true,
              customRowComponent: "ResultsDataCard",
              customRowProps:{
                showButton:true
              }
            },
            enableGlobalSearch: false,
            enableColumnSort: true,
            resultsJsonPath: "CampaignDetails",
            tableClassName: "table campaign-table",
          },
          children: {},
          show: true,
        },
        links: {
          show: false,
        },
        filter: {
          show: false,
        },
      },
      additionalSections: {},
      persistFormData: true,
      showAsRemovableTagsInMobile: true,
    },
    {
      label: "CAMPAIGN_ONGOING",
      type: "search",
      apiDetails: {
        serviceName: "/project-factory/v1/project-type/search",
        requestParam: {},
        requestBody: {},
        minParametersForSearchForm: 0,
        minParametersForFilterForm: 0,
        masterName: "commonUiConfig",
        moduleName: "MyCampaignConfigOngoing",
        tableFormJsonPath: "requestBody.inbox",
        filterFormJsonPath: "requestBody.custom",
        searchFormJsonPath: "requestBody.custom",
      },
      sections: {
        search: {
          uiConfig: {
            headerLabel: "ES_COMMON_SEARCH",
            type: "search",
            typeMobile: "filter",
            headerStyle: null,
            primaryLabel: "Filter",
            primaryLabelVariation: "teritiary",
            primaryLabelIcon: "FilterListAlt",
            secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
            minReqFields: 0,
            defaultValues: {
              campaignName: "",
              campaignType: "",
            },
            sortConfig: {
              initialSortOrder: "desc",
              label: "Sort",
              variation: "teritiary",
              icon: "ImportExport",
            },
            fields: [
              {
                label: "CAMPAIGN_SEARCH_NAME",
                type: "text",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "campaignName",
                  error: "TQM_ERR_VALID_CAMPAIGN_NAME",
                  style: {
                    marginBottom: "0px",
                  },
                },
              },
              //   {
              //     label: "CAMPAIGN_SEARCH_TYPE",
              //     type: "apidropdown",
              //     isMandatory: false,
              //     disable: false,
              //     populators: {
              //       optionsCustomStyle: {
              //         top: "2.3rem",
              //       },
              //       name: "campaignType",
              //       optionsKey: "code",
              //       allowMultiSelect: false,
              //       masterName: "commonUiConfig",
              //       moduleName: "MyCampaignConfigOngoing",
              //       customfn: "populateCampaignTypeReqCriteria",
              //     },
              //   },
            ],
          },
          label: "",
          labelMobile: "ES_COMMON_SEARCH",
          children: {},
          show: true,
        },
        searchResult: {
          uiConfig: {
            columns: [
              {
                label: "CAMPAIGN_NAME",
                jsonPath: "campaignName",
                // additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_TYPE",
                jsonPath: "projectType",
                prefix: "CAMPAIGN_PROJECT_",
                translate: true,
              },
              {
                label: "CAMPAIGN_LAST_UPDATE",
                jsonPath: "lastModified",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_START_DATE",
                jsonPath: "startDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              {
                label: "CAMPAIGN_END_DATE",
                jsonPath: "endDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              {
                label: "CAMPAIGN_ACTIONS",
                jsonPath: "actions",
                additionalCustomization: true,
                // disableSortBy: true,
              },
            ],
            totalCountJsonPath:"totalCount",
            customRow: {
              overRideRowWithCustomRowComponent: true,
              customRowComponent: "ResultsDataCard",
              customRowProps:{
                showButton:true
              }
            },
            enableGlobalSearch: false,
            enableColumnSort: true,
            resultsJsonPath: "CampaignDetails",
            tableClassName: "table campaign-table",
          },
          children: {},
          show: true,
        },
        links: {
          show: false,
        },
        filter: {
          show: false,
        },
      },
      additionalSections: {},
      persistFormData: true,
      showAsRemovableTagsInMobile: true,
    },
    {
      label: "CAMPAIGN_COMPLETED",
      type: "search",
      apiDetails: {
        serviceName: "/project-factory/v1/project-type/search",
        requestParam: {},
        requestBody: {},
        minParametersForSearchForm: 0,
        minParametersForFilterForm: 0,
        masterName: "commonUiConfig",
        moduleName: "MyCampaignConfigCompleted",
        tableFormJsonPath: "requestBody.inbox",
        filterFormJsonPath: "requestBody.custom",
        searchFormJsonPath: "requestBody.custom",
      },
      sections: {
        search: {
          uiConfig: {
            headerLabel: "ES_COMMON_SEARCH",
            type: "search",
            typeMobile: "filter",
            headerStyle: null,
            primaryLabel: "Filter",
            primaryLabelVariation: "teritiary",
            primaryLabelIcon: "FilterListAlt",
            secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
            minReqFields: 0,
            defaultValues: {
              campaignName: "",
              campaignType: "",
            },
            sortConfig: {
              initialSortOrder: "desc",
              label: "Sort",
              variation: "teritiary",
              icon: "ImportExport",
            },
            fields: [
              {
                label: "CAMPAIGN_SEARCH_NAME",
                type: "text",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "campaignName",
                  error: "TQM_ERR_VALID_CAMPAIGN_NAME",
                  style: {
                    marginBottom: "0px",
                  },
                },
              },
              //   {
              //     label: "CAMPAIGN_SEARCH_TYPE",
              //     type: "apidropdown",
              //     isMandatory: false,
              //     disable: false,
              //     populators: {
              //       optionsCustomStyle: {
              //         top: "2.3rem",
              //       },
              //       name: "campaignType",
              //       optionsKey: "code",
              //       allowMultiSelect: false,
              //       masterName: "commonUiConfig",
              //       moduleName: "MyCampaignConfigCompleted",
              //       customfn: "populateCampaignTypeReqCriteria",
              //     },
              //   },
            ],
          },
          label: "",
          labelMobile: "ES_COMMON_SEARCH",
          children: {},
          show: true,
        },
        searchResult: {
          uiConfig: {
            totalCountJsonPath:"totalCount",
            columns: [
              {
                label: "CAMPAIGN_NAME",
                jsonPath: "campaignName",
                // additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_TYPE",
                jsonPath: "projectType",
                prefix: "CAMPAIGN_PROJECT_",
                translate: true,
              },
              {
                label: "CAMPAIGN_LAST_UPDATE",
                jsonPath: "lastModified",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_START_DATE",
                jsonPath: "startDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              {
                label: "CAMPAIGN_END_DATE",
                jsonPath: "endDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              {
                label: "CAMPAIGN_ACTIONS",
                jsonPath: "actions",
                additionalCustomization: true,
                // disableSortBy: true,
              },
            ],
            customRow: {
              overRideRowWithCustomRowComponent: true,
              customRowComponent: "ResultsDataCard",
              customRowProps:{
                showButton:true
              }
            },
            enableGlobalSearch: false,
            enableColumnSort: true,
            resultsJsonPath: "CampaignDetails",
            // customDefaultPagination: {
            //   limit: 5,
            //   offset: 0,
            // },
            // customPageSizesArray: [5, 10, 15, 20],
            tableClassName: "table campaign-table",
          },
          children: {},
          show: true,
        },
        links: {
          show: false,
        },
        filter: {
          show: false,
        },
      },
      additionalSections: {},
      persistFormData: true,
      showAsRemovableTagsInMobile: true,
    },
    {
      label: "CAMPAIGN_UPCOMING",
      type: "search",
      apiDetails: {
        serviceName: "/project-factory/v1/project-type/search",
        requestParam: {},
        requestBody: {},
        minParametersForSearchForm: 0,
        minParametersForFilterForm: 0,
        masterName: "commonUiConfig",
        moduleName: "MyCampaignConfigUpcoming",
        tableFormJsonPath: "requestBody.inbox",
        filterFormJsonPath: "requestBody.custom",
        searchFormJsonPath: "requestBody.custom",
      },
      sections: {
        search: {
          uiConfig: {
            headerLabel: "ES_COMMON_SEARCH",
            type: "search",
            typeMobile: "filter",
            headerStyle: null,
            primaryLabel: "Filter",
            primaryLabelVariation: "teritiary",
            primaryLabelIcon: "FilterListAlt",
            secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
            minReqFields: 0,
            defaultValues: {
              campaignName: "",
              campaignType: "",
            },
            sortConfig: {
              initialSortOrder: "desc",
              label: "Sort",
              variation: "teritiary",
              icon: "ImportExport",
            },
            fields: [
              {
                label: "CAMPAIGN_SEARCH_NAME",
                type: "text",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "campaignName",
                  error: "TQM_ERR_VALID_CAMPAIGN_NAME",
                  style: {
                    marginBottom: "0px",
                  },
                },
              },
              //   {
              //     label: "CAMPAIGN_SEARCH_TYPE",
              //     type: "apidropdown",
              //     isMandatory: false,
              //     disable: false,
              //     populators: {
              //       optionsCustomStyle: {
              //         top: "2.3rem",
              //       },
              //       name: "campaignType",
              //       optionsKey: "code",
              //       allowMultiSelect: false,
              //       masterName: "commonUiConfig",
              //       moduleName: "MyCampaignConfigUpcoming",
              //       customfn: "populateCampaignTypeReqCriteria",
              //     },
              //   },
            ],
          },
          label: "",
          labelMobile: "ES_COMMON_SEARCH",
          children: {},
          show: true,
        },
        searchResult: {
          uiConfig: {
            totalCountJsonPath:"totalCount",
            columns: [
              {
                label: "CAMPAIGN_NAME",
                jsonPath: "campaignName",
                // additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_TYPE",
                jsonPath: "projectType",
                prefix: "CAMPAIGN_PROJECT_",
                translate: true,
              },
              {
                label: "CAMPAIGN_LAST_UPDATE",
                jsonPath: "lastModified",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_START_DATE",
                jsonPath: "startDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              {
                label: "CAMPAIGN_END_DATE",
                jsonPath: "endDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              {
                label: "CAMPAIGN_ACTIONS",
                jsonPath: "actions",
                additionalCustomization: true,
                // disableSortBy: true,
              },
            ],
            customRow: {
              overRideRowWithCustomRowComponent: true,
              customRowComponent: "ResultsDataCard",
              customRowProps:{
                showButton:true
              }
            },
            enableGlobalSearch: false,
            enableColumnSort: true,
            resultsJsonPath: "CampaignDetails",
            // customDefaultPagination: {
            //   limit: 5,
            //   offset: 0,
            // },
            // customPageSizesArray: [5, 10, 15, 20],
            tableClassName: "table campaign-table",
          },
          children: {},
          show: true,
        },
        links: {
          show: false,
        },
        filter: {
          show: false,
        },
      },
      additionalSections: {},
      persistFormData: true,
      showAsRemovableTagsInMobile: true,
    },
    {
      label: "CAMPAIGN_DRAFTS",
      type: "search",
      apiDetails: {
        serviceName: "/project-factory/v1/project-type/search",
        requestParam: {},
        requestBody: {},
        minParametersForSearchForm: 0,
        minParametersForFilterForm: 0,
        masterName: "commonUiConfig",
        moduleName: "MyCampaignConfigDrafts",
        tableFormJsonPath: "requestBody.inbox",
        filterFormJsonPath: "requestBody.custom",
        searchFormJsonPath: "requestBody.custom",
      },
      sections: {
        search: {
          uiConfig: {
            headerLabel: "ES_COMMON_SEARCH",
            type: "search",
            typeMobile: "filter",
            headerStyle: null,
            primaryLabel: "Filter",
            primaryLabelVariation: "teritiary",
            primaryLabelIcon: "FilterListAlt",
            secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
            minReqFields: 0,
            defaultValues: {
              campaignName: "",
              campaignType: "",
            },
            sortConfig: {
              initialSortOrder: "desc",
              label: "Sort",
              variation: "teritiary",
              icon: "ImportExport",
            },
            fields: [
              {
                label: "CAMPAIGN_SEARCH_NAME",
                type: "text",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "campaignName",
                  error: "TQM_ERR_VALID_CAMPAIGN_NAME",
                  style: {
                    marginBottom: "0px",
                  },
                },
              },
              //   {
              //     label: "CAMPAIGN_SEARCH_TYPE",
              //     type: "apidropdown",
              //     isMandatory: false,
              //     disable: false,
              //     populators: {
              //       optionsCustomStyle: {
              //         top: "2.3rem",
              //       },
              //       name: "campaignType",
              //       optionsKey: "code",
              //       allowMultiSelect: false,
              //       masterName: "commonUiConfig",
              //       moduleName: "MyCampaignConfigDrafts",
              //       customfn: "populateCampaignTypeReqCriteria",
              //     },
              //   },
            ],
          },
          label: "",
          labelMobile: "ES_COMMON_SEARCH",
          children: {},
          show: true,
        },
        searchResult: {
          uiConfig: {
            totalCountJsonPath:"totalCount",
            columns: [
              {
                label: "CAMPAIGN_NAME",
                jsonPath: "campaignName",
                // additionalCustomization: true,
              },
              {
                label: "CM_DRAFT_TYPE",
                jsonPath: "parentId",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_TYPE",
                jsonPath: "projectType",
                prefix: "CAMPAIGN_PROJECT_",
                translate: true,
              },
              {
                label: "CAMPAIGN_LAST_UPDATE",
                jsonPath: "lastModified",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_START_DATE",
                jsonPath: "startDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              // {
              //   label: "CAMPAIGN_END_DATE",
              //   jsonPath: "endDate",
              //   additionalCustomization: true,
              //   // disableSortBy: true,
              // },
              {
                label: "LAST_MODIFIED_TIME",
                jsonPath: "auditDetails.lastModifiedTime",
                additionalCustomization: true,
              },
            ],
            customRow: {
              overRideRowWithCustomRowComponent: true,
              customRowComponent: "ResultsDataCard",
              customRowProps:{
                showButton:true
              }
            },
            enableGlobalSearch: false,
            enableColumnSort: true,
            resultsJsonPath: "CampaignDetails",
            tableClassName: "table campaign-table",
          },
          children: {},
          show: true,
        },
        links: {
          show: false,
        },
        filter: {
          show: false,
        },
      },
      additionalSections: {},
      persistFormData: true,
      showAsRemovableTagsInMobile: true,
    },
    {
      label: "CAMPAIGN_FAILED",
      type: "search",
      apiDetails: {
        serviceName: "/project-factory/v1/project-type/search",
        requestParam: {},
        requestBody: {},
        minParametersForSearchForm: 0,
        minParametersForFilterForm: 0,
        masterName: "commonUiConfig",
        moduleName: "MyCampaignConfigFailed",
        tableFormJsonPath: "requestBody.inbox",
        filterFormJsonPath: "requestBody.custom",
        searchFormJsonPath: "requestBody.custom",
      },
      sections: {
        search: {
          uiConfig: {
            headerLabel: "ES_COMMON_SEARCH",
            type: "search",
            typeMobile: "filter",
            headerStyle: null,
            primaryLabel: "Filter",
            primaryLabelVariation: "teritiary",
            primaryLabelIcon: "FilterListAlt",
            secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
            minReqFields: 0,
            defaultValues: {
              campaignName: "",
              campaignType: "",
            },
            sortConfig: {
              initialSortOrder: "desc",
              label: "Sort",
              variation: "teritiary",
              icon: "ImportExport",
            },
            fields: [
              {
                label: "CAMPAIGN_SEARCH_NAME",
                type: "text",
                isMandatory: false,
                disable: false,
                populators: {
                  name: "campaignName",
                  error: "TQM_ERR_VALID_CAMPAIGN_NAME",
                  style: {
                    marginBottom: "0px",
                  },
                },
              },
              //   {
              //     label: "CAMPAIGN_SEARCH_TYPE",
              //     type: "apidropdown",
              //     isMandatory: false,
              //     disable: false,
              //     populators: {
              //       optionsCustomStyle: {
              //         top: "2.3rem",
              //       },
              //       name: "campaignType",
              //       optionsKey: "code",
              //       allowMultiSelect: false,
              //       masterName: "commonUiConfig",
              //       moduleName: "MyCampaignConfigCompleted",
              //       customfn: "populateCampaignTypeReqCriteria",
              //     },
              //   },
            ],
          },
          label: "",
          labelMobile: "ES_COMMON_SEARCH",
          children: {},
          show: true,
        },
        searchResult: {
          uiConfig: {
            totalCountJsonPath:"totalCount",
            columns: [
              {
                label: "CAMPAIGN_NAME",
                jsonPath: "campaignName",
                // additionalCustomization: true,
              },
              {
                label: "CM_DRAFT_TYPE",
                jsonPath: "parentId",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_TYPE",
                jsonPath: "projectType",
                prefix: "CAMPAIGN_PROJECT_",
                translate: true,
              },
              {
                label: "CAMPAIGN_LAST_UPDATE",
                jsonPath: "lastModified",
                additionalCustomization: true,
              },
              {
                label: "CAMPAIGN_START_DATE",
                jsonPath: "startDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              {
                label: "CAMPAIGN_END_DATE",
                jsonPath: "endDate",
                additionalCustomization: true,
                // disableSortBy: true,
              },
              {
                label: "CAMPAIGN_ACTIONS",
                jsonPath: "actions",
                additionalCustomization: true,
                // disableSortBy: true,
              },
            ],
            customRow: {
              overRideRowWithCustomRowComponent: true,
              customRowComponent: "ResultsDataCard",
              customRowProps:{
                showButton:true
              }
            },
            enableGlobalSearch: false,
            enableColumnSort: true,
            resultsJsonPath: "CampaignDetails",
            // customDefaultPagination: {
            //   limit: 5,
            //   offset: 0,
            // },
            // customPageSizesArray: [5, 10, 15, 20],
            tableClassName: "table campaign-table",
          },
          children: {},
          show: true,
        },
        links: {
          show: false,
        },
        filter: {
          show: false,
        },
      },
      additionalSections: {},
      persistFormData: true,
      showAsRemovableTagsInMobile: true,
    },
  ],
};
