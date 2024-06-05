import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../atoms/digit_header.dart';

class CustomHeaderMolecule extends StatelessWidget {
  final HeaderType type;
  final String? title;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final Widget? trailingWidget;

  const CustomHeaderMolecule({
    Key? key,
    this.type = HeaderType.light,
    this.title,
    this.actions,
    this.leadingWidget,
    this.trailingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

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
      child: isMobile || isTab
        ? _buildMobileTabHeader(context):
        _buildDesktopHeader(context),
    );
  }

  Widget _buildMobileTabHeader(BuildContext context) {

    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            leadingWidget ?? Icon(Icons.menu, size: 24, color: type==HeaderType.dark ? const DigitColors().light.paperPrimary : const DigitColors().light.textPrimary,),
            if (title != null)
              const SizedBox(
                width: 16,
              ),
            if (title != null)
              Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style: currentTypography.headingM
                    .copyWith(color: type==HeaderType.dark ? const DigitColors().light.paperPrimary :const DigitColors().light.textPrimary),
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
            trailingWidget ?? (type == HeaderType.light ? SvgPicture.asset(Common.digitLogoDarkSvg): SvgPicture.asset(Common.digitLogoLightSvg)),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {

    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            leadingWidget ?? (type == HeaderType.light ? SvgPicture.asset(Common.digitLogoDarkSvg): SvgPicture.asset(Common.digitLogoLightSvg)),
            if (title != null)
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
            trailingWidget ?? (type == HeaderType.light ? SvgPicture.asset(Common.digitLogoDarkSvg): SvgPicture.asset(Common.digitLogoLightSvg)),
          ],
        ),
      ],
    );
  }
}




