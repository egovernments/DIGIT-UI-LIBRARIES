import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitTextBlock extends StatelessWidget {
  final String? caption;
  final TextStyle? captionStyle;
  final String? heading;
  final TextStyle? headingStyle;
  final String? subHeading;
  final TextStyle? subHeadingStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final EdgeInsets? padding;
  final double spacing;

  const DigitTextBlock({
    Key? key,
    this.caption,
    this.heading,
    this.subHeading,
    this.description,
    this.captionStyle,
    this.headingStyle,
    this.subHeadingStyle,
    this.descriptionStyle,
    this.padding,
    this.spacing = spacer2,
  }) : super(key: key);

  List<Widget> _conditionalRender(String? text, TextStyle? style, {bool addSpacing = false}) {
    if (text == null) return [];
    List<Widget> children = [
      Text(
        text,
        style: style,
      ),
    ];
    if (addSpacing) children.add(SizedBox(height: spacing));
    return children;
  }

  List<Widget> _buildTextBlocks(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final List<Widget> blocks = [];

    blocks.addAll(_conditionalRender(
      caption,
      captionStyle ?? textTheme.captionS.copyWith(color: theme.colorTheme.text.secondary),
      addSpacing: caption != null && (heading != null || subHeading != null || description != null),
    ));

    blocks.addAll(_conditionalRender(
      heading,
      headingStyle ?? textTheme.headingXl.copyWith(color: theme.colorTheme.text.primary),
      addSpacing: heading != null && (subHeading != null || description != null),
    ));

    blocks.addAll(_conditionalRender(
      subHeading,
      subHeadingStyle ?? textTheme.headingM.copyWith(color: theme.colorTheme.text.secondary),
      addSpacing: subHeading != null && description != null,
    ));

    blocks.addAll(_conditionalRender(
      description,
      descriptionStyle ?? textTheme.bodyS.copyWith(color: theme.colorTheme.text.secondary),
    ));

    return blocks;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: spacer2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildTextBlocks(context),
      ),
    );
  }
}