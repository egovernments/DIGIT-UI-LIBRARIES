import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class TextChunk extends StatelessWidget {
  final String? caption;
  final String? heading;
  final String? subheading;
  final String? body;

  const TextChunk({
    Key? key,
    this.caption,
    this.heading,
    this.subheading,
    this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (caption != null)
          Text(
            caption!,
            style: currentTypography.captionS
                .copyWith(color: const DigitColors().light.textSecondary),
          ),
        if (caption != null) const SizedBox(height: 8),
        if (heading != null)
          Text(heading!,
              maxLines: 5,
              style: currentTypography.headingXl
                  .copyWith(color: const DigitColors().light.textPrimary)),
        if (heading != null) const SizedBox(height: 8),
        if (subheading != null)
          Text(subheading!,
              style: currentTypography.headingM
                  .copyWith(color: const DigitColors().light.textSecondary)),
        if (subheading != null) const SizedBox(height: 8),
        if (body != null)
          Text(body!,
              style: currentTypography.bodyS
                  .copyWith(color: const DigitColors().light.textSecondary)),
      ],
    );
  }
}
