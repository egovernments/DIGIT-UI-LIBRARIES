import 'dart:math';

import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

import '../molecules/digit_card.dart';

// Model to hold card data
class MenuCardItem {
  final Widget? centerWidget;
  final IconData? centerIcon;
  final String label;
  final String? description;
  final VoidCallback? onTap;

  MenuCardItem({
    this.centerWidget,
    this.centerIcon,
    required this.label,
    this.description,
    this.onTap,
  }) : assert(centerWidget != null || centerIcon != null,
  'Either centerWidget or centerIcon must be provided.');
}

class GroupMenu extends StatefulWidget {
  final List<MenuCardItem> items;
  final int crossAxisCount;

  const GroupMenu({
    Key? key,
    required this.items,
    this.crossAxisCount = 3,
  }) : super(key: key);

  @override
  _GroupMenuState createState() => _GroupMenuState();
}

class _GroupMenuState extends State<GroupMenu> {
  final List<GlobalKey> _keys = [];
  double _maxCardHeight = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureCardHeights();
    });
  }

  void _measureCardHeights() {
    double maxHeight = 0;
    for (var key in _keys) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        final height = box?.size.height ?? 0;
        maxHeight = max(maxHeight, height);
      }
    }
    setState(() {
      _maxCardHeight = maxHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: .8, // Aspect ratio is kept as 1 to ensure card width equals height
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final key = GlobalKey();
        _keys.add(key);
        return GroupMenuCard(
          key: key,
          widget: item.centerWidget ?? Icon(
            item.centerIcon!,
            size: 32,
            color: theme.colorTheme.primary.primary1,
          ),
          label: item.label,
          description: item.description,
          onTap: item.onTap,
          fixedHeight: _maxCardHeight,
        );
      },
    );
  }
}

class GroupMenuCard extends StatelessWidget {
  final Widget widget;
  final String label;
  final String? description;
  final VoidCallback? onTap;
  final double fixedHeight;

  const GroupMenuCard({
    Key? key,
    required this.widget,
    required this.label,
    this.description,
    this.onTap,
    required this.fixedHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitCard(
      onPressed: onTap,
      children: [
        SizedBox(
          width: double.infinity, // Ensures the card takes up the full width available
          height: fixedHeight, // Use the fixed height for consistency
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget,
              const SizedBox(height: 12),
              Text(
                label,
                style: textTheme.bodyL.copyWith(
                  color: theme.colorTheme.text.primary,
                ),
                textAlign: TextAlign.center,
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                Text(
                  description!,
                  style: textTheme.bodyS.copyWith(
                    color: theme.colorTheme.text.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}