import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/material.dart';
import '../helper_widget/overlay_dropdown.dart';

class CustomHeaderMolecule extends StatelessWidget {
  final HeaderType type;
  final String? title;
  final List<HeaderAction>? actions;
  final Widget? leadingWidget;
  final Widget? trailingWidget;
  final bool? leadingDigitLogo;
  final bool? trailingDigitLogo;
  final bool actionRequired;
  final void Function()? onMenuTap;

  const CustomHeaderMolecule({
    Key? key,
    this.type = HeaderType.light,
    this.title,
    this.actions,
    this.leadingWidget,
    this.trailingWidget,
    this.leadingDigitLogo,
    this.trailingDigitLogo,
    this.actionRequired = false,
    this.onMenuTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: isMobile ? 56 : 64,
      padding: EdgeInsets.symmetric(
          horizontal: isMobile
              ? 16
              : isTab
              ? 24
              : 40.0,
          vertical: 16.0),
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
          ? _buildMobileTabHeader(context)
          : _buildDesktopHeader(context),
    );
  }

  Widget _buildMobileTabHeader(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              hoverColor: const DigitColors().transparent,
              splashColor: const DigitColors().transparent,
              highlightColor: const DigitColors().transparent,
              onTap: onMenuTap,
              child: leadingWidget ??
                  Icon(
                    Icons.menu,
                    size: isTab ? 32 : 24,
                    color: type == HeaderType.dark
                        ? const DigitColors().light.paperPrimary
                        : const DigitColors().light.textPrimary,
                  ),
            ),
            SizedBox(width:  isTab ? 20 : 16,),
            if (leadingDigitLogo!=false)
              (type == HeaderType.dark
                  ? Image.asset(
                Base.digitLogoDarkSvg,
                height: 24,
                fit: BoxFit.fill,
              )
                  : Image.asset(
                Base.digitLogoLightSvg,
                height: 24,
                fit: BoxFit.fill,
              )),
            if (leadingDigitLogo!=false)
            const SizedBox(
              width: 8,
            ),
            if (leadingDigitLogo!=false)
            Container(
              height: isTab ? 32 : 24,
              width: 1,
              color: type == HeaderType.dark
                  ? const DigitColors().light.paperPrimary
                  : const DigitColors().light.textPrimary,
            ),
            if (title != null && leadingDigitLogo!=false)
              const SizedBox(
                width: 8,
              ),
            if (title != null)
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  title!,
                  overflow: TextOverflow.ellipsis,
                  style: currentTypography.headingS.copyWith(
                      color: type == HeaderType.dark
                          ? const DigitColors().light.paperPrimary
                          : const DigitColors().light.textPrimary),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        SizedBox(
          width: isTab ? 24 : 16,
        ),
        if(actionRequired)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (actions != null)
                ...actions!
                    .asMap()
                    .entries
                    .map(
                      (widgets) => Padding(
                    padding: EdgeInsets.only(
                      right: widgets.key != actions!.length - 1 ? isTab ? 24 : 16 : 0,
                    ),
                    child: widgets.value.dropdownItems!=null ?
                    OverlayDropdown(
                      type: OverlayDropdownType.header,
                      items: widgets.value.dropdownItems!,
                      title: widgets.value.widget,
                      onChange: (selectedItem) {
                        if (widgets.value.onDropdownItemSelected != null) {
                          widgets.value.onDropdownItemSelected!(selectedItem);
                        }
                      },
                    ) :
                    widgets.value.widget,
                  ),
                )
                    .toList(),
              if (trailingWidget != null) trailingWidget!,
              if (trailingDigitLogo==true)
                (type == HeaderType.dark
                    ? Image.asset(
                  Base.digitLogoDarkSvg,
                  // width: ,
                  height: 24,
                  fit: BoxFit.fill,
                )
                    : Image.asset(
                  Base.digitLogoLightSvg,
                  //width: 40,
                  height: 24,
                  fit: BoxFit.fill,
                )),
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
            if (leadingWidget != null) leadingWidget!,
            if(leadingWidget!=null && leadingDigitLogo==true)
              const SizedBox(width: 24,),
            if (leadingDigitLogo==true)
              (type == HeaderType.dark
                  ? Image.asset(
                Base.digitLogoDarkSvg,
                height: 24,
                fit: BoxFit.fill,
              )
                  : Image.asset(
                Base.digitLogoLightSvg,
                height: 24,
                fit: BoxFit.fill,
              )),
            if (title != null && (leadingDigitLogo==true || leadingWidget != null))
              const SizedBox(
                width: 16,
              ),
            if (title != null)
              Text(
                title!,
                overflow: TextOverflow.ellipsis,
                style: currentTypography.headingM.copyWith(
                    color: type == HeaderType.dark
                        ? const DigitColors().light.paperPrimary
                        : const DigitColors().light.textPrimary),
                textAlign: TextAlign.center,
              ),
          ],
        ),
        const SizedBox(
          width: 32,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (actions != null)
              ...actions!
                  .asMap()
                  .entries
                  .map(
                    (widgets) => Padding(
                  padding: EdgeInsets.only(
                    right: widgets.key != actions!.length - 1 ? 32 : 0,
                  ),
                  child: widgets.value.dropdownItems!=null ?
                  OverlayDropdown(
                    type: OverlayDropdownType.header,
                    items: widgets.value.dropdownItems!,
                    title: widgets.value.widget,
                    searchable: widgets.value.isSearchable,
                    onChange: (selectedItem) {
                      if (widgets.value.onDropdownItemSelected != null) {
                        widgets.value.onDropdownItemSelected!(selectedItem);
                      }
                    },
                  ) :
                  widgets.value.widget,
                ),
              )
                  .toList(),
            if (actions != null &&
                (trailingDigitLogo!=false || trailingWidget != null))
              const SizedBox(
                width: 24,
              ),
            if (trailingWidget != null) trailingWidget!,
            if (trailingDigitLogo!=false)
              (type == HeaderType.dark
                  ? Image.asset(
                Base.digitLogoDarkSvg,
                // width: ,
                height: 24,
                fit: BoxFit.fill,
              )
                  : Image.asset(
                Base.digitLogoLightSvg,
                //width: 40,
                height: 24,
                fit: BoxFit.fill,
              )),
          ],
        ),
      ],
    );
  }
}

class HeaderAction {
  final Widget widget;
  final List<DropdownItem>? dropdownItems;
  final bool isSearchable;
  final void Function(DropdownItem)? onDropdownItemSelected;

  HeaderAction({
    required this.widget,
    this.dropdownItems,
    this.isSearchable = false,
    this.onDropdownItemSelected,
  });
}

enum HeaderType {
  light,
  dark,
}