export const FormComposerConfig=[
    // {
    //     "form": [
    //         {
    //             "body": [
    //                 {
    //                     "key": "basicDetails_projectID",
    //                     "type": "text",
    //                     "label": "WORKS_PROJECT_ID",
    //                     "inline": true,
    //                     "disable": true,
    //                     "populators": {
    //                         "name": "basicDetails_projectID",
    //                         "customClass": "field-value-no-border",
    //                         "customStyle": {
    //                             "display": "none"
    //                         }
    //                     },
    //                     "preProcess": {
    //                         "updateDependent": [
    //                             "populators.customStyle.display"
    //                         ]
    //                     },
    //                     "isMandatory": false
    //                 },
    //                 {
    //                     "key": "basicDetails_dateOfProposal",
    //                     "type": "date",
    //                     "label": "ES_COMMON_PROPOSAL_DATE",
    //                     "inline": true,
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "basicDetails_dateOfProposal",
    //                         "validation": {
    //                             "max": "currentDate"
    //                         }
    //                     },
    //                     "preProcess": {
    //                         "updateDependent": [
    //                             "populators.validation.max"
    //                         ]
    //                     },
    //                     "isMandatory": false
    //                 },
    //                 {
    //                     "key": "basicDetails_projectName",
    //                     "type": "text",
    //                     "label": "ES_COMMON_PROJECT_NAME",
    //                     "inline": true,
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "basicDetails_projectName",
    //                         "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_NAME",
    //                         "validation": {
    //                             "pattern": "^[a-zA-Z0-9\\/{ \\/ .\\- _$@#\\' } ]*$",
    //                             "maxlength": 128,
    //                             "minlength": 2
    //                         }
    //                     },
    //                     "preProcess": {
    //                         "convertStringToRegEx": [
    //                             "populators.validation.pattern"
    //                         ]
    //                     },
    //                     "isMandatory": true
    //                 },
    //                 {
    //                     "key": "basicDetails_projectDesc",
    //                     "type": "textarea",
    //                     "label": "PROJECT_PROJECT_DESC",
    //                     "inline": true,
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "basicDetails_projectDesc",
    //                         "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_DESC",
    //                         "validation": {
    //                             "pattern": "^[a-zA-Z0-9\\/{ \\/ .\\- ,:_$@#\\'() } ]*$",
    //                             "maxlength": 256,
    //                             "minlength": 2
    //                         }
    //                     },
    //                     "preProcess": {
    //                         "convertStringToRegEx": [
    //                             "populators.validation.pattern"
    //                         ]
    //                     },
    //                     "isMandatory": true
    //                 }
    //             ],
    //             "head": "",
    //             "subHead": ""
    //         },
    //         {
    //             "body": [
    //                 {
    //                     "key": "noSubProject_letterRefNoOrReqNo",
    //                     "type": "text",
    //                     "label": "WORKS_LOR",
    //                     "inline": true,
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "noSubProject_letterRefNoOrReqNo",
    //                         "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_LOR",
    //                         "validation": {
    //                             "pattern": "^[a-zA-Z0-9\\/{ \\/ .\\- _$@#\\' } ]*$",
    //                             "maxlength": 32,
    //                             "minlength": 2
    //                         }
    //                     },
    //                     "preProcess": {
    //                         "convertStringToRegEx": [
    //                             "populators.validation.pattern"
    //                         ]
    //                     },
    //                     "isMandatory": false
    //                 },
    //                 {
    //                     "key": "noSubProject_typeOfProject",
    //                     "type": "radioordropdown",
    //                     "label": "WORKS_PROJECT_TYPE",
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "noSubProject_typeOfProject",
    //                         "error": "WORKS_REQUIRED_ERR",
    //                         "required": true,
    //                         "mdmsConfig": {
    //                             "masterName": "ProjectType",
    //                             "moduleName": "works",
    //                             "localePrefix": "COMMON_MASTERS"
    //                         },
    //                         "optionsKey": "name"
    //                     },
    //                     "isMandatory": true
    //                 },
    //                 {
    //                     "key": "noSubProject_targetDemography",
    //                     "type": "radioordropdown",
    //                     "label": "PROJECT_TARGET_DEMOGRAPHY",
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "noSubProject_targetDemography",
    //                         "error": "WORKS_REQUIRED_ERR",
    //                         "required": false,
    //                         "mdmsConfig": {
    //                             "masterName": "TargetDemography",
    //                             "moduleName": "works",
    //                             "localePrefix": "COMMON_MASTERS"
    //                         },
    //                         "optionsKey": "name"
    //                     },
    //                     "isMandatory": false
    //                 },
    //                 {
    //                     "key": "noSubProject_estimatedCostInRs",
    //                     "type": "amount",
    //                     "label": "PROJECT_ESTIMATED_COST_IN_RS",
    //                     "inline": true,
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "noSubProject_estimatedCostInRs",
    //                         "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_ESTIMATED_COST",
    //                         "validation": {
    //                             "max": 5000000,
    //                             "min": 0,
    //                             "step": "0.01",
    //                             "pattern": "^[1-9]\\d*(\\.\\d+)?$",
    //                             "maxlength": 16
    //                         }
    //                     },
    //                     "preProcess": {
    //                         "convertStringToRegEx": [
    //                             "populators.validation.pattern"
    //                         ]
    //                     },
    //                     "isMandatory": false
    //                 }
    //             ],
    //             "head": "WORKS_PROJECT_DETAILS",
    //             "navLink": "Project_Details"
    //         },
    //         {
    //             "body": [
    //                 {
    //                     "key": "noSubProject_geoLocation",
    //                     "type": "text",
    //                     "label": "WORKS_GEO_LOCATION",
    //                     "inline": true,
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "noSubProject_geoLocation",
    //                         "error": "COMMON_ENTER_VALID_GEO_LOCATION",
    //                         "validation": {
    //                             "pattern": "^[-+]?([1-8]?\\d(\\.\\d+)?|90(\\.0+)?)\\s*,\\s*[-+]?(180(\\.0+)?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d+)?)$"
    //                         }
    //                     },
    //                     "preProcess": {
    //                         "convertStringToRegEx": [
    //                             "populators.validation.pattern"
    //                         ]
    //                     },
    //                     "isMandatory": true
    //                 },
    //                 {
    //                     "key": "noSubProject_ulb",
    //                     "type": "radioordropdown",
    //                     "label": "ES_COMMON_ULB",
    //                     "disable": true,
    //                     "populators": {
    //                         "name": "noSubProject_ulb",
    //                         "error": "WORKS_REQUIRED_ERR",
    //                         "options": [],
    //                         "required": true,
    //                         "optionsKey": "i18nKey"
    //                     },
    //                     "preProcess": {
    //                         "updateDependent": [
    //                             "populators.options"
    //                         ]
    //                     },
    //                     "isMandatory": false
    //                 },
    //                 {
    //                     "key": "noSubProject_ward",
    //                     "type": "radioordropdown",
    //                     "label": "PDF_STATIC_LABEL_ESTIMATE_WARD",
    //                     "disable": false,
    //                     "populators": {
    //                         "name": "noSubProject_ward",
    //                         "error": "WORKS_REQUIRED_ERR",
    //                         "options": [],
    //                         "required": false,
    //                         "optionsKey": "i18nKey"
    //                     },
    //                     "preProcess": {
    //                         "updateDependent": [
    //                             "populators.options"
    //                         ]
    //                     },
    //                     "isMandatory": true
    //                 },
    //                 {
    //                     "type": "apidropdown",
    //                     "label": "WORKS_LOCALITY",
    //                     "disable": false,
    //                     "populators": {
    //                         "url": "/boundary-service/boundary-relationships/_search",
    //                         "name": "noSubProject_locality",
    //                         "error": "WORKS_REQUIRED_ERR",
    //                         "params": {
    //                             "boundaryType": "Locality",
    //                             "hierarchyTypeCode": "ADMIN"
    //                         },
    //                         "required": true,
    //                         "selectFun": "return data?.TenantBoundary[0]?.boundary?.sort((a, b) => a.code.localeCompare(b.code)).map(item => ({ code: item.code, name: t(`${headerLocale}_ADMIN_${item?.code}`), i18nKey: `${headerLocale}_ADMIN_${item?.code}` }))",
    //                         "optionsKey": "i18nKey",
    //                         "allowMultiSelect": false
    //                     },
    //                     "isMandatory": true
    //                 }
    //             ],
    //             "head": "ES_COMMON_LOCATION_DETAILS",
    //             "navLink": "Project_Details"
    //         },
    //         {
    //             "body": [
    //                 {
    //                     "name": "noSubProject_docs",
    //                     "type": "documentUpload",
    //                     "error": "WORKS_REQUIRED_ERR",
    //                     "module": "Project",
    //                     "customClass": "",
    //                     "localePrefix": "PROJECT",
    //                     "withoutLabel": true
    //                 }
    //             ],
    //             "head": "",
    //             "navLink": "Project_Details"
    //         }
    //     ],
    //     "metaData": {
    //         "showNavs": false,
    //         "currentFormCategory": false
    //     },
    //     "screenName": "CreateProjectConfig",
    //     "defaultValues": {}
    // }

    {
        "body": [
            {
                "key": "basicDetails_projectID",
                "type": "text",
                "label": "WORKS_PROJECT_ID",
                "inline": true,
                "disable": true,
                "populators": {
                    "name": "basicDetails_projectID",
                    "customClass": "field-value-no-border",
                    "customStyle": {
                        "display": "none"
                    }
                },
                "preProcess": {
                    "updateDependent": [
                        "populators.customStyle.display"
                    ]
                },
                "isMandatory": false
            },
            {
                "key": "basicDetails_dateOfProposal",
                "type": "date",
                "label": "ES_COMMON_PROPOSAL_DATE",
                "inline": true,
                "disable": false,
                "populators": {
                    "name": "basicDetails_dateOfProposal",
                    "validation": {
                        "max": "currentDate"
                    }
                },
                "preProcess": {
                    "updateDependent": [
                        "populators.validation.max"
                    ]
                },
                "isMandatory": false
            },
            {
                "key": "basicDetails_projectName",
                "type": "text",
                "label": "ES_COMMON_PROJECT_NAME",
                "inline": true,
                "disable": false,
                "populators": {
                    "name": "basicDetails_projectName",
                    "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_NAME",
                    "validation": {
                        "pattern": "^[a-zA-Z0-9\\/{ \\/ .\\- _$@#\\' } ]*$",
                        "maxlength": 128,
                        "minlength": 2
                    }
                },
                "preProcess": {
                    "convertStringToRegEx": [
                        "populators.validation.pattern"
                    ]
                },
                "isMandatory": true
            },
            {
                "key": "basicDetails_projectDesc",
                "type": "textarea",
                "label": "PROJECT_PROJECT_DESC",
                "inline": true,
                "disable": false,
                "populators": {
                    "name": "basicDetails_projectDesc",
                    "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_DESC",
                    "validation": {
                        "pattern": "^[a-zA-Z0-9\\/{ \\/ .\\- ,:_$@#\\'() } ]*$",
                        "maxlength": 256,
                        "minlength": 2
                    }
                },
                "preProcess": {
                    "convertStringToRegEx": [
                        "populators.validation.pattern"
                    ]
                },
                "isMandatory": true
            },
            {
                "key": "basicDetails_projectDesc",
                "type": "textarea",
                "label": "PROJECT_PROJECT_DESC",
                "inline": true,
                "disable": false,
                "populators": {
                    "name": "basicDetails_projectDesc",
                    "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_DESC",
                    "validation": {
                        "pattern": "^[a-zA-Z0-9\\/{ \\/ .\\- ,:_$@#\\'() } ]*$",
                        "maxlength": 256,
                        "minlength": 2
                    }
                },
                "preProcess": {
                    "convertStringToRegEx": [
                        "populators.validation.pattern"
                    ]
                },
                "isMandatory": true
            }
        ],
        "head": "",
        "subHead": ""
    },
    {
        "body": [
            {
                "key": "noSubProject_letterRefNoOrReqNo",
                "type": "text",
                "label": "WORKS_LOR",
                "inline": true,
                "disable": false,
                "populators": {
                    "name": "noSubProject_letterRefNoOrReqNo",
                    "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_LOR",
                    "validation": {
                        "pattern": "^[a-zA-Z0-9\\/{ \\/ .\\- _$@#\\' } ]*$",
                        "maxlength": 32,
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
                "key": "noSubProject_typeOfProject",
                "type": "radioordropdown",
                "label": "WORKS_PROJECT_TYPE",
                "disable": false,
                "populators": {
                    "name": "noSubProject_typeOfProject",
                    "error": "WORKS_REQUIRED_ERR",
                    "required": true,
                    "mdmsConfig": {
                        "masterName": "ProjectType",
                        "moduleName": "works",
                        "localePrefix": "COMMON_MASTERS"
                    },
                    "optionsKey": "name"
                },
                "isMandatory": true
            },
            {
                "key": "noSubProject_targetDemography",
                "type": "radioordropdown",
                "label": "PROJECT_TARGET_DEMOGRAPHY",
                "disable": false,
                "populators": {
                    "name": "noSubProject_targetDemography",
                    "error": "WORKS_REQUIRED_ERR",
                    "required": false,
                    "mdmsConfig": {
                        "masterName": "TargetDemography",
                        "moduleName": "works",
                        "localePrefix": "COMMON_MASTERS"
                    },
                    "optionsKey": "name"
                },
                "isMandatory": false
            },
            {
                "key": "noSubProject_estimatedCostInRs",
                "type": "amount",
                "label": "PROJECT_ESTIMATED_COST_IN_RS",
                "inline": true,
                "disable": false,
                "populators": {
                    "name": "noSubProject_estimatedCostInRs",
                    "error": "PROJECT_PATTERN_ERR_MSG_PROJECT_ESTIMATED_COST",
                    "validation": {
                        "max": 5000000,
                        "min": 0,
                        "step": "0.01",
                        "pattern": "^[1-9]\\d*(\\.\\d+)?$",
                        "maxlength": 16
                    }
                },
                "preProcess": {
                    "convertStringToRegEx": [
                        "populators.validation.pattern"
                    ]
                },
                "isMandatory": false
            }
        ],
        "head": "WORKS_PROJECT_DETAILS",
        "navLink": "Project_Details"
    },
    {
        "body": [
            {
                "key": "noSubProject_geoLocation",
                "type": "text",
                "label": "WORKS_GEO_LOCATION",
                "inline": true,
                "disable": false,
                "populators": {
                    "name": "noSubProject_geoLocation",
                    "error": "COMMON_ENTER_VALID_GEO_LOCATION",
                    "validation": {
                        "pattern": "^[-+]?([1-8]?\\d(\\.\\d+)?|90(\\.0+)?)\\s*,\\s*[-+]?(180(\\.0+)?|((1[0-7]\\d)|([1-9]?\\d))(\\.\\d+)?)$"
                    }
                },
                "preProcess": {
                    "convertStringToRegEx": [
                        "populators.validation.pattern"
                    ]
                },
                "isMandatory": true
            },
            {
                "key": "noSubProject_ulb",
                "type": "radioordropdown",
                "label": "ES_COMMON_ULB",
                "disable": true,
                "populators": {
                    "name": "noSubProject_ulb",
                    "error": "WORKS_REQUIRED_ERR",
                    "options": [],
                    "required": true,
                    "optionsKey": "i18nKey"
                },
                "preProcess": {
                    "updateDependent": [
                        "populators.options"
                    ]
                },
                "isMandatory": false
            },
            {
                "key": "noSubProject_ward",
                "type": "radioordropdown",
                "label": "PDF_STATIC_LABEL_ESTIMATE_WARD",
                "disable": false,
                "populators": {
                    "name": "noSubProject_ward",
                    "error": "WORKS_REQUIRED_ERR",
                    "options": [],
                    "required": false,
                    "optionsKey": "i18nKey"
                },
                "preProcess": {
                    "updateDependent": [
                        "populators.options"
                    ]
                },
                "isMandatory": true
            },
            {
                "type": "apidropdown",
                "label": "WORKS_LOCALITY",
                "disable": false,
                "populators": {
                    "url": "/boundary-service/boundary-relationships/_search",
                    "name": "noSubProject_locality",
                    "error": "WORKS_REQUIRED_ERR",
                    "params": {
                        "boundaryType": "Locality",
                        "hierarchyTypeCode": "ADMIN"
                    },
                    "required": true,
                    "selectFun": "return data?.TenantBoundary[0]?.boundary?.sort((a, b) => a.code.localeCompare(b.code)).map(item => ({ code: item.code, name: t(`${headerLocale}_ADMIN_${item?.code}`), i18nKey: `${headerLocale}_ADMIN_${item?.code}` }))",
                    "optionsKey": "i18nKey",
                    "allowMultiSelect": false
                },
                "isMandatory": true
            }
        ],
        "head": "ES_COMMON_LOCATION_DETAILS",
        "navLink": "Project_Details"
    },
    {
        "body": [
            {
                "name": "noSubProject_docs",
                "type": "documentUpload",
                "error": "WORKS_REQUIRED_ERR",
                "module": "Project",
                "customClass": "",
                "localePrefix": "PROJECT",
                "withoutLabel": true
            }
        ],
        "head": "",
        "navLink": "Project_Details"
    }
]
  