import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class TextChunk extends StatelessWidget {
  final String? caption;
  final TextStyle? captionStyle;
  final String? heading;
  final TextStyle? headingStyle;
  final String? subHeading;
  final TextStyle? subHeadingStyle;
  final String? body;
  final TextStyle? bodyStyle;
  final EdgeInsets? padding;

  const TextChunk({
    Key? key,
    this.caption,
    this.heading,
    this.subHeading,
    this.body,
    this.captionStyle,
    this.headingStyle,
    this.subHeadingStyle,
    this.bodyStyle,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (caption != null)
            Text(
              caption!,
              style: captionStyle ?? currentTypography.captionS.copyWith(color: const DigitColors().light.textSecondary),
            ),
          if (caption != null) const SizedBox(height: 8),
          if (heading != null)
            Text(
              heading!,
              maxLines: 5,
              style: headingStyle ?? currentTypography.headingXl.copyWith(color: const DigitColors().light.textPrimary),
            ),
          if (heading != null && (subHeading != null || body != null)) const SizedBox(height: 8),
          if (subHeading != null)
            Text(
              subHeading!,
              style: subHeadingStyle ?? currentTypography.headingM.copyWith(color: const DigitColors().light.textSecondary),
            ),
          if (subHeading != null && body != null) const SizedBox(height: 8),
          if (body != null)
            Text(
              body!,
              style: bodyStyle ?? currentTypography.bodyS.copyWith(color: const DigitColors().light.textSecondary),
            ),
        ],
      ),
    );
  }
}