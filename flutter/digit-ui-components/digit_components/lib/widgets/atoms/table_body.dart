import 'package:digit_ui_components/widgets/atoms/table_cell.dart';
import 'package:flutter/material.dart';

class TableBody extends StatelessWidget {
  final List<List<String>> rows;
  final bool withColumnDividers;
  final bool withRowDividers;

  const TableBody({
    Key? key,
    required this.rows,
    this.withColumnDividers = false,
    this.withRowDividers = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: rows.length,
      itemBuilder: (context, rowIndex) {
        return Column(
          children: [
            Row(
              children: rows[rowIndex].asMap().entries.map((entry) {
                int index = entry.key;
                String data = entry.value;
                return Expanded(
                  child: DigitTableCell(
                    data: data,
                    withColumnDividers: withColumnDividers && index < rows[rowIndex].length - 1,
                  ),
                );
              }).toList(),
            ),
            if (withRowDividers)
              const Divider(height: 1, color: Colors.grey),
          ],
        );
      },
    );
  }
}

