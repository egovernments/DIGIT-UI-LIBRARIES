import 'package:digit_ui_components/theme/colors.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final List<String> tabs;
  final int initialIndex;
  final ValueChanged<int> onTabSelected;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    this.initialIndex = 0,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
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

    return maxWidth + 40; // Add padding to account for horizontal padding
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
    final double tabWidth = _calculateMaxTabWidth(context)+ 80;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: widget.tabs.asMap().entries.map((entry) {
        int index = entry.key;
        String tab = entry.value;

        return GestureDetector(
          onTap: () => _onTabTapped(index),
          child: Container(
            width: tabWidth,
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? const DigitColors().light.paperPrimary
                  : const DigitColors().light.genericBackground,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8)),
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
                  width: 1,
                ),
                right: BorderSide(
                  color: _selectedIndex == index
                      ? const DigitColors().light.primary1
                      : const DigitColors().light.genericInputBorder,
                  width: 1,
                ),
                top: BorderSide(
                  color: _selectedIndex == index
                      ? const DigitColors().light.primary1
                      : const DigitColors().light.genericInputBorder,
                  width: 1,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              tab,
              style: textTheme.headingM.copyWith(
                color: _selectedIndex == index
                    ? const DigitColors().light.primary1
                    : const DigitColors().light.textSecondary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
