/// `RadioList` is a widget for rendering a list of radio buttons.
/// This widget provides options for radio buttons, handling hover effects, and a disabled state.
/// Example usage:
/// ```dart
/// RadioList(
///   radioButtons: [
///     RadioButtonModel(code: 'option1', name: 'Option 1'),
///     RadioButtonModel(code: 'option2', name: 'Option 2'),
///   ],
///   onChanged: (selectedValue) {
///     // Handle radio button selection
///   },
///   groupValue: 'option1', // can be passed same to select value initially
///   isDisabled: false,
/// )

import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../models/RadioButtonModel.dart';
import '../../utils/utils.dart';

class RadioList extends StatefulWidget {
  /// List of RadioButtonModel objects representing the radio buttons
  final List<RadioButtonModel> radioButtons;

  /// Callback function to be called when a radio button is selected
  final void Function(RadioButtonModel) onChanged;

  /// Currently selected value in the radio button group
  String groupValue;

  final String? errorMessage;

  /// Flag to indicate if the radio buttons are disabled
  final bool isDisabled;

  final bool readOnly;

  /// container padding
  final EdgeInsetsGeometry containerPadding;

  /// radio button width
  final double radioWidth;

  /// radio button height
  final double radioHeight;
  final bool capitalizeFirstLetter;

  /// Constructor for the RadioList widget
  RadioList({
    Key? key,
    required this.radioButtons,
    required this.onChanged,
    this.groupValue = '',
    this.isDisabled = false,
    this.errorMessage,
    this.readOnly = false,
    this.containerPadding = RadioConstant.defaultPadding,
    this.radioWidth = RadioConstant.radioWidth,
    this.radioHeight = RadioConstant.radioHeight,
    this.capitalizeFirstLetter = true,
  }) : super(key: key);

  /// Create the state for the widget
  @override
  _RadioListState createState() => _RadioListState();
}

/// State class for the RadioList widget
class _RadioListState extends State<RadioList> {
  /// List to track whether each radio button is being hovered over
  late List<bool> isHoveredList;
  late List<bool> isMouseDown;
  late bool isMobile;

  /// Initialize the state
  @override
  void initState() {
    super.initState();

    /// Initialize the hover list with false values
    isHoveredList = List.generate(widget.radioButtons.length, (index) => false);
    isMouseDown = List.generate(widget.radioButtons.length, (index) => false);
  }

  /// Build the widget layout
  @override
  Widget build(BuildContext context) {

    String? capitalizedErrorMessage =
    convertInToSentenceCase(widget.errorMessage);

    DigitTypography currentTypography = getTypography(context, false);
    isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    if (!isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: _buildRadioButtons(currentTypography),
          ),
          if(widget.errorMessage!=null)
            const SizedBox(width: spacer1),
          if(widget.errorMessage!=null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: spacer1 / 2,
                      ),
                      SizedBox(
                        height: spacer4,
                        width: spacer4,
                        child: Icon(
                          Icons.info,
                          color: const DigitColors()
                              .light
                              .alertError,
                          size: BaseConstants.errorIconSize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: spacer1),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(truncateWithEllipsis(256, capitalizedErrorMessage!),
                      style: currentTypography.bodyS.copyWith(
                        color: const DigitColors()
                            .light
                            .alertError,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }

    /// Default layout
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildRadioButtons(currentTypography),
        ),
        if(widget.errorMessage!=null)
          const SizedBox(width: spacer1),
        if(widget.errorMessage!=null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: spacer1 / 2,
                    ),
                    SizedBox(
                      height: spacer4,
                      width: spacer4,
                      child: Icon(
                        Icons.info,
                        color: const DigitColors()
                            .light
                            .alertError,
                        size: BaseConstants.errorIconSize,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: spacer1),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(truncateWithEllipsis(256, capitalizedErrorMessage!),
                    style: currentTypography.bodyS.copyWith(
                      color: const DigitColors()
                          .light
                          .alertError,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> _buildRadioButtons(DigitTypography currentTypography) {

    return widget.radioButtons.map(
      (button) {
        final index = widget.radioButtons.indexOf(button);
        return Padding(
          padding: widget.containerPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: isMobile ? 0 : spacer1 / 2,
                  ),
                  InkWell(
                    hoverColor: const DigitColors().transparent,
                    splashColor: const DigitColors().transparent,
                    highlightColor: const DigitColors().transparent,
                    onHover: widget.isDisabled || widget.readOnly
                        ? null
                        : (hover) {
                            setState(() {
                              isHoveredList[index] = hover;
                            });
                          },
                    onTapDown: widget.isDisabled|| widget.readOnly
                        ? null
                        : (_) {
                            /// Handle mouse down state
                            setState(() {
                              isMouseDown[index] = true;
                            });
                          },
                    onTapUp: widget.isDisabled || widget.readOnly
                        ? null
                        : (_) {
                            /// Handle mouse up state
                            setState(() {
                              isMouseDown[index] = false;
                            });
                          },
                    onTap: widget.isDisabled || widget.readOnly
                        ? null
                        : () {
                            if (mounted) {
                              setState(() {
                                /// Update the selected value and call the onChanged callback
                                widget.groupValue = button.code;
                              });
                              widget.onChanged!(button);
                            }
                          },
                    child: Container(
                      padding: const EdgeInsets.all(spacer1),
                      width: widget.radioWidth,
                      height: widget.radioHeight,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.isDisabled || widget.readOnly
                              ? const DigitColors().light.genericDivider
                              : (widget.groupValue == button.code ||
                                      isHoveredList[index] ||
                                      isMouseDown[index])
                                  ? const DigitColors().light.primary1
                                  : const DigitColors().light.textSecondary,
                          width: ((widget.isDisabled || widget.readOnly) &&
                                      widget.groupValue == button.code) ||
                                  widget.groupValue == button.code
                              ? 2
                              : Base.defaultBorderWidth,
                        ),
                        color: widget.isDisabled || widget.readOnly
                            ? const DigitColors().light.paperSecondary
                            : isMouseDown[index]
                                ? const DigitColors().light.primary1Bg
                                : const DigitColors().light.paperPrimary,
                        boxShadow: isMouseDown[index]
                            ? [
                                BoxShadow(
                                  color: const DigitColors().light.primary1Bg,
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: const Offset(0, 0),
                                ),
                              ]
                            : [],
                      ),
                      child: widget.groupValue == button.code
                          ? Container(
                              height: spacer3,
                              width: spacer3,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: widget.isDisabled || widget.readOnly
                                    ? const DigitColors().light.textDisabled
                                    : const DigitColors().light.primary1,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: spacer2,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: EdgeInsets.only(top: isMobile ? spacer1 / 2 : 0),
                  child: Text(
                    convertInToSentenceCase(button.name)!,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: currentTypography.bodyL.copyWith(
                      color: widget.isDisabled
                          ? const DigitColors().light.textDisabled
                          : const DigitColors().light.textPrimary,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    ).toList();
  }
}
