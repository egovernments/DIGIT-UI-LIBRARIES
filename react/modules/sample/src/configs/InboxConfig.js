import inboxConfig from "./SampleInboxConfig"

const InboxConfig=[
    {
      "type": "inbox",
      "label": "ACTION_TEST_ESTIMATE_INBOX",
      "sections": {
        "links": {
          "show": true,
          "children": {},
          "uiConfig": {
            "label": "ACTION_TEST_ESTIMATE_HEADER",
            "links": [
              {
                "url": "/employee/project/search-project",
                "text": "ACTION_TEST_CREATE_ESTIMATE",
                "roles": [
                  "ESTIMATE_CREATOR"
                ]
              },
              {
                "url": "/employee/estimate/search-estimate",
                "text": "ACTION_TEST_SEARCH_ESTIMATE",
                "roles": [
                  "ESTIMATE_VIEWER",
                  "ESTIMATE_CREATOR",
                  "ESTIMATE_VERIFIER",
                  "TECHNICAL_SANCTIONER",
                  "ESTIMATE_APPROVER"
                ]
              },
              {
                "url": "/employee/estimate/search-estimate?status=APPROVED&businessService=ESTIMATE",
                "text": "WORKS_CREATE_REVISED_ESTIMATE",
                "roles": [
                  "ESTIMATE_CREATOR"
                ]
              }
            ],
            "logoIcon": {
              "component": "EstimateIcon",
              "customClass": "inbox-links-icon"
            }
          }
        },
        "filter": {
          "show": true,
          "label": "ES_COMMON_FILTER",
          "uiConfig": {
            "type": "filter",
            "fields": [
              {
                "type": "radio",
                "label": "",
                "disable": false,
                "populators": {
                  "name": "assignee",
                  "styles": {
                    "gap": "1rem",
                    "flexDirection": "column"
                  },
                  "options": [
                    {
                      "code": "ASSIGNED_TO_ME",
                      "name": "EST_INBOX_ASSIGNED_TO_ME"
                    },
                    {
                      "code": "ASSIGNED_TO_ALL",
                      "name": "EST_INBOX_ASSIGNED_TO_ALL"
                    }
                  ],
                  "optionsKey": "name",
                  "innerStyles": {
                    "display": "flex"
                  }
                },
                "isMandatory": false
              },
              {
                "type": "locationdropdown",
                "label": "COMMON_WARD",
                "disable": false,
                "populators": {
                  "name": "ward",
                  "type": "ward",
                  "optionsKey": "i18nKey",
                  "defaultText": "COMMON_SELECT_WARD",
                  "selectedText": "COMMON_SELECTED",
                  "allowMultiSelect": true
                },
                "isMandatory": false
              },
              {
                "type": "workflowstatesfilter",
                "disable": false,
                "populators": {
                  "name": "state",
                  "labelPrefix": "WF_",
                  "componentLabel": "COMMON_WORKFLOW_STATES",
                  "businessService": "mukta-estimate"
                },
                "isMandatory": false
              }
            ],
            "headerStyle": null,
            "minReqFields": 0,
            "primaryLabel": "ES_COMMON_FILTER",
            "defaultValues": {
              "ward": [],
              "state": "",
              "status": "",
              "assignee": {
                "code": "ASSIGNED_TO_ALL",
                "name": "EST_INBOX_ASSIGNED_TO_ALL"
              },
              "locality": []
            },
            "secondaryLabel": ""
          }
        },
        "search": {
          "show": true,
          "label": "",
          "children": {},
          "uiConfig": {
            "fields": [
              {
                "type": "text",
                "label": "ESTIMATE_INBOX_ESTIMATE_NO",
                "disable": false,
                "populators": {
                  "name": "estimateNumber",
                  "error": "ESTIMATE_PATTERN_ERR_MSG",
                  "validation": {
                    "pattern": "ES|RE/[0-9]+-[0-9]+/[0-9]+",
                    "minlength": 2
                  }
                },
                "preProcess": {
                  "convertStringToRegEx": [
                    "populators.validation.pattern"
                  ]
                },
                "isMandatory": false
              },
              {
                "type": "text",
                "label": "WORKS_PROJECT_ID",
                "disable": false,
                "populators": {
                  "name": "projectId",
                  "error": "PROJECT_PATTERN_ERR_MSG",
                  "validation": {
                    "pattern": "PJ\\/[0-9]+-[0-9]+\\/[0-9]+",
                    "minlength": 2
                  }
                },
                "preProcess": {
                  "convertStringToRegEx": [
                    "populators.validation.pattern"
                  ]
                },
                "isMandatory": false
              },
              {
                "type": "dropdown",
                "label": "WORKS_PROJECT_TYPE",
                "disable": false,
                "populators": {
                  "name": "projectType",
                  "mdmsConfig": {
                    "masterName": "ProjectType",
                    "moduleName": "works",
                    "localePrefix": "COMMON_MASTERS"
                  },
                  "optionsKey": "name"
                },
                "isMandatory": false
              }
            ],
            "headerStyle": null,
            "minReqFields": 1,
            "primaryLabel": "ES_COMMON_SEARCH",
            "defaultValues": {
              "projectId": "",
              "projectType": "",
              "estimateNumber": ""
            },
            "secondaryLabel": "ES_COMMON_CLEAR_SEARCH"
          }
        },
        "searchResult": {
          "show": true,
          "label": "",
          "children": {},
          "uiConfig": {
            "columns": [
              {
                "key": "estimateNumber",
                "label": "ESTIMATE_INBOX_ESTIMATE_NO",
                "jsonPath": "ProcessInstance.businessId",
                "additionalCustomization": true
              },
              {
                "label": "ES_COMMON_PROJECT_NAME",
                "jsonPath": "businessObject.project.name"
              },
              {
                "label": "ESTIMATE_PREPARED_BY",
                "jsonPath": "businessObject.additionalDetails.creator"
              },
              {
                "key": "assignee",
                "label": "COMMON_ASSIGNEE",
                "jsonPath": "ProcessInstance.assignes",
                "additionalCustomization": true
              },
              {
                "key": "state",
                "label": "COMMON_WORKFLOW_STATES",
                "jsonPath": "ProcessInstance.state.state",
                "additionalCustomization": true
              },
              {
                "key": "estimatedAmount",
                "label": "WORKS_ESTIMATED_AMOUNT",
                "jsonPath": "businessObject.additionalDetails.totalEstimatedAmount",
                "headerAlign": "right",
                "additionalCustomization": true
              },
              {
                "key": "sla",
                "label": "COMMON_SLA_DAYS",
                "jsonPath": "businessObject.serviceSla",
                "additionalCustomization": true
              }
            ],
            "resultsJsonPath": "items",
            "enableColumnSort": true,
            "enableGlobalSearch": false
          },
          "projectId": "",
          "department": "",
          "estimateNumber": "",
          "estimateStatus": "",
          "toProposalDate": "",
          "fromProposalDate": ""
        }
      },
      "apiDetails": {
        "masterName": "commonUiConfig",
        "moduleName": "EstimateInboxConfig",
        "requestBody": {
          "inbox": {
            "moduleSearchCriteria": {},
            "processSearchCriteria": {
              "moduleName": "estimate-service",
              "businessService": [
                "ESTIMATE",
                "REVISION-ESTIMATE"
              ]
            }
          }
        },
        "serviceName": "/inbox/v2/_search",
        "requestParam": {},
        "tableFormJsonPath": "requestBody.inbox",
        "filterFormJsonPath": "requestBody.inbox.moduleSearchCriteria",
        "searchFormJsonPath": "requestBody.inbox.moduleSearchCriteria",
        "minParametersForFilterForm": 0,
        "minParametersForSearchForm": 0
      },
      "screenName": "EstimateInboxConfig",
      "additionalSections": {}
    }
  ]

export default inboxConfig;