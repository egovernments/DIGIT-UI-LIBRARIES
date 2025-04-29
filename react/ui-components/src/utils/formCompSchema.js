import React from "react";

let schema = {
  "type": "array",
  "items": {
    "type": "object",
    "required": ["body"],
    "properties": {
      "head": {
        "anyOf": [
          { "type": "string" },
          { "type": "number" }
        ]
      },
      "key": {
        "anyOf": [
          { "type": "string" },
          { "type": "number" }
        ]
      },
      "body": {
        "type": "array",
        "items": {
          "type": "object",
          "required": ["type", "populators"],
          "properties": {
            "type": {
              "type": "string",
              "enum": ["text", "date", "time", "geolocation", "numeric", "password", "search", "textarea", "radio", "toggle", "dropdown", "multiselectdropdown", "checkbox", "component"]
            },
            "label": {
              "anyOf": [
                { "type": "string" },
                { "type": "number" }
              ]
            },
            "inline": {
              "type": "boolean"
            },
            "key": {
              "anyOf": [
                { "type": "string" },
                { "type": "number" }
              ]
            },
            "isMandatory": {
              "type": "boolean"
            },
            "disable": {
              "type": "boolean"
            },
            "placeholder": {
              "type": "string"
            },
            "variant": {
              "type": "string"
            },
            "nonEditable": {
              "type": "boolean"
            },
            "description": {
              "anyOf": [
                { "type": "string" },
                { "type": "number" }
              ]
            },
            "infoMessage": {
              "type": "string"
            },
            "charCount": {
              "type": "boolean"
            },
            "withoutLabel": {
              "type": "boolean"
            },
            "component": {
              "type": "string",
              "isRegisteredComponent": true,
            },
            "populators": {
              "type": "object",
              "required": ["name"],
              "properties": {
                "name": {
                  "type": "string"
                },
                "title": {
                  "type": "string"
                },
                "error": {
                  "type": "string"
                },
                "optionsKey": {
                  "type": "string"
                },
                "customIcon": {
                  "type": "string"
                },
                "wrapLabel": {
                  "type": "boolean"
                },
                "isLabelFirst": {
                  "type": "boolean"
                },
                "showIcon": {
                  "type": "boolean"
                },
                "isSearchable": {
                  "type": "boolean"
                },
                "addCategorySelectAllCheck": {
                  "type": "boolean"
                },
                "isDropdownWithChip": {
                  "type": "boolean"
                },
                "addSelectAllCheck": {
                  "type": "boolean"
                },
                "resizeSmart": {
                  "type": "boolean"
                },
                "required": {
                  "type": "boolean"
                },
                "prefix": {
                  "anyOf": [
                    { "type": "string" },
                    { "type": "number" }
                  ]
                },
                "suffix": {
                  "anyOf": [
                    { "type": "string" },
                    { "type": "number" }
                  ]
                },
                "mdmsConfig": {
                  "type": "object",
                  "properties": {
                    "masterName": {
                      "type": "string"
                    },
                    "moduleName": {
                      "type": "string"
                    },
                    "localePrefix": {
                      "type": "string"
                    }
                  },
                },
                "validation": {
                  "type": "object",
                  "properties": {
                    "minlength": {
                      "type": "number"
                    },
                    "maxlength": {
                      "type": "number"
                    }
                  },
                  "required": []
                },
                "options": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "code": {
                        "anyOf": [
                          { "type": "string" },
                          { "type": "number" }
                        ]
                      },
                      "name": {
                        "anyOf": [
                          { "type": "string" },
                          { "type": "number" }
                        ]
                      },
                      "value": {
                        "anyOf": [
                          { "type": "string" },
                          { "type": "number" },
                          { "type": "boolean" },
                        ]
                      },
                      "options": {
                        "type": "array",
                        "items": {
                          "type": "object",
                          "properties": {
                            "code": {
                              "anyOf": [
                                { "type": "string" },
                                { "type": "number" }
                              ]
                            },
                            "name": {
                              "anyOf": [
                                { "type": "string" },
                                { "type": "number" }
                              ]
                            },
                            "options": {
                              "type": "array",
                              "items": {
                                "type": "object",
                                "properties": {
                                  "code": {
                                    "anyOf": [
                                      { "type": "string" },
                                      { "type": "number" }
                                    ]
                                  },
                                  "name": {
                                    "anyOf": [
                                      { "type": "string" },
                                      { "type": "number" }
                                    ]
                                  },
                                }
                              }
                            },
                          }
                        }
                      },
                      "profileIcon": {
                        "type": "string"
                      },
                      "description": {
                        "type": "string"
                      },
                      "icon": {
                        "type": "string"
                      }
                    },
                    "required": []
                  }
                }
              }
            }
          },
          "if": {
            "properties": {
              "type": { "const": "component" }
            }
          },
          "then": {
            "required": ["component"]
          }
        }
      }
    },
    "additionalProperties": true
  }
}

export default schema;