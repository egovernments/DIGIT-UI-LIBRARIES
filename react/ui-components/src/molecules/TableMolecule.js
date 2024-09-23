import React, {
  useState,
  useRef,
  useEffect,
  useLayoutEffect,
  Fragment,
} from "react";
import { useTranslation } from "react-i18next";
import TableMain from "../atoms/TableMain";
import TableHeader from "../atoms/TableHeader";
import TableFooter from "../atoms/TableFooter";
import TableBody from "../atoms/TableBody";
import TableCell from "../atoms/TableCell";
import TableRow from "../atoms/TableRow";
import CheckBox from "../atoms/CheckBox";
import Card from "../atoms/Card";
import { SVG } from "../atoms";
import { CustomSVG } from "../atoms";
import { StringManipulator } from "../atoms";
import Button from "../atoms/Button";

const TableMolecule = ({
  headerData,
  rows,
  footerContent,
  initialRowsPerPage = 5,
  frozenColumns = 0,
  withBorder,
  withAlternateBg,
  withHeaderDivider,
  withColumnDivider,
  withRowDivider,
  rowsPerPageOptions = [5, 10, 15, 20],
  isStickyHeader = false,
  addCheckbox = false,
  checkboxLabel,
  initialSelectedRows = [],
  onSelectedRowsChange,
  isStickyFooter,
  addStickyFooter,
  stickyFooterContent,
  tableTitle,
  tableDescription,
  showSelectedState,
  onRowClick,
  hideFooter,
  actionButtonLabel,
  actions,
  headerStyles,
  footerStyles,
  bodyStyles,
  className,
  tableStyles,
  onFilter,
  addFilter,
  scrollableStickyFooterContent,
  isTableSortable,
  initialSortOrder,
}) => {
  const { t } = useTranslation();
  const [currentPage, setCurrentPage] = useState(1);
  const [rowsPerPage, setRowsPerPage] = useState(initialRowsPerPage);
  const [selectedRows, setSelectedRows] = useState(initialSelectedRows);
  const frozenColumnsRefsForHeaders = useRef([]);
  const frozenColumnsRefsForRows = useRef({});
  const [selectedRowsDetails, setSelectedRowsDetails] = useState([]);
  const [sortOrder, setSortOrder] = useState(initialSortOrder || "ascending");
  const [sortedColumnIndex, setSortedColumnIndex] = useState(null);
  const [sortedRows, setSortedRows] = useState([]);

  // Pagination Logic
  const indexOfLastRow = currentPage * rowsPerPage;
  const indexOfFirstRow = indexOfLastRow - rowsPerPage;

  // Handling Select All Rows
  const allRowsSelected = selectedRows?.length === rows?.length;

  const onSelectAllRows = () => {
    if (allRowsSelected) {
      setSelectedRows([]);
    } else {
      setSelectedRows(rows.map((_, index) => index));
    }
  };

  // Handling Select Individual Row
  const onSelectRow = (rowIndex) => {
    setSelectedRows((prevSelected) =>
      prevSelected?.includes(rowIndex)
        ? prevSelected?.filter((i) => i !== rowIndex)
        : [...prevSelected, rowIndex]
    );
  };

  //Handling PageChange
  const handlePageChange = (newPage) => {
    if (newPage > 0 && newPage <= totalPages) {
      setCurrentPage(newPage);
    }
  };

  // Handling change in rows per page
  const handleRowsPerPageChange = (event) => {
    setRowsPerPage(Number(event?.target?.value));
    setCurrentPage(1);
    // Reset to first page when changing rows per page
  };

  useEffect(() => {
    setSortedRows([...rows]);
  }, [rows]);

  useEffect(() => {
    if (!sortOrder) return;
    const sortRows = (columnIndex) => {
      const newSortedRows = [...rows];
      newSortedRows.sort((a, b) => {
        const columnA = a[columnIndex];
        const columnB = b[columnIndex];
  
        // Sorting based on data type
        if (typeof columnA === "number" && typeof columnB === "number") {
          return sortOrder === "ascending"
            ? columnA - columnB
            : columnB - columnA;
        } else if (typeof columnA === "object" && typeof columnB === "object") {
          return sortOrder === "ascending"
            ? columnA?.label.localeCompare(columnB?.label)
            : columnB?.label.localeCompare(columnA?.label);
        } else if (typeof columnA === "string" && typeof columnB === "string") {
          return sortOrder === "ascending"
            ? columnA.localeCompare(columnB)
            : columnB.localeCompare(columnA);
        }
        return 0; // Default case if types don't match
      });
      setSortedRows(newSortedRows);
    };

    if (sortedColumnIndex !== null) {
      sortRows(sortedColumnIndex);
    } else {
      const firstSortableColumnIndex = headerData?.findIndex((header) =>
        ["serialno", "numeric", "description", "text"].includes(header.type)
      );
      if (firstSortableColumnIndex !== -1) {
        sortRows(firstSortableColumnIndex);
      }
    }
  }, [sortedColumnIndex, sortOrder, rows, headerData]);
  

  const currentRows = isTableSortable
    ? sortedRows?.slice(indexOfFirstRow, indexOfLastRow)
    : rows?.slice(indexOfFirstRow, indexOfLastRow);

  const totalPages = Math.ceil(rows?.length / rowsPerPage);

  const handleSort = (index) => {
    if (sortedColumnIndex === index) {
      setSortOrder(sortOrder === "ascending" ? "descending" : "ascending");
    } else {
      setSortedColumnIndex(index);
      setSortOrder(sortOrder === "ascending" ? "descending" : "ascending");
    }
    setCurrentPage(1);
  };

  useLayoutEffect(() => {
    let leftOffset = 0;
    frozenColumnsRefsForHeaders.current.forEach((cell, index) => {
      if (cell) {
        requestAnimationFrame(() => {
          cell.style.left = `${leftOffset}px`;
          leftOffset += cell.offsetWidth;
        });
      }
    });

    Object.entries(frozenColumnsRefsForRows.current).forEach(
      ([rowIndex, cells]) => {
        let leftOffsetForBody = 0;
        cells.forEach((cell, index) => {
          if (cell) {
            requestAnimationFrame(() => {
              cell.style.left = `${leftOffsetForBody}px`;
              leftOffsetForBody += cell.offsetWidth;
            });
          }
        });
      }
    );
  }, [headerData, frozenColumns, rowsPerPage, currentPage, rows]);

  // Calling the callback whenever selectedRows changes
  useEffect(() => {
    const newselectedRowsDetails = selectedRows?.map((index) => rows[index]);
    setSelectedRowsDetails(newselectedRowsDetails);
  }, [selectedRows, rows]);

  // Separating the fixed and scrollable headers
  const fixedHeader = headerData?.slice(0, frozenColumns);
  const scrollableHeader = headerData?.slice(frozenColumns);

  const hasDescription = headerData?.some((header) => header.description);

  const renderTable = () => {
    return (
      <div className={"digit-table-footer-wrapper"}>
        <div
          className={`digit-table-container ${withBorder ? "withBorder" : ""}`}
        >
          <TableMain className={className} style={tableStyles}>
            {/* Dynamic Table Header */}
            <TableHeader
              className={`${isStickyHeader ? "sticky-header" : ""} ${
                hasDescription ? "hasDes" : ""
              }`}
              style={headerStyles}
            >
              <TableRow>
                {addCheckbox && (
                  <TableCell
                    isHeader={true}
                    className={`fixed-columns ${
                      withBorder ? "withBorder" : ""
                    } ${
                      withColumnDivider && !withHeaderDivider
                        ? "withColumnDivider"
                        : ""
                    } ${withHeaderDivider ? "withHeaderDivider" : ""}`}
                    style={headerStyles}
                  >
                    <CheckBox
                      checked={allRowsSelected}
                      onChange={onSelectAllRows}
                      label={checkboxLabel}
                      hideLabel={
                        checkboxLabel && checkboxLabel !== "" ? false : true
                      }
                      mainClassName={"table-checkbox"}
                    />
                  </TableCell>
                )}
                {fixedHeader?.map((header, index) => (
                  <TableCell
                    key={index}
                    isHeader={true}
                    className={`fixed-columns ${
                      withBorder ? "withBorder" : ""
                    } ${
                      withColumnDivider && !withHeaderDivider
                        ? "withColumnDivider"
                        : ""
                    } ${withHeaderDivider ? "withHeaderDivider" : ""}`}
                    cellref={(el) => {
                      frozenColumnsRefsForHeaders.current[index] = el;
                    }}
                    style={headerStyles}
                  >
                    <div className="header-des-wrap">
                      <div className="column-header">
                        {StringManipulator(
                          "TOSENTENCECASE",
                          StringManipulator(
                            "TRUNCATESTRING",
                            t(header?.label),
                            {
                              maxLength: header?.maxLength || 64,
                            }
                          )
                        )}
                        {(header.type === "serialno" ||
                          header.type === "numeric" ||
                          header.type === "description" ||
                          header.type === "text") && isTableSortable && (
                          <span
                            className="sort-icon"
                            onClick={() => handleSort(index)}
                          >
                            {sortedColumnIndex === index ? (
                              sortOrder === "ascending" ? (
                                <CustomSVG.SortDown
                                  fill={"#363636"}
                                  width={"16px"}
                                  height={"16px"}
                                />
                              ) : (
                                <CustomSVG.SortUp
                                  fill={"#363636"}
                                  width={"16px"}
                                  height={"16px"}
                                />
                              )
                            ) : sortOrder === "ascending" ? (
                              <CustomSVG.SortDown
                                fill={"#363636"}
                                width={"16px"}
                                height={"16px"}
                              />
                            ) : (
                              <CustomSVG.SortUp
                                fill={"#363636"}
                                width={"16px"}
                                height={"16px"}
                              />
                            )}
                          </span>
                        )}
                      </div>
                      {header.description && (
                        <div className="column-description">
                          {StringManipulator(
                            "TOSENTENCECASE",
                            StringManipulator(
                              "TRUNCATESTRING",
                              t(header?.description),
                              {
                                maxLength: header?.maxLength || 64,
                              }
                            )
                          )}
                        </div>
                      )}
                    </div>
                  </TableCell>
                ))}
                {scrollableHeader?.map((header, index) => (
                  <TableCell
                    key={index}
                    isHeader={true}
                    className={`scrollable-columns ${
                      withBorder ? "withBorder" : ""
                    } ${
                      withColumnDivider && !withHeaderDivider
                        ? "withColumnDivider"
                        : ""
                    } ${withHeaderDivider ? "withHeaderDivider" : ""}`}
                    style={headerStyles}
                  >
                    <div className="header-des-wrap">
                      <div className="column-header">
                        {StringManipulator(
                          "TOSENTENCECASE",
                          StringManipulator(
                            "TRUNCATESTRING",
                            t(header?.label),
                            {
                              maxLength: header?.maxLength || 64,
                            }
                          )
                        )}
                        {(header.type === "serialno" ||
                          header.type === "numeric" ||
                          header.type === "description" ||
                          header.type === "text") && isTableSortable && (
                          <span
                            className="sort-icon"
                            onClick={() => handleSort(index)}
                          >
                            {sortedColumnIndex === index ? (
                              sortOrder === "ascending" ? (
                                <CustomSVG.SortDown
                                  fill={"#363636"}
                                  width={"16px"}
                                  height={"16px"}
                                />
                              ) : (
                                <CustomSVG.SortUp
                                  fill={"#363636"}
                                  width={"16px"}
                                  height={"16px"}
                                />
                              )
                            ) : sortOrder === "ascending" ? (
                              <CustomSVG.SortDown
                                fill={"#363636"}
                                width={"16px"}
                                height={"16px"}
                              />
                            ) : (
                              <CustomSVG.SortUp
                                fill={"#363636"}
                                width={"16px"}
                                height={"16px"}
                              />
                            )}
                          </span>
                        )}
                      </div>
                      {header.description && (
                        <div className="column-description">
                          {StringManipulator(
                            "TOSENTENCECASE",
                            StringManipulator(
                              "TRUNCATESTRING",
                              t(header?.description),
                              {
                                maxLength: header?.maxLength || 64,
                              }
                            )
                          )}
                        </div>
                      )}
                    </div>
                  </TableCell>
                ))}
              </TableRow>
            </TableHeader>

            {/* Dynamic Table Body with Pagination */}
            <TableBody style={bodyStyles}>
              {currentRows?.map((row, rowIndex) => (
                <TableRow
                  key={rowIndex}
                  className={`${withAlternateBg ? "withAlternateBg" : ""} ${
                    onRowClick ? "addHover" : ""
                  } ${selectedRows?.includes(rowIndex) ? "selected" : ""}`}
                  onClick={
                    onRowClick ? () => onRowClick(row, rowIndex) : undefined
                  }
                >
                  {addCheckbox && (
                    <TableCell
                      isHeader={false}
                      className={`fixed-columns ${
                        withRowDivider ? "withRowDivider" : ""
                      } ${withColumnDivider ? "withColumnDivider" : ""}`}
                      columnType={"custom"}
                      cellData={
                        <CheckBox
                          checked={selectedRows.includes(
                            rowIndex + indexOfFirstRow
                          )}
                          onChange={() =>
                            onSelectRow(rowIndex + indexOfFirstRow)
                          }
                          hideLabel={true}
                          mainClassName={"table-checkbox"}
                        />
                      }
                      style={bodyStyles}
                    ></TableCell>
                  )}
                  {row?.slice(0, frozenColumns)?.map((cell, cellIndex) => (
                    <TableCell
                      key={cellIndex}
                      isHeader={false}
                      isFooter={false}
                      className={`fixed-columns  ${
                        withRowDivider ? "withRowDivider" : ""
                      } ${withColumnDivider ? "withColumnDivider" : ""}`}
                      cellData={cell}
                      columnType={
                        headerData && headerData.length > 0
                          ? headerData[cellIndex]?.type
                          : "custom"
                      }
                      cellref={(el) => {
                        if (!frozenColumnsRefsForRows.current[rowIndex]) {
                          frozenColumnsRefsForRows.current[rowIndex] = [];
                        }
                        frozenColumnsRefsForRows.current[rowIndex][
                          cellIndex
                        ] = el;
                      }}
                      style={bodyStyles}
                    ></TableCell>
                  ))}
                  {row?.slice(frozenColumns)?.map((cell, cellIndex) => (
                    <TableCell
                      key={cellIndex + frozenColumns}
                      isHeader={false}
                      isFooter={false}
                      className={`scrollable-columns  ${
                        withRowDivider ? "withRowDivider" : ""
                      } ${withColumnDivider ? "withColumnDivider" : ""}`}
                      cellData={cell}
                      columnType={headerData[cellIndex + frozenColumns]?.type}
                    ></TableCell>
                  ))}
                </TableRow>
              ))}
            </TableBody>
            {/* Dynamic Table Footer with Pagination */}
          </TableMain>
        </div>
        {!hideFooter && (
          <TableFooter
            className={`digit-table-footer ${
              isStickyFooter || (addStickyFooter && stickyFooterContent)
                ? "sticky-footer"
                : ""
            } `}
          >
            {addStickyFooter && stickyFooterContent && (
              <TableRow
                className={`sticky-footer-content ${
                  scrollableStickyFooterContent ? "scrollable" : ""
                }`}
              >
                <TableCell
                  isHeader={false}
                  isFooter={true}
                  className={`sticker-footer-td ${
                    withBorder ? "withBorder" : ""
                  }`}
                  style={footerStyles}
                >
                  {stickyFooterContent}
                </TableCell>
              </TableRow>
            )}
            <TableRow className={"footer-pagination-content"}>
              <TableCell
                isHeader={false}
                isFooter={true}
                className={`${withBorder ? "withBorder" : ""}`}
                style={footerStyles}
              >
                <div className="footer-content">
                  {footerContent}
                  <div className={"footer-pagination-container"}>
                    <div className="rows-per-page">
                      <label htmlFor="rowsPerPage">
                        {t("CS_COMMON_ROWS_PER_PAGE")}
                        {":"}{" "}
                      </label>
                      <select
                        className="pagination-dropdown"
                        id="rowsPerPage"
                        value={rowsPerPage}
                        onChange={handleRowsPerPageChange}
                      >
                        {rowsPerPageOptions.map((option) => (
                          <option key={option} value={option}>
                            {option}
                          </option>
                        ))}
                      </select>
                    </div>
                    <div>
                      <span>
                        {indexOfFirstRow + 1}-
                        {Math.min(indexOfLastRow, rows?.length)} of{" "}
                        {rows?.length}
                      </span>
                    </div>
                    <div className="pagination">
                      <button
                        onClick={() => handlePageChange(currentPage - 1)}
                        disabled={currentPage === 1}
                      >
                        <SVG.ChevronLeft
                          fill={currentPage === 1 ? "#C5C5C5" : "#363636"}
                        ></SVG.ChevronLeft>
                      </button>
                      <button
                        onClick={() => handlePageChange(currentPage + 1)}
                        disabled={currentPage === totalPages}
                      >
                        <SVG.ChevronRight
                          fill={
                            currentPage === totalPages ? "#C5C5C5" : "#363636"
                          }
                        ></SVG.ChevronRight>
                      </button>
                    </div>
                  </div>
                </div>
              </TableCell>
            </TableRow>
          </TableFooter>
        )}
      </div>
    );
  };

  // Table Card
  return tableTitle || tableDescription || showSelectedState || addFilter ? (
    <Card className={"digit-table-card"}>
      {(tableDescription || tableTitle || addFilter) && (
        <div className="table-header-wrapper">
          <div className="header-filter-wrapper">
            {tableTitle && <div className="table-header">{tableTitle}</div>}
            {addFilter && (
              <CustomSVG.FilterSvg
                fill={"#363636"}
                width={"2rem"}
                height={"2rem"}
                className={"table-filter-svg"}
                onClick={onFilter}
              />
            )}
          </div>
          {tableDescription && (
            <div className="table-description">{tableDescription}</div>
          )}
        </div>
      )}
      {showSelectedState && selectedRows.length > 0 && (
        <div className="selection-state-wrapper">
          <div className="svg-state-wrapper">
            <SVG.DoneAll
              width={"1.5rem"}
              height={"1.5rem"}
              fill={"#C84C0E"}
            ></SVG.DoneAll>
            <div className={"selected-state"}>{`${selectedRows.length} ${t(
              "ROWS_SELECTED"
            )}`}</div>
          </div>
          {actions && actions.length > 0 ? (
            actions
          ) : (
            <Button
              variation="secondary"
              label={actionButtonLabel || t("TakeAction")}
              type="button"
              onClick={() => onSelectedRowsChange(selectedRowsDetails)}
              size={"large"}
            />
          )}
        </div>
      )}
      {renderTable()}
    </Card>
  ) : (
    renderTable()
  );
};

TableMolecule.propTypes = {
};

TableMolecule.defaultProps = {};

export default TableMolecule;
