import 'package:digit_ui_components/constants/AppView.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../atoms/table_cell.dart';

class TableBody extends StatefulWidget {
  final List<DigitTableRow> rows;
  final bool hasFooter;
  final Set<int>? selectedRows;
  final Set<int>? highlightedRows;
  final List<DigitTableColumn> columns;
  final bool withRowDividers;
  final bool alternateRowColor;
  final bool enableBorder;
  final bool withColumnDividers;
  final bool enableSelection;
  final bool headerCheckboxValue;
  final double? tableHeight;
  final List<double>? rowHeights;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? controller;
  final void Function(int, bool) onRowCheckboxChanged;
  final bool expandOnRowClick;
  final List<GlobalKey> keys;
  final bool isFrozen;
  final bool showExpandIconOnHover;
  final double Function(DigitTableColumn)? getColumnWidth;

  const TableBody({
    Key? key,
    required this.rows,
    this.hasFooter = false,
    this.selectedRows,
    this.enableSelection = false,
    this.highlightedRows,
    required this.columns,
    this.withRowDividers = false,
    this.alternateRowColor = false,
    this.enableBorder = false,
    this.tableHeight,
    this.rowHeights,
    this.withColumnDividers = false,
    this.headerCheckboxValue = false,
    this.scrollPhysics,
    this.controller,
    required this.keys,
    this.isFrozen = false,
    required this.onRowCheckboxChanged,
    this.expandOnRowClick = true,
    this.showExpandIconOnHover = false,
    this.getColumnWidth,
  }) : super(key: key);

  @override
  _TableBodyState createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  final Set<int> _hoveredRows = {};
  final Set<int> _selectedRows = {};
  final Set<int> _highlightedRows = {};
  final Set<int> _expandedRows = {};

  @override
  void initState() {
    super.initState();
    if (widget.selectedRows != null) {
      _selectedRows.addAll(widget.selectedRows!);
    }
    if (widget.highlightedRows != null) {
      _highlightedRows.addAll(widget.highlightedRows!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(TableBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedRows != null &&
        widget.selectedRows != oldWidget.selectedRows) {
      _selectedRows.addAll(widget.selectedRows!);
    }
    if (widget.highlightedRows != null &&
        widget.highlightedRows != oldWidget.highlightedRows) {
      _highlightedRows.addAll(widget.highlightedRows!);
    }
  }

  /// Helper to get the width of a column based on screen size
  double _getColumnWidth(DigitTableColumn column) {
    // If a custom width calculator is provided, use it
    if (widget.getColumnWidth != null) {
      return widget.getColumnWidth!(column);
    }
    
    final screenSize = MediaQuery.of(context).size;
    
    // If width is provided, use responsive calculation
    if (column.width != null) {
      if (AppView.isMobileView(screenSize)) {
        // On mobile, reduce width by 30%
        return column.width! * 0.7;
      } else if (AppView.isTabletView(screenSize)) {
        // On tablet, reduce width by 15%
        return column.width! * 0.85;
      } else {
        // On desktop, use full width
        return column.width!;
      }
    }
    
    // Default responsive widths based on column type and screen size
    double baseWidth;
    
    switch (column.type) {
      case ColumnType.checkbox:
      case ColumnType.numeric:
        baseWidth = AppView.isMobileView(screenSize) ? 50 : 
                   AppView.isTabletView(screenSize) ? 70 : 100;
        break;
      case ColumnType.DigitButton:
      case ColumnType.dropDown:
      case ColumnType.textField:
        baseWidth = AppView.isMobileView(screenSize) ? 120 : 
                   AppView.isTabletView(screenSize) ? 150 : 180;
        break;
      case ColumnType.tags:
      case ColumnType.switchs:
        baseWidth = AppView.isMobileView(screenSize) ? 100 : 
                   AppView.isTabletView(screenSize) ? 130 : 160;
        break;
      case ColumnType.description:
        baseWidth = AppView.isMobileView(screenSize) ? 180 : 
                   AppView.isTabletView(screenSize) ? 220 : 280;
        break;
      case ColumnType.text:
      default:
        baseWidth = AppView.isMobileView(screenSize) ? 140 : 
                   AppView.isTabletView(screenSize) ? 170 : 202;
        break;
    }
    
    return baseWidth;
  }
  
  /// Calculate total table width
  double _calculateTableWidth() {
    double totalWidth = 0;
    for (var column in widget.columns) {
      totalWidth += _getColumnWidth(column);
    }
    return totalWidth + 2; // Add 2 for borders
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Early return if no columns or rows
    if (widget.columns.isEmpty || widget.rows.isEmpty) {
      return const SizedBox.shrink();
    }
    
    List<Widget> rowWidgets = [];

    double headerHeight = 52.0;
    double footerHeight = widget.hasFooter ? 64.0 : 0.0;

    for (int i = 0; i < widget.rows.length; i++) {
      // Safely get key and height with bounds check
      final key = i < widget.keys.length ? widget.keys[i] : GlobalKey();
      final height = (widget.rowHeights != null && i < widget.rowHeights!.length) 
          ? widget.rowHeights![i] 
          : null;
      
      rowWidgets.add(
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: widget.enableBorder
                  ? BorderSide(color: theme.colorTheme.generic.divider)
                  : BorderSide.none,
              right: widget.enableBorder
                  ? BorderSide(color: theme.colorTheme.generic.divider)
                  : BorderSide.none,
            ),
          ),
          key: key,
          height: height,
          child: _buildRow(i, key, widget.isFrozen),
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: _calculateTableWidth(),
        // maxHeight: (widget.tableHeight ?? MediaQuery.of(context).size.height) - 2*headerHeight - (footerHeight==0 ? 64 : 2*footerHeight),
        maxHeight: widget.tableHeight != null
            ? widget.tableHeight!
            : (MediaQuery.of(context).size.height -
                2 * headerHeight -
                (footerHeight == 0 ? 64 : 2 * footerHeight)),
      ),
      child: ListView.builder(
        physics: widget.scrollPhysics,
        controller: widget.controller,
        shrinkWrap: true,
        itemCount: rowWidgets.length,
        itemBuilder: (context, index) => rowWidgets[index],
      ),
    );
  }

