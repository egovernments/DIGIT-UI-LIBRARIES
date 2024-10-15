import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

import '../../theme/ComponentTheme/switch_theme.dart';

class DigitSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showSymbol; // Option to show symbols/icons inside the switch
  final String? label;
  final MainAxisAlignment mainAxisAlignment;
  final DigitSwitchThemeData? themeData;
  final bool disabled;
  final bool readonly;

  const DigitSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.showSymbol = false,
    this.label,
    this.themeData,
    this.disabled = false,
    this.readonly = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  _DigitSwitchState createState() => _DigitSwitchState();
}

class _DigitSwitchState extends State<DigitSwitch>
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
  void didUpdateWidget(DigitSwitch oldWidget) {
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
    final DigitSwitchTheme = theme.extension<DigitSwitchThemeData>() ?? widget.themeData;
    final defaultSwitchTheme = DigitSwitchThemeData.defaultTheme(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: widget.mainAxisAlignment,
      children: [
        InkWell(
          hoverColor: theme.colorTheme.generic.transparent,
          highlightColor: theme.colorTheme.generic.transparent,
          splashColor: theme.colorTheme.generic.transparent,
          onTap: widget.readonly || widget.disabled ? null : _toggleSwitch,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                width: DigitSwitchTheme?.trackWidth ?? defaultSwitchTheme.trackWidth,
                height: DigitSwitchTheme?.trackHeight ?? defaultSwitchTheme.trackHeight,
                padding: DigitSwitchTheme?.padding ?? defaultSwitchTheme.padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(spacer4),
                  color: widget.readonly || widget.disabled ? theme.colorTheme.text.disabled : _animation.value > 0.5
                      ? DigitSwitchTheme?.activeColor ?? defaultSwitchTheme.activeColor
                      : DigitSwitchTheme?.inactiveColor ?? defaultSwitchTheme.inactiveColor,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Active symbol/icon
                    if (_animation.value > 0.5 && widget.showSymbol)
                      Positioned(
                        left: 8,
                        child: Container(
                          width: 2,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(Radius.circular(1)),
                            color: DigitSwitchTheme?.symbolColor ?? defaultSwitchTheme.symbolColor,
                          ),
                        ),
                      ),
                    // Inactive symbol/icon
                    if (_animation.value <= 0.5 && widget.showSymbol)
                      Positioned(
                        right: 6,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: DigitSwitchTheme?.symbolColor ?? defaultSwitchTheme.symbolColor!,
                            ),
                            color: DigitSwitchTheme?.symbolColor ?? defaultSwitchTheme.inactiveColor,
                          ),
                        ),
                      ),
                    // Thumb
                    Positioned(
                      left: _animation.value *( DigitSwitchTheme?.animationValue ?? defaultSwitchTheme.animationValue!),
                      child: Container(
                        width: DigitSwitchTheme?.thumbSize ?? defaultSwitchTheme.thumbSize,
                        height: DigitSwitchTheme?.thumbSize ?? defaultSwitchTheme.thumbSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: DigitSwitchTheme?.symbolColor ?? defaultSwitchTheme.symbolColor,
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
        if (widget.label != null) ...[
          SizedBox(width: theme.spacerTheme.spacer2),
          Flexible(
            child: Text(
              widget.label!,
              style: widget.disabled ? theme.digitTextTheme(context).bodyS.copyWith(
                color: theme.colorTheme.text.disabled,
              ) : DigitSwitchTheme?.labelTextStyle ?? defaultSwitchTheme.labelTextStyle,
            ),
          ),
        ],
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