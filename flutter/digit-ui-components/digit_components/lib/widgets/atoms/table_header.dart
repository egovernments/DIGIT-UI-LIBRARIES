import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/table_cell.dart';

class TableHeader extends StatelessWidget {
  final List<TableColumn> columns;
  final bool withColumnDividers;
  final void Function(int index, SortOrder order)? onSort;
  final int? sortedColumnIndex;
  final SortOrder? sortOrder;

  const TableHeader({
    Key? key,
    required this.columns,
    this.withColumnDividers = false,
    this.onSort,
    this.sortedColumnIndex,
    this.sortOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Row(
      children: columns.asMap().entries.map((entry) {
        int index = entry.key;
        TableColumn column = entry.value;
        bool isSortedColumn = sortedColumnIndex == index;

        return Expanded(
          child: InkWell(
            hoverColor: theme.colorTheme.generic.transparent,
            highlightColor: theme.colorTheme.generic.transparent,
            splashColor: theme.colorTheme.generic.transparent,
            onTap: column.isSortable && onSort != null
                ? () {
              onSort!(index, SortOrder.ascending);
            }
                : null,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                  right: withColumnDividers
                      ? BorderSide(color: Colors.grey)
                      : BorderSide.none,
                ),
                color: const DigitColors().light.genericBackground,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    column.header,
                    style: textTheme.headingM.copyWith(
                      color: theme.colorTheme.primary.primary2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (column.isSortable)
                    Icon(
                      isSortedColumn
                          ? (sortOrder == SortOrder.ascending
                          ? Icons.arrow_downward
                          : Icons.arrow_upward)
                          : Icons.sort,
                      size: 24.0,
                      color: theme.colorTheme.primary.primary2,
                    ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