  // Method to build a single row
  Widget _buildRow(int rowIndex, GlobalKey key, bool isFrozen) {
    final theme = Theme.of(context);
    Color rowColor = widget.alternateRowColor && rowIndex % 2 != 0
        ? theme.colorTheme.paper.secondary
        : theme.colorTheme.paper.primary;

    List<Widget> cells = [];
    
    // Ensure we don't exceed bounds
    final cellCount = widget.rows[rowIndex].tableRow.length;
    final columnCount = widget.columns.length;
    final maxIterations = cellCount < columnCount ? cellCount : columnCount;
    
    for (int j = 0; j < maxIterations; j++) {
      // Safely get column type with bounds check
      ColumnType type = j < widget.columns.length 
          ? widget.columns[j].type 
          : ColumnType.text;
      dynamic value = widget.headerCheckboxValue;

      cells.add(
        Container(
          width: _getColumnWidth(widget.columns[j]),
          decoration: BoxDecoration(
            border: Border(
              right: widget.withColumnDividers &&
                      j != widget.rows[rowIndex].tableRow.length - 1
                  ? BorderSide(color: theme.colorTheme.generic.divider)
                  : BorderSide.none,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.topLeft,
              child: DigitTableCell(
                cellData: widget.rows[rowIndex].tableRow[j],
                type: type,
                value: value,
                areAllRowsSelected: (value) {
                  if (value) {
                    setState(() {
                      _selectedRows.add(rowIndex);
                    });
                  } else {
                    setState(() {
                      _selectedRows.remove(rowIndex);
                    });
                  }

                  widget.onRowCheckboxChanged(rowIndex, value);
                },
              ),
            ),
          ),
        ),
      );
    }

    return InkWell(
      onHover: widget.enableSelection
          ? (hover) {
              setState(() {
                if (hover) {
                  _hoveredRows.add(rowIndex);
                } else {
                  _hoveredRows.remove(rowIndex);
                }
              });
            }
          : null,
      onTap: widget.rows[rowIndex].nestedTable != null
          ? () {
              setState(() {
                if (_expandedRows.contains(rowIndex)) {
                  _expandedRows.remove(rowIndex); // Collapse row
                } else {
                  _expandedRows.add(rowIndex); // Expand row
                }
              });
            }
          : widget.enableSelection
              ? () {
                  setState(() {
                    if (_selectedRows.contains(rowIndex)) {
                      _selectedRows.remove(rowIndex);
                    } else {
                      _selectedRows.add(rowIndex);
                    }
                  });
                }
              : null,
      child: Container(
        decoration: BoxDecoration(
          color: _hoveredRows.contains(rowIndex) ||
                  _selectedRows.contains(rowIndex) ||
                  _highlightedRows.contains(rowIndex)
              ? theme.colorTheme.primary.primaryBg
              : rowColor,
          border: Border(
            bottom: widget.withRowDividers ||
                    (!widget.withRowDividers &&
                        widget.enableBorder &&
                        rowIndex == widget.rows.length - 1)
                ? BorderSide(color: theme.colorTheme.generic.divider)
                : BorderSide.none,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: cells,
                    ),
                    if (widget.showExpandIconOnHover &&
                        widget.rows[rowIndex].nestedTable != null &&
                        _hoveredRows.contains(rowIndex))
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (_expandedRows.contains(rowIndex)) {
                              _expandedRows.remove(rowIndex);
                            } else {
                              _expandedRows.add(rowIndex);
                            }
                          });
                        },
                        child: Icon(
                          _expandedRows.contains(rowIndex)
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: theme.colorTheme.primary.primary1,
                        ),
                      ),
                    if (_selectedRows.contains(rowIndex) &&
                        !widget.showExpandIconOnHover &&
                        widget.rows[rowIndex].nestedTable == null)
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 4,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                            ),
                            color:
                                theme.colorTheme.primary.primary1, // Line color
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (_expandedRows.contains(rowIndex) &&
                widget.rows[rowIndex].nestedTable != null)
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                child: widget
                    .rows[rowIndex].nestedTable!, // Add the nested table widget
              ),
          ],
        ),
      ),
    );
  }
}
