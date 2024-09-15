import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/table_container.dart';
import 'package:flutter/material.dart';
import '../atoms/table_body.dart';
import '../atoms/table_cell.dart';
import '../atoms/table_header.dart';
import '../atoms/table_footer.dart';

class CustomTable extends StatefulWidget {
  final List<DigitTableColumn> columns;
  final List<DigitTableRow> rows;
  final List<int> rowsPerPageOptions;
  final bool showRowsPerPage;
  final bool withColumnDividers;
  final bool withRowDividers;
  final bool alternateRowColor;
  final bool enableBorder;
  final bool stickyHeader;
  final int frozenColumnsCount;
  final Widget? customRow;
  final bool isCustomRowFixed;
  // Callback for selected row indices
  final void Function(int)? onSelectedRowsChanged;


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
    this.stickyHeader = false,
    this.frozenColumnsCount = 0,
    this.customRow,
    this.isCustomRowFixed = false,
    this.onSelectedRowsChanged,
  }) : super(key: key);

  @override
  _CustomTableState createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  int currentPage = 1;
  int rowsPerPage = 5;
  SortOrder? sortOrder;
  int? sortedColumnIndex;
  List<DigitTableRow> sortedRows = [];
  List<double> columnWidths = [];
  final List<GlobalKey> headerKeys = [];
  bool _isFrozenColumnsHidden = false;

  // Checkbox state management
  bool _headerCheckboxValue = false;
  bool _headerCheckboxIndeterminate = false; // Added for intermediate state
  late Set<int> _selectedRowIndices;
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;


  @override
  void initState() {
    super.initState();
    sortedRows = widget.rows;
    _selectedRowIndices = Set<int>();

    // Listen to scroll events
    _scrollController.addListener(_onScroll);

    headerKeys.addAll(List.generate(widget.columns.length, (_) => GlobalKey()));
    for (int i = 0; i < widget.columns.length; i++) {
      if (widget.columns[i].isSortable) {
        sortedColumnIndex = i;
        sortOrder = SortOrder.ascending;
        _sortRows();
        break;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double scrollOffset = _scrollController.offset;

    // Check if the frozen columns are hidden
    setState(() {
      _isFrozenColumnsHidden = scrollOffset > _getFrozenWidth();
    });
  }

  double _getFrozenWidth() {
    List<DigitTableColumn> frozenColumns = _getFrozenColumns();
    return frozenColumns.fold(0, (sum, column) => sum + 200);
  }

  void _measureHeaderWidths() {
    columnWidths.clear();
    for (var key in headerKeys) {
      final context = key.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox;
        columnWidths.add(renderBox.size.width);
      }
    }
    setState(() {});
  }

  void _sortRows() {
    if (sortedColumnIndex != null && sortOrder != null) {
      sortedRows.sort((a, b) {
        final columnA = a.tableRow[sortedColumnIndex!].label;
        final columnB = b.tableRow[sortedColumnIndex!].label;

        return sortOrder == SortOrder.ascending
            ? columnA.compareTo(columnB)
            : columnB.compareTo(columnA);
      });
    }
  }

  List<DigitTableColumn> _getFrozenColumns() {
    return widget.columns.where((column) => column.isFrozen).toList();
  }

  Widget _buildFrozenColumns(double scrollOffset, BuildContext context) {

    final theme = Theme.of(context);

    // Only build frozen columns when they are hidden (out of viewport)
    if (!_isFrozenColumnsHidden) {
      return SizedBox(); // Return an empty widget if the columns are visible
    }

    List<DigitTableColumn> frozenColumns = _getFrozenColumns();

    // Define frozen column width (adjust as necessary)
    double frozenWidth = frozenColumns.fold(0, (sum, column) => sum + 202); // Assuming each frozen column is 100px wide

    return Positioned(
      top: 0,
      left: scrollOffset,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: theme.colorTheme.text.disabled, spreadRadius: 0, blurRadius: 1, offset: const Offset(1, 0))],
        ),
        width: frozenWidth,
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
              headerCheckboxValue: _headerCheckboxValue,
              headerCheckboxIndeterminate: _headerCheckboxIndeterminate,
              onHeaderCheckboxChanged: _onHeaderCheckboxChanged,
            ),
            TableBody(
              rows: sortedRows.map((row) {
                // Filter cells for the current row that match the frozen columns
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
                print('sdfjsldkfjsdlkf');
                // Trigger the callback if it's provided
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
    print('updating');
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

  @override
  Widget build(BuildContext context) {
    int totalPages = (sortedRows.length / rowsPerPage).ceil();
    int startIndex = (currentPage - 1) * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;
    List<DigitTableRow> paginatedRows = sortedRows.sublist(
      startIndex,
      endIndex > sortedRows.length ? sortedRows.length : endIndex,
    );

    // Update header checkbox based on selected rows
    _updateHeaderCheckbox();

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
             // width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  if (!widget.stickyHeader)
                    TableHeader(
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
                ],
              ),
            ),
          ),
        ),
        _buildFrozenColumns(_scrollOffset, context),
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
            child: TableHeader(
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
      ],
    );
  }
}
