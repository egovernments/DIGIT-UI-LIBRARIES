import 'dart:math';

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/table_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:horizontal_data_table/scroll/linked_scroll_controller/linked_scroll_controller.dart';
import '../atoms/table_body.dart';
import '../atoms/table_cell.dart';
import '../atoms/table_header.dart';
import '../atoms/table_footer.dart';

class DigitTable extends StatefulWidget {
  final List<DigitTableColumn> columns;
  final List<DigitTableRow> rows;
  final List<int> selectedRows;
  final List<int> highlightedRows;
  final List<int> rowsPerPageOptions;
  final bool showRowsPerPage;
  final bool withColumnDividers;
  final bool withRowDividers;
  final bool showPagination;
  final bool alternateRowColor;
  final bool enableBorder;
  final bool stickyHeader;
  final bool stickyFooter;
  final int frozenColumnsCount;
  final Widget? customRow;
  final bool isCustomRowFixed;
  final bool showSelectedState;
  final ScrollPhysics? scrollPhysics;
  final ScrollPhysics? scrollPhysicsForPagination;
  final double? tableHeight;
  final double? tableWidth;
  // Callback for selected row indices
  final void Function(int)? onSelectedRowsChanged;
  final bool expandOnRowClick;
  final bool showExpandIconOnHover;

  const DigitTable({
    Key? key,
    required this.columns,
    required this.rows,
    this.scrollPhysicsForPagination,
    this.selectedRows = const [],
    this.highlightedRows = const [],
    this.rowsPerPageOptions = const [5, 10, 15, 20],
    this.showRowsPerPage = true,
    this.showPagination = true,
    this.showSelectedState = true,
    this.withColumnDividers = false,
    this.withRowDividers = true,
    this.alternateRowColor = false,
    this.enableBorder = false,
    this.stickyHeader = false,
    this.stickyFooter = false,
    this.frozenColumnsCount = 0,
    this.customRow,
    this.tableHeight,
    this.tableWidth,
    this.scrollPhysics,
    this.isCustomRowFixed = false,
    this.onSelectedRowsChanged,
    this.expandOnRowClick = true,
    this.showExpandIconOnHover = false,
  }) : super(key: key);

  @override
  _DigitTableState createState() => _DigitTableState();
}

class _DigitTableState extends State<DigitTable> {
  int currentPage = 1;
  int rowsPerPage = 5;
  SortOrder? sortOrder;
  int? sortedColumnIndex;
  List<DigitTableRow> sortedRows = [];
  List<double> columnWidths = [];
  final List<GlobalKey> headerKeys = [];
  bool _isFrozenColumnsHidden = false;
  List<double> rowHeights = [];
  List<GlobalKey> frozenKeys = [];
  List<GlobalKey> nonFrozenKeys = [];

  // Checkbox state management
  bool _headerCheckboxValue = false;
  bool _headerCheckboxIndeterminate = false; // Added for intermediate state
  late Set<int> _selectedRowIndices = Set<int>();
  late Set<int> _highlightedRowIndices = Set<int>();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _isOverflowing = false;
  bool _isOverflowingVertical = false;
  bool firstBuild = false;

  late final LinkedScrollControllerGroup _linkedScrollGroup;
  late final ScrollController _nonFrozenScrollController;
  late final ScrollController _frozenScrollController;


