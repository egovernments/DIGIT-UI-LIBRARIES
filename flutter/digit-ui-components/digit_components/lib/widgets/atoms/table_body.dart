import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/divider_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../atoms/table_cell.dart';

class TableBody extends StatelessWidget {
  final List<List<CustomColumn>> rows;
  final List<TableColumnWidth> columnWidths; // Added to manage column widths
  final bool withRowDividers;
  final bool alternateRowColor;
  final bool enableBorder;
  final bool withColumnDividers;


  const TableBody({
    Key? key,
    required this.rows,
    this.columnWidths = const [], // Added default empty list for column widths
    this.withRowDividers = false,
    this.alternateRowColor = false,
    this.enableBorder = false,
    this.withColumnDividers = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> rowWidgets = [];

    for (int i = 0; i < rows.length; i++) {
      // Determine row color based on even or odd row
      Color rowColor = i % 2 != 0 && alternateRowColor ? theme.colorTheme.paper.secondary : theme.colorTheme.paper.primary;

      // Build row cells
      List<Widget> cells = [];
      for (int j = 0; j < rows[i].length; j++) {
        cells.add(
          Expanded(
            flex: columnWidths.isNotEmpty ? 0 : 1,
            child: Container(
              constraints: const BoxConstraints(minWidth: 200),
              decoration: BoxDecoration(
                border: Border(
                  left: enableBorder && j==0
                      ? BorderSide(color: theme.colorTheme.text.secondary)
                      : BorderSide.none,
                  right: (withColumnDividers || j  == rows[i].length - 1)
                      ? BorderSide(color: theme.colorTheme.text.secondary)
                      : BorderSide.none,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CustomTableCell(column: rows[i][j]),
              ),
            ),
          ),
        );
      }

      // Add row with cells and alternating background color to rowWidgets list
      rowWidgets.add(
        Container(
          color: rowColor, // Apply the row color here
          child: Column(
            children: [
              Row(
                children: cells,
              ),
              if (withRowDividers || (enableBorder && i == rows.length - 1))
                 DigitDivider(dividerType: DividerType.small, dividerThemeData:  DigitDividerThemeData(color: enableBorder && i == rows.length - 1 ? theme.colorTheme.text.secondary : theme.colorTheme.generic.divider)), // Add row divider if enabled and not the last row
            ],
          ),
        ),
      );
    }

    return Column(
      children: rowWidgets,
    );
  }
}
