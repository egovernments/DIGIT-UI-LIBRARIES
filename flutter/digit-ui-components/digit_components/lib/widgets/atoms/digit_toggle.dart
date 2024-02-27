import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
/// DigitToggle is a custom toggle button widget that provides visual feedback on hover and supports selection.

class DigitToggle extends StatefulWidget {
  final void Function(bool isSelected) onChanged;
  final String label;
  bool isSelected;
  final double maxLabelWidth;

  DigitToggle({
    Key? key,
    required this.onChanged,
    required this.label,
    this.isSelected = false,
    required this.maxLabelWidth,
  }) : super(key: key);

  @override
  _DigitToggleState createState() => _DigitToggleState();
}

class _DigitToggleState extends State<DigitToggle> {
  bool isHovered = false;
  bool isMouseDown = false;

  @override
  Widget build(BuildContext context) {
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
            if(widget.isSelected==false){
              widget.onChanged(true);
            }
          },
          child: Container(
            height: 32,
            width: widget.maxLabelWidth+40,
            padding: widget.isSelected ? const EdgeInsets.all(2.0) : const EdgeInsets.symmetric(horizontal: 2.0),
            constraints: const BoxConstraints(
              minWidth: 40,
              maxWidth: 200,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.zero,
              border: Border.all(
                color: (isHovered || widget.isSelected || isMouseDown)
                    ? const DigitColors().lightPrimaryOrange
                    : const DigitColors().lightGenericDivider,
                width: 1.0,
              ),
              color: widget.isSelected
                  ? const DigitColors().lightPrimaryOrange
                  : const DigitColors().lightPaperPrimary,
              boxShadow: [
                BoxShadow(
                  color: isMouseDown ? const DigitColors().shadowColor : const DigitColors().transparent,
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
                    widget.label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: widget.isSelected
                   ? DigitTheme.instance.mobileTheme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        fontWeight: FontWeight.w700,
                        color: const DigitColors().lightPaperPrimary,
                        overflow: TextOverflow.ellipsis,
                    )
                    :DigitTheme.instance.mobileTheme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: (isHovered || isMouseDown)
                          ? const DigitColors().lightPrimaryOrange
                          : widget.isSelected
                          ? const DigitColors().lightPaperPrimary
                          : const DigitColors().lightTextDisabled,
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