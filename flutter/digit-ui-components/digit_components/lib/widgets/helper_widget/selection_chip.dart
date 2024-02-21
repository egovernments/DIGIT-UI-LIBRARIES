import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../models/chipModel.dart';

class SelectionChip<T> extends StatelessWidget {
  final SelectionType? selectionType;
  final ChipConfig? chipConfig;
  final Function(dynamic) onItemDelete;
  final dynamic item;

  const SelectionChip({
    Key? key,
    this.chipConfig,
    required this.item,
    required this.onItemDelete,
    this.selectionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: chipConfig?.padding ?? const EdgeInsets.symmetric(vertical: kPadding , horizontal: kPadding),
      label: selectionType == SelectionType.nestedMultiSelect
          ? Text('${item.type}: ${item.name}')
          : Text(item.name),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Default.defaultChipRadius),
      ),
      deleteIcon: Icon(
        Icons.cancel,
        size: 20,
        color: const DigitColors().lightTextSecondary,
      ),
      shadowColor: const DigitColors().transparent,
      deleteIconColor: const DigitColors().lightTextSecondary,
      labelPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      backgroundColor: const DigitColors().lightGenericDivider,
      labelStyle: DigitTheme.instance.mobileTheme.textTheme.bodyMedium?.copyWith(
        color: const DigitColors().lightTextPrimary,
        height: 1,
      ),
      onDeleted: () => onItemDelete(item),
    );
  }
}
