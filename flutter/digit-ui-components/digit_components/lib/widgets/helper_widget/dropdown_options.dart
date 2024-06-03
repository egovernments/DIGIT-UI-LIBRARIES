import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../models/DropdownModels.dart';
import '../../theme/theme.dart';
import '../atoms/digit_checkbox_icon.dart';

class DropdownOption extends StatefulWidget {
  final DropdownItem option;
  final bool isSelected;
  final SelectionType selectionType;
  final Color backgroundColor;
  final bool? isFocused;
  final int? focusedIndex;
  final List<DropdownItem> selectedOptions;
  final Function(List<DropdownItem>)? onOptionSelected;
  final Function(DropdownItem currentHoverItem, bool isHovered)? onHover;

  const DropdownOption({
    super.key,
    required this.option,
    required this.isSelected,
    required this.selectionType,
    required this.backgroundColor,
    required this.selectedOptions,
    this.onOptionSelected,
    this.isFocused,
    this.onHover,
    this.focusedIndex,
  });

  @override
  _DropdownOptionState createState() => _DropdownOptionState();
}

class _DropdownOptionState extends State<DropdownOption> {
  final Map<DropdownItem, bool> _itemMouseDownStates = {};
  final Map<DropdownItem, bool> _itemHoverStates = {};

  /// Capitalize the first letter if required
  String capitalizeFirstLetter(String text) {
    if (text.isNotEmpty) {
      return text.substring(0, 1).toUpperCase() + text.substring(1);
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);
    return Column(
      children: [
        StatefulBuilder(
          builder: (context, setState) {
            return InkWell(
              onTapDown: (_) {
                setState(() {
                  _itemMouseDownStates[widget.option] = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _itemMouseDownStates[widget.option] = false;
                });
              },
              splashColor: const DigitColors().transparent,
              hoverColor: const DigitColors().transparent,
              highlightColor: const DigitColors().transparent,
              onHover: (hover) {
                if (widget.focusedIndex != -1 && widget.isFocused == true) {
                  setState(() {
                    _itemHoverStates[widget.option] = false;
                  });
                } else {
                  setState(() {
                    if (hover && _itemHoverStates[widget.option] == null) {
                      widget.onHover?.call(widget.option, true);
                    }
                    _itemHoverStates[widget.option] = hover;
                  });
                }
              },
              onTap: () {
                widget.onOptionSelected?.call(widget.selectedOptions);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: Base.hoverBorderWidth,
                    color: _itemMouseDownStates[widget.option] == true ||
                            widget.isFocused == true ||
                            _itemHoverStates[widget.option] == true ||
                            widget.isSelected
                        ? const DigitColors().light.primary1
                        : Colors.transparent,
                  ),
                  color: _itemMouseDownStates[widget.option] == true ||
                          widget.isSelected
                      ? const DigitColors().light.primary1
                      : _itemHoverStates[widget.option] == true ||
                              widget.isFocused == true
                          ? const DigitColors().light.primary1Bg
                          : widget.backgroundColor,
                ),
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: widget.selectionType == SelectionType.nestedSelect
                      ? widget.option.description != null
                          ? const EdgeInsets.symmetric(
                              horizontal: spacer4,
                              vertical: spacer2,
                            )
                          : DropdownConstants.defaultPadding
                      : DropdownConstants.nestedItemPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.isSelected ||
                                  _itemMouseDownStates[widget.option] == true
                              ? DigitCheckboxIcon(
                                  size: spacer5,
                                  state: DigitCheckboxState.checked,
                                  color: const DigitColors().light.paperPrimary,
                                )
                              : const DigitCheckboxIcon(
                                  size: spacer5,
                                  state: DigitCheckboxState.unchecked),
                          const SizedBox(
                            width: spacer3,
                          ),
                          Row(
                            children: [
                              if (widget.option.textIcon != null)
                                Icon(
                                  widget.option.textIcon,
                                  size: DropdownConstants.textIconSize,
                                  color: widget.isSelected ||
                                          _itemMouseDownStates[widget.option] ==
                                              true
                                      ? const DigitColors().light.paperPrimary
                                      : const DigitColors().light.textSecondary,
                                ),
                              if (widget.option.textIcon != null)
                                const SizedBox(
                                  width: spacer1,
                                ),
                              Text(
                                capitalizeFirstLetter(widget.option.name),
                                style: widget.isSelected ||
                                        _itemMouseDownStates[widget.option] ==
                                            true
                                    ? currentTypography.headingS.copyWith(
                                        color: const DigitColors()
                                            .light
                                            .paperPrimary,
                                      )
                                    : widget.option.description != null
                                        ? currentTypography.bodyL.copyWith(
                                            color: const DigitColors()
                                                .light
                                                .textSecondary,
                                          )
                                        : currentTypography.bodyS.copyWith(
                                            color: const DigitColors()
                                                .light
                                                .textPrimary,
                                          ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (widget.option.description != null)
                        Padding(
                          padding: const EdgeInsets.only(left: spacer8),
                          child: Text(
                            capitalizeFirstLetter(widget.option.description!),
                            style: currentTypography.bodyXS.copyWith(
                              color: widget.isSelected ||
                                      _itemMouseDownStates[widget.option] ==
                                          true
                                  ? const DigitColors().light.paperPrimary
                                  : const DigitColors().light.textSecondary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.selectionType == SelectionType.nestedSelect)
          Container(
            height: 1,
            color: const DigitColors().light.genericDivider,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
          )
      ],
    );
  }
}
