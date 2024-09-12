import 'dart:math';

import 'package:digit_ui_components/theme/ComponentTheme/digit_tab_bar_theme.dart';
import 'package:digit_ui_components/theme/colors.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class DigitTabBar extends StatefulWidget {
  final List<String> tabs;
  final int initialIndex;
  final ValueChanged<int> onTabSelected;
  final DigitTabBarThemeData? tabBarThemeData;

  const DigitTabBar({
    Key? key,
    required this.tabs,
    this.initialIndex = 0,
    required this.onTabSelected,
    this.tabBarThemeData,
  }) : super(key: key);

  @override
  _DigitTabBarState createState() => _DigitTabBarState();
}

class _DigitTabBarState extends State<DigitTabBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  double _calculateMaxTabWidth(BuildContext context) {
    final textTheme = Theme.of(context).digitTextTheme(context);
    final maxWidth = widget.tabs.map((tab) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: tab,
          style: textTheme.headingM,
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      return textPainter.size.width;
    }).reduce((a, b) => a > b ? a : b);

    return maxWidth + 40;
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final tabBarTheme =
        widget.tabBarThemeData ?? theme.extension<DigitTabBarThemeData>();
    final defaultTabBarTheme = DigitTabBarThemeData.defaultTheme(context);
    final double tabWidth = _calculateMaxTabWidth(context) + 48;
    // Calculate maximum width for each tab based on screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    final int tabCount = widget.tabs.length;
    final double maxTabWidth = screenWidth / tabCount;

    final double tabCorrectWidth = min(tabWidth, maxTabWidth);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: widget.tabs.asMap().entries.map((entry) {
        int index = entry.key;
        String tab = entry.value;

        return GestureDetector(
          onTap: () => _onTabTapped(index),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: maxTabWidth, // Ensure tab width does not exceed maxTabWidth
            ),
            width: tabBarTheme?.tabWidth ?? tabCorrectWidth,
            height: _selectedIndex == index
                ? tabBarTheme?.selectedTabHeight ??
                    defaultTabBarTheme.selectedTabHeight
                : tabBarTheme?.tabHeight ?? defaultTabBarTheme.tabHeight,
            padding: tabBarTheme?.padding ?? defaultTabBarTheme.padding,
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? const DigitColors().light.paperPrimary
                  : const DigitColors().light.paperSecondary,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8)),
              border: Border(
                bottom: BorderSide(
                  color: _selectedIndex == index
                      ? const DigitColors().light.primary1
                      : const DigitColors().light.genericInputBorder,
                  width: _selectedIndex == index ? 4 : 1,
                ),
                left: BorderSide(
                  color: _selectedIndex == index
                      ? const DigitColors().light.primary1
                      : const DigitColors().light.genericInputBorder,
                  width: _selectedIndex == index ? 2 : 1,
                ),
                right: BorderSide(
                  color: _selectedIndex == index
                      ? const DigitColors().light.primary1
                      : const DigitColors().light.genericInputBorder,
                  width: _selectedIndex == index ? 2 : 1,
                ),
                top: BorderSide(
                  color: _selectedIndex == index
                      ? const DigitColors().light.primary1
                      : const DigitColors().light.genericInputBorder,
                  width: _selectedIndex == index ? 2 : 1,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              tab,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: tabBarTheme?.maxLine ?? defaultTabBarTheme.maxLine,
              style: _selectedIndex == index
                  ? tabBarTheme?.selectedTextStyle ??
                      defaultTabBarTheme.selectedTextStyle
                  : tabBarTheme?.unselectedTextStyle ??
                      defaultTabBarTheme.unselectedTextStyle,
            ),
          ),
        );
      }).toList(),
    );
  }
}
