/// `DigitCheckbox` is a DigitCheckbox component with a label and optional icon customization.

/// This widget allows the user to toggle between checked and unchecked states. It supports
/// customization of the DigitCheckbox icon color, label, and disabled state.

/// Example usage:
/// ```dart
/// DigitCheckbox(
///   label: 'DigitCheckbox label',
///   onChanged: (value) {
///     // Handle DigitCheckbox state change
///     print('Feature X is now ${value ? 'enabled' : 'disabled'}');
///   },
///   disabled: false, // Set to true to disable the DigitCheckbox
///   value: true, // Set the initial state of the DigitCheckbox
///   padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0), // Customize padding
///   iconColor: Colors.blue, // Customize DigitCheckbox icon color
/// )

import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/checkbox_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../theme/ComponentTheme/chip_theme.dart';
import '../../utils/utils.dart';

class DigitCheckbox extends StatefulWidget {
  /// The current value of the DigitCheckbox.
  final bool value;

  /// The label associated with the DigitCheckbox.
  final String? label;

  /// Callback function triggered when the DigitCheckbox value changes.
  final ValueChanged<bool> onChanged;

  /// Indicates whether the DigitCheckbox is disabled or not.
  final bool isDisabled;

  final bool capitalizeFirstLetter;

  final DigitCheckboxThemeData? checkboxThemeData;

  /// Creates a `DigitCheckbox` widget with the given parameters.
  const DigitCheckbox({
    Key? key,
    this.label,
    required this.onChanged,
    this.isDisabled = false,
    this.value = false,
    this.capitalizeFirstLetter = true,
    this.checkboxThemeData,
  }) : super(key: key);

  @override
  _DigitCheckboxState createState() => _DigitCheckboxState();
}

class _DigitCheckboxState extends State<DigitCheckbox> {
  late bool _currentState;
  bool isHovered = false;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _currentState = widget.value;
  }

  @override
  void didUpdateWidget(DigitCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the value has changed
    if (widget.value != oldWidget.value) {
      setState(() {
        _currentState = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final checkboxThemeData =
        widget.checkboxThemeData ?? theme.extension<DigitCheckboxThemeData>();
    final defaultThemeData = DigitCheckboxThemeData.defaultTheme(context);

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

    /// Capitalize the first letter of the label if required
    final processedLabel = widget.capitalizeFirstLetter
        ? convertInToSentenceCase(widget.label)
        : widget.label;

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: checkboxThemeData?.labelTextDirection ??
          defaultThemeData.labelTextDirection,
      children: [
        Column(
          children: [
            SizedBox(
              height: isMobile ? 0 : 2,
            ),
            InkWell(
              hoverColor: theme.colorTheme.generic.transparent,
              splashColor: theme.colorTheme.generic.transparent,
              highlightColor: theme.colorTheme.generic.transparent,
              focusColor: theme.colorTheme.generic.transparent,
              onFocusChange: (value) {
                setState(() {
                  isFocused = value;
                });
              },
              onHover: (hover) {
                setState(() {
                  isHovered = hover;
                });
              },
              onTap: widget.isDisabled
                  ? null
                  : () {
                      if (mounted) {
                        setState(() {
                          _currentState = !_currentState;
                        });
                        widget.onChanged(_currentState);
                      }
                    },
              child: DigitCheckboxIcon(
                state: _currentState
                    ? DigitCheckboxState.checked
                    : DigitCheckboxState.unchecked,
                isDisabled: widget.isDisabled,
                checkboxThemeData: widget.checkboxThemeData ?? defaultThemeData,
              ),
            ),
          ],
        ),
        if (widget.label != null) ...[
          const SizedBox(width: spacer4),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                processedLabel!,
                style: widget.isDisabled
                    ? checkboxThemeData?.disabledLabelTextStyle ??
                        defaultThemeData.disabledLabelTextStyle
                    : checkboxThemeData?.labelTextStyle ??
                        defaultThemeData.labelTextStyle,
              ),
            ),
          ),
        ]
      ],
    );
  }
}
