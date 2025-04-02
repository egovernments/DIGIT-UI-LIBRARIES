import React, {
  useMemo,
  useCallback,
  useState,
  useEffect,
  Fragment,
  useContext,
} from "react";
import { useTranslation } from "react-i18next";
import { useForm, Controller } from "react-hook-form";
import _ from "lodash";
import { InboxContext } from "./InboxSearchComposerContext";
import { Loader } from "../atoms";
import { CustomSVG } from "../atoms";
import CheckBox from "../atoms/CheckBox";
import NoResultsFound from "../atoms/NoResultsFound";
import ResultsDataTable from "../molecules/ResultsDataTable";
import Button from "../atoms/Button";
import { useHistory} from "react-router-dom";

const useDebounce = (value, delay) => {
  const [debouncedValue, setDebouncedValue] = useState(value);
  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value);
    }, delay);

    return () => {
      clearTimeout(handler);
    };
  }, [value, delay]);
  return debouncedValue;
};

const ResultsDataTableWrapper = ({
  config,
  data,
  isLoading,
  isFetching,
  fullConfig,
  revalidate,
  type,
  activeLink,
  browserSession,
  additionalConfig,
  TotalCount,
}) => {
  const { apiDetails } = fullConfig;
  const { t } = useTranslation();
  const history = useHistory();
  const resultsKey = config.resultsJsonPath;
  const [showResultsTable, setShowResultsTable] = useState(true);
  const [session, setSession, clearSession] = browserSession || [];
  let searchResult = _.get(data, resultsKey, []);
  searchResult = searchResult?.length > 0 ? searchResult : [];
  // searchResult = searchResult.reverse();
  const [selectedRows, setSelectedRows] = useState([]);
  const { state, dispatch } = useContext(InboxContext);
  const configModule =
    Digit?.Customizations?.[apiDetails?.masterName]?.[apiDetails?.moduleName];
  const [currentPage, setCurrentPage] = useState(1);
  const [rowsPerPage, setRowsPerPage] = useState(
    config?.defaultRowsPerPage || 10
  );
  const [limitAndOffset, setLimitAndOffset] = useState({
    limit: rowsPerPage,
    offset: (currentPage - 1) * rowsPerPage,
  });

  //here I am just checking state.searchForm has all empty keys or not(when clicked on clear search)
  useEffect(() => {
    if (
      apiDetails?.minParametersForSearchForm !== 0 &&
      Object.keys(state.searchForm).length > 0 &&
      !Object.keys(state.searchForm).some(
        (key) => state.searchForm[key] !== ""
      ) &&
      type === "search" &&
      activeLink?.minParametersForSearchForm !== 0
    ) {
      setShowResultsTable(false);
    }
    return () => {
      setShowResultsTable(true);
    };
  }, [state]);

  const handleLinkColumn = (event) => {
    const linkColumnHandler = configModule?.linkColumnHandler || {};
    if (typeof linkColumnHandler === "function") {
      linkColumnHandler(event);
    } else {
      console.error("linkColumnHandler is not defined or is not a function");
    }
  };

  const tableColumns = useMemo(() => {
    //test if accessor can take jsonPath value only and then check sort and global search work properly
    return config?.columns?.map((column) => {
      const commonProps = {
        id: column?.id,
        name: t(column?.label) || t("ES_COMMON_NA"),
        format: column?.format,
        grow: column?.grow,
        width: column?.width,
        minWidth: column?.minWidth,
        maxWidth: column?.maxWidth,
        right: column?.right,
        center: column?.center,
        ignoreRowClick: column?.ignoreRowClick,
        wrap: column?.wrap,
        sortable: !column?.disableSortBy,
        headerAlign: column?.headerAlign,
        style: column?.style,
        conditionalCellStyles: column?.conditionalCellStyles,
        sortFunction:
          typeof column?.sortFunction === "function"
            ? (rowA, rowB) => column.sortFunction(rowA, rowB)
            : (rowA, rowB) => 0,
        selector: (row, index) => _.get(row, column?.jsonPath),
      };
      if (column?.svg) {
        // const icon = Digit.ComponentRegistryService.getComponent(column.svg);
        return {
          ...commonProps,
          cell: ({ row, index, column, id }) => {
            return (
              <div
                className="cursorPointer"
                style={{ marginLeft: "1rem" }}
                onClick={() => additionalConfig?.resultsTable?.onClickSvg(row)}
              >
                <CustomSVG.EditIcon />
              </div>
            );
          },
        };
      }
      if (column.additionalCustomization) {
        return {
          ...commonProps,
          selector: (row, index) => {
            return configModule?.additionalCustomizations(
              row,
              column?.label,
              column,
              _.get(row, column?.jsonPath),
              t,
              searchResult
            );
          },
        };
      }
      if (column?.link) {
        return {
          ...commonProps,
          cell: (row, index, col, id) => {
            console.log(
              row,
              column,
              column?.jsonPath,
              _.get(row, column?.jsonPath),
              "testing"
            );
            return (
              <Button
                variation="link"
                label={
                  _.get(row, column?.jsonPath)
                    ? column.translate
                      ? t(_.get(row, column?.jsonPath))
                      : _.get(row, column?.jsonPath)
                    : t("ES_COMMON_NA")
                }
                type="button"
                icon={column?.buttonProps?.icon}
                size={column?.buttonProps?.size || "medium"}
                onClick={
                  column?.buttonProps?.linkTo
                    ? () => {
                        history.push(
                          `/${window?.contextPath}/employee/${column?.linkTo}`
                        );
                      }
                    : () => handleLinkColumn(row)
                }
              />
            );
          },
        };
      }
      return commonProps;
    });
  }, [config, searchResult]);

  const defaultValuesFromSession = config?.customDefaultPagination
    ? config?.customDefaultPagination
    : session?.tableForm
    ? { ...session?.tableForm }
    : { limit: 10, offset: 0 };

  const {
    register,
    handleSubmit,
    setValue,
    getValues,
    reset,
    watch,
    trigger,
    control,
    formState,
    errors,
    setError,
    clearErrors,
    unregister,
  } = useForm({
    defaultValues: defaultValuesFromSession,
  });

  //call this fn whenever session gets updated
  const setDefaultValues = () => {
    reset(defaultValuesFromSession);
  };

  //adding this effect because simply setting session to default values is not working
  useEffect(() => {
    setDefaultValues();
  }, [session]);

  const [searchQuery, onSearch] = useState("");
  const debouncedValue = config?.debouncedValue || 1000;
  const debouncedSearchQuery = useDebounce(searchQuery, debouncedValue);

  const filterValue = useCallback((rows, id, filterValue = "") => {
    return rows.filter((row) => {
      if (!row) return false; // Ensure row exists

      return Object.keys(row).some((key) => {
        let value = row[key];

        // If the value is an object (like `data`), iterate inside it
        if (typeof value === "object" && value !== null) {
          return Object.keys(value).some((nestedKey) => {
            let nestedValue = value[nestedKey];

            if (typeof nestedValue === "string") {
              return nestedValue
                .toLowerCase()
                .includes(filterValue.toLowerCase());
            } else if (typeof nestedValue === "number") {
              return String(nestedValue).includes(filterValue);
            }
            return false;
          });
        }

        // If the value is a string or number at the root level
        if (typeof value === "string") {
          return value.toLowerCase().includes(filterValue.toLowerCase());
        } else if (typeof value === "number") {
          return String(value).includes(filterValue);
        }

        return false;
      });
    });
  }, []);

  const filteredData = useMemo(() => {
    if (!debouncedSearchQuery) return searchResult; // If no query, return all rows
    return filterValue(searchResult, null, debouncedSearchQuery);
  }, [debouncedSearchQuery, searchResult, filterValue]);

  useEffect(() => {
    register(
      "offset",
      session?.tableForm?.offset ||
        state.tableForm.offset ||
        config?.customDefaultPagination?.offset ||
        0
    );
    register(
      "limit",
      session?.tableForm?.limit ||
        state.tableForm.limit ||
        config?.customDefaultPagination?.limit ||
        10
    );
  });

  const onSubmit = (data) => {
    //here update the reducer state
    //call a dispatch to update table's part of the state and update offset, limit
    // this will in turn make the api call and give search results and table will be rendered acc to the new data
    dispatch({
      type: "tableForm",
      state: { ...data },
    });
  };

  const selectProps = {
    hideLabel: true,
    mainClassName: "digit-data-table-select-checkbox",
  };

  const conditionalRowStyles = [
    {
      when: (row) =>
        selectedRows.some(
          (selectedRow) => JSON.stringify(selectedRow) === JSON.stringify(row)
        ),
      style: {
        backgroundColor: "#FBEEE8",
      },
      classNames: ["selectedRow"],
    },
  ];
  const handleRowSelect = (event) => {
    setSelectedRows(event?.selectedRows);
    const rowClickHandler = configModule?.selectionHandler || {};
    if (typeof rowClickHandler === "function") {
      rowClickHandler(event);
    } else {
      console.error("selectionHandler is not defined or is not a function");
    }
  };

  const handleActionSelect = (index, label, selectedRows) => {
    const actionHandler = configModule?.actionSelectHandler || {};
    if (typeof actionHandler === "function") {
      actionHandler(index, label, selectedRows);
    } else {
      console.error("actionSelectHandler is not defined or is not a function");
    }
  };

  const handlePageChange = (page, totalRows) => {
    setCurrentPage(page);
    const updatedOffset = (page - 1) * rowsPerPage;
    setLimitAndOffset({ ...limitAndOffset, offset: updatedOffset });
    setValue("offset", updatedOffset);
    handleSubmit(onSubmit)();
  };

  const handlePerRowsChange = (currentRowsPerPage, currentPage) => {
    setRowsPerPage(currentRowsPerPage);
    setCurrentPage(1);
    const newLimit = currentRowsPerPage;
    const newOffset = (currentPage - 1) * currentRowsPerPage;
    setLimitAndOffset({
      limit: newLimit,
      offset: newOffset,
    });
    setValue("limit", newLimit);
    setValue("offset", newOffset);
    handleSubmit(onSubmit)();
  };
  useEffect(() => {
    if (limitAndOffset) {
      setValue("limit", limitAndOffset.limit);
      setValue("offset", limitAndOffset.offset);
    }
  }, [limitAndOffset]);

  if (isLoading || isFetching) return <div className="digit-table-loader"><Loader/></div>;
  if (!data) return <></>;
  if (!showResultsTable) return <></>;
  if (searchResult?.length === 0) return <NoResultsFound />;
  return (
    <ResultsDataTable
      data={filteredData || []}
      columns={tableColumns}
      responsive={true}
      showCheckBox={config?.selectionProps?.showCheckBox}
      selectableRowsNoSelectAll={config?.selectProps?.selectableRowsNoSelectAll}
      showSelectedState={config?.selectionProps?.showSelectedState}
      showSelectedStatePosition={config?.selectProps?.showSelectedStatePosition}
      selectableRowsHighlight={true}
      selectableRowsComponent={CheckBox}
      selectProps={selectProps}
      onSelectedRowsChange={handleRowSelect}
      onRowClicked={additionalConfig?.resultsTable?.onRowClicked}
      expandableRows={config?.expandableProps?.expandableRows}
      expandableRowsComponent={config?.expandableProps?.expandableRowsComponent}
      onRowExpandToggled={(expanded, row) =>
        config?.handleRowExpand?.(expanded, row)
      }
      progressPending={config?.progressPending}
      conditionalRowStyles={conditionalRowStyles}
      tableClassName={config?.tableProps?.tableClassName ? config?.tableProps?.tableClassName : ""}
      defaultSortAsc={config?.defaultSortAsc}
      pagination={config.isPaginationRequired}
      paginationTotalRows={
        TotalCount ||
        data?.count ||
        data?.TotalCount ||
        data?.totalCount ||
        searchResult?.length
      }
      onChangeRowsPerPage={handlePerRowsChange}
      paginationDefaultPage={currentPage}
      paginationPerPage={rowsPerPage}
      onChangePage={handlePageChange}
      paginationRowsPerPageOptions={config?.paginationRowsPerPageOptions}
      showTableDescription={config?.tableProps?.showTableDescription}
      showTableTitle={config?.tableProps?.showTableTitle}
      enableGlobalSearch={config?.enableGlobalSearch}
      selectedRows={selectedRows}
      actions={config?.actionProps?.actions}
      searchHeader={config.searchHeader}
      configModule={configModule}
      onSearch={onSearch}
      handleActionSelect={handleActionSelect}
      rowsPerPageText={config?.paginationComponentOptions?.rowsPerPage}
      paginationComponentOptions={config?.paginationComponentOptions}
    ></ResultsDataTable>
  );
};

export default ResultsDataTableWrapper;
