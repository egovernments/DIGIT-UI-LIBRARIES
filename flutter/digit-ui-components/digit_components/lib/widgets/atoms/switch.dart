import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final double thumbInset;
  final bool showSymbol; // New property to show/hide label
  final String? label; // Optional label text

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.width = 60.0,
    this.height = 30.0,
    this.thumbInset = 2.0,
    this.showSymbol = false, // Default is to not show label
    this.label,
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = _animationController.drive(
      CurveTween(curve: Curves.easeInOut),
    );

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: [
        if ( widget.label != null) ...[
          Flexible(
            child: Text(widget.label!, style: textTheme.bodyS.copyWith(
              color: theme.colorTheme.text.secondary,
            )),
          ),
          const SizedBox(width: 8),
        ],
        GestureDetector(
          onTap: _toggleSwitch,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                width: 44,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.height / 2),
                  color: _animation.value > 0.5
                      ? const DigitColors().light.primary1
                      : const DigitColors().light.textDisabled,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Rectangle on the left when active
                    if (_animation.value > 0.5 && widget.showSymbol)
                      Positioned(
                        left: 10,
                        child: Container(
                          width: 2,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(Radius.circular(1)),
                            color: const DigitColors().light.paperPrimary,
                          ),
                        ),
                      ),
                    // Circle on the right when inactive
                    if (_animation.value <= 0.5 && widget.showSymbol)
                      Positioned(
                        right: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: const DigitColors().light.paperPrimary,
                            ),
                            color: const DigitColors().light.textDisabled,
                          ),
                        ),
                      ),
                    // Thumb (this remains as the moving part)
                    Positioned(
                      left:
                          _animation.value * widget.width  + 2,
                      top: 2,
                      bottom: 2,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const DigitColors().light.paperPrimary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4.0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _toggleSwitch() {
    final newValue = !widget.value;
    widget.onChanged(newValue);

    if (newValue) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
