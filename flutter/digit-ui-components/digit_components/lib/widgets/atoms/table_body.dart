import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/divider_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../atoms/table_cell.dart';

class TableBody extends StatefulWidget {
  final List<DigitTableRow> rows;
  final bool hasFooter;
  final Set<int> ?selectedRows;
  final Set<int>? highlightedRows;
  final List<DigitTableColumn> columns;
  final bool withRowDividers;
  final bool alternateRowColor;
  final bool enableBorder;
  final bool withColumnDividers;
  final bool enableSelection;
  final bool headerCheckboxValue;
  final double? tableHeight;
  final void Function(int, bool) onRowCheckboxChanged;

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
    this.withColumnDividers = false,
    this.headerCheckboxValue = false,
    required this.onRowCheckboxChanged,
  }) : super(key: key);

  @override
  _TableBodyState createState() => _TableBodyState();
}
class _TableBodyState extends State<TableBody> {
  final Set<int> _hoveredRows = {};
  final Set<int> _selectedRows = {};
  final Set<int> _highlightedRows = {};

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


    if (widget.selectedRows != oldWidget.selectedRows) {
      _selectedRows.addAll(widget.selectedRows!);
    }

    if (widget.highlightedRows != oldWidget.highlightedRows) {
      _highlightedRows.addAll(widget.highlightedRows!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> rowWidgets = [];

    // Check if any column has a description
    bool hasDescription = widget.columns.any((column) => column.description != null);

    double headerHeight = hasDescription ? 70.0 : 52.0;
    double footerHeight = widget.hasFooter ? 64.0 : 0.0;

    // Get the count of checkbox and numeric columns
    int specialColumnCount = _countSpecialColumns();
    int normalColumns = widget.columns.length - specialColumnCount;

    for (int i = 0; i < widget.rows.length; i++) {
      // Determine row color based on hover state
      Color rowColor = _hoveredRows.contains(i) || _selectedRows.contains(i) || _highlightedRows.contains(i)
          ? theme.colorTheme.primary.primaryBg // Hover color
          : i % 2 != 0 && widget.alternateRowColor
          ? theme.colorTheme.paper.secondary
          : theme.colorTheme.paper.primary;

      // Build row cells
      List<Widget> cells = [];
      for (int j = 0; j < widget.rows[i].tableRow.length; j++) {
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
                right: (widget.withColumnDividers && j != widget.rows[i].tableRow.length - 1)
                    ? BorderSide(color: theme.colorTheme.generic.divider)
                    : BorderSide.none,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: DigitTableCell(
                  cellData: widget.rows[i].tableRow[j],
                  type: type,
                  value: value,
                  areAllRowsSelected: (value) {
                    widget.onRowCheckboxChanged(i, value);
                  },
                ),
              ),
            ),
          ),
        );
      }

      // Add row with cells and alternating background color to rowWidgets list
      rowWidgets.add(
        InkWell(
          onHover: widget.enableSelection ?(hover) {
            setState(() {
              if (hover) {
                _hoveredRows.add(i);
              } else {
                _hoveredRows.remove(i);
              }
            });
          } : null,
          onTap:widget.enableSelection ? () {
            setState(() {
              if (_selectedRows.contains(i)) {
                _selectedRows.remove(i);
              } else {
                _selectedRows.add(i);
              }
            });
          }: null,
          child: Container(
            decoration: BoxDecoration(
              color: rowColor,
              border: Border(
                bottom: widget.withRowDividers || (widget.enableBorder && i == widget.rows.length - 1)
                    ? BorderSide(color: theme.colorTheme.generic.divider)
                    : BorderSide.none,
                left: widget.enableBorder
                    ? BorderSide(color: theme.colorTheme.generic.divider)
                    : BorderSide.none,
                right: widget.enableBorder
                    ? BorderSide(color: theme.colorTheme.generic.divider)
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                if(_selectedRows.contains(i))
                  Container(
                    width: 4,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(4),
                          bottomRight: Radius.circular(4)),
                      color: theme.colorTheme.primary.primary1,
                    ),
                  ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cells,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: normalColumns * 200 + specialColumnCount * 100 + 2,
        maxHeight: (widget.tableHeight ?? MediaQuery.of(context).size.height )- headerHeight - footerHeight,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: rowWidgets.length,
        itemBuilder: (context, index) => rowWidgets[index],
      ),
    );
  }
}