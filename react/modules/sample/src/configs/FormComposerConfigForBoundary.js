export const FormComposerForBoundaryConfig=[
   
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
            // Boundary Component
            {
                "key": "boundaryComponnet",
                "type": "boundary",
                "inline": true,
                "label": "BoundaryFIlter",
                "disable": false,
                "populators": {
                    "name":"boundaryComponnet",
                    "levelConfig": {lowestLevel:"LOCALITY", highestLevel:"PROVINCE", isSingleSelect:[]} ,
                    "hierarchyType":"NEWTEST00222" ,
                    "noCardStyle":true,
                    "preSelected":["NEWTEST00222_MO","NEWTEST00222_MO_11_MARYLAND","NEWTEST00222_MO_11_06_PLEEBO"],
                    
                    // "frozenData":
                    // [{
                    //     code: "NEWTEST00222_MO",
                    //     name: "NEWTEST00222_MO"
                    //   },
                    //   {
                    //     code: "NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND",
                    //     name: "NEWTEST00222_MO_11_MARYLAND"
                    //   },
                    //   {
                    //     code: "NEWTEST00222_MO.NEWTEST00222_MO_11_MARYLAND.NEWTEST00222_MO_11_06_PLEEBO",
                    //     name: "NEWTEST00222_MO_11_06_PLEEBO"
                    //   }]
                },
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
                "label": "ESS_COMMON_PROJECT_NAME",
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
            
        ],
        "head": "",
        "subHead": ""
    }
   
]
  