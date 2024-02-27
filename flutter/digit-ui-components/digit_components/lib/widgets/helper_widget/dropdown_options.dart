import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../models/DropdownModels.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../atoms/digit_checkbox_icon.dart';

class DropdownOption extends StatefulWidget {
  final DropdownItem option;
  final bool isSelected;
  final SelectionType selectionType;
  final Color backgroundColor;
  final List<DropdownItem> selectedOptions;
  final Function(List<DropdownItem>)? onOptionSelected;

  DropdownOption({
    required this.option,
    required this.isSelected,
    required this.selectionType,
    required this.backgroundColor,
    required this.selectedOptions,
    this.onOptionSelected,
  });

  @override
  _DropdownOptionState createState() => _DropdownOptionState();
}

class _DropdownOptionState extends State<DropdownOption> {
  final Map<DropdownItem, bool> _itemMouseDownStates = {};
  final Map<DropdownItem, bool> _itemHoverStates = {};

  @override
  Widget build(BuildContext context) {
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
                setState(() {
                  _itemHoverStates[widget.option] = hover;
                });
              },
              onTap: () {
                widget.onOptionSelected?.call(widget.selectedOptions);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: _itemMouseDownStates[widget.option] == true ||
                            _itemHoverStates[widget.option] == true || widget.isSelected
                        ? const DigitColors().lightPrimaryOrange
                        : Colors.transparent,
                  ),
                  color: _itemMouseDownStates[widget.option] == true ||
                          widget.isSelected
                      ? const DigitColors().lightPrimaryOrange
                      : _itemHoverStates[widget.option] == true
                          ? const DigitColors().orangeBG
                          : widget.backgroundColor,
                ),
                padding: EdgeInsets.zero,
                child: Padding(
                  padding: widget.selectionType == SelectionType.multiSelect
                      ? DropdownConstants.defaultPadding
                      : DropdownConstants.nestedItemPadding,
                  child: Row(
                    children: [
                      widget.isSelected ||
                              _itemMouseDownStates[widget.option] == true
                          ? DigitCheckboxIcon(
                              size: 20,
                              state: CheckboxState.checked,
                              color: const DigitColors().lightPaperPrimary,
                            )
                          : const DigitCheckboxIcon(
                              size: 20, state: CheckboxState.unchecked),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (widget.option.textIcon != null)
                                Icon(
                                  widget.option.textIcon,
                                  size: DropdownConstants.textIconSize,
                                  color: widget.isSelected ||
                                          _itemMouseDownStates[widget.option] ==
                                              true
                                      ? const DigitColors().lightPaperPrimary
                                      : const DigitColors().lightTextSecondary,
                                ),
                              if (widget.option.textIcon != null)
                                const SizedBox(
                                  width: kPadding / 2,
                                ),
                              Text(
                                widget.option.name,
                                style: widget.isSelected ||
                                        _itemMouseDownStates[widget.option] ==
                                            true
                                    ? DigitTheme.instance.mobileTheme.textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                        color: const DigitColors()
                                            .lightPaperPrimary,
                                        height: 1.188,
                                      )
                                    : DigitTheme.instance.mobileTheme.textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                        color: const DigitColors()
                                            .lightTextPrimary,
                                        height: 1.125,
                                      ),
                              ),
                            ],
                          ),
                          if (widget.option.description != null)
                            Text(
                              widget.option.description!,
                              style: DigitTheme
                                  .instance.mobileTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: widget.isSelected ||
                                        _itemMouseDownStates[widget.option] ==
                                            true
                                    ? const DigitColors().lightPaperPrimary
                                    : const DigitColors().lightTextSecondary,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        if (widget.selectionType == SelectionType.nestedMultiSelect)
          Container(
            height: 1,
            color: const DigitColors().lightGenericDivider,
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
