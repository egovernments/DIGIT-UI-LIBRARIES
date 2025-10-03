import 'dart:async';
import 'dart:math';

import 'package:digit_ui_components/constants/AppView.dart';
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
  
  // Cache for column widths to avoid recalculation
  late Map<String, double> _columnWidthCache;
  
  // Optimized frozen column state
  List<DigitTableColumn> _frozenColumns = [];
  double _frozenWidth = 0;
  bool _showFrozenColumns = false;
  
  // Row height management - simplified
  List<double> rowHeights = [];
  List<GlobalKey> frozenKeys = [];
  List<GlobalKey> nonFrozenKeys = [];
  
  /// Calculate total table width based on column widths
  double _calculateTableWidth() {
    double totalWidth = 0;
    for (var column in widget.columns) {
      totalWidth += _getColumnWidth(column);
    }
    return totalWidth + 2; // Add 2 for borders
  }

  // Checkbox state management
  bool _headerCheckboxValue = false;
  bool _headerCheckboxIndeterminate = false;
  late Set<int> _selectedRowIndices = Set<int>();
  late Set<int> _highlightedRowIndices = Set<int>();
  
  // Scroll controllers - simplified
  final ScrollController _horizontalScrollController = ScrollController();
  late final LinkedScrollControllerGroup _linkedScrollGroup;
  late final ScrollController _nonFrozenScrollController;
  late final ScrollController _frozenScrollController;
  
  // Performance flags
  bool _isOverflowing = false;
  bool _needsRebuild = false;
  Timer? _scrollDebounce;


  @override
  void initState() {
    super.initState();
    sortedRows = widget.rows;
    _selectedRowIndices = Set<int>();
    _columnWidthCache = {};
    
    // Initialize keys only if needed for frozen columns
    final validFrozenCount = widget.frozenColumnsCount.clamp(0, widget.columns.length);
    if (validFrozenCount > 0 && widget.rows.isNotEmpty) {
      frozenKeys = List.generate(widget.rows.length, (_) => GlobalKey());
      nonFrozenKeys = List.generate(widget.rows.length, (_) => GlobalKey());
      rowHeights = List.filled(widget.rows.length, 52.0); // Default height
    } else {
      frozenKeys = [];
      nonFrozenKeys = [];
      rowHeights = [];
    }
    
    // Initialize linked scroll controllers for frozen columns
    _linkedScrollGroup = LinkedScrollControllerGroup();
    _nonFrozenScrollController = _linkedScrollGroup.addAndGet();
    _frozenScrollController = _linkedScrollGroup.addAndGet();
    
    if(widget.selectedRows.isNotEmpty) {
      _selectedRowIndices = widget.selectedRows.toSet();
    }
    
    if(widget.highlightedRows.isNotEmpty) {
      _highlightedRowIndices = widget.highlightedRows.toSet();
    }
    
    // Calculate frozen columns once
    _updateFrozenColumns();
    
    // Listen to scroll events with debouncing
    _horizontalScrollController.addListener(_onScrollDebounced);
  }

  // Calculate frozen columns once instead of on every scroll
  void _updateFrozenColumns() {
    // Ensure frozen count doesn't exceed actual columns
    final validFrozenCount = widget.frozenColumnsCount.clamp(0, widget.columns.length);
    
    if (validFrozenCount > 0 && widget.columns.isNotEmpty) {
      _frozenColumns = widget.columns.take(validFrozenCount).toList();
      _frozenWidth = _frozenColumns.fold(0, (sum, col) => sum + _getColumnWidth(col));
      _showFrozenColumns = true;
    } else {
      _frozenColumns = [];
      _frozenWidth = 0;
      _showFrozenColumns = false;
    }
  }
  
  // Debounced scroll handler for better performance
  void _onScrollDebounced() {
    _scrollDebounce?.cancel();
    _scrollDebounce = Timer(const Duration(milliseconds: 10), () {
      if (mounted && _horizontalScrollController.hasClients) {
        final offset = _horizontalScrollController.offset;
        if (offset > 10 && widget.frozenColumnsCount > 0) {
          if (!_showFrozenColumns) {
            setState(() => _showFrozenColumns = true);
          }
        } else {
          if (_showFrozenColumns && widget.frozenColumnsCount == 0) {
            setState(() => _showFrozenColumns = false);
          }
        }
      }
    });
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
      // Update keys only if using frozen columns
      final validFrozenCount = widget.frozenColumnsCount.clamp(0, widget.columns.length);
      if (validFrozenCount > 0 && widget.rows.isNotEmpty) {
        final newRowCount = widget.rows.length;
        rowHeights = List.filled(newRowCount, 52.0);
        frozenKeys = List.generate(newRowCount, (_) => GlobalKey());
        nonFrozenKeys = List.generate(newRowCount, (_) => GlobalKey());
      } else {
        frozenKeys = [];
        nonFrozenKeys = [];
        rowHeights = [];
      }
    }
    
    if (widget.frozenColumnsCount != oldWidget.frozenColumnsCount || 
        widget.columns.length != oldWidget.columns.length) {
      _updateFrozenColumns();
      _columnWidthCache.clear(); // Clear cache when config changes
    }
  }

  @override
  void dispose() {
    _scrollDebounce?.cancel();
    _nonFrozenScrollController.dispose();
    _frozenScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  // Removed _onScroll method - using debounced version instead

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

  Widget _buildFrozenColumns(BuildContext context, List<DigitTableRow> rows) {
    final theme = Theme.of(context);
    
    // If no frozen columns or not scrolled, return empty
    if (!_showFrozenColumns || _frozenColumns.isEmpty) {
      return const SizedBox.shrink();
    }
    return Positioned(
      top: 0,
      left: 0,
      bottom: widget.stickyFooter ? 64 : 0,
      child: Container(
        margin: _isOverflowing ? const EdgeInsets.only(bottom: 12) : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: theme.colorTheme.paper.primary,
          boxShadow: [BoxShadow(
            color: theme.colorTheme.text.disabled.withOpacity(0.2), 
            spreadRadius: 0, 
            blurRadius: 2, 
            offset: const Offset(2, 0)
          )],
        ),
        width: _frozenWidth,
        child: Column(
          children: [
            TableHeader(
              withRowDividers: widget.withRowDividers,
              columns: _frozenColumns,
              sortedColumnIndex: sortedColumnIndex,
              sortOrder: sortOrder,
              enabledBorder: widget.enableBorder,
              getColumnWidth: _getColumnWidth,
              onSort: _handleSort,
              withColumnDividers: widget.withColumnDividers,
              headerCheckboxValue: _headerCheckboxValue,
              headerCheckboxIndeterminate: _headerCheckboxIndeterminate,
              onHeaderCheckboxChanged: _onHeaderCheckboxChanged,
            ),
            if (_frozenColumns.isNotEmpty && rows.isNotEmpty)
              TableBody(
                keys: frozenKeys.isNotEmpty ? frozenKeys : List.generate(rows.length, (_) => GlobalKey()),
                rowHeights: rowHeights.isNotEmpty ? rowHeights : null,
                isFrozen: true,
                controller: _frozenScrollController,
                tableHeight: widget.tableHeight,
                enableSelection: widget.showSelectedState,
                highlightedRows: _highlightedRowIndices,
                selectedRows: _selectedRowIndices,
                hasFooter: widget.showPagination,
                getColumnWidth: _getColumnWidth,
                rows: rows.map((row) {
                  // Take only the frozen column cells, ensure we don't exceed available cells
                  final cellCount = row.tableRow.length.clamp(0, _frozenColumns.length);
                  List<DigitTableData> frozenCells = cellCount > 0 
                      ? row.tableRow.take(cellCount).toList()
                      : [];
                  return DigitTableRow(tableRow: frozenCells);
                }).toList(),
                columns: _frozenColumns,
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

  // Removed _getColumnsToFreeze - now using pre-calculated _frozenColumns

  /// Helper to get the width of a column with caching
  double _getColumnWidth(DigitTableColumn column) {
    // Use cache key based on column header and type
    final cacheKey = '${column.header}_${column.type}';
    
    // Return cached value if exists
    if (_columnWidthCache.containsKey(cacheKey)) {
      return _columnWidthCache[cacheKey]!;
    }
    
    final screenSize = MediaQuery.of(context).size;
    double width;
    
    // If width is provided, use responsive calculation
    if (column.width != null) {
      if (AppView.isMobileView(screenSize)) {
        width = column.width! * 0.7;
      } else if (AppView.isTabletView(screenSize)) {
        width = column.width! * 0.85;
      } else {
        width = column.width!;
      }
    } else {
      // Default responsive widths based on column type
      switch (column.type) {
        case ColumnType.checkbox:
        case ColumnType.numeric:
          width = AppView.isMobileView(screenSize) ? 50 : 
                 AppView.isTabletView(screenSize) ? 70 : 100;
          break;
        case ColumnType.DigitButton:
        case ColumnType.dropDown:
        case ColumnType.textField:
          width = AppView.isMobileView(screenSize) ? 120 : 
                 AppView.isTabletView(screenSize) ? 150 : 180;
          break;
        case ColumnType.tags:
        case ColumnType.switchs:
          width = AppView.isMobileView(screenSize) ? 100 : 
                 AppView.isTabletView(screenSize) ? 130 : 160;
          break;
        case ColumnType.description:
          width = AppView.isMobileView(screenSize) ? 180 : 
                 AppView.isTabletView(screenSize) ? 220 : 280;
          break;
        case ColumnType.text:
        default:
          width = AppView.isMobileView(screenSize) ? 140 : 
                 AppView.isTabletView(screenSize) ? 170 : 202;
          break;
      }
    }
    
    // Cache the calculated width
    _columnWidthCache[cacheKey] = width;
    return width;
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


  // Extract pagination logic
  List<DigitTableRow> _getPaginatedRows() {
    if (!widget.showPagination) return sortedRows;
    
    int startIndex = (currentPage - 1) * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    return sortedRows.sublist(
      startIndex,
      endIndex > sortedRows.length ? sortedRows.length : endIndex,
    );
  }
  
  // Build table header widget
  Widget _buildTableHeader() {
    return TableHeader(
      withRowDividers: widget.withRowDividers,
      columns: widget.columns,
      sortedColumnIndex: sortedColumnIndex,
      sortOrder: sortOrder,
      enabledBorder: widget.enableBorder,
      getColumnWidth: _getColumnWidth,
      onSort: _handleSort,
      withColumnDividers: widget.withColumnDividers,
      headerCheckboxValue: _headerCheckboxValue,
      headerCheckboxIndeterminate: _headerCheckboxIndeterminate,
      onHeaderCheckboxChanged: _onHeaderCheckboxChanged,
    );
  }
  
  // Handle sort action
  void _handleSort(int index, SortOrder order) {
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
  }
  
  // Build table footer widget
  Widget _buildTableFooter(int totalPages) {
    return TableFooter(
      enableBorder: widget.enableBorder,
      width: _calculateTableWidth(),
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
        setState(() => currentPage = page);
      },
      onNext: () {
        if (currentPage < totalPages) {
          setState(() => currentPage++);
        }
      },
      onPrevious: () {
        if (currentPage > 1) {
          setState(() => currentPage--);
        }
      },
      onPageSelected: (page) {
        setState(() => currentPage = page);
      },
      showRowsPerPage: widget.showRowsPerPage,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    // Early return if no columns or rows
    if (widget.columns.isEmpty) {
      return const Center(
        child: Text('No columns configured'),
      );
    }
    
    final paginatedRows = _getPaginatedRows();
    final totalPages = sortedRows.isEmpty ? 1 : (sortedRows.length / rowsPerPage).ceil();
    
    // Update header checkbox based on selected rows
    _updateHeaderCheckbox();

    // Check overflow once after first build
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (mounted && _horizontalScrollController.hasClients) {
        final hasOverflow = _horizontalScrollController.position.maxScrollExtent > 0;
        if (hasOverflow != _isOverflowing) {
          setState(() => _isOverflowing = hasOverflow);
        }
      }
    });

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
                      controller: _horizontalScrollController,
                      thumbVisibility: _isOverflowing,
                      child: SingleChildScrollView(
                        padding: _isOverflowing ? const EdgeInsets.only(bottom: 12) : EdgeInsets.zero,
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!widget.stickyHeader) _buildTableHeader(),
                              TableBody(
                                keys: nonFrozenKeys.isNotEmpty ? nonFrozenKeys : List.generate(paginatedRows.length, (_) => GlobalKey()),
                                controller: _nonFrozenScrollController,
                                tableHeight: widget.tableHeight!=null ? widget.tableHeight! - 48 : null,
                                scrollPhysics: widget.scrollPhysicsForPagination,
                                enableSelection: widget.showSelectedState,
                                highlightedRows: _highlightedRowIndices,
                                selectedRows: _selectedRowIndices,
                                hasFooter: widget.showPagination,
                                getColumnWidth: _getColumnWidth,
                                rows: paginatedRows,
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
                    if (widget.frozenColumnsCount > 0)
                      _buildFrozenColumns(context, paginatedRows),
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
                  _buildTableFooter(totalPages),
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
          if (widget.stickyHeader)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildTableHeader(),
            ),
          if (widget.showPagination && widget.stickyFooter)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildTableFooter(totalPages),
            ),
        ],
      ),
    );
  }
}
