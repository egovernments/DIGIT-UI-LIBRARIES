import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/checkbox_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class CustomTableCell extends StatelessWidget {
  final CustomColumn column;

  const CustomTableCell({
    Key? key,
    required this.column,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildCellContent(context);
  }

  Widget _buildCellContent(BuildContext context) {
    switch (column.columnType) {
      case ColumnType.checkbox:
        return DigitCheckbox(
          label: column.label,
          onChanged: (value){},
          checkboxThemeData: const DigitCheckboxThemeData().copyWith(
            context: context,
            iconSize: 20,
          ),
        );
      case ColumnType.textField:
        return DigitTextFormInput(
          initialValue: column.value.toString(),
        );
      case ColumnType.dropDown:
        return const DigitDropdown(
          items: [
            DropdownItem(name: 'text1', code: '1'),
            DropdownItem(name: 'text2', code: '2')
          ],
        );
      case ColumnType.button:
        return Button(
          size: ButtonSize.medium,
          type: ButtonType.secondary,
          onPressed: column.onButtonPressed ?? () {},
          label: column.label.isNotEmpty ? column.label : 'Button',
        );
      case ColumnType.numeric:
        return Align(
          alignment: Alignment.bottomRight,
          child: Text(
            column.value.toString(),
            style: const TextStyle(fontFamily: 'RobotoMono'),
          ),
        );
      case ColumnType.text:
      default:
        return Text(column.label);
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
  dropDown,
}

class TableColumn {
  final String header;
  final bool isSortable;

  TableColumn({
    required this.header,
    this.isSortable = false,
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

