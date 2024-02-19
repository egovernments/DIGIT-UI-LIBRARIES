import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../models/chipModel.dart';

class SelectionChip<T> extends StatelessWidget {
  final SelectionType? selectionType;
  final ChipConfig chipConfig;
  final Function(dynamic) onItemDelete;
  final dynamic item;

  const SelectionChip({
    Key? key,
    required this.chipConfig,
    required this.item,
    required this.onItemDelete,
    this.selectionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: chipConfig.padding,
      label: selectionType == SelectionType.nestedMultiSelect
          ? Text('${item.type}: ${item.name}')
          : Text(item.name),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Default.defaultChipRadius),
      ),
      deleteIcon: Icon(
        Icons.cancel,
        color: const DigitColors().lightTextSecondary,
      ),
      deleteIconColor: DigitColors().waterBlue,
      labelPadding: const EdgeInsets.symmetric(vertical: kPadding / 2),
      backgroundColor: const DigitColors().lightGenericDivider,
      labelStyle:
          DigitTheme.instance.mobileTheme.textTheme.bodyMedium,
      onDeleted: () => onItemDelete(item),
    );
  }
}
