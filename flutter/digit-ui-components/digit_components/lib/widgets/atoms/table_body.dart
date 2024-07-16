import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../atoms/table_cell.dart';

class TableBody extends StatelessWidget {
  final List<List<CustomColumn>> rows;
  final List<TableColumnWidth> columnWidths; // Added to manage column widths
  final bool withRowDividers;

  const TableBody({
    Key? key,
    required this.rows,
    this.columnWidths = const [], // Added default empty list for column widths
    this.withRowDividers = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rowWidgets = [];

    for (int i = 0; i < rows.length; i++) {
      // Build row cells
      List<Widget> cells = [];
      for (int j = 0; j < rows[i].length; j++) {
        cells.add(
          Expanded(
            flex: columnWidths.isNotEmpty ? 0 : 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTableCell(column: rows[i][j]),
            ),
          ),
        );
      }

      // Add row with cells to rowWidgets list
      rowWidgets.add(
        Column(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: cells,
            ),
            if (withRowDividers && i < rows.length - 1)
              const DigitDivider(), // Add row divider if enabled and not the last row
          ],
        ),
      );
    }

    return Column(
      children: rowWidgets,
    );
  }
}
