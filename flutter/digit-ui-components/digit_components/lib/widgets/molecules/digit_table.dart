import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/table_container.dart';
import 'package:flutter/material.dart';
import '../atoms/table_body.dart';
import '../atoms/table_cell.dart';
import '../atoms/table_header.dart';
import '../atoms/table_footer.dart';

class CustomTable extends StatefulWidget {
  final List<TableColumn> columns;
  final List<List<CustomColumn>> rows;
  final List<int> rowsPerPageOptions;
  final bool showRowsPerPage;
  final bool withColumnDividers;
  final bool withRowDividers;
  final bool alternateRowColor;
  final bool enableBorder;
  final int frozenColumnsCount; // Add frozen columns count

  const CustomTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.rowsPerPageOptions = const [5, 10, 15, 20],
    this.showRowsPerPage = true,
    this.withColumnDividers = true,
    this.withRowDividers = true,
    this.alternateRowColor = false,
    this.enableBorder = false,
    this.frozenColumnsCount = 1, // Default 1 frozen column
  }) : super(key: key);

  @override
  _CustomTableState createState() => _CustomTableState();
}


class _CustomTableState extends State<CustomTable> {
  int currentPage = 1;
  int rowsPerPage = 5;
  SortOrder? sortOrder;
  int? sortedColumnIndex;
  List<List<CustomColumn>> sortedRows = [];

  @override
  void initState() {
    super.initState();
    sortedRows = List.from(widget.rows);
    for (int i = 0; i < widget.columns.length; i++) {
      if (widget.columns[i].isSortable) {
        sortedColumnIndex = i;
        sortOrder = SortOrder.ascending;
        _sortRows();
        break;
      }
    }
  }

  void _sortRows() {
    if (sortedColumnIndex != null && sortOrder != null) {
      sortedRows.sort((a, b) {
        final columnA = a[sortedColumnIndex!].value;
        final columnB = b[sortedColumnIndex!].value;

        if (columnA is num && columnB is num) {
          return sortOrder == SortOrder.ascending
              ? columnA.compareTo(columnB)
              : columnB.compareTo(columnA);
        } else if (columnA is String && columnB is String) {
          return sortOrder == SortOrder.ascending
              ? columnA.compareTo(columnB)
              : columnB.compareTo(columnA);
        }
        return 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = (sortedRows.length / rowsPerPage).ceil();
    int startIndex = (currentPage - 1) * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    List<List<CustomColumn>> paginatedRows = sortedRows.sublist(
      startIndex,
      endIndex > sortedRows.length ? sortedRows.length : endIndex,
    );

    List<TableColumn> frozenColumns =
    widget.columns.sublist(0, widget.frozenColumnsCount);
    List<TableColumn> scrollableColumns =
    widget.columns.sublist(widget.frozenColumnsCount);

    List<List<CustomColumn>> frozenRows = paginatedRows
        .map((row) => row.sublist(0, widget.frozenColumnsCount))
        .toList();
    List<List<CustomColumn>> scrollableRows = paginatedRows
        .map((row) => row.sublist(widget.frozenColumnsCount))
        .toList();

    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                // Frozen columns section
                SizedBox(
                  width: MediaQuery.of(context).size.width*.4,
                  child: Column(
                    children: [
                      TableHeader(
                        columns: frozenColumns,
                        sortedColumnIndex: sortedColumnIndex,
                        sortOrder: sortOrder,
                        enabledBorder: widget.enableBorder,
                        onSort: (index, order) {
                          setState(() {
                            if (sortedColumnIndex == index) {
                              sortOrder = sortOrder == SortOrder.ascending
                                  ? SortOrder.descending
                                  : SortOrder.ascending;
                            } else {
                              sortedColumnIndex = index;
                              sortOrder = SortOrder.ascending;
                            }
                            _sortRows();
                            currentPage = 1;
                          });
                        },
                        withColumnDividers: widget.withColumnDividers,
                      ),
                      TableBody(
                        rows: frozenRows,
                        alternateRowColor: widget.alternateRowColor,
                        withRowDividers: widget.withRowDividers,
                        enableBorder: widget.enableBorder,
                        withColumnDividers: widget.withColumnDividers,
                      ),
                    ],
                  ),
                ),
                // Scrollable columns section
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TableHeader(
                          columns: scrollableColumns,
                          sortedColumnIndex: sortedColumnIndex,
                          sortOrder: sortOrder,
                          enabledBorder: widget.enableBorder,
                          onSort: (index, order) {
                            setState(() {
                              if (sortedColumnIndex == index) {
                                sortOrder = sortOrder == SortOrder.ascending
                                    ? SortOrder.descending
                                    : SortOrder.ascending;
                              } else {
                                sortedColumnIndex = index;
                                sortOrder = SortOrder.ascending;
                              }
                              _sortRows();
                              currentPage = 1;
                            });
                          },
                          withColumnDividers: widget.withColumnDividers,
                        ),
                        TableBody(
                          rows: scrollableRows,
                          alternateRowColor: widget.alternateRowColor,
                          withRowDividers: widget.withRowDividers,
                          enableBorder: widget.enableBorder,
                          withColumnDividers: widget.withColumnDividers,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TableFooter(
              currentPage: currentPage,
              totalPages: totalPages,
              rowsPerPage: rowsPerPage,
              rowsPerPageOptions: widget.rowsPerPageOptions,
              onRowsPerPageChanged: (value) {
                setState(() {
                  rowsPerPage = value;
                  currentPage = 1;
                });
              },
              onPageChanged: (page) {
                setState(() {
                  currentPage = page;
                });
              },
              onNext: () {
                setState(() {
                  if (currentPage < totalPages) {
                    currentPage++;
                  }
                });
              },
              onPrevious: () {
                setState(() {
                  if (currentPage > 1) {
                    currentPage--;
                  }
                });
              },
              onPageSelected: (page) {
                setState(() {
                  currentPage = page;
                });
              },
              showRowsPerPage: widget.showRowsPerPage,
            ),
          ],
        ),
      ),
    );
  }
}

