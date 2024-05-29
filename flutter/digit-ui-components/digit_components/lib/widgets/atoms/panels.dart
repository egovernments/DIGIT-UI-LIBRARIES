import 'package:digit_ui_components/constants/app_constants.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../constants/AppView.dart';

class Panel extends StatelessWidget {
  final PanelType type;
  final String title;
  final List<Text>? description;

  const Panel(
      {Key? key, required this.type, required this.title, this.description})
      : super(key: key);

  Color _getBackgroundColor() {
    switch (type) {
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
        padding: EdgeInsets.all(isMobile ? 32 : 40),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: isMobile ? const BorderRadius.only(
              topLeft: Radius.circular(4), topRight: Radius.circular(4)) : Common.radius,
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            type == PanelType.success
                ? Lottie.asset(
                    'assets/animation_json/success.json',
                    repeat: false,
                    width: isMobile
                        ? 40
                        : isTab
                            ? 48
                            : 56,
                    height: isMobile
                        ? 40
                        : isTab
                            ? 48
                            : 56,
                    fit: BoxFit.fill,
                  )
                : Lottie.asset(
                    'assets/animation_json/error.json',
                    repeat: false,
                    width: isMobile
                        ? 40
                        : isTab
                            ? 48
                            : 56,
                    height: isMobile
                        ? 40
                        : isTab
                            ? 48
                            : 56,
                    fit: BoxFit.fill,
                  ),
            const SizedBox(
              height: 24,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: currentTypography.headingXl.copyWith(
                color: const DigitColors().light.paperPrimary,
              ),
            ),
            if (description != null)
            const SizedBox(
              height: 24,
            ),
            if (description != null)
              ...description!
                  .asMap()
                  .entries
                  .map((widgets) => Padding(
                        padding: EdgeInsets.only(
                            bottom:
                                widgets.key != description!.length - 1 ? 4 : 0),
                        child: widgets.value,
                      ))
                  .toList(),
          ],
        ));
  }
}

enum PanelType {
  success,
  error,
}
