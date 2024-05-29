import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../helper_widget/button_list.dart';

class ActionCard extends StatelessWidget {
  final double? width;
  final double? height;
  final List<Button> actions;
  final double? spacing;

  const ActionCard({
    super.key,
    this.width,
    this.height,
    this.spacing,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    double? cardWidth = width;

    return Dialog.fullscreen(
      backgroundColor: const DigitColors().transparent,
      child: Center(
        child: Container(
          width: cardWidth,
          height: height,
          margin: EdgeInsets.symmetric(
              vertical: height == null
                  ? isMobile
                      ? 64
                      : isTab
                          ? 100
                          : 74
                  : 0,
              horizontal: width == null
                  ? isMobile
                      ? 16
                      : isTab
                          ? 98
                          : 446
                  : 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(spacer1),
            color: const DigitColors().light.paperPrimary,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(.16),
                offset: const Offset(0, 1),
                spreadRadius: 0,
                blurRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(isMobile
                          ? spacer4
                          : isTab
                              ? spacer5
                              : spacer6),
                      child: ButtonListTile(
                        buttons: actions,
                        isVertical: true,
                        spacing: spacing ??
                            (isMobile
                                ? spacer4
                                : isTab
                                    ? spacer5
                                    : spacer6),
                      ),
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
