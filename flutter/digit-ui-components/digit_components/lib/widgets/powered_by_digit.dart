import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';

class PoweredByDigit extends StatefulWidget {
  final Size? size;
  final EdgeInsets? padding;
  final String version;
  final bool ispaperPrimaryLogo;

  const PoweredByDigit(
      {super.key,
      this.size,
      this.padding,
      this.ispaperPrimaryLogo = false,
      required this.version});

  @override
  State<PoweredByDigit> createState() => _PoweredByDigitState();
}

class _PoweredByDigitState extends State<PoweredByDigit> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: Center(
          child: Column(children: [
            Container(
              height: 24,
              padding: widget.padding ?? const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: Image.asset( Base.digitLogo,
                  // package: 'digit_components',
                  fit: BoxFit.contain,
                  color: widget.ispaperPrimaryLogo
                      ? DigitTheme.instance.colorScheme.onPrimary
                      : null),
            ),
            Text(widget.version)
          ]),
        ),
      );
}
