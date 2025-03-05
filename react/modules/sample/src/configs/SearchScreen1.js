const searchConfig1={
    "type": "search",
    "label": "WORKS_SEARCH_PROJECTS",
    "sections": {
      "search": {
        "show": true,
        "label": "",
        "children": {},
        "uiConfig": {
          "fields": [
            {
              "type": "locationdropdown",
              "label": "PDF_STATIC_LABEL_ESTIMATE_WARD",
              "disable": false,
              "populators": {
                "name": "boundary",
                "type": "ward",
                "optionsKey": "i18nKey",
                "allowMultiSelect": false
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
            },
            {
              "type": "text",
              "label": "WORKS_PROJECT_NAME",
              "disable": false,
              "populators": {
                "name": "projectName",
                "error": "PROJECT_PATTERN_ERR_MSG",
                "validation": {
                  "pattern": "^[^\\$\"<>?\\\\~`!@$%^()+={}\\[\\]*:;“”‘’]{1,50}$",
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
                "name": "projectNumber",
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
              "key": "createdFrom",
              "type": "date",
              "label": "ES_COMMON_CREATED_FROM",
              "disable": false,
              "populators": {
                "max": "currentDate",
                "name": "createdFrom"
              },
              "preProcess": {
                "updateDependent": [
                  "populators.max"
                ]
              },
              "isMandatory": false
            },
            {
              "key": "createdTo",
              "type": "date",
              "label": "ES_COMMON_CREATED_TO",
              "disable": false,
              "populators": {
                "max": "currentDate",
                "name": "createdTo",
                "error": "DATE_VALIDATION_MSG"
              },
              "preProcess": {
                "updateDependent": [
                  "populators.max"
                ]
              },
              "isMandatory": false,
              "additionalValidation": {
                "keys": {
                  "end": "createdTo",
                  "start": "createdFrom"
                },
                "type": "date"
              }
            }
          ],
          "headerStyle": null,
          "minReqFields": 1,
          "primaryLabel": "ES_COMMON_SEARCH",
          "defaultValues": {
            "boundary": "",
            "createdTo": "",
            "createdFrom": "",
            "projectName": "",
            "projectType": "",
            "projectNumber": ""
          },
          "secondaryLabel": "ES_COMMON_CLEAR_SEARCH",
          "showFormInstruction": "PROJECT_SELECT_ONE_PARAM_TO_SEARCH"
        }
      },
      "searchResult": {
        "show": true,
        "label": "",
        "children": {},
        "uiConfig": {
          "columns": [
            {
              "label": "WORKS_PROJECT_ID",
              "jsonPath": "businessObject.projectNumber",
              "additionalCustomization": true
            },
            {
              "label": "WORKS_PROJECT_NAME",
              "jsonPath": "businessObject.name",
              "maxLength": 40,
              "additionalCustomization": true
            },
            {
              "label": "ES_COMMON_LOCATION",
              "jsonPath": "businessObject.address.boundary",
              "additionalCustomization": true
            },
            {
              "label": "PROJECT_ESTIMATED_COST_IN_RS",
              "jsonPath": "businessObject.additionalDetails.estimatedCostInRs",
              "headerAlign": "right",
              "additionalCustomization": true
            }
          ],
          "resultsJsonPath": "items",
          "enableColumnSort": true,
          "enableGlobalSearch": false
        }
      }
    },
    "actionLink": "project/create-project",
    "actionRole": "PROJECT_CREATOR",
    "apiDetails": {
      "masterName": "commonUiConfig",
      "moduleName": "SearchWMSProjectConfig",
      "requestBody": {
        "inbox": {
          "moduleSearchCriteria": {}
        }
      },
      "serviceName": "/wms/project/_search",
      "requestParam": {},
      "tableFormJsonPath": "requestBody.inbox",
      "filterFormJsonPath": "requestBody.inbox.moduleSearchCriteria",
      "searchFormJsonPath": "requestBody.inbox.moduleSearchCriteria",
      "minParametersForSearchForm": 1
    },
    "screenName": "SearchWMSProjectConfig",
    "actionLabel": "WORKS_CREATE_PROJECT",
    "additionalSections": {}
  }

  export default searchConfig1;