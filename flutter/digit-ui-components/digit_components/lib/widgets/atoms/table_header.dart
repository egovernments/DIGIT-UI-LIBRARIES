import 'package:digit_ui_components/constants/AppView.dart';
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
  final double Function(DigitTableColumn)? getColumnWidth;

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
      this.onHeaderCheckboxChanged,
      this.getColumnWidth})
      : super(key: key);

  /// Helper to get the width of a column based on screen size
  double _getColumnWidth(DigitTableColumn column, BuildContext context) {
    // If a custom width calculator is provided, use it
    if (getColumnWidth != null) {
      return getColumnWidth!(column);
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
  double _calculateTableWidth(BuildContext context) {
    double totalWidth = 0;
    for (var column in columns) {
      totalWidth += _getColumnWidth(column, context);
    }
    return totalWidth + 2; // Add 2 for borders
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    
    // Early return if no columns
    if (columns.isEmpty) {
      return const SizedBox.shrink();
    }

    // Check if any column has a description
    bool hasDescription = columns.any((column) => column.description != null);

    /// Set height based on whether any column has a description
    double headerHeight = hasDescription ? 73.0 : 52.0;

    return Container(
      width: _calculateTableWidth(context),
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
              width: _getColumnWidth(column, context),
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
                          width: _getColumnWidth(column, context) - 
                                (column.showCheckbox && column.type == ColumnType.checkbox ? 28 : 0) - 
                                (column.isSortable ? 27 : 0) - 16,
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
                        width: _getColumnWidth(column, context) - 20,
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
