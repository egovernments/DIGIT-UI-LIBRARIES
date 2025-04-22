import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../helper_widget/button_list.dart';

class DigitBottomSheet extends StatefulWidget {
  final double? initialHeightPercentage;
  final double? fixedHeight;
  final bool disableDrag;
  final Widget content;
  final String? primaryActionLabel;
  final String? secondaryActionLabel;
  final void Function(BuildContext context)? onPrimaryAction;
  final void Function(BuildContext context)? onSecondaryAction;

  const DigitBottomSheet({
    Key? key,
    required this.content,
    this.initialHeightPercentage,
    this.fixedHeight,
    this.primaryActionLabel,
    this.secondaryActionLabel,
    this.disableDrag = false,
    this.onPrimaryAction,
    this.onSecondaryAction,
  }) : super(key: key);

  @override
  _DigitBottomSheetState createState() => _DigitBottomSheetState();
}

class _DigitBottomSheetState extends State<DigitBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late double _currentHeight;
  late Map<double, double> _heightOptions;
  late bool isAction;
  late bool isAtMaxHeight;

  @override
  void initState() {
    super.initState();
    isAction = widget.onSecondaryAction != null || widget.onPrimaryAction != null;
    isAtMaxHeight = false;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    double screenHeight = MediaQuery.of(context).size.height;

    _heightOptions = {
      5: isAction ? screenHeight * 0.2 : screenHeight * 0.05,
      30: screenHeight * 0.30,
      50: screenHeight * 0.50,
      70: screenHeight * 0.70,
      100: screenHeight * 1.00,
    };

    double actionHeight = isAction ? 40: 0.0; // Adjust based on actual height of actions
    _currentHeight = widget.fixedHeight ??
        (_heightOptions[widget.initialHeightPercentage] ??
            (isAction ? screenHeight * 0.1 + actionHeight : screenHeight * 0.05));

    _heightAnimation = Tween<double>(
      begin: 0,
      end: _currentHeight,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateHeight(double newHeight) {
    setState(() {
      _currentHeight = newHeight;
      isAtMaxHeight = _currentHeight == _heightOptions[100];

      _heightAnimation = Tween<double>(
        begin: _heightAnimation.value,
        end: _currentHeight,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ));
      _animationController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: MouseRegion(
            cursor: widget.disableDrag
                ? SystemMouseCursors.basic
                : SystemMouseCursors.resizeDown,
            child: GestureDetector(
              onVerticalDragUpdate: widget.disableDrag
                  ? null
                  : (details) {
                setState(() {
                  _currentHeight = (_heightAnimation.value) - details.primaryDelta!;
                  final minHeight = _heightOptions.values.first;
                  final maxHeight = _heightOptions.values.last;
                  _currentHeight = _currentHeight.clamp(minHeight, maxHeight);

                  _heightAnimation = Tween<double>(
                    begin: _heightAnimation.value,
                    end: _currentHeight,
                  ).animate(CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.easeInOut,
                  ));

                  isAtMaxHeight = _currentHeight == maxHeight;
                });
              },
              onVerticalDragEnd: widget.disableDrag
                  ? null
                  : (details) {
                final snappedHeight = _heightOptions.values.reduce(
                      (a, b) => (_currentHeight - a).abs() <
                      (_currentHeight - b).abs()
                      ? a
                      : b,
                );
                _updateHeight(snappedHeight);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: _heightAnimation.value,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: _currentHeight == _heightOptions[100]
                      ? null
                      : const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000026).withOpacity(.15),
                      blurRadius: 4,
                      spreadRadius: -1,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (!isAtMaxHeight)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 100,
                        height: 6,
                        decoration: BoxDecoration(
                          color: const DigitColors().light.textDisabled,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: widget.content,
                        ),
                      ),
                    ),
                    if (isAction)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                        child: DigitButtonListTile(
                          spacing: 24,
                          buttons: [
                            if(widget.onPrimaryAction != null)
                              DigitButton(
                                label: widget.primaryActionLabel ?? '',
                                onPressed: () {
                                  widget.onPrimaryAction?.call(context);
                                },
                                type: DigitButtonType.primary,
                                size: DigitButtonSize.large,
                              ),
                            if(widget.onSecondaryAction != null)
                              DigitButton(
                                label: widget.secondaryActionLabel ?? '',
                                onPressed: () {
                                  widget.onSecondaryAction?.call(context);
                                },
                                type: DigitButtonType.secondary,
                                size: DigitButtonSize.large,
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}