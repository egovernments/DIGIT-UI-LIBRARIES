import 'package:digit_ui_components/theme/ComponentTheme/bread_crumb_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class Breadcrumb extends StatefulWidget {
  final List<String> items;
  final Function(int) onTap;
  final BreadcrumbThemeData? breadcrumbThemeData;

  const Breadcrumb(
      {Key? key,
      required this.items,
      required this.onTap,
      this.breadcrumbThemeData})
      : super(key: key);

  @override
  _BreadcrumbState createState() => _BreadcrumbState();
}

class _BreadcrumbState extends State<Breadcrumb> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final breadCrumbTheme = widget.breadcrumbThemeData ??
        theme.extension<BreadcrumbThemeData>() ??
        BreadcrumbThemeData.defaultTheme(context);

    return Row(
      children: widget.items.asMap().entries.map((entry) {
        int idx = entry.key;
        String item = entry.value;

        return Row(
          children: [
            InkWell(
              highlightColor: theme.colorTheme.generic.transparent,
              hoverColor: theme.colorTheme.generic.transparent,
              splashColor: theme.colorTheme.generic.transparent,
              onHover: idx < widget.items.length - 1
                  ? (hover) {
                      setState(() {
                        if (hover) {
                          _hoveredIndex = idx;
                        } else {
                          _hoveredIndex = null;
                        }
                      });
                    }
                  : null,
              onTap: idx < widget.items.length - 1
                  ? () => widget.onTap(idx)
                  : null,
              child: Text(
                item,
                style: idx < widget.items.length - 1
                    ? breadCrumbTheme.activeTextStyle?.copyWith(
                        decoration: _hoveredIndex == idx
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: theme.colorTheme.primary.primary1,
                      )
                    : breadCrumbTheme.inactiveTextStyle,
              ),
            ),
            if (idx < widget.items.length - 1)
              SizedBox(
                width: theme.spacerTheme.spacer2,
              ),
            if (idx < widget.items.length - 1)
              Text(
                breadCrumbTheme.separatorText,
                style: breadCrumbTheme.separatorTextStyle,
              ),
            if (idx < widget.items.length - 1)
              SizedBox(
                width: theme.spacerTheme.spacer2,
              ),
          ],
        );
      }).toList(),
    );
  }
}
