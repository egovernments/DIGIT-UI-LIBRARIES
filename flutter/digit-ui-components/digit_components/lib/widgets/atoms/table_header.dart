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
  final bool enabledBorder;

  const TableHeader({
    Key? key,
    required this.columns,
    this.withColumnDividers = false,
    this.onSort,
    this.sortedColumnIndex,
    this.sortOrder,
    this.enabledBorder = false,
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

        // Determine if this is the first or last column
        bool isLastColumn = index == columns.length - 1;
        bool isFirstColumn = index == 0;

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
              constraints: const BoxConstraints(minWidth: 200),
              padding: EdgeInsets.only(left: theme.spacerTheme.spacer4, top: theme.spacerTheme.spacer4, bottom: theme.spacerTheme.spacer4, right: withColumnDividers || enabledBorder ? theme.spacerTheme.spacer4 : 0),
              decoration: BoxDecoration(
                color: const DigitColors().light.genericBackground,
                border: Border(
                  left: (withColumnDividers || enabledBorder) && isFirstColumn
                      ? BorderSide(color: theme.colorTheme.text.secondary)
                      : BorderSide.none,
                  right: withColumnDividers || enabledBorder
                      ? BorderSide(color: theme.colorTheme.text.secondary)
                      : BorderSide.none,
                  top: enabledBorder ? BorderSide(color: theme.colorTheme.text.secondary) : BorderSide.none, // Top border for all columns
                  bottom: enabledBorder ? BorderSide(color: theme.colorTheme.text.secondary) : BorderSide.none, // Bottom border for all columns
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(right: withColumnDividers || enabledBorder ? 0 : theme.spacerTheme.spacer4),
                decoration: BoxDecoration(
                  color: const DigitColors().light.genericBackground,
                  border: Border(
                    right: withColumnDividers || enabledBorder ? BorderSide.none
                        : BorderSide(color: theme.colorTheme.text.secondary),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      column.header,
                      style: textTheme.headingS.copyWith(
                        color: theme.colorTheme.text.primary,
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
          ),
        );
      }).toList(),
    );
  }
}
