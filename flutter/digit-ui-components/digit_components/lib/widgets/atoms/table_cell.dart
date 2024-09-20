import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/checkbox_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:flutter/material.dart';

import 'digit_button.dart';
import 'digit_tag.dart';

class DigitTableCell extends StatelessWidget {
  final DigitTableData cellData;
  final ColumnType type;
  final dynamic value;
  final void Function(bool)? areAllRowsSelected;

  const DigitTableCell({
    Key? key,
    required this.cellData,
    this.type = ColumnType.text,
    this.value,
    this.areAllRowsSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCellContent(context);
  }

  Widget _buildCellContent(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    switch (type) {
      case ColumnType.checkbox:
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 100,
            minWidth: 40,
          ),
          child: DigitCheckbox(
            value: value ?? false,
            onChanged: (value) {
              if (areAllRowsSelected != null) {
                areAllRowsSelected!(value);
              }
            },
            checkboxThemeData: const DigitCheckboxThemeData().copyWith(
              context: context,
              iconSize: 20,
            ),
          ),
        );

      case ColumnType.textField:
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 168,
          ),
          child: const DigitTextFormInput(
            //initialValue: cellData.value,
          ),
        );

      case ColumnType.dropDown:
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 168,
          ),
          child: DigitDropdown(
            items: cellData.items ?? [],
          ),
        );

      case ColumnType.DigitButton:
        return DigitButton(
          mainAxisSize: MainAxisSize.min,
          size: DigitButtonSize.medium,
          type: DigitButtonType.secondary,
          onPressed: () {
            if (cellData.callBack != null) {
              cellData.callBack!(cellData);
            }
          },
          label: cellData.label.isNotEmpty ? cellData.label : 'DigitButton',
        );

      case ColumnType.numeric:
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 100,
            minWidth: 40,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Text(
              cellData.label,
              style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary),
            ),
          ),
        );

      case ColumnType.description:
        return Text(
          cellData.label,
          style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary),
        );

      case ColumnType.tags:
        return Tag(
          label: cellData.label,
        );

      case ColumnType.switchs:
        return CustomSwitch(
            mainAxisAlignment: MainAxisAlignment.start,
            label: cellData.label,
            value: cellData.value ?? false, onChanged: (value) {
          if(cellData.callBack != null) {
            cellData.callBack!(cellData);
          }
        });
      case ColumnType.text:
      default:
        return cellData.widget ?? Text(
          cellData.label,
          maxLines: 1,
          style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary),
        );
    }
  }
}

enum SortOrder {
  ascending,
  descending,
}

enum ColumnType {
  text,
  checkbox,
  textField,
  DigitButton,
  numeric,
  description,
  dropDown,
  switchs,
  tags,
}

class DigitTableColumn {
  final String header;
  final String? description;
  final ColumnType type;
  final String cellValue;
  final bool isSortable;
  final double? width;
  bool? value;
  final bool isFrozen;
  final bool showCheckbox;
  final void Function(bool)? onCheckboxChanged;

  DigitTableColumn({
    required this.header,
    this.description,
    this.type = ColumnType.text,
    required this.cellValue,
    this.isSortable = false,
    this.value,
    this.width,
    this.isFrozen = false,
    this.showCheckbox = false,
    this.onCheckboxChanged,
  });
}

class DigitTableRow {
  final List<DigitTableData> tableRow;

  DigitTableRow({
    required this.tableRow,
  });
}

class DigitTableData {
  final String label;
  final TextStyle? style;
  late final dynamic value;
  final String cellKey;
  final List<DropdownItem>? items;
  ValueChanged<DigitTableData>? callBack;
  final Widget? widget;

  DigitTableData(
      this.label, {
        this.style,
        this.value,
        this.callBack,
        this.items,
        required this.cellKey,
        this.widget,
      });
}

class CustomColumn {
  final ColumnType columnType;
  final dynamic value;
  final String label;
  final VoidCallback? onDigitButtonPressed;
  final ValueChanged<bool>? onCheckboxChanged;

  CustomColumn({
    required this.columnType,
    this.value,
    required this.label,
    this.onDigitButtonPressed,
    this.onCheckboxChanged,
  });
}