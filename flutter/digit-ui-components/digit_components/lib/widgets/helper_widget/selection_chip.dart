import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../models/DropdownModels.dart';
import '../../models/chipModel.dart';

class SelectionChip<T> extends StatelessWidget {
  final SelectionType? selectionType;
  final ChipConfig? chipConfig;
  final Function(dynamic) onItemDelete;
  final dynamic item;
  final List<ValueMapper>? valueMapper;

  const SelectionChip({
    Key? key,
    this.chipConfig,
    required this.item,
    required this.onItemDelete,
    this.selectionType,
    this.valueMapper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// Capitalize the first letter if required
    String capitalizeFirstLetter(String text) {
      if (text.isNotEmpty) {
        return text.substring(0, 1).toUpperCase() + text.substring(1);
      }
      return text;
    }
    
    String? chipValue;
    DigitTypography currentTypography = getTypography(context);

    /// Helper function to get the associated value from the value mapper
    bool getAssociatedValue(String code) {
      if (valueMapper != null) {
        ValueMapper? mappedValue = valueMapper?.firstWhere(
          (value) => value.code == code,
          orElse: () => const ValueMapper(code: '', name: ''),

          /// Provide default values here
        );
        if (mappedValue?.code != '') {
          chipValue = mappedValue?.name;
          return true;
        }
      }

      return false;
    }

    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding,
          vertical: kPadding,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Default.defaultChipRadius),
          color: const DigitColors().light.genericDivider,
        ),
        child: Row(
          children: [
            getAssociatedValue(item.code)
                ? Text(
                    capitalizeFirstLetter(chipValue!),
                    style: currentTypography.bodyS.copyWith(
                      color: const DigitColors().light.textPrimary,
                      height: 1.025,
                    ),
                  )
                : selectionType == SelectionType.nestedMultiSelect
                    ? Text(
                        capitalizeFirstLetter('${item.type}: ${item.name}'),
                        style: currentTypography.bodyS.copyWith(
                          color: const DigitColors().light.textPrimary,
                          height: 1.025,
                        ),
                      )
                    : Text(
                        capitalizeFirstLetter(item.name),
                        style: currentTypography.bodyS.copyWith(
                          color: const DigitColors().light.textPrimary,
                          height: 1.025,
                        ),
                      ),
            const SizedBox(
              width: kPadding,
            ),
            InkWell(
              onTap: () => onItemDelete(item),
              hoverColor: const DigitColors().transparent,
              splashColor: const DigitColors().transparent,
              highlightColor: const DigitColors().transparent,
              child: Icon(
                Icons.cancel,
                size: 24,
                color: const DigitColors().light.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
