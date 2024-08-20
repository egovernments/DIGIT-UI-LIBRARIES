import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  final double? initialHeightPercentage;
  final Widget content;
  final void Function(BuildContext context)? onPrimaryAction;
  final void Function(BuildContext context)? onSecondaryAction;

  const CustomBottomSheet({
    Key? key,
    required this.content,
    this.initialHeightPercentage,
    this.onPrimaryAction,
    this.onSecondaryAction,
  }) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  late double _currentHeight;
  late Map<double, double> _heightOptions;
  late bool isAction;

  @override
  void initState() {
    isAction = widget.onSecondaryAction != null || widget.onPrimaryAction != null;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    double screenHeight = MediaQuery.of(context).size.height;

    _heightOptions = {
      5: isAction ? screenHeight * 0.2 : screenHeight * 0.05,  // 15% height with action buttons, 5% without
      30: screenHeight * 0.30,  // 30% height
      50: screenHeight * 0.50,  // 50% height
      70: screenHeight * 0.70,  // 70% height
      100: screenHeight * 1.00, // Full-screen height
    };

    _currentHeight = _heightOptions[widget.initialHeightPercentage] ?? (isAction ? screenHeight*.1 : screenHeight * 0.05);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

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
    print(isAction);
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: MouseRegion(
            cursor: SystemMouseCursors.resizeUpDown,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
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
                });
              },
              onVerticalDragEnd: (details) {
                final snappedHeight = _heightOptions.values.reduce(
                      (a, b) => (_currentHeight - a).abs() < (_currentHeight - b).abs() ? a : b,
                );
                _updateHeight(snappedHeight);
              },
              child: Container(
                height: _heightAnimation.value,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10.0,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: 100,
                      height: 6,
                      decoration: BoxDecoration(
                        color: const DigitColors().light.genericInputBorder,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: widget.content,
                        ),
                      ),
                    ),
                     if (isAction)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Button(
                              label: 'Button 1',
                              onPressed: () {
                                widget.onPrimaryAction?.call(context);
                              },
                              type: ButtonType.secondary,
                              size: ButtonSize.large,
                            ),
                            const SizedBox(width: 8,),
                            Button(
                              label: 'Button 2',
                              onPressed: () {
                                widget.onSecondaryAction?.call(context);
                              },
                              type: ButtonType.primary,
                              size: ButtonSize.large,
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
