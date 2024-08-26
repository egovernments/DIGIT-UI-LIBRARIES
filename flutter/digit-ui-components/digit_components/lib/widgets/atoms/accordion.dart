import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

import '../../models/accordionModel.dart';

class DigitAccordion extends StatefulWidget {
  final List<DigitAccordionItem> items;
  final bool allowMultipleOpen;
  final Duration animationDuration;
  final Color headerBackgroundColor;
  final double headerElevation;

  const DigitAccordion({
    Key? key,
    required this.items,
    this.allowMultipleOpen = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.headerBackgroundColor = Colors.white,
    this.headerElevation = 0,
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildAccordionItem(item, index),
        );
      }).toList(),
    );
  }

  Widget _buildAccordionItem(DigitAccordionItem item, int index) {
    bool isExpanded = _expandedStates[index];
    return AnimatedContainer(
      duration: widget.animationDuration,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: const DigitColors().light.paperSecondary,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        border: Border.all(
            color: const DigitColors().light.genericDivider, width: 1.0),
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
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: item.header),
                  RotationTransition(
                    turns: _animationControllers[index].drive(
                      Tween(begin: 0.0, end: -0.25),
                    ),
                    child: const Icon(
                      Icons.chevron_right,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: _animationControllers[index],
              curve: Curves.easeInOut,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 4.0),
              child: item.content,
            ),
          ),
        ],
      ),
    );
  }
}
