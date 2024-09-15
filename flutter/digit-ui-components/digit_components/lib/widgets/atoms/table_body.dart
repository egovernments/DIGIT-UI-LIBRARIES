import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/divider_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../atoms/table_cell.dart';

class TableBody extends StatefulWidget {
  final List<DigitTableRow> rows;
  final List<DigitTableColumn> columns;
  final List<TableColumnWidth> columnWidths; // Added to manage column widths
  final bool withRowDividers;
  final bool alternateRowColor;
  final bool enableBorder;
  final bool withColumnDividers;
  final bool headerCheckboxValue;
  final void Function(int, bool) onRowCheckboxChanged;

  const TableBody({
    Key? key,
    required this.rows,
    required this.columns,
    this.columnWidths = const [], // Added default empty list for column widths
    this.withRowDividers = false,
    this.alternateRowColor = false,
    this.enableBorder = false,
    this.withColumnDividers = false,
    this.headerCheckboxValue = false,
    required this.onRowCheckboxChanged,
  }) : super(key: key);

  @override
  _TableBodyState createState() => _TableBodyState();
}

class _TableBodyState extends State<TableBody> {
  final Set<int> _hoveredRows = {};


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> rowWidgets = [];


    for (int i = 0; i < widget.rows.length; i++) {
      // Determine row color based on even or odd row and hover state
      Color rowColor = _hoveredRows.contains(i)
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
            constraints: BoxConstraints(minWidth: (type == ColumnType.numeric || type == ColumnType.checkbox) ? 40 : 100, maxWidth: (type == ColumnType.numeric || type == ColumnType.checkbox) ? 100 : 200),
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
                child: CustomTableCell(cellData: widget.rows[i].tableRow[j], type: type, value: value, areAllRowsSelected:(value){
                  widget.onRowCheckboxChanged(i, value);
                },),
              ),
            ),
          ),
        );
      }

      // Add row with cells and alternating background color to rowWidgets list
      rowWidgets.add(
        MouseRegion(
          onEnter: (_) => setState(() => _hoveredRows.add(i)),
          onExit: (_) => setState(() => _hoveredRows.remove(i)),
          child: Container(
            decoration: BoxDecoration(
              color: rowColor,
              border: Border(
                bottom: widget.withRowDividers || (widget.enableBorder && i == widget.rows.length - 1) ?
                BorderSide(color: widget.withRowDividers && i != widget.rows.length - 1 ? theme.colorTheme.generic.divider : theme.colorTheme.generic.divider)
                    : BorderSide.none,
                left: widget.enableBorder ?
                BorderSide(color: theme.colorTheme.generic.divider)
                    : BorderSide.none,
                right: widget.enableBorder ?
                BorderSide(color: theme.colorTheme.generic.divider)
                    : BorderSide.none,

              ),
            ),
            // Apply the row color here
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cells,
                ),
                // if (widget.withRowDividers || (widget.enableBorder && i == widget.rows.length - 1))
                //   DigitDivider(
                //     dividerType: DividerType.small,
                //     dividerThemeData: DigitDividerThemeData(
                //         color: widget.enableBorder && i == widget.rows.length - 1
                //             ? theme.colorTheme.generic.divider
                //             : theme.colorTheme.generic.divider
                //     ),
                //   ), // Add row divider if enabled and not the last row
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      children: rowWidgets,
    );
  }
}