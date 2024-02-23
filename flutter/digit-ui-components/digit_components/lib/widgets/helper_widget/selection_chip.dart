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
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding,
          vertical: kPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Default.defaultChipRadius),
          color: const DigitColors().lightGenericDivider,
        ),
        child: Row(
          children: [
            selectionType == SelectionType.nestedMultiSelect
                ? Text('${item.type}: ${item.name}')
                : Text(item.name),
            const SizedBox(width: kPadding,),
            InkWell(
              onTap: () => onItemDelete(item),
              hoverColor: const DigitColors().transparent,
              splashColor: const DigitColors().transparent,
              highlightColor: const DigitColors().transparent,
              child: Icon(
                Icons.cancel,
                size: 24,
                color: const DigitColors().lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );

  }
}