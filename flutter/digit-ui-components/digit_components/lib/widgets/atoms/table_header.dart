import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:digit_ui_components/widgets/atoms/table_cell.dart';

import '../../theme/ComponentTheme/checkbox_theme.dart';

class TableHeader extends StatelessWidget {
  final List<DigitTableColumn> columns;
  final bool withColumnDividers;
  final void Function(int index, SortOrder order)? onSort;
  final int? sortedColumnIndex;
  final SortOrder? sortOrder;
  final bool enabledBorder;
  final bool headerCheckboxValue;
  final bool withRowDividers;
  final bool headerCheckboxIndeterminate;
  final void Function(bool? value)? onHeaderCheckboxChanged;

  const TableHeader(
      {Key? key,
      required this.columns,
      this.withColumnDividers = false,
      this.onSort,
      this.sortedColumnIndex,
      this.sortOrder,
      this.withRowDividers = true,
      this.enabledBorder = false,
      this.headerCheckboxValue = false,
      this.headerCheckboxIndeterminate = false,
      this.onHeaderCheckboxChanged})
      : super(key: key);

  // Method to count how many checkbox or numeric columns exist
  int _countSpecialColumns() {
    int count = 0;
    for (var column in columns) {
      if (column.type == ColumnType.checkbox ||
          column.type == ColumnType.numeric) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    // Check if any column has a description
    bool hasDescription = columns.any((column) => column.description != null);

    /// Set height based on whether any column has a description
    double headerHeight = hasDescription ? 73.0 : 52.0;

    // Get the count of checkbox and numeric columns
    int specialColumnCount = _countSpecialColumns();
    int normalColumns = columns.length - specialColumnCount;

    return Container(
      width: normalColumns * 200 + specialColumnCount * 100 + 2,
      height: headerHeight,
      decoration: BoxDecoration(
        color: const DigitColors().light.genericBackground,
        border: Border(
          left: enabledBorder
              ? BorderSide(color: theme.colorTheme.generic.divider)
              : BorderSide.none,
          right: enabledBorder
              ? BorderSide(color: theme.colorTheme.generic.divider)
              : BorderSide.none,
          top: enabledBorder
              ? BorderSide(color: theme.colorTheme.generic.divider)
              : BorderSide.none,
          // Top border for all columns
          bottom: enabledBorder || withRowDividers
              ? BorderSide(color: theme.colorTheme.generic.divider)
              : BorderSide.none, // Bottom border for all columns
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns.asMap().entries.map((entry) {
          int index = entry.key;
          DigitTableColumn column = entry.value;
          bool isSortedColumn = sortedColumnIndex == index;

          // Determine if this is the first or last column
          bool isLastColumn = index == columns.length - 1;
          bool isFirstColumn = index == 0;

          return InkWell(
            hoverColor: theme.colorTheme.generic.transparent,
            highlightColor: theme.colorTheme.generic.transparent,
            splashColor: theme.colorTheme.generic.transparent,
            onTap: column.isSortable && onSort != null
                ? () {
                    onSort!(index, SortOrder.ascending);
                  }
                : null,
            child: Container(
              constraints: BoxConstraints(
                  minWidth: (column.type == ColumnType.numeric ||
                          column.type == ColumnType.checkbox)
                      ? 100
                      : 200,
                  maxWidth: (column.type == ColumnType.numeric ||
                          column.type == ColumnType.checkbox)
                      ? 100
                      : 200),
              padding: EdgeInsets.only(
                  left: theme.spacerTheme.spacer4,
                  top: theme.spacerTheme.spacer4,
                  bottom: theme.spacerTheme.spacer4,
                  right: !withColumnDividers || enabledBorder
                      ? theme.spacerTheme.spacer4
                      : 0),
              decoration: BoxDecoration(
                color: const DigitColors().light.genericBackground,
                border: Border(
                  right: withColumnDividers && !isLastColumn
                      ? BorderSide(color: theme.colorTheme.generic.divider)
                      : BorderSide.none,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(
                    right: withColumnDividers ? 0 : theme.spacerTheme.spacer4),
                decoration: BoxDecoration(
                  color: const DigitColors().light.genericBackground,
                  border: Border(
                    right: (withColumnDividers) || isLastColumn
                        ? BorderSide.none
                        : BorderSide(color: theme.colorTheme.text.secondary),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (column.type == ColumnType.checkbox &&
                            column.showCheckbox)
                          headerCheckboxIndeterminate
                              ? InkWell(
                                  onTap: () {
                                    if (column.onCheckboxChanged != null) {
                                      column.onCheckboxChanged!(true);
                                    }
                                    if (onHeaderCheckboxChanged != null) {
                                      onHeaderCheckboxChanged!(true);
                                    }
                                  },
                                  child: DigitCheckboxIcon(
                                    state: DigitCheckboxState.intermediate,
                                    checkboxThemeData:
                                        const DigitCheckboxThemeData().copyWith(
                                      context: context,
                                      iconSize: 20,
                                    ),
                                  ),
                                )
                              : DigitCheckbox(
                                  checkboxThemeData:
                                      const DigitCheckboxThemeData().copyWith(
                                    context: context,
                                    iconSize: 20,
                                  ),
                                  value: headerCheckboxValue ?? false,
                                  onChanged: (value) {
                                    if (column.onCheckboxChanged != null) {
                                      column.onCheckboxChanged!(value);
                                    }
                                    if (onHeaderCheckboxChanged != null) {
                                      onHeaderCheckboxChanged!(value);
                                    }
                                    column.value = value;
                                  },
                                ),
                        if (column.type == ColumnType.checkbox &&
                            column.showCheckbox)
                          const SizedBox(width: 4),
                        Container(
                          width:  (column.type == ColumnType.numeric ||
                              column.type == ColumnType.checkbox) ? column.isSortable ? 30 : 50 : column.isSortable ? 100 : 140,
                          child: Text(
                            column.header,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headingS.copyWith(
                              color: theme.colorTheme.primary.primary2,
                            ),
                          ),
                        ),
                        if(column.isSortable)
                        const SizedBox(width: 4),
                        if (column.isSortable)
                          Icon(
                            isSortedColumn
                                ? (sortOrder == SortOrder.ascending
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward)
                                : Icons.sort,
                            size: 19.0,
                            color: theme.colorTheme.primary.primary2,
                          ),
                      ],
                    ),
                    if (column.description != null)
                      Container(
                        width:  (column.type == ColumnType.numeric ||
                            column.type == ColumnType.checkbox) ? 80 : 180,
                        child: Text(
                          column.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyS.copyWith(
                            color: theme.colorTheme.text.secondary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
