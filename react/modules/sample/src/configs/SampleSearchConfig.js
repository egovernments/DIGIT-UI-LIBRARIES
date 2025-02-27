import React from "react";

const ExpandedComponent = ({ data }) => (
  <pre>{JSON.stringify(data, null, 2)}</pre>
);

export const Config = {
    label: "WBH_SEARCH_MDMS",
    type: "search",
    actionLabel: "WBH_ADD_MDMS",
    actionRoles: ["MDMS_ADMIN","CAMPAIGN_ADMIN","SUPERUSER"],
    actionLink: "workbench/mdms-add-v2",
    apiDetails: {
      serviceName: `/egov-mdms-service/v2/_search`,
      requestParam: {},
      requestBody: {
        MdmsCriteria: {
          
        },
      },
      minParametersForSearchForm: 0,
      masterName: "commonUiConfig",
      moduleName: "SearchMDMSConfig",
      tableFormJsonPath: "requestBody.MdmsCriteria",
      filterFormJsonPath: "requestBody.MdmsCriteria.custom",
      searchFormJsonPath: "requestBody.MdmsCriteria.custom"
    },
    sections: {
      search: {
        uiConfig: {
          headerStyle: null,
          formClassName: "",
          primaryLabel: "ES_COMMON_SEARCH",
          secondaryLabel: "ES_COMMON_CLEAR_SEARCH",
          minReqFields: 0,
          defaultValues: {
            value: "",
            field: "",
            isActive:{
              code: "WBH_COMMON_ALL",
              value: "all",
            }
          },
          fields: [
            {
              label: "Field",
              type: "dropdown",
              isMandatory: false,
              disable: false,
              populators: {
                name: "field",
                optionsKey: "name",
                optionsCustomStyle: { top: "2.3rem" },
                options: [
                  {
                    code: "code",
                    name: "code",
                  },
                  {
                    code: "name",
                    name: "name",
                  },
                  {
                    code: "description",
                    name: "description",
                  },
                ],
              },
            },
            {
              label: "Value",
              type: "text",
              isMandatory: false,
              disable: false,
              populators: {
                name: "value",
                validation: { pattern: {}, maxlength: 140 },
              },
            },
            {
              label: "IsActive",
              type: "dropdown",
              isMandatory: false,
              disable: false,
              populators: {
                name: "isActive",
                optionsKey: "code",
                optionsCustomStyle: { top: "2.3rem" },
                options: [
                  {
                    code: "WBH_COMMON_YES",
                    value: true,
                  },
                  {
                    code: "WBH_COMMON_NO",
                    value: false,
                  },
                  {
                    code: "WBH_COMMON_ALL",
                    value: "all",
                  }
                ],
              },
            }
          ],
        },
        label: "",
        children: {},
        show: true,
      },
      searchResult: {
        label: "",
        uiConfig: {
          columns: [
            {
              label: "Unique Identifier",
              jsonPath: "uniqueIdentifier",
              // additionalCustomization:true
            },
            {
              label: "Id",
              jsonPath: "id",
              // additionalCustomization:true
            },
            {
              label: "tenantId",
              jsonPath: "tenantId",
            },
            {
              label: "Active",
              jsonPath: "isActive",
              additionalCustomization:true
            }
          ],
          enableGlobalSearch: true,
          enableColumnSort: true,
          resultsJsonPath: "mdms",
          rowClassName:"table-row-mdms table-row-mdms-hover",
          showTableDescription: "This is the search table description",
          showTableTitle: "Search table title",
          addFilter: true,
          showCheckBox: true,
          showSelectedState: true,
          actionButtonLabel: "Customized ActionButton",
          expandableRows: true,
          defaultSortAsc: true,
          expandableRowsComponent: ExpandedComponent,
          selectableRowsNoSelectAll: false,
          actions: [
            {
              label: "Action1",
              variation: "secondary",
              icon: "Edit",
            },
            {
              label: "Action2",
              variation: "primary",
              icon: "CheckCircle",
            },
          ],
        },
        children: {},
        show: true,
      },
    },
    additionalSections: {},
  };
  