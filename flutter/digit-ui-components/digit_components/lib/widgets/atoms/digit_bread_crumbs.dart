import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/ComponentTheme/bread_crumb_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitBreadCrumb extends StatefulWidget {
  final List<DigitBreadCrumbItem> crumbs;
  final int? maxItems;
  final int? itemsBeforeCollapse;
  final int? itemsAfterCollapse;
  final String? expandText;
  final Widget? customSeparator;
  final DigitBreadCrumbThemeData? themeData;
  final void Function(DigitBreadCrumbItem)? onClick;

  const DigitBreadCrumb({
    Key? key,
    required this.crumbs,
    this.maxItems,
    this.itemsBeforeCollapse,
    this.itemsAfterCollapse,
    this.expandText = '...',
    this.customSeparator,
    this.themeData,
    this.onClick,
  }) : super(key: key);

  @override
  _DigitBreadCrumbState createState() => _DigitBreadCrumbState();
}

class _DigitBreadCrumbState extends State<DigitBreadCrumb> {
  bool expanded = false;
  late List<DigitBreadCrumbItem> crumbsToDisplay;
  final Set<int> hoveredIndexes = {};

  @override
  void initState() {
    super.initState();
    _updateCrumbsToDisplay();
  }

  void _updateCrumbsToDisplay() {
    if (widget.maxItems != null &&
        widget.crumbs.length > widget.maxItems! &&
        !expanded) {
      final startCrumbs = widget.crumbs
          .sublist(0, widget.itemsBeforeCollapse ?? widget.maxItems! ~/ 2);
      final endCrumbs = widget.crumbs.sublist(widget.crumbs.length -
          (widget.itemsAfterCollapse ?? widget.maxItems! ~/ 2));
      crumbsToDisplay = [
        ...startCrumbs,
        DigitBreadCrumbItem(content: widget.expandText ?? '...', show: true),
        ...endCrumbs,
      ];
    } else {
      crumbsToDisplay = widget.crumbs;
    }
  }

  void _toggleExpanded() {
    setState(() {
      expanded = !expanded;
      _updateCrumbsToDisplay();
    });
  }

  bool _isLast(int index) {
    return index == crumbsToDisplay.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DigitBreadCrumbTheme = widget.themeData ??
        theme.extension<DigitBreadCrumbThemeData>();
    final defaultTheme = DigitBreadCrumbThemeData.defaultTheme(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: crumbsToDisplay.map((crumb) {
        if (!crumb.show) return Container();

        final index = crumbsToDisplay.indexOf(crumb);
        final isHovered = hoveredIndexes.contains(index);
        final isLast = _isLast(index);

        return Row(
          children: [
            InkWell(
              highlightColor: theme.colorTheme.generic.transparent,
              hoverColor: theme.colorTheme.generic.transparent,
              splashColor: theme.colorTheme.generic.transparent,
              onHover: isLast ? null : (value) {
                if(value){
                  setState(() => hoveredIndexes.add(index));
                } else {
                  setState(() => hoveredIndexes.remove(index));
                }
              },
              onTap: isLast ? null : crumb.content == widget.expandText
                  ? _toggleExpanded
                  : widget.onClick != null
                  ? () => widget.onClick!(crumb)
                  : null,
              child: Row(
                children: [
                  if (crumb.icon != null) Icon(crumb.icon, size: theme.spacerTheme.spacer5, color: isLast ? theme.colorTheme.text.secondary: theme.colorTheme.primary.primary1,),
                  if (crumb.icon != null) const SizedBox(width: spacer1,),
                  Text(
                    crumb.content,
                    style: (isLast
                        ? DigitBreadCrumbTheme?.inactiveTextStyle ??
                        defaultTheme.inactiveTextStyle
                        : DigitBreadCrumbTheme?.activeTextStyle ??
                        defaultTheme.activeTextStyle)
                        ?.copyWith(
                      decoration: isHovered && !isLast
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: theme.colorTheme.primary.primary1,
                    ),
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                padding:
                DigitBreadCrumbTheme?.itemPadding ?? defaultTheme.itemPadding,
                child: widget.customSeparator ??
                    Text(
                      '/',
                      style: DigitBreadCrumbTheme?.separatorTextStyle ??
                          defaultTheme.separatorTextStyle,
                    ),
              ),
          ],
        );
      }).toList(),
    );
  }
}

class DigitBreadCrumbItem {
  final String content;
  final bool show;
  final IconData? icon;

  DigitBreadCrumbItem({
    required this.content,
    this.show = true,
    this.icon,
  });
}
