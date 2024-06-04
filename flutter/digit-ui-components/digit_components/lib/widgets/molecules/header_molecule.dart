import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../atoms/digit_header.dart';

class CustomHeaderMolecule extends StatelessWidget {
  final HeaderType type;
  final String? title;
  final List<Widget>? actions;
  final String? leadingImageUrl;
  final String? trailingImageUrl;

  const CustomHeaderMolecule({
    Key? key,
    this.type = HeaderType.light,
    this.title,
    this.actions,
    this.leadingImageUrl,
    this.trailingImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTab ? 24 : 40.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: type == HeaderType.light
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.primary2,
        boxShadow: type == HeaderType.light
            ? [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.15),
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
            Row(
              children: [
                if (leadingImageUrl != null)
                SizedBox(
                  height: 32.0,
                  width: 20,
                  child: Image.network(
                    leadingImageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
                if (title != null && leadingImageUrl != null)
                  const SizedBox(
                    width: 16,
                  ),
                if (title != null)
                  Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: currentTypography.headingM
                        .copyWith(color: const DigitColors().light.textPrimary),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          const SizedBox(width: 24,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (actions != null)
                ...actions!.expand((widget) => [
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: widget,
                      ),
                    ]),
              if (trailingImageUrl != null)
                SizedBox(
                  height: 32.0,
                  child: Image.network(
                    trailingImageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
