/// A custom Panel widget that displays a title, an optional description, and an animation.
/// The panel can be of type success or error, each having distinct background colors,
/// animation sizes, and paddings. The appearance of the panel can be customized using
/// the PanelThemeData theme extension.
///
/// Basic Use Case:
/// ```
/// Panel(
///   type: PanelType.success,
///   title: 'Success Panel',
///   description: [Text('This is a success message')],
/// )
/// ```

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/theme/ComponentTheme/panel_theme.dart';

class Panel extends StatefulWidget {
  final PanelType type;
  final String title;
  final List<Text>? description;
  final bool animate;
  final bool repeat;
  final PanelThemeData? panelThemeData;

  const Panel({
    Key? key,
    required this.type,
    required this.title,
    this.description,
    this.animate = true,
    this.repeat = false,
    this.panelThemeData,
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final themeData = widget.panelThemeData ??
        theme.extension<PanelThemeData>() ??
        PanelThemeData.defaultTheme(context);

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return Container(
      padding: widget.type == PanelType.success
          ? themeData.successPadding
          : themeData.errorPadding,
      width: themeData.cardWidth,
      decoration: BoxDecoration(
        color: widget.type == PanelType.success
            ? themeData.successBackgroundColor
            : themeData.errorBackgroundColor,
        borderRadius: themeData.radiusGeometry,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            widget.type == PanelType.success
                ? themeData.successJson
                : themeData.errorJson,
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
                _controller.value = 1.0;

                /// Move to the last frame
              }
            },
            width: widget.type == PanelType.success
                ? themeData.successAnimationSize
                : themeData.errorAnimationSize,
            height: widget.type == PanelType.success
                ? themeData.successAnimationSize
                : themeData.errorAnimationSize,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: widget.type == PanelType.success
                ? 0
                : isMobile
                    ? theme.spacerTheme.spacer4
                    : isTab
                        ? theme.spacerTheme.spacer5
                        : theme.spacerTheme.spacer6,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: themeData.titleTextStyle,
          ),
          if (widget.description != null)
            SizedBox(
              height: theme.spacerTheme.spacer6,
            ),
          if (widget.description != null)
            ...widget.description!
                .asMap()
                .entries
                .map((widgets) => Padding(
                      padding: EdgeInsets.only(
                          bottom: widgets.key != widget.description!.length - 1
                              ? theme.spacerTheme.spacer1
                              : 0),
                      child: widgets.value,
                    ))
                .toList(),
        ],
      ),
    );
  }
}
