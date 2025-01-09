import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class LabelValueItem extends StatelessWidget {
  final String label;
  final dynamic value;
  final TextStyle? labelTextStyle;
  final TextStyle? valueTextStyle;
  final bool isInline;
  final int labelFlex;
  final int valueFlex;
  final int? maxLines;
  final EdgeInsets? padding;

  const LabelValueItem({
    Key? key,
    required this.label,
    required this.value,
    this.labelTextStyle,
    this.valueTextStyle,
    this.isInline = true, // Default to inline layout
    this.labelFlex = 2,
    this.valueFlex = 8,
    this.maxLines,
    this.padding,
  }) : super(key: key);

  Widget _buildValue(dynamic value, BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    if (value is String) {
      return Text(
        value,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: valueTextStyle ?? textTheme.bodyS.copyWith(
          color: theme.colorTheme.text.primary,
        ),
      );
    } else if (value is List<String>) {
      // If the value is a list of strings, wrap each string in a Text widget and use Wrap for multi-line support.
      return Wrap(
        spacing: 8.0, // Gap between each item
        runSpacing: 8.0, // Gap between lines
        children: value
            .map((str) => Text(
          str,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: valueTextStyle ?? textTheme.bodyS.copyWith(
            color: theme.colorTheme.text.primary,
          ),
        ))
            .toList(),
      );
    } else if (value is Widget) {
      // If the value is a single widget, return it directly.
      return value;
    } else if (value is List<Widget>) {
      // If the value is a list of widgets, wrap them in a Wrap for multi-line support.
      return Wrap(
        spacing: 8.0, // Gap between each widget
        runSpacing: 8.0, // Gap between rows of widgets
        children: value,
      );
    } else {
      return Container(); // Return an empty container if no valid type is provided.
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: isInline
          ? Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: labelFlex,
            child: Text(
              label,
              style: labelTextStyle ??
                  textTheme.headingS.copyWith(
                    color: theme.colorTheme.text.primary,
                  ),
            ),
          ),
          const SizedBox(width: spacer6), // Optional spacing between label and value
          Expanded(
            flex: valueFlex,
            child: _buildValue(value, context),
          ),
        ],
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: labelTextStyle ??
                textTheme.headingS.copyWith(
                  color: theme.colorTheme.text.primary,
                ),
          ),
          const SizedBox(height: 8),
          _buildValue(value, context),
        ],
      ),
    );
  }
}
