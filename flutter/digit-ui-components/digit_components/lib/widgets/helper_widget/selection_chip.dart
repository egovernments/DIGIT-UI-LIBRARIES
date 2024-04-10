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
          border: Border.all(
            color: const DigitColors().light.genericDivider,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(4),
          color: const DigitColors().light.genericBackground,
        ),
        child: Row(
          children: [
            getAssociatedValue(item.code)
                ? Text(
                    capitalizeFirstLetter(chipValue!),
                    style: currentTypography.bodyS.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color: const DigitColors().light.textPrimary,
                      height: 1.025,
                    ),
                  )
                : selectionType == SelectionType.nestedMultiSelect
                    ? Text(
                        capitalizeFirstLetter('${item.type}: ${item.name}'),
              overflow: TextOverflow.ellipsis,
                        style: currentTypography.bodyS.copyWith(
                          overflow: TextOverflow.ellipsis,
                          color: const DigitColors().light.textPrimary,
                          height: 1.025,
                        ),
                      )
                    : Text(
                        capitalizeFirstLetter(item.name),
              overflow: TextOverflow.ellipsis,
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
              child: Container(
                width: 24,
                height: 24,
                // padding: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: const DigitColors().light.textSecondary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  Icons.close, // Replace 'your_icon_here' with the desired icon
                  size: 24,
                  color: const DigitColors().light.paperPrimary,
                ),
              )

            ),
          ],
        ),
      ),
    );
  }
}

class FileData {
  final String name;
  final String code;

  FileData({required this.name, required this.code});
}
