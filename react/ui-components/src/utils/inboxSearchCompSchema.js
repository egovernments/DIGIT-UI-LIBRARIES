import React from "react";
import schema from "./formCompSchema";

const fieldsSchema = schema.items.properties.body;

let ibschema = {
    "type": "object",
    "required": ["type", "apiDetails"],
    "properties": {
        "type": {
            "type": "string",
            "enum": ["inbox", "search", "download"]
        },
        "headerLabel": {
            "anyOf": [
                { "type": "string" },
                { "type": "number" }
            ]
        },
        "postProcessResult": {
            "type": "boolean"
        },
        "apiDetails": {
            "type": "object",
            "properties": {
                "serviceName": {
                    "type": "string"
                },
                "masterName": {
                    "type": "string"
                },
                "moduleName": {
                    "type": "string"
                },
                "tableFormJsonPath": {
                    "type": "string"
                },
                "filterFormJsonPath": {
                    "type": "string"
                },
                "searchFormJsonPath": {
                    "type": "string"
                },
                "minParametersForSearchForm": {
                    "type": "number"
                },
                "minParametersForFilterForm": {
                    "type": "number"
                },
                "requestBody": {
                    "type": "object",
                    "properties": {
                    },
                },
                "requestParam": {
                    "type": "object",
                    "properties": {
                        "limit": {
                            "type": "number"
                        },
                        "names": {
                            "type": "string"
                        },
                        "roles": {
                            "type": "string"
                        },
                        "offset": {
                            "type": "number"
                        },
                        "sortBy": {
                            "type": "string"
                        },
                        "tenantId": {
                            "type": "string"
                        },
                        "sortOrder": {
                            "type": "string"
                        }
                    },
                }
            },
            "required": []
        },
        "actions": {
            "type": "object",
            "properties": {
                "actionLabel": {
                    "anyOf": [
                        { "type": "string" },
                        { "type": "number" }
                    ]
                },
                "actionRoles": {
                    "type": "array",
                    "items": {
                        "type": "string"
                    }
                },
                "actionLink": {
                    "type": "string"
                }
            },
            "required": [],
        },
        "sections": {
            "type": "object",
            "properties": {
                "search": {
                    "type": "object",
                    "required": ["uiConfig"],
                    "properties": {
                        "label": {
                            "anyOf": [
                                { "type": "string" },
                                { "type": "number" }
                            ]
                        },
                        "show": {
                            "type": "boolean"
                        },
                        "uiConfig": {
                            "type": "object",
                            "properties": {
                                "formClassName": {
                                    "type": "string"
                                },
                                "primaryLabel": {
                                    "anyOf": [
                                        { "type": "string" },
                                        { "type": "number" }
                                    ]
                                },
                                "secondaryLabel": {
                                    "anyOf": [
                                        { "type": "string" },
                                        { "type": "number" }
                                    ]
                                },
                                "minReqFields": {
                                    "type": "number"
                                },
                                "fields": fieldsSchema,
                            }
                        }
                    },
                },
                "links": {
                    "type": "object",
                    "properties": {
                        "show": {
                            "type": "boolean"
                        },
                        "uiConfig": {
                            "type": "object",
                            "required": ["links"],
                            "properties": {
                                "label": {
                                    "anyOf": [
                                        { "type": "string" },
                                        { "type": "number" }
                                    ]
                                },
                                "logoIcon": {
                                    "type": "object",
                                    "properties": {
                                        "component": {
                                            "type": "string"
                                        },
                                        "customClass": {
                                            "type": "string"
                                        }
                                    }
                                },
                                "links": {
                                    "type": "array",
                                    "items": {
                                        "type": "object",
                                        "required": ["roles"],
                                        "properties": {
                                            "text": {
                                                "anyOf": [
                                                    { "type": "string" },
                                                    { "type": "number" }
                                                ]
                                            },
                                            "url": {
                                                "type": "string"
                                            },
                                            "roles": {
                                                "type": "array",
                                                "items": {
                                                    "type": "string"
                                                }
                                            },
                                            "hyperlink": {
                                                "type": "boolean"
                                            }
                                        },
                                    }
                                }
                            }
                        }
                    },
                    "required": ["uiConfig"],
                },
                "filter": {
                    "type": "object",
                    "properties": {
                        "show": {
                            "type": "boolean"
                        },
                        "uiConfig": {
                            "type": "object",
                            "properties": {
                                "label": {
                                    "anyOf": [
                                        { "type": "string" },
                                        { "type": "number" }
                                    ]
                                },
                                "type": {
                                    "type": "string",
                                    "enum": ["filter"]
                                },
                                "primaryLabel": {
                                    "anyOf": [
                                        { "type": "string" },
                                        { "type": "number" }
                                    ]
                                },
                                "secondaryLabel": {
                                    "anyOf": [
                                        { "type": "string" },
                                        { "type": "number" }
                                    ]
                                },
                                "minReqFields": {
                                    "type": "number"
                                },
                                "fields": fieldsSchema, 
                            }
                        }
                    },
                    "required": ["uiConfig"],
                },
                "sort": {
                    "type": "object",
                    "properties": {
                        "show": {
                            "type": "boolean"
                        }
                    }
                },
                "searchResult": {
                    "type": "object",
                    "properties": {
                        "show": {
                            "type": "boolean"
                        },
                        "uiConfig": {
                            "type": "object",
                            "properties": {
                                "columns": {
                                    "type": "array",
                                    "items": {
                                        "type": "object",
                                        "required": [],
                                        "properties": {
                                            "label": {
                                                "anyOf": [
                                                    { "type": "string" },
                                                    { "type": "number" }
                                                ]
                                            },
                                            "jsonPath": {
                                                "type": "string"
                                            },
                                            "disableSortBy": {
                                                "type": "boolean"
                                            },
                                            "link": {
                                                "type": "boolean"
                                            },
                                            "buttonProps": {
                                                "type": "object",
                                                "properties": {
                                                    "size": {
                                                        "type": "string"
                                                    },
                                                    "icon": {
                                                        "type": "string"
                                                    },
                                                    "linkTo": {
                                                        "type": "string"
                                                    },
                                                    "additionalCustomization": {
                                                        "type": "boolean"
                                                    }
                                                }
                                            }

                                        },
                                    }
                                },
                                "selectionProps": {
                                    "type": "object",
                                    "properties": {
                                        "showCheckBox": {
                                            "type": "boolean"
                                        },
                                        "showSelectedState": {
                                            "type": "boolean"
                                        },
                                        "selectableRowsNoSelectAll": {
                                            "type": "boolean"
                                        },
                                        "showSelectedStatePosition": {
                                            "type": "string"
                                        }
                                    },
                                },
                                "tableProps": {
                                    "type": "object",
                                    "properties": {
                                        "showTableDescription":{
                                            "anyOf": [
                                                { "type": "string" },
                                                { "type": "number" }
                                            ]
                                        },
                                        "showTableTitle": {
                                            "anyOf": [
                                                { "type": "string" },
                                                { "type": "number" }
                                            ]
                                        },
                                        "tableClassName": {
                                            "anyOf": [
                                                { "type": "string" },
                                                { "type": "number" }
                                            ]
                                        },
                                    },
                                },
                                "actionProps": {
                                    "type": "object",
                                    "properties": {
                                        "actions": {
                                            "type": "array",
                                            "items": {
                                                "type": "object",
                                                "properties": {
                                                    "label": {
                                                        "type": "string"
                                                    },
                                                    "variation": {
                                                        "type": "string"
                                                    },
                                                    "icon": {
                                                        "type": "string"
                                                    }
                                                },
                                            }
                                        }
                                    },
                                },
                                "enableGlobalSearch": {
                                    "type": "boolean"
                                },
                                "enableColumnSort": {
                                    "type": "boolean"
                                },
                                "defaultSortAsc": {
                                    "type": "boolean"
                                },
                                "resultsJsonPath": {
                                    "type": "string"
                                },
                                "isPaginationRequired": {
                                    "type": "boolean"
                                },
                            },
                            "required": ["resultsJsonPath"]
                        }
                    },
                    "required": ["uiConfig"]
                },
            },
            "required": ["searchResult"],
        },
        "footerProps": {
            "type": "object",
            "properties": {
                "showFooter": {
                    "type": "boolean"
                },
                "allowedRolesForFooter": {
                    "type": "array",
                    "items": {
                        "type": "string"
                    }
                },
                "actionFields": {
                    "type": "array",
                    "items": {
                        "type": "object",
                        "properties": {
                            "label": {
                                "type": "string"
                            },
                            "icon": {
                                "type": "string"
                            },
                            "isSuffix": {
                                "type": "boolean"
                            },
                            "variation": {
                                "type": "string"
                            },
                            "allowedRoles": {
                                "type": "array",
                                "items": {
                                    "type": "string"
                                }
                            }
                        },
                    }
                },
                "setactionFieldsToLeft": {
                    "type": "boolean"
                },
                "setactionFieldsToRight": {
                    "type": "boolean"
                },
                "maxActionFieldsAllowed": {
                    "type": "number"
                },
                "sortActionFields": {
                    "type": "boolean"
                },
                "className": {
                    "type": "string"
                },
            },
            "required": [],
        },
    },
    "additionalProperties": true
}


export default ibschema;