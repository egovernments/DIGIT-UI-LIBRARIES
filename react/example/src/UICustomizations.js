import React, { useState, Fragment } from "react";
import { Link } from "react-router-dom";
import _ from "lodash";
import { Amount,Button,Tag} from "@egovernments/digit-ui-components";


//create functions here based on module name set in mdms(eg->SearchProjectConfig)
//how to call these -> Digit?.Customizations?.[masterName]?.[moduleName]
// these functions will act as middlewares
var Digit = window.Digit || {};

function cleanObject(obj) {
  for (const key in obj) {
    if (Object.hasOwn(obj, key)) {
      if (Array.isArray(obj[key])) {
        if (obj[key].length === 0) {
          delete obj[key];
        }
      } else if (
        obj[key] === undefined ||
        obj[key] === null ||
        obj[key] === false ||
        obj[key] === "" || // Check for empty string
        (typeof obj[key] === "object" && Object.keys(obj[key]).length === 0)
      ) {
        delete obj[key];
      }
    }
  }
  return obj;
}

const businessServiceMap = {
  "muster roll": "MR",
};

const inboxModuleNameMap = {
  "muster-roll-approval": "muster-roll-service",
};

export const UICustomizations = {
  businessServiceMap,
  updatePayload: (applicationDetails, data, action, businessService) => {
    if (businessService === businessServiceMap.estimate) {
      const workflow = {
        comment: data.comments,
        documents: data?.documents?.map((document) => {
          return {
            documentType: action?.action + " DOC",
            fileName: document?.[1]?.file?.name,
            fileStoreId: document?.[1]?.fileStoreId?.fileStoreId,
            documentUid: document?.[1]?.fileStoreId?.fileStoreId,
            tenantId: document?.[1]?.fileStoreId?.tenantId,
          };
        }),
        assignees: data?.assignees?.uuid ? [data?.assignees?.uuid] : null,
        action: action.action,
      };
      //filtering out the data
      Object.keys(workflow).forEach((key, index) => {
        if (!workflow[key] || workflow[key]?.length === 0) delete workflow[key];
      });

      return {
        estimate: applicationDetails,
        workflow,
      };
    }
    if (businessService === businessServiceMap.contract) {
      const workflow = {
        comment: data?.comments,
        documents: data?.documents?.map((document) => {
          return {
            documentType: action?.action + " DOC",
            fileName: document?.[1]?.file?.name,
            fileStoreId: document?.[1]?.fileStoreId?.fileStoreId,
            documentUid: document?.[1]?.fileStoreId?.fileStoreId,
            tenantId: document?.[1]?.fileStoreId?.tenantId,
          };
        }),
        assignees: data?.assignees?.uuid ? [data?.assignees?.uuid] : null,
        action: action.action,
      };
      //filtering out the data
      Object.keys(workflow).forEach((key, index) => {
        if (!workflow[key] || workflow[key]?.length === 0) delete workflow[key];
      });

      return {
        contract: applicationDetails,
        workflow,
      };
    }
    if (businessService === businessServiceMap?.["muster roll"]) {
      const workflow = {
        comment: data?.comments,
        documents: data?.documents?.map((document) => {
          return {
            documentType: action?.action + " DOC",
            fileName: document?.[1]?.file?.name,
            fileStoreId: document?.[1]?.fileStoreId?.fileStoreId,
            documentUid: document?.[1]?.fileStoreId?.fileStoreId,
            tenantId: document?.[1]?.fileStoreId?.tenantId,
          };
        }),
        assignees: data?.assignees?.uuid ? [data?.assignees?.uuid] : null,
        action: action.action,
      };
      //filtering out the data
      Object.keys(workflow).forEach((key, index) => {
        if (!workflow[key] || workflow[key]?.length === 0) delete workflow[key];
      });

      return {
        musterRoll: applicationDetails,
        workflow,
      };
    }
    if (businessService === businessServiceMap?.["works.purchase"]) {
      const workflow = {
        comment: data.comments,
        documents: data?.documents?.map((document) => {
          return {
            documentType: action?.action + " DOC",
            fileName: document?.[1]?.file?.name,
            fileStoreId: document?.[1]?.fileStoreId?.fileStoreId,
            documentUid: document?.[1]?.fileStoreId?.fileStoreId,
            tenantId: document?.[1]?.fileStoreId?.tenantId,
          };
        }),
        assignees: data?.assignees?.uuid ? [data?.assignees?.uuid] : null,
        action: action.action,
      };
      //filtering out the data
      Object.keys(workflow).forEach((key, index) => {
        if (!workflow[key] || workflow[key]?.length === 0) delete workflow[key];
      });

      const additionalFieldsToSet = {
        projectId: applicationDetails.additionalDetails.projectId,
        invoiceDate: applicationDetails.billDate,
        invoiceNumber: applicationDetails.referenceId.split("_")?.[1],
        contractNumber: applicationDetails.referenceId.split("_")?.[0],
        documents: applicationDetails.additionalDetails.documents,
      };
      return {
        bill: { ...applicationDetails, ...additionalFieldsToSet },
        workflow,
      };
    }
  },
  enableModalSubmit: (businessService, action, setModalSubmit, data) => {
    if (
      businessService === businessServiceMap?.["muster roll"] &&
      action.action === "APPROVE"
    ) {
      setModalSubmit(data?.acceptTerms);
    }
  },
  enableHrmsSearch: (businessService, action) => {
    if (businessService === businessServiceMap.estimate) {
      return (
        action.action.includes("TECHNICALSANCTION") ||
        action.action.includes("VERIFYANDFORWARD")
      );
    }
    if (businessService === businessServiceMap.contract) {
      return action.action.includes("VERIFY_AND_FORWARD");
    }
    if (businessService === businessServiceMap?.["muster roll"]) {
      return action.action.includes("VERIFY");
    }
    if (businessService === businessServiceMap?.["works.purchase"]) {
      return action.action.includes("VERIFY_AND_FORWARD");
    }
    return false;
  },
  getBusinessService: (moduleCode) => {
    if (moduleCode?.includes("estimate")) {
      return businessServiceMap?.estimate;
    } else if (moduleCode?.includes("contract")) {
      return businessServiceMap?.contract;
    } else if (moduleCode?.includes("muster roll")) {
      return businessServiceMap?.["muster roll"];
    } else if (moduleCode?.includes("works.purchase")) {
      return businessServiceMap?.["works.purchase"];
    } else if (moduleCode?.includes("works.wages")) {
      return businessServiceMap?.["works.wages"];
    } else if (moduleCode?.includes("works.supervision")) {
      return businessServiceMap?.["works.supervision"];
    } else {
      return businessServiceMap;
    }
  },
  getInboxModuleName: (moduleCode) => {
    if (moduleCode?.includes("estimate")) {
      return inboxModuleNameMap?.estimate;
    } else if (moduleCode?.includes("contract")) {
      return inboxModuleNameMap?.contracts;
    } else if (moduleCode?.includes("attendence")) {
      return inboxModuleNameMap?.attendencemgmt;
    } else {
      return inboxModuleNameMap;
    }
  },

  AttendanceInboxConfig: {
    preProcess: (data) => {
      //set tenantId
      data.body.inbox.tenantId = Digit.ULBService.getCurrentTenantId();
      data.body.inbox.processSearchCriteria.tenantId = Digit.ULBService.getCurrentTenantId();

      const musterRollNumber = data?.body?.inbox?.moduleSearchCriteria?.musterRollNumber?.trim();
      if (musterRollNumber)
        data.body.inbox.moduleSearchCriteria.musterRollNumber = musterRollNumber;

      const attendanceRegisterName = data?.body?.inbox?.moduleSearchCriteria?.attendanceRegisterName?.trim();
      if (attendanceRegisterName)
        data.body.inbox.moduleSearchCriteria.attendanceRegisterName = attendanceRegisterName;

      // deleting them for now(assignee-> need clarity from pintu,ward-> static for now,not implemented BE side)
      const assignee = _.clone(data.body.inbox.moduleSearchCriteria.assignee);
      delete data.body.inbox.moduleSearchCriteria.assignee;
      if (assignee?.code === "ASSIGNED_TO_ME") {
        data.body.inbox.moduleSearchCriteria.assignee = Digit.UserService.getUser().info.uuid;
      }

      //cloning locality and workflow states to format them
      // let locality = _.clone(data.body.inbox.moduleSearchCriteria.locality ? data.body.inbox.moduleSearchCriteria.locality : []);

      let selectedOrg = _.clone(
        data.body.inbox.moduleSearchCriteria.orgId
          ? data.body.inbox.moduleSearchCriteria.orgId
          : null
      );
      delete data.body.inbox.moduleSearchCriteria.orgId;
      if (selectedOrg) {
        data.body.inbox.moduleSearchCriteria.orgId =
          selectedOrg?.[0]?.applicationNumber;
      }

      // let selectedWard =  _.clone(data.body.inbox.moduleSearchCriteria.ward ? data.body.inbox.moduleSearchCriteria.ward : null);
      // delete data.body.inbox.moduleSearchCriteria.ward;
      // if(selectedWard) {
      //    data.body.inbox.moduleSearchCriteria.ward = selectedWard?.[0]?.code;
      // }

      let states = _.clone(
        data.body.inbox.moduleSearchCriteria.state
          ? data.body.inbox.moduleSearchCriteria.state
          : []
      );
      let ward = _.clone(
        data.body.inbox.moduleSearchCriteria.ward
          ? data.body.inbox.moduleSearchCriteria.ward
          : []
      );
      // delete data.body.inbox.moduleSearchCriteria.locality;
      delete data.body.inbox.moduleSearchCriteria.state;
      delete data.body.inbox.moduleSearchCriteria.ward;

      // locality = locality?.map((row) => row?.code);
      states = Object.keys(states)?.filter((key) => states[key]);
      ward = ward?.map((row) => row?.code);

      // //adding formatted data to these keys
      // if (locality.length > 0) data.body.inbox.moduleSearchCriteria.locality = locality;
      if (states.length > 0)
        data.body.inbox.moduleSearchCriteria.status = states;
      if (ward.length > 0) data.body.inbox.moduleSearchCriteria.ward = ward;
      const projectType = _.clone(
        data.body.inbox.moduleSearchCriteria.projectType
          ? data.body.inbox.moduleSearchCriteria.projectType
          : {}
      );
      if (projectType?.code)
        data.body.inbox.moduleSearchCriteria.projectType = projectType.code;

      //adding tenantId to moduleSearchCriteria
      data.body.inbox.moduleSearchCriteria.tenantId = Digit.ULBService.getCurrentTenantId();

      //setting limit and offset becoz somehow they are not getting set in muster inbox
      data.body.inbox.limit = data.state.tableForm.limit;
      data.body.inbox.offset = data.state.tableForm.offset;
      delete data.state;
      return data;
    },
    postProcess: (responseArray, uiConfig) => {
      const statusOptions = responseArray?.statusMap
        ?.filter((item) => item.applicationstatus)
        ?.map((item) => ({
          code: item.applicationstatus,
          i18nKey: `COMMON_MASTERS_${item.applicationstatus}`,
        }));
      if (uiConfig?.type === "filter") {
        let fieldConfig = uiConfig?.fields?.filter(
          (item) =>
            item.type === "dropdown" &&
            item.populators.name === "musterRollStatus"
        );
        if (fieldConfig.length) {
          fieldConfig[0].populators.options = statusOptions;
        }
      }
    },
    additionalCustomizations: (row, key, column, value, t, searchResult) => {
      if (key === "ATM_MUSTER_ROLL_ID") {
        return (
          <span className="link">
            <Link
              to={`/${
                window.contextPath
              }/employee/attendencemgmt/view-attendance?tenantId=${Digit.ULBService.getCurrentTenantId()}&musterRollNumber=${value}`}
            >
              {String(
                value
                  ? column.translate
                    ? t(column.prefix ? `${column.prefix}${value}` : value)
                    : value
                  : t("ES_COMMON_NA")
              )}
            </Link>
          </span>
        );
      }
      if (key === "ATM_ATTENDANCE_WEEK") {
        const week = `${Digit.DateUtils.ConvertTimestampToDate(
          value?.startDate,
          "dd/MM/yyyy"
        )}-${Digit.DateUtils.ConvertTimestampToDate(
          value?.endDate,
          "dd/MM/yyyy"
        )}`;
        return <div>{week}</div>;
      }
      if (key === "ATM_NO_OF_INDIVIDUALS") {
        return <div>{value?.length}</div>;
      }
      if (key === "ATM_AMOUNT_IN_RS") {
        return (
          <span>
            {value
              ? Digit.Utils.dss.formatterWithoutRound(value, "number")
              : t("ES_COMMON_NA")}
          </span>
        );
      }
      if (key === "ATM_SLA") {
        return parseInt(value) > 0 ? (
          <span className="sla-cell-success">{t(value) || ""}</span>
        ) : (
          <span className="sla-cell-error">{t(value) || ""}</span>
        );
      }
      if (key === "COMMON_WORKFLOW_STATES") {
        return <span>{t(`WF_MUSTOR_${value}`)}</span>;
      }
      //added this in case we change the key and not updated here , it'll throw that nothing was returned from cell error if that case is not handled here. To prevent that error putting this default
      return <span>{t(`CASE_NOT_HANDLED`)}</span>;
    },
    MobileDetailsOnClick: (row, tenantId) => {
      let link;
      Object.keys(row).map((key) => {
        if (key === "ATM_MUSTER_ROLL_ID")
          link = `/${window.contextPath}/employee/attendencemgmt/view-attendance?tenantId=${tenantId}&musterRollNumber=${row[key]}`;
      });
      return link;
    },
    populateReqCriteria: () => {
      const tenantId = Digit.ULBService.getCurrentTenantId();
      return {
        url: "/org-services/organisation/v1/_search",
        params: { limit: 50, offset: 0 },
        body: {
          SearchCriteria: {
            tenantId: tenantId,
            functions: {
              type: "CBO",
            },
          },
        },
        config: {
          enabled: true,
          select: (data) => {
            return data?.organisations;
          },
        },
      };
    },
  },
  SearchWageSeekerConfig: {
    customValidationCheck: (data) => {
      //checking both to and from date are present
      const { createdFrom, createdTo } = data;
      if (
        (createdFrom === "" && createdTo !== "") ||
        (createdFrom !== "" && createdTo === "")
      )
        return { warning: true, label: "ES_COMMON_ENTER_DATE_RANGE" };

      return false;
    },
    preProcess: (data) => {
      data.params = {
        ...data.params,
        tenantId: Digit.ULBService.getCurrentTenantId(),
      };

      let requestBody = { ...data.body.Individual };
      const pathConfig = {
        name: "name.givenName",
      };
      const dateConfig = {
        createdFrom: "daystart",
        createdTo: "dayend",
      };
      const selectConfig = {
        wardCode: "wardCode[0].code",
        socialCategory: "socialCategory.code",
      };
      const textConfig = ["name", "individualId"];
      let Individual = Object.keys(requestBody)
        .map((key) => {
          if (selectConfig[key]) {
            requestBody[key] = _.get(requestBody, selectConfig[key], null);
          } else if (typeof requestBody[key] == "object") {
            requestBody[key] = requestBody[key]?.code;
          } else if (textConfig?.includes(key)) {
            requestBody[key] = requestBody[key]?.trim();
          }
          return key;
        })
        .filter((key) => requestBody[key])
        .reduce((acc, curr) => {
          if (pathConfig[curr]) {
            _.set(acc, pathConfig[curr], requestBody[curr]);
          } else if (dateConfig[curr] && dateConfig[curr]?.includes("day")) {
            _.set(
              acc,
              curr,
              Digit.Utils.date.convertDateToEpoch(
                requestBody[curr],
                dateConfig[curr]
              )
            );
          } else {
            _.set(acc, curr, requestBody[curr]);
          }
          return acc;
        }, {});

      data.body.Individual = { ...Individual };
      return data;
    },
    additionalCustomizations: (row, key, column, value, t, searchResult) => {
      //here we can add multiple conditions
      //like if a cell is link then we return link
      //first we can identify which column it belongs to then we can return relevant result
      switch (key) {
        case "MASTERS_WAGESEEKER_ID":
          return (
            <span className="link">
              <Link
                to={`/${window.contextPath}/employee/masters/view-wageseeker?tenantId=${row?.tenantId}&individualId=${value}`}
              >
                {String(
                  value
                    ? column.translate
                      ? t(column.prefix ? `${column.prefix}${value}` : value)
                      : value
                    : t("ES_COMMON_NA")
                )}
              </Link>
            </span>
          );

        case "MASTERS_SOCIAL_CATEGORY":
          return value ? (
            <span style={{ whiteSpace: "nowrap" }}>
              {String(t(`MASTERS_${value}`))}
            </span>
          ) : (
            t("ES_COMMON_NA")
          );

        case "CORE_COMMON_PROFILE_CITY":
          return value ? (
            <span style={{ whiteSpace: "nowrap" }}>
              {String(t(Digit.Utils.locale.getCityLocale(value)))}
            </span>
          ) : (
            t("ES_COMMON_NA")
          );

        case "MASTERS_WARD":
          return value ? (
            <span style={{ whiteSpace: "nowrap" }}>
              {String(
                t(Digit.Utils.locale.getMohallaLocale(value, row?.tenantId))
              )}
            </span>
          ) : (
            t("ES_COMMON_NA")
          );

        case "MASTERS_LOCALITY":
          return value ? (
            <span style={{ whiteSpace: "break-spaces" }}>
              {String(
                t(Digit.Utils.locale.getMohallaLocale(value, row?.tenantId))
              )}
            </span>
          ) : (
            t("ES_COMMON_NA")
          );
        default:
          return t("ES_COMMON_NA");
      }
    },
    MobileDetailsOnClick: (row, tenantId) => {
      let link;
      Object.keys(row).map((key) => {
        if (key === "MASTERS_WAGESEEKER_ID")
          link = `/${window.contextPath}/employee/masters/view-wageseeker?tenantId=${tenantId}&wageseekerId=${row[key]}`;
      });
      return link;
    },
    additionalValidations: (type, data, keys) => {
      if (type === "date") {
        return data[keys.start] && data[keys.end]
          ? () =>
              new Date(data[keys.start]).getTime() <=
              new Date(data[keys.end]).getTime()
          : true;
      }
    },
  },
  // SearchIndividualConfig: {
  //   preProcess: (data) => {
  //     delete data.params.tenantId;
  //     delete data.params.limit;
  //     delete data.params.offset;
  //     delete data.body.apiOperation;
  //     delete data.body.Individual;
  //     data.body.MdmsCriteria = {
  //       "tenantId": "dev",
  //       "filters": {},
  //       "schemaCode": "ACCESSCONTROL-ACTIONS-TEST.actions-test",
  //       "limit": 10,
  //       "offset": 0
  //   }
  //     return data;
  //   },
  //   additionalCustomizations: (row, key, column, value, t, searchResult) => {
  //     //here we can add multiple conditions
  //     //like if a cell is link then we return link
  //     //first we can identify which column it belongs to then we can return relevant result
  //     switch (key) {
  //       case "MASTERS_WAGESEEKER_ID":
  //         return (
  //           <span className="link">
  //             <Link to={`/${window.contextPath}/employee/masters/view-wageseeker?tenantId=${row?.tenantId}&individualId=${value}`}>
  //               {String(value ? (column.translate ? t(column.prefix ? `${column.prefix}${value}` : value) : value) : t("ES_COMMON_NA"))}
  //             </Link>
  //           </span>
  //         );

  //       case "MASTERS_SOCIAL_CATEGORY":
  //         return value ? <span style={{ whiteSpace: "nowrap" }}>{String(t(`MASTERS_${value}`))}</span> : t("ES_COMMON_NA");

  //       case "CORE_COMMON_PROFILE_CITY":
  //         return value ? <span style={{ whiteSpace: "nowrap" }}>{String(t(Digit.Utils.locale.getCityLocale(value)))}</span> : t("ES_COMMON_NA");

  //       case "MASTERS_WARD":
  //         return value ? (
  //           <span style={{ whiteSpace: "nowrap" }}>{String(t(Digit.Utils.locale.getMohallaLocale(value, row?.tenantId)))}</span>
  //         ) : (
  //           t("ES_COMMON_NA")
  //         );

  //       case "MASTERS_LOCALITY":
  //         return value ? (
  //           <span style={{ whiteSpace: "break-spaces" }}>{String(t(Digit.Utils.locale.getMohallaLocale(value, row?.tenantId)))}</span>
  //         ) : (
  //           t("ES_COMMON_NA")
  //         );
  //       default:
  //         return t("ES_COMMON_NA");
  //     }
  //   }
  // },
  SearchWMSProjectConfig: {
    preProcess: (data) => {
      const createdFrom = Digit.Utils.pt.convertDateToEpoch(
        data.body.inbox.moduleSearchCriteria?.createdFrom,
        "daystart"
      );
      const createdTo = Digit.Utils.pt.convertDateToEpoch(
        data.body.inbox.moduleSearchCriteria?.createdTo
      );
      const projectType =
        data.body.inbox.moduleSearchCriteria?.projectType?.code;
      const boundary =
        data.body.inbox.moduleSearchCriteria?.boundary?.[0]?.code;
      data.params = {
        ...data.params,
        tenantId: Digit.ULBService.getCurrentTenantId(),
        includeAncestors: true,
      };
      let projectName = data.body.inbox.moduleSearchCriteria?.projectName?.trim();
      let projectNumber = data.body.inbox.moduleSearchCriteria?.projectNumber?.trim();
      delete data.body.inbox.moduleSearchCriteria?.createdFrom;
      delete data.body.inbox.moduleSearchCriteria?.ward;
      delete data.body.inbox.moduleSearchCriteria?.createdTo;
      data.body.inbox.tenantId = Digit.ULBService.getCurrentTenantId();
      data.body.inbox.moduleSearchCriteria = {
        ...data.body.inbox.moduleSearchCriteria,
        tenantId: Digit.ULBService.getCurrentTenantId(),
        projectNumber,
        projectType,
        projectName,
        boundary,
        createdFrom,
        createdTo,
      };

      return data;
    },
    postProcess: (responseArray) => {
      const listOfUuids = responseArray?.map(
        (row) => row.auditDetails.createdBy
      );
      const uniqueUuids = listOfUuids?.filter(function (item, i, ar) {
        return ar.indexOf(item) === i;
      });
      const tenantId = Digit.ULBService.getCurrentTenantId();
      const reqCriteria = {
        url: "/user/_search",
        params: {},
        body: { tenantId, pageSize: 100, uuid: [...uniqueUuids] },
        config: {
          enabled: responseArray?.length > 0 ? true : false,
          select: (data) => {
            const usersResponse = data?.user;
            responseArray?.forEach((row) => {
              const uuid = row?.auditDetails?.createdBy;
              const user = usersResponse?.filter((user) => user.uuid === uuid);
              row.createdBy = user?.[0].name;
            });
            return responseArray;
          },
        },
      };
      const {
        isLoading: isPostProcessLoading,
        data: combinedResponse,
        isFetching: isPostProcessFetching,
      } = Digit.Hooks.useCustomAPIHook(reqCriteria);

      return {
        isPostProcessFetching,
        isPostProcessLoading,
        combinedResponse,
      };
    },
    customValidationCheck: (data) => {
      //checking both to and from date are present
      const { createdFrom, createdTo } = data;
      if (createdTo !== "" && createdFrom === "")
        return { warning: true, label: "ES_COMMON_ENTER_DATE_RANGE" };
      else if (createdTo === "" && createdFrom !== "")
        return { warning: true, label: "ES_COMMON_ENTER_DATE_RANGE" };

      return false;
    },
    additionalCustomizations: (row, key, column, value, t, searchResult) => {
      //here we can add multiple conditions
      //like if a cell is link then we return link
      //first we can identify which column it belongs to then we can return relevant result
      switch (key) {
        case "WORKS_PROJECT_ID":
          return (
            <span className="link">
              <Link
                to={`/${window.contextPath}/employee/project/project-details?tenantId=${row?.businessObject?.tenantId}&projectNumber=${value}`}
              >
                {String(
                  value
                    ? column.translate
                      ? t(column.prefix ? `${column.prefix}${value}` : value)
                      : value
                    : t("ES_COMMON_NA")
                )}
              </Link>
            </span>
          );

        case "WORKS_PARENT_PROJECT_ID":
          return value ? (
            <span className="link">
              <Link
                to={`/${window.contextPath}/employee/project/project-details?tenantId=${row?.businessObject?.tenantId}&projectNumber=${value}`}
              >
                {String(value ? value : t("ES_COMMON_NA"))}
              </Link>
            </span>
          ) : (
            t("ES_COMMON_NA")
          );

        case "WORKS_PROJECT_NAME": {
          let currentProject = searchResult?.filter(
            (result) => result?.businessObject?.id === row?.businessObject?.id
          )[0];
          return (
            <div class="tooltip">
              <span
                class="textoverflow"
                style={{ "--max-width": `${column?.maxLength}ch` }}
              >
                {String(t(value))}
              </span>
              {/* check condtion - if length greater than 20 */}
              <span class="tooltiptext" style={{ whiteSpace: "nowrap" }}>
                {currentProject?.businessObject?.description}
              </span>
            </div>
          );
        }

        case "PROJECT_ESTIMATED_COST_IN_RS":
          return (
            <Amount
              customStyle={{ textAlign: "right" }}
              value={value}
              t={t}
            ></Amount>
          );

        case "ES_COMMON_LOCATION": {
          let currentProject = searchResult?.filter(
            (result) => result?.businessObject.id === row?.businessObject.id
          )[0].businessObject;
          const headerLocale = Digit.Utils.locale.getTransformedLocale(
            row?.businessObject.tenantId
          );
          if (currentProject) {
            let locality = currentProject?.address?.boundary
              ? t(`${headerLocale}_ADMIN_${currentProject?.address?.boundary}`)
              : "";
            let ward = currentProject?.additionalDetails?.ward
              ? t(
                  `${headerLocale}_ADMIN_${currentProject?.additionalDetails?.ward}`
                )
              : "";
            let city = currentProject?.address?.city
              ? t(
                  `TENANT_TENANTS_${Digit.Utils.locale.getTransformedLocale(
                    currentProject?.address?.city
                  )}`
                )
              : "";
            return (
              <p>{`${locality ? locality + ", " : ""}${
                ward ? ward + ", " : ""
              }${city}`}</p>
            );
          }
          return <p>{"NA"}</p>;
        }

        default:
          return t("ES_COMMON_NA");
      }
    },
    additionalValidations: (type, data, keys) => {
      if (type === "date") {
        return data[keys.start] && data[keys.end]
          ? () =>
              new Date(data[keys.start]).getTime() <=
              new Date(data[keys.end]).getTime()
          : true;
      }
    },
    MobileDetailsOnClick: (row, tenantId) => {
      let link;
      Object.keys(row).map((key) => {
        if (key === "WORKS_PROJECT_ID")
          link = `/${window.contextPath}/employee/project/project-details?tenantId=${tenantId}&projectNumber=${row[key]}`;
      });
      return link;
    },
  },
  FacilityMappingConfig: {
    preProcess: (data) => {
      return data;
    },
    getFacilitySearchRequest: (prop) => {
      const tenantId = Digit.ULBService.getCurrentTenantId();
      const { campaignId } = Digit.Hooks.useQueryParams();
      return {
        url: `/project-factory/v1/project-type/search`,
        params: {},
        body: {
          CampaignDetails: {
            tenantId: tenantId,
            ids: [campaignId],
          },
        },
        changeQueryName: `boundarySearchForPlanFacility`,
        config: {
          enabled: true,
          select: (data) => {
            const result =
              data?.CampaignDetails?.[0]?.boundaries?.filter(
                (item) => item.type == prop.lowestHierarchy
              ) || [];
            return result;
          },
        },
      };
    },
    // additionalCustomizations: (row, key, column, value, t, searchResult) => {
    //   const [showPopup, setShowPopup] = useState(false);
    //   const FacilityPopUp = Digit.ComponentRegistryService.getComponent("FacilityPopup");
    //   const VillageHierarchyTooltipWrapper = Digit.ComponentRegistryService.getComponent("VillageHierarchyTooltipWrapper");

    //   switch (key) {
    //     case `MICROPLAN_FACILITY_${column?.projectType}_CAPACITY`:
    //       if (row?.additionalDetails?.capacity || row?.additionalDetails?.capacity === 0) {
    //         return row?.additionalDetails?.capacity;
    //       }
    //       return t("NA");
    //     case "MICROPLAN_FACILITY_SERVINGPOPULATION":
    //       return row?.additionalDetails?.servingPopulation;
    //     case "MICROPLAN_FACILITY_RESIDINGVILLAGE":
    //       return <div style={{display:"flex", gap:".5rem"}}>
    //       {t(row?.residingBoundary)}
    //       <VillageHierarchyTooltipWrapper  boundaryCode={row?.residingBoundary}/>
    //     </div>
    //     case "MICROPLAN_FACILITY_ASSIGNED_VILLAGES":
    //       const assignedVillages = row?.serviceBoundaries;
    //       return assignedVillages ? assignedVillages.length : null;
    //     case "HCM_MICROPLAN_FACILITY_VIEW_ASSIGNMENT":
    //     case "HCM_MICROPLAN_FACILITY_ACTION_ASSIGNMENT":
    //       return (
    //         <>
    //           <Button
    //             className=""
    //             icon="ArrowForward"
    //             iconFill=""
    //             isSuffix
    //             label={t(key)}
    //             onClick={() => setShowPopup(true)}
    //             // removed this because due to popup crashing on dev
    //             // onClick={() => console.log("temp action")}
    //             options={[]}
    //             optionsKey=""
    //             size="medium"
    //             style={{}}
    //             title={t(key)}
    //             variation="primary"
    //           />
    //           {showPopup && (
    //             <FacilityPopUp
    //               detail={row}
    //               onClose={() => {
    //                 setShowPopup(false);
    //               }}
    //             />
    //           )}
    //         </>
    //       );
    //     default:
    //       return null;
    //   }
    // },
  },
  SampleInboxConfig: {
    getSearchRequest: (prop) => {
      const tenantId = Digit.ULBService.getCurrentTenantId();
      return {
        url: `/plan-service/config/_search`,
        params: {},
        body: {
          CampaignDetails: {
            tenantId: tenantId,
          },
        },
        changeQueryName: `boundarySearchForPlanFacility`,
        config: {
          enabled: true,
          select: (data) => {
            const result =
              data?.CampaignDetails?.[0]?.boundaries?.filter(
                (item) => item.type == prop.lowestHierarchy
              ) || [];
            return result;
          },
        },
      };
    },
    additionalCustomizations: (row, key, column, value, t, searchResult) => {
      if (key === "Facility name") {
        return (
          <Button
            variation="link"
            label={
              value ? (column.translate ? t(value) : value) : t("ES_COMMON_NA")
            }
            type="button"
            icon="Edit"
            size={"medium"}
          />
        );
      }
      //added this in case we change the key and not updated here , it'll throw that nothing was returned from cell error if that case is not handled here. To prevent that error putting this default
      return <span>{t(`CASE_NOT_HANDLED`)}</span>;
    },
    selectionHandler: (event) => {
      console.log(event, "selection handler event");
    },
    actionSelectHandler: (index, label, selectedRows) => {
      console.log(index, label, selectedRows, "action handler");
    },
    preProcess: (data, additionalDetails) => {
      const { name, status } = data?.state?.searchForm || {};

      data.body.PlanConfigurationSearchCriteria = {};
      data.body.PlanConfigurationSearchCriteria.limit =
        data?.state?.tableForm?.limit;
      // data.body.PlanConfigurationSearchCriteria.limit = 10
      data.body.PlanConfigurationSearchCriteria.offset =
        data?.state?.tableForm?.offset;
      data.body.PlanConfigurationSearchCriteria.name = name;
      data.body.PlanConfigurationSearchCriteria.tenantId = Digit.ULBService.getCurrentTenantId();
      data.body.PlanConfigurationSearchCriteria.userUuid = Digit.UserService.getUser().info.uuid;
      // delete data.body.PlanConfigurationSearchCriteria.pagination
      data.body.PlanConfigurationSearchCriteria.status = status?.status;
      data.body.PlanConfigurationSearchCriteria.name =
        data?.state?.searchForm?.microplanName;
      cleanObject(data.body.PlanConfigurationSearchCriteria);

      const dic = {
        0: [
          "EXECUTION_TO_BE_DONE",
          "CENSUS_DATA_APPROVAL_IN_PROGRESS",
          "CENSUS_DATA_APPROVED",
          "RESOURCE_ESTIMATION_IN_PROGRESS",
          "RESOURCE_ESTIMATIONS_APPROVED",
        ],
        1: ["EXECUTION_TO_BE_DONE"],
        2: [
          "CENSUS_DATA_APPROVAL_IN_PROGRESS",
          "CENSUS_DATA_APPROVED",
          "RESOURCE_ESTIMATION_IN_PROGRESS",
        ],
        3: ["RESOURCE_ESTIMATIONS_APPROVED"],
      };
      const url = Digit.Hooks.useQueryParams();

      const tabId = url.tabId || "0"; // Default to '0' if tabId is undefined
      data.body.PlanConfigurationSearchCriteria.status = dic[String(tabId)];
      return data;
    },
    postProcess: (responseArray, uiConfig) => {
      return responseArray;
    },
  },
  SearchMDMSConfig: {
    customValidationCheck: (data) => {
      //checking both to and from date are present
      const { createdFrom, createdTo, field, value } = data;
      if (
        (createdFrom === "" && createdTo !== "") ||
        (createdFrom !== "" && createdTo === "")
      )
        return { type: "warning", label: "ES_COMMON_ENTER_DATE_RANGE" };

      if ((field && !value) || (!field && value)) {
        return {
          type: "warning",
          label: "WBH_MDMS_SEARCH_VALIDATION_FIELD_VALUE_PAIR",
        };
      }

      return false;
    },
    preProcess: (data, additionalDetails) => {
      const tenantId = Digit.ULBService.getCurrentTenantId();
      data.body.MdmsCriteria.tenantId = tenantId;
      const filters = {};
      const custom = data.body.MdmsCriteria.custom;
      const { field, value, isActive } = custom || {};
      filters[field?.code] = value;
      if (isActive) {
        if (isActive.value === "all") delete data.body.MdmsCriteria.isActive;
        else data.body.MdmsCriteria.isActive = isActive?.value;
      } else {
        delete data.body.MdmsCriteria.isActive;
      }
      data.body.MdmsCriteria.filters = filters;
      // data.body.MdmsCriteria.limit = 100
      data.body.MdmsCriteria.limit = data.state.tableForm.limit;
      data.body.MdmsCriteria.offset = data.state.tableForm.offset;
      data.body.MdmsCriteria.schemaCode =
        // additionalDetails?.currentSchemaCode
        "ACCESSCONTROL-ACTIONS-TEST.actions-test";
      delete data.body.MdmsCriteria.custom;
      return data;
    },
    additionalCustomizations: (row, key, column, value, t, searchResult) => {
      switch (key) {
        case "Active":
          return (
            <Tag
              icon=""
              label={value ? "Active" : "InActive"}
              labelStyle={{}}
              showIcon={false}
              style={{}}
              type="success"
            />
          );
        default:
          return t("ES_COMMON_NA");
      }
    },
    MobileDetailsOnClick: (row, tenantId) => {
      let link;
      Object.keys(row).map((key) => {
        if (key === "MASTERS_WAGESEEKER_ID")
          link = `/${window.contextPath}/employee/masters/view-wageseeker?tenantId=${tenantId}&wageseekerId=${row[key]}`;
      });
      return link;
    },
    additionalValidations: (type, data, keys) => {
      if (type === "date") {
        return data[keys.start] && data[keys.end]
          ? () =>
              new Date(data[keys.start]).getTime() <=
              new Date(data[keys.end]).getTime()
          : true;
      }
    },
    selectionHandler: (event) => {
      console.log(event, "selection handler event");
    }, // selectionHandler : Is used to handle row selections. gets on object which containes 3 key value pairs:  allSelected(whether all rows are selected or not), selectedCount (no, of rows selected),selectedRows( an array of selected rows)
    actionSelectHandler: (index, label, selectedRows) => {
      console.log(index, label, selectedRows, "action handler");
    }, // actionSelectHandler : Is used to handle onClick functions of table action button on row selections, gets index,label and selectedRows as props
    footerActionHandler: (index, event) => {
      console.log(index, "index");
      console.log(event, "event");
    }, // footerActionHandler : Is used to handle onclick functions of footer action buttons, gets index and event as props
    linkColumnHandler: (row) => {
      console.log(row, "row");
      const url = `/${window.contextPath}/employee/microplan/view?tenantId=${row?.tenantId}&uniqueIdentifier=${row?.uniqueIdentifier}`;
      window.location.href = url;
    }, 
  },
};