  @override
  void initState() {
    super.initState();
    sortedRows = widget.rows;
    _selectedRowIndices = Set<int>();

    // Initialize keys for each row

    frozenKeys = List.generate(widget.rows.length, (_) => GlobalKey());

    nonFrozenKeys = List.generate(widget.rows.length, (_) => GlobalKey());

    // Initialize row heights to zero
    rowHeights = List.filled(widget.rows.length, 0.0);

    // Initialize linked scroll controllers
    _linkedScrollGroup = LinkedScrollControllerGroup();
    _nonFrozenScrollController = _linkedScrollGroup.addAndGet();
    _frozenScrollController = _linkedScrollGroup.addAndGet();


    if(widget.selectedRows.isNotEmpty) {
      _selectedRowIndices = widget.selectedRows.toSet();
    }

    if(widget.highlightedRows.isNotEmpty) {
      _highlightedRowIndices = widget.highlightedRows.toSet();
    }

    // Listen to scroll events
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // Prevent setState if disposed
      _updateRowHeights();
    });
  }

  // Method to update row heights after rendering
  void _updateRowHeights() {
      if (!mounted) return; // Prevent setState if disposed

      for (int index = 0; index < frozenKeys.length; index++) {
        final frozenContext = frozenKeys[index].currentContext;
        final nonFrozenContext = nonFrozenKeys[index].currentContext;

        if (frozenContext == null || nonFrozenContext == null) continue;

        final RenderBox? frozenBox = frozenContext.findRenderObject() as RenderBox?;
        final RenderBox? nonFrozenBox = nonFrozenContext.findRenderObject() as RenderBox?;

        double frozenHeight = frozenBox?.size.height ?? 0;
        double nonFrozenHeight = nonFrozenBox?.size.height ?? 0;
        double maxHeight = max(frozenHeight, nonFrozenHeight);

        // Check if index is within bounds
        if (index >= rowHeights.length) {
          rowHeights.add(maxHeight);
        } else {
          if (mounted && rowHeights[index] != maxHeight) {
            setState(() {
              rowHeights[index] = maxHeight;
            });
          }
        }
      }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(DigitTable oldWidget) {
    super.didUpdateWidget(oldWidget);


    if (widget.selectedRows != oldWidget.selectedRows) {
      _selectedRowIndices.addAll(widget.selectedRows);
    }

    if (widget.highlightedRows != oldWidget.highlightedRows) {
      _highlightedRowIndices.addAll(widget.highlightedRows);
    }

    if(widget.rows != oldWidget.rows) {
      sortedRows = widget.rows;
    }

    if (widget.rows != oldWidget.rows) {
      sortedRows = widget.rows;

      // Update rowHeights and keys when row count changes
      final newRowCount = widget.rows.length;
      if (newRowCount != rowHeights.length) {
        rowHeights = List.filled(newRowCount, 0.0);
        frozenKeys = List.generate(newRowCount, (_) => GlobalKey());
        nonFrozenKeys = List.generate(newRowCount, (_) => GlobalKey());
      } else {
        // Reset heights if rows change but count remains the same
        rowHeights = List.filled(newRowCount, 0.0);
      }
       _updateRowHeights();
    }

  }

  @override
  void dispose() {
    _nonFrozenScrollController.dispose();
    _frozenScrollController.dispose();
    _scrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double scrollOffset = _scrollController.offset;
    // Check if the frozen columns are hidden
    setState(() {
      _isFrozenColumnsHidden = _getColumnsToFreeze(scrollOffset).isEmpty;
    });
  }

  void _sortRows() {
    if (sortedColumnIndex != null && sortOrder != null) {
      sortedRows.sort((a, b) {
        final columnA = a.tableRow[sortedColumnIndex!].label;
        final columnB = b.tableRow[sortedColumnIndex!].label;

        // Function to extract the numeric part of a string, if it exists
        int extractNumber(String str) {
          // Use a regular expression to find a number in the string
          final match = RegExp(r'\d+').firstMatch(str);
          return match != null ? int.parse(match.group(0)!) : -1; // return -1 if no number
        }

        final numA = extractNumber(columnA);
        final numB = extractNumber(columnB);

        // If both contain numbers, compare the numbers
        if (numA != -1 && numB != -1) {
          return sortOrder == SortOrder.ascending
              ? numA.compareTo(numB)
              : numB.compareTo(numA);
        }

        // Fallback to lexicographical comparison for strings
        return sortOrder == SortOrder.ascending
            ? columnA.compareTo(columnB)
            : columnB.compareTo(columnA);
      });
    }
  }

  Widget _buildFrozenColumns(double scrollOffset, BuildContext context, List<DigitTableRow> row, bool isOverflowing) {

    final theme = Theme.of(context);

    // If frozen columns should not be hidden, return an empty widget
    if (_isFrozenColumnsHidden) {
      return const SizedBox(); // No frozen columns are hidden
    }

    // Find the columns that need to be frozen based on scroll offset
    List<DigitTableColumn> frozenColumns = _getColumnsToFreeze(scrollOffset);

    // Define frozen column width based on the columns to be frozen
    double frozenWidth = frozenColumns.fold(0, (sum, column) => sum + _getColumnWidth(column));
    return Positioned(
      top: 0,
      left: scrollOffset,
      bottom: widget.stickyFooter ? 64 : 0,
      child: Container(
        margin: _isOverflowing ? const EdgeInsets.only(bottom: 12) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: theme.colorTheme.generic.transparent,
          boxShadow: [BoxShadow(color: theme.colorTheme.text.disabled, spreadRadius: 0, blurRadius: 1, offset: const Offset(1, 0))],
        ),
        width: frozenWidth,
        child: Column(
          children: [
            TableHeader(
              withRowDividers: widget.withRowDividers,
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
              headerCheckboxValue: _headerCheckboxValue,
              headerCheckboxIndeterminate: _headerCheckboxIndeterminate,
              onHeaderCheckboxChanged: _onHeaderCheckboxChanged,
            ),
            TableBody(
              keys: frozenKeys,
              rowHeights: rowHeights,
              isFrozen: true,
              controller: _frozenScrollController,
              tableHeight: widget.tableHeight,
              enableSelection: widget.showSelectedState,
              highlightedRows: _highlightedRowIndices,
              selectedRows: _selectedRowIndices,
              hasFooter: widget.showPagination,
              rows: row.map((row) {
                /// Filter cells for the current row that match the frozen columns
                List<DigitTableData> filteredCells = row.tableRow.where((cell) {
                  return frozenColumns.any((column) => column.cellValue == cell.cellKey);
                }).toList();

                return DigitTableRow(tableRow: filteredCells);
              }).toList(),
              columns: frozenColumns,
              alternateRowColor: widget.alternateRowColor,
              withRowDividers: widget.withRowDividers,
              enableBorder: widget.enableBorder,
              withColumnDividers: widget.withColumnDividers,
              headerCheckboxValue: _headerCheckboxValue,
              onRowCheckboxChanged: (rowIndex, isSelected) {
                setState(() {
                  if (isSelected) {
                    _selectedRowIndices.add(rowIndex);
                  } else {
                    _selectedRowIndices.remove(rowIndex);
                  }
                  _updateHeaderCheckbox();
                });
                if (widget.onSelectedRowsChanged != null) {
                  widget.onSelectedRowsChanged!(_selectedRowIndices.length);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Get the list of columns that need to be frozen based on the scroll offset
  List<DigitTableColumn> _getColumnsToFreeze(double scrollOffset) {
    List<DigitTableColumn> frozenColumns = [];

    // Loop through all columns and freeze those that have scrolled out of view
    double cumulativeWidth = 0;
    for (int i = 0; i < widget.columns.length; i++) {
      DigitTableColumn column = widget.columns[i];
      double columnWidth = _getColumnWidth(column);

      // If the cumulative width of the columns is less than the scroll offset,
      // it means the column has scrolled out of view and should be frozen
      if ( scrollOffset >cumulativeWidth || widget.columns[i].isFrozen) {
        frozenColumns.add(column);
      }
      cumulativeWidth += columnWidth;
    }
    return frozenColumns;
  }

  /// Helper to get the width of a column
  double _getColumnWidth(DigitTableColumn column) {
    return column.width ?? 202.0;
  }

  void _onHeaderCheckboxChanged(bool? newValue) {
    setState(() {
      if (newValue == true) {
        _selectedRowIndices = Set<int>.from(sortedRows.asMap().keys);
      } else {
        _selectedRowIndices.clear();
      }
      _updateHeaderCheckbox();
    });
  }

  void _updateHeaderCheckbox() {
    final selectedCount = _selectedRowIndices.length;
    final totalRows = sortedRows.length;

    if (selectedCount == 0) {
      _headerCheckboxValue = false;
      _headerCheckboxIndeterminate = false;
    } else if (selectedCount == totalRows) {
      _headerCheckboxValue = true;
      _headerCheckboxIndeterminate = false;
    } else {
      _headerCheckboxValue = false;
      _headerCheckboxIndeterminate = true;
    }
  }

  // Method to count how many checkbox or numeric columns exist
  int _countSpecialColumns() {
    int count = 0;
    for (var column in widget.columns) {
      if (column.type == ColumnType.checkbox || column.type == ColumnType.numeric) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    // Get the count of checkbox and numeric columns
    int specialColumnCount = _countSpecialColumns();

    int normalColumns = widget.columns.length - specialColumnCount;

    int totalPages = (sortedRows.length / rowsPerPage).ceil();
    int startIndex = (currentPage - 1) * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    List<DigitTableRow> paginatedRows = sortedRows.sublist(
      startIndex,
      endIndex > sortedRows.length ? sortedRows.length : endIndex,
    );

    // Update header checkbox based on selected rows
    // _updateHeaderCheckbox();

    if (!firstBuild) {
      firstBuild = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (_scrollController.hasClients) {
            _isOverflowing = (_scrollController.position.maxScrollExtent > 0);
          }
          if (_verticalScrollController.hasClients) {
            _isOverflowingVertical = (_scrollController.position.maxScrollExtent > 0);
          }
        });
      });
    }

    return SizedBox(
      height: widget.tableHeight,
      width: widget.tableWidth,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: widget.stickyHeader ? 52 : 0, bottom: widget.stickyFooter ? 64 : 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: _isOverflowing,
                      child: SingleChildScrollView(
                        padding: _isOverflowing ? const EdgeInsets.only(bottom: 12) : EdgeInsets.zero,
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!widget.stickyHeader)
                                TableHeader(
                                  withRowDividers: widget.withRowDividers,
                                  columns: widget.columns,
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
                                  headerCheckboxValue: _headerCheckboxValue,
                                  headerCheckboxIndeterminate: _headerCheckboxIndeterminate, // Pass down
                                  onHeaderCheckboxChanged: _onHeaderCheckboxChanged,
                                ),
                              TableBody(
                                keys: nonFrozenKeys,
                                controller: _nonFrozenScrollController,
                                tableHeight: widget.tableHeight!=null ? widget.tableHeight! - 48 : null,
                                scrollPhysics: widget.scrollPhysicsForPagination,
                                enableSelection: widget.showSelectedState,
                                highlightedRows: _highlightedRowIndices,
                                selectedRows: _selectedRowIndices,
                                hasFooter: widget.showPagination,
                                rows: widget.showPagination ? paginatedRows: sortedRows,
                                columns: widget.columns,
                                alternateRowColor: widget.alternateRowColor,
                                withRowDividers: widget.withRowDividers,
                                enableBorder: widget.enableBorder,
                                withColumnDividers: widget.withColumnDividers,
                                headerCheckboxValue: _headerCheckboxValue,
                                onRowCheckboxChanged: (rowIndex, isSelected) {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedRowIndices.add(rowIndex);
                                    } else {
                                      _selectedRowIndices.remove(rowIndex);
                                    }
                                    _updateHeaderCheckbox();
                                  });
                                  if (widget.onSelectedRowsChanged != null) {
                                    widget.onSelectedRowsChanged!(_selectedRowIndices.length);
                                  }
                                },
                                expandOnRowClick: widget.expandOnRowClick,
                                showExpandIconOnHover: widget.showExpandIconOnHover,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _buildFrozenColumns(_scrollOffset, context, widget.showPagination ? paginatedRows: sortedRows, _isOverflowing),
                  ],
                ),
                if (widget.customRow != null && !widget.isCustomRowFixed)
                  Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const DigitColors().light.genericDivider,
                        ),
                        color: const DigitColors().light.paperPrimary,
                      ),
                      child: widget.customRow!),
                if(widget.showPagination && !widget.stickyFooter)
                  TableFooter(
                    enableBorder: widget.enableBorder,
                    width: normalColumns * 200 + specialColumnCount * 100+2,
                    currentPage: currentPage,
                    totalPages: totalPages,
                    rowsPerPage: rowsPerPage,
                    rowsPerPageOptions: widget.rowsPerPageOptions,
                    onRowsPerPageChanged: (value) {
                      setState(() {
                        rowsPerPage = value;
                        currentPage =
                        1; // Reset to the first page when rows per page changes
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
          if (widget.customRow != null && widget.isCustomRowFixed)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const DigitColors().light.genericDivider,
                    ),
                    color: const DigitColors().light.paperPrimary,
                  ),
                  child: widget.customRow!),
            ),
          if ( widget.stickyHeader)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TableHeader(
                withRowDividers: widget.withRowDividers,
                columns: widget.columns,
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
                headerCheckboxValue: _headerCheckboxValue,
                headerCheckboxIndeterminate: _headerCheckboxIndeterminate, // Pass down
                onHeaderCheckboxChanged: _onHeaderCheckboxChanged,
              ),
            ),
          if (widget.showPagination && widget.stickyFooter)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TableFooter(
                enableBorder: widget.enableBorder,
                width: normalColumns * 200 + specialColumnCount * 100+2,
                currentPage: currentPage,
                totalPages: totalPages,
                rowsPerPage: rowsPerPage,
                rowsPerPageOptions: widget.rowsPerPageOptions,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    rowsPerPage = value;
                    currentPage =
                    1; // Reset to the first page when rows per page changes
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
            ),
        ],
      ),
    );
  }
}