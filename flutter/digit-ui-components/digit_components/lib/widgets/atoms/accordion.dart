import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:flutter/material.dart';
import '../../models/accordionModel.dart';

class DigitAccordion extends StatefulWidget {
  final List<DigitAccordionItem> items;
  final bool allowMultipleOpen;
  final Duration animationDuration;
  final Color? headerBackgroundColor;
  final Color? contentBackgroundColor;
  final double headerElevation;
  final bool divider;

  const DigitAccordion({
    Key? key,
    required this.items,
    this.allowMultipleOpen = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.headerBackgroundColor,
    this.contentBackgroundColor,
    this.headerElevation = 0,
    this.divider = false,
  }) : super(key: key);

  @override
  _DigitAccordionState createState() => _DigitAccordionState();
}

class _DigitAccordionState extends State<DigitAccordion>
    with TickerProviderStateMixin {
  late List<bool> _expandedStates;
  late List<AnimationController> _animationControllers;

  @override
  void initState() {
    super.initState();
    _expandedStates =
        widget.items.map((item) => item.initiallyExpanded).toList();
    _animationControllers = widget.items.map((item) {
      return AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );
    }).toList();

    for (int i = 0; i < _expandedStates.length; i++) {
      if (_expandedStates[i]) {
        _animationControllers[i].forward();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.asMap().entries.map((entry) {
        int index = entry.key;
        DigitAccordionItem item = entry.value;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: _buildAccordionItem(item, index, context),
            ),
            if (widget.divider && index < widget.items.length - 1)
              ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(
                    color: const DigitColors().light.genericDivider,
                    height: 1,
                  ),
                ),
              ],
          ],
        );
      }).toList(),
    );
  }

  Widget _buildAccordionItem(DigitAccordionItem item, int index, BuildContext context) {
    final theme = Theme.of(context);

    bool isMobile = AppView.isMobileView(MediaQuery
        .of(context)
        .size);
    bool isTab = AppView.isTabletView(MediaQuery
        .of(context)
        .size);

    bool isExpanded = _expandedStates[index];
    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: widget.headerBackgroundColor ?? theme.colorTheme.paper.primary,
        borderRadius: BorderRadius.circular(4),
        border: item.showBorder
            ? Border.all(
            color: const DigitColors().light.genericDivider, width: 1.0)
            : null, // Conditional border based on showBorder
        boxShadow: [
          if (widget.headerElevation > 0)
            BoxShadow(
              color: Colors.black26,
              blurRadius: widget.headerElevation,
              offset: Offset(0, widget.headerElevation / 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (!widget.allowMultipleOpen) {
                  for (int i = 0; i < _expandedStates.length; i++) {
                    if (i != index) {
                      _expandedStates[i] = false;
                      _animationControllers[i].reverse();
                    }
                  }
                }
                _expandedStates[index] = !isExpanded;
                if (isExpanded) {
                  _animationControllers[index].reverse();
                } else {
                  _animationControllers[index].forward();
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.headerBackgroundColor ?? theme.colorTheme.paper.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTab ? 20 : 24, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 4,),
                      item.header,
                    ],
                  ),
                  const SizedBox(width: 16,),
                  RotationTransition(
                    turns: _animationControllers[index].drive(
                      Tween(begin: 0.0, end: 0.25),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(item.divider && isExpanded) ...[const DigitDivider(dividerType: DividerType.small,), const SizedBox(height: 8,)],
          SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: _animationControllers[index],
              curve: Curves.easeOut,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: widget.contentBackgroundColor ?? theme.colorTheme.paper.primary,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.only(left: isMobile ? 8.0 : isTab ? 16 : 20, right: isMobile ? 8.0 : isTab ? 16 : 20, bottom: 16.0, top: 8),
              child: item.content,
            ),
          ),
        ],
      ),
    );
  }
}