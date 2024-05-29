import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:digit_ui_components/constants/app_constants.dart';
import 'package:digit_ui_components/digit_components.dart';
import '../../constants/AppView.dart';

class Panel extends StatefulWidget {
  final PanelType type;
  final String title;
  final List<Text>? description;
  final bool animate;
  final bool repeat;

  const Panel({
    Key? key,
    required this.type,
    required this.title,
    this.description,
    this.animate = true,
    this.repeat = false,
  }) : super(key: key);

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case PanelType.success:
        return const DigitColors().light.alertSuccess;
      case PanelType.error:
        return const DigitColors().light.alertError;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return Container(
      padding: const EdgeInsets.all(40),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: isMobile
            ? const BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4))
            : Common.radius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            widget.type == PanelType.success
                ? 'assets/animation_json/success.json'
                : 'assets/animation_json/error.json',
            controller: _controller,
            onLoaded: (composition) {
              _controller.duration = composition.duration;
              if (widget.animate == true) {
                if (widget.repeat == true) {
                  _controller.repeat();
                } else {
                  _controller.forward();
                }
              } else {
                _controller.value = 1.0; /// Move to the last frame
              }
            },
            width: isMobile ? 56 : isTab ? 64 : 74,
            height: isMobile ? 56 : isTab ? 64 : 74,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: currentTypography.headingXl.copyWith(
              color: const DigitColors().light.paperPrimary,
            ),
          ),
          if (widget.description != null)
            const SizedBox(
              height: 24,
            ),
          if (widget.description != null)
            ...widget.description!
                .asMap()
                .entries
                .map((widgets) => Padding(
              padding: EdgeInsets.only(
                  bottom: widgets.key != widget.description!.length - 1
                      ? 4
                      : 0),
              child: widgets.value,
            ))
                .toList(),
        ],
      ),
    );
  }
}

enum PanelType {
  success,
  error,
}
