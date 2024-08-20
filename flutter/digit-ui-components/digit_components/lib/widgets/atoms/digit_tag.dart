import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

import '../../theme/ComponentTheme/digit_tag_theme.dart';

class Tag extends StatelessWidget {
  final String label;
  final TagType type;
  final bool isIcon;
  final bool isStroke;
  final VoidCallback? onClick;
  final Icon? customIcon;
  final TextStyle? customTextStyle;
  final TagThemeData? themeData;

  const Tag({
    super.key,
    required this.label,
    this.isIcon = false,
    this.isStroke = false,
    this.onClick,
    this.type = TagType.success,
    this.customIcon,
    this.customTextStyle,
    this.themeData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tagThemeData = themeData ?? theme.extension<TagThemeData>();

    final defaultTagThemeData = TagThemeData.defaultTheme(context);

    Color backgroundColor;
    Color textColor;
    Icon? icon;

    switch (type) {
      case TagType.success:
        backgroundColor = tagThemeData?.successBackgroundColor ??
            defaultTagThemeData.successBackgroundColor!;
        textColor =
            tagThemeData?.successColor ?? defaultTagThemeData.successColor!;
        icon = tagThemeData?.successIcon ?? defaultTagThemeData.successIcon!;
        break;
      case TagType.warning:
        backgroundColor = tagThemeData?.warningBackgroundColor ??
            defaultTagThemeData.warningBackgroundColor!;
        textColor =
            tagThemeData?.warningColor ?? defaultTagThemeData.warningColor!;
        icon = tagThemeData?.warningIcon ?? defaultTagThemeData.warningIcon!;
        break;
      case TagType.error:
        backgroundColor = tagThemeData?.errorBackgroundColor ??
            defaultTagThemeData.errorBackgroundColor!;
        textColor = tagThemeData?.errorColor ?? defaultTagThemeData.errorColor!;
        icon = tagThemeData?.errorIcon ?? defaultTagThemeData.errorIcon!;
        break;
      case TagType.monochrome:
        backgroundColor = theme.colorTheme.paper.secondary;
        textColor = tagThemeData?.monochromeColor ??
            defaultTagThemeData.monochromeColor!;
        icon = null;
        break;
    }

    return Container(
      padding: tagThemeData?.padding ?? defaultTagThemeData.padding,
      width: tagThemeData?.tagWidth,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            tagThemeData?.borderRadius ?? defaultTagThemeData.borderRadius,
        border: isStroke
            ? Border.all(
                color: textColor,
                width: tagThemeData?.borderWidth ??
                    defaultTagThemeData.borderWidth!)
            : null,
        boxShadow: onClick!=null
            ? [
                BoxShadow(
                    color: textColor.withOpacity(.15),
                    offset: const Offset(0, 1),
                    spreadRadius: 1,
                    blurRadius: 3),
                BoxShadow(
                    color: textColor.withOpacity(.30),
                    offset: const Offset(0, 1),
                    blurRadius: 2)
              ]
            : null,
      ),
      child: InkWell(
        hoverColor: theme.colorTheme.generic.transparent,
        splashColor: theme.colorTheme.generic.transparent,
        highlightColor: theme.colorTheme.generic.transparent,
        onTap: onClick,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIcon && !(type == TagType.monochrome)) ...[
              customIcon ?? icon!,
              SizedBox(width: theme.spacerTheme.spacer2),
            ],
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                maxLines: themeData?.maxLine ?? defaultTagThemeData.maxLine,
                style: customTextStyle ??
                    tagThemeData?.textStyle?.copyWith(color: textColor) ??
                    defaultTagThemeData.textStyle!.copyWith(color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum TagType {
  success,
  warning,
  error,
  monochrome,
}
