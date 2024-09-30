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
    if (widget.selectedRows != null && widget.selectedRows != oldWidget.selectedRows) {
      _selectedRows.addAll(widget.selectedRows!);
    }
    if (widget.highlightedRows != null && widget.highlightedRows != oldWidget.highlightedRows) {
      _highlightedRows.addAll(widget.highlightedRows!);
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
    final theme = Theme.of(context);
    List<Widget> rowWidgets = [];

    // Get the count of checkbox and numeric columns
    int specialColumnCount = _countSpecialColumns();
    int normalColumns = widget.columns.length - specialColumnCount;

    double headerHeight = 52.0;
    double footerHeight = widget.hasFooter ? 64.0 : 0.0;

    for (int i = 0; i < widget.rows.length; i++) {
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
          key: widget.keys[i],
          height: widget.rowHeights?[i],
          child: _buildRow(i, widget.keys[i], widget.isFrozen),
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: normalColumns * 200 + specialColumnCount * 100 + 2,
        maxHeight: (widget.tableHeight ?? MediaQuery.of(context).size.height) - 2*headerHeight - (footerHeight==0 ? 64 : 2*footerHeight),
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
    for (int j = 0; j < widget.rows[rowIndex].tableRow.length; j++) {
      ColumnType type = widget.columns[j].type;
      dynamic value = widget.headerCheckboxValue;

      cells.add(
        Container(
          constraints: BoxConstraints(
            minWidth: (type == ColumnType.numeric || type == ColumnType.checkbox) ? 40 : 100,
            maxWidth: (type == ColumnType.numeric || type == ColumnType.checkbox) ? 100 : 200,
          ),
          decoration: BoxDecoration(
            border: Border(
              right: widget.withColumnDividers && j!=widget.rows[rowIndex].tableRow.length-1
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
                  if(value) {
                    setState(() {
                      _selectedRows.add(rowIndex);
                    });
                  }else{
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
      onTap: widget.rows[rowIndex].nestedTable != null ? () {
        setState(() {
          if (_expandedRows.contains(rowIndex)) {
            _expandedRows.remove(rowIndex); // Collapse row
          } else {
            _expandedRows.add(rowIndex); // Expand row
          }
        });
      } : widget.enableSelection ? (){
        setState(() {
          if (_selectedRows.contains(rowIndex)) {
            _selectedRows.remove(rowIndex);
          } else {
            _selectedRows.add(rowIndex);
          }
        });
      } : null,
      child: Container(
        decoration: BoxDecoration(
          color: _hoveredRows.contains(rowIndex) ||_selectedRows.contains(rowIndex) || _highlightedRows.contains(rowIndex) ? theme.colorTheme.primary.primaryBg : rowColor,
          border: Border(
            bottom: widget.withRowDividers || (!widget.withRowDividers && widget.enableBorder && rowIndex==widget.rows.length-1)
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
                    if(widget.showExpandIconOnHover && widget.rows[rowIndex].nestedTable != null && _hoveredRows.contains(rowIndex))
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
                            color: theme.colorTheme.primary.primary1,  // Line color
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            if (_expandedRows.contains(rowIndex) && widget.rows[rowIndex].nestedTable != null)
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                child: widget.rows[rowIndex].nestedTable!, // Add the nested table widget
              ),
          ],
        ),
      ),
    );
  }
}