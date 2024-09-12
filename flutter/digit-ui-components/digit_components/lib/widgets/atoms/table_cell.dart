import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/checkbox_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/switch.dart';
import 'package:flutter/material.dart';

import 'digit_tag.dart';

class CustomTableCell extends StatelessWidget {
  final DigitTableData cellData;
  final ColumnType type;
  final dynamic value;
  final void Function(bool)? areAllRowsSelected;

  const CustomTableCell({
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
        return DigitCheckbox(
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
          child: const DigitDropdown(
            items: [
              DropdownItem(name: 'text1', code: '1'),
              DropdownItem(name: 'text2', code: '2')
            ],
          ),
        );

      case ColumnType.button:
        return Button(
          mainAxisSize: MainAxisSize.min,
          size: ButtonSize.medium,
          type: ButtonType.secondary,
          onPressed: () {
            if (cellData.callBack != null) {
              cellData.callBack!(cellData);
            }
          },
          label: cellData.label.isNotEmpty ? cellData.label : 'Button',
        );

      case ColumnType.numeric:
        return Align(
          alignment: Alignment.topRight,
          child: Text(
            cellData.label,
            style: const TextStyle(fontFamily: 'RobotoMono'),
          ),
        );

      case ColumnType.description:
        return Text(
          cellData.label,
          style: textTheme.bodyS.copyWith(color: theme.colorTheme.text.primary),
        );

      // case ColumnType.tags:
      //   return Tag(
      //     label: cellData.label,
      //   );

      // case ColumnType.switchs:
      //   return CustomSwitch(
      //       value: cellData.value ?? false, onChanged: (value) {
      //     cellData.value = value;
      //         if(cellData.callBack != null) {
      //           cellData.callBack!(cellData);
      //         }
      //       });
      case ColumnType.text:
      default:
        return Text(
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
  button,
  numeric,
  description,
  dropDown,
  // switchs,
  // tags,
}

class DigitTableColumn {
  final String header;
  final ColumnType type;
  final String cellValue;
  final bool isSortable;
  bool? value;
  final bool isFrozen;
  final void Function(bool)? onCheckboxChanged;

  DigitTableColumn({
    required this.header,
    this.type = ColumnType.text,
    required this.cellValue,
    this.isSortable = false,
    this.value,
    this.isFrozen = false,
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
  ValueChanged<DigitTableData>? callBack;
  final Widget? widget;

  DigitTableData(
    this.label, {
    this.style,
    this.value,
    this.callBack,
    required this.cellKey,
    this.widget,
  });
}

class CustomColumn {
  final ColumnType columnType;
  final dynamic value;
  final String label;
  final VoidCallback? onButtonPressed;
  final ValueChanged<bool>? onCheckboxChanged;

  CustomColumn({
    required this.columnType,
    this.value,
    required this.label,
    this.onButtonPressed,
    this.onCheckboxChanged,
  });
}
