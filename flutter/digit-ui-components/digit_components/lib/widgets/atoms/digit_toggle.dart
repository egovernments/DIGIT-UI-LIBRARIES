import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

/// Toggle is a custom toggle button widget that provides visual feedback on hover and supports selection.

class Toggle extends StatefulWidget {
  final void Function(bool isSelected) onChanged;
  final String label;
  bool isSelected;
  final double maxLabelWidth;

  Toggle({
    Key? key,
    required this.onChanged,
    required this.label,
    this.isSelected = false,
    required this.maxLabelWidth,
  }) : super(key: key);

  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  bool isHovered = false;
  bool isMouseDown = false;

  /// Utility function to capitalize the first letter of every word
  String capitalizeFirstLetterOfEveryWord(String text) {
    List<String> words = text.split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalizedWord =
            word[0].toUpperCase() + word.substring(1).toLowerCase();
        capitalizedWords.add(capitalizedWord);
      }
    }

    return capitalizedWords.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context);

    /// Capitalize the first letter of the label if required
    final processedLabel = capitalizeFirstLetterOfEveryWord(widget.label);

    return Align(
      alignment: Alignment.centerLeft,
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            isHovered = false;
          });
        },
        child: InkWell(
          hoverColor: const DigitColors().transparent,
          splashColor: const DigitColors().transparent,
          highlightColor: const DigitColors().transparent,
          onTapDown: (_) {
            /// Handle mouse down state
            setState(() {
              isMouseDown = true;
            });
          },
          onTapUp: (_) {
            /// Handle mouse up state
            setState(() {
              isMouseDown = false;
            });
          },
          onTap: () {
            if (widget.isSelected == false) {
              widget.onChanged(true);
            }
          },
          child: Container(
            height: 32,
            width: widget.maxLabelWidth + 40,
            padding: widget.isSelected
                ? const EdgeInsets.all(2.0)
                : const EdgeInsets.symmetric(horizontal: 2.0),
            constraints: const BoxConstraints(
              minWidth: 40,
              maxWidth: 200,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              border: Border.all(
                color: (isHovered || widget.isSelected || isMouseDown)
                    ? const DigitColors().light.primaryOrange
                    : const DigitColors().light.genericDivider,
                width: 1.0,
              ),
              color: widget.isSelected
                  ? const DigitColors().light.primaryOrange
                  : const DigitColors().light.paperPrimary,
              boxShadow: [
                BoxShadow(
                  color: isMouseDown
                      ? const DigitColors().shadowColor
                      : const DigitColors().transparent,
                  offset: const Offset(
                    0,
                    0,
                  ),
                  spreadRadius: 0,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    processedLabel,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: widget.isSelected
                        ? currentTypography.headingS.copyWith(
                            height: 1.5,
                            fontWeight: FontWeight.w700,
                            color: const DigitColors().light.paperPrimary,
                            overflow: TextOverflow.ellipsis,
                          )
                        : currentTypography.bodyXS.copyWith(
                            height: 1.25,
                            color: (isHovered || isMouseDown)
                                ? const DigitColors().light.primaryOrange
                                : const DigitColors().light.textDisabled,
                            overflow: TextOverflow.ellipsis,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
