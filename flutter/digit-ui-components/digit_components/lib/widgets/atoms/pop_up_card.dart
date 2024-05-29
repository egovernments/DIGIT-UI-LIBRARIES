import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../enum/app_enums.dart';
import '../../theme/colors.dart';
import '../../theme/spacers.dart';
import '../../theme/typography.dart';
import '../helper_widget/button_list.dart';
import 'digit_button.dart';
import 'package:flutter/scheduler.dart';

class Popup extends StatefulWidget {
  final String title;
  final PopUpType type;
  final double? width;
  final double? height;
  final Icon? titleIcon;
  final String? subHeading;
  final String? description;
  final List<Widget>? additionalWidgets;
  final List<Button>? actions;
  final void Function()? onCrossTap;
  final bool? inlineActions;
  final double? actionSpacing;
  final MainAxisAlignment? actionAlignment;

  const Popup({
    super.key,
    required this.title,
    this.type = PopUpType.simple,
    this.width,
    this.height,
    this.titleIcon,
    this.subHeading,
    this.description,
    this.additionalWidgets,
    this.actions,
    this.onCrossTap,
    this.inlineActions,
    this.actionSpacing,
    this.actionAlignment,
  });

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  final ScrollController _scrollController = ScrollController();
  bool _isOverflowing = false;
  bool firstBuild = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildSimplePopUp(
      DigitTypography currentTypography, bool isMobile, bool isTab) {
    return Container(
      padding: EdgeInsets.only(
        bottom: isMobile
            ? spacer4
            : isTab
                ? spacer5
                : spacer6,
      ),
      decoration: BoxDecoration(
        color: const DigitColors().light.paperPrimary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(spacer1),
            topRight: Radius.circular(spacer1)),
        boxShadow: _isOverflowing
            ? [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.16),
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: isMobile
                      ? spacer4
                      : isTab
                          ? spacer5
                          : spacer6,
                  right: spacer2,
                  top: isMobile
                      ? spacer4
                      : isTab
                          ? spacer5
                          : spacer6,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.titleIcon != null) widget.titleIcon!,
                    if (widget.titleIcon != null)
                      const SizedBox(
                        width: spacer2,
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: currentTypography.headingL.copyWith(
                              color: const DigitColors().light.textPrimary),
                        ),
                        if (widget.subHeading != null)
                          const SizedBox(
                            height: spacer2,
                          ),
                        if (widget.subHeading != null)
                          Text(
                            widget.subHeading!,
                            style: currentTypography.captionS.copyWith(
                              color: const DigitColors().light.textSecondary,
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: spacer2,
                  right: spacer2,
                ),
                child: InkWell(
                  hoverColor: const DigitColors().transparent,
                  highlightColor: const DigitColors().transparent,
                  splashColor: const DigitColors().transparent,
                  onTap: widget.onCrossTap,
                  child: Icon(
                    Icons.close,
                    size: isMobile
                        ? spacer6
                        : isTab
                            ? spacer6
                            : spacer7,
                    color: const DigitColors().light.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertPopUp(
      DigitTypography currentTypography, bool isMobile, bool isTab) {
    return Container(
      padding: EdgeInsets.all(
        isMobile
            ? spacer4
            : isTab
                ? spacer5
                : spacer6,
      ),
      decoration: BoxDecoration(
        color: const DigitColors().light.paperPrimary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(spacer1),
            topRight: Radius.circular(spacer1)),
        boxShadow: _isOverflowing
            ? [
                BoxShadow(
                  color: const Color(0xFF000000).withOpacity(.16),
                  offset: const Offset(0, 1),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.titleIcon ??
              Icon(
                Icons.warning,
                size: spacer12,
                color: const DigitColors().light.alertError,
              ),
          const SizedBox(
            width: spacer2,
          ),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: currentTypography.headingL
                .copyWith(color: const DigitColors().light.textPrimary),
          ),
          const SizedBox(
            width: spacer2,
          ),
          if (widget.subHeading != null)
            const SizedBox(
              height: spacer2,
            ),
          if (widget.subHeading != null)
            Text(
              widget.subHeading!,
              textAlign: TextAlign.center,
              style: currentTypography.captionS.copyWith(
                color: const DigitColors().light.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent(
      DigitTypography currentTypography, bool isMobile, bool isTab) {
    return Padding(
      padding: EdgeInsets.only(
        left: isMobile
            ? spacer4
            : isTab
                ? spacer5
                : spacer6,
        right: isMobile
            ? spacer4
            : isTab
                ? spacer5
                : spacer6,
        top: _isOverflowing
            ? isMobile
                ? spacer4
                : isTab
                    ? spacer5
                    : spacer6
            : 0,
        bottom: !_isOverflowing && (widget.actions != null)
            ? 0
            : isMobile
                ? spacer4
                : isTab
                    ? spacer5
                    : spacer6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.description != null)
            Text(
              widget.description!,
              style: currentTypography.bodyS.copyWith(
                color: const DigitColors().light.textPrimary,
              ),
            ),
          if (widget.description != null && widget.additionalWidgets != null)
            SizedBox(
              height: isMobile
                  ? spacer4
                  : isTab
                      ? spacer5
                      : spacer6,
            ),
          if (widget.additionalWidgets != null)
            ...widget.additionalWidgets!
                .asMap()
                .entries
                .map(
                  (widgets) => Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          widgets.key != widget.additionalWidgets!.length - 1
                              ? isMobile
                                  ? spacer4
                                  : isTab
                                      ? spacer5
                                      : spacer6
                              : 0,
                    ),
                    child: widgets.value,
                  ),
                )
                .toList(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!firstBuild) {
      firstBuild = true;
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (_scrollController.hasClients) {
            _isOverflowing = (_scrollController.position.maxScrollExtent > 0);
          }
        });
      });
    }

    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    final double? cardWidth = widget.width;
    final double? cardHeight = widget.height;

    return Dialog.fullscreen(
      backgroundColor: const DigitColors().transparent,
      child: Center(
        child: Container(
          width: cardWidth,
          height: cardHeight,
          margin: EdgeInsets.symmetric(
              vertical: cardHeight == null
                  ? isMobile
                      ? 64
                      : isTab
                          ? 100
                          : 74
                  : 0,
              horizontal: cardWidth == null
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
            crossAxisAlignment: widget.type == PopUpType.alert
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              widget.type == PopUpType.simple
                  ? _buildSimplePopUp(currentTypography, isMobile, isTab)
                  : _buildAlertPopUp(currentTypography, isMobile, isTab),
              if (widget.description != null ||
                  widget.additionalWidgets != null)
                Flexible(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: _buildContent(currentTypography, isMobile, isTab),
                  ),
                ),
              if (widget.actions != null)
                Container(
                  padding: EdgeInsets.only(
                    left: isMobile
                        ? spacer4
                        : isTab
                            ? spacer5
                            : spacer6,
                    right: isMobile
                        ? spacer4
                        : isTab
                            ? spacer5
                            : spacer6,
                    top: _isOverflowing ||
                            (widget.additionalWidgets != null ||
                                widget.description != null)
                        ? isMobile
                            ? spacer4
                            : isTab
                                ? spacer5
                                : spacer6
                        : 0,
                    bottom: isMobile
                        ? spacer4
                        : isTab
                            ? spacer5
                            : spacer6,
                  ),
                  decoration: BoxDecoration(
                    color: const DigitColors().light.paperPrimary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(spacer1),
                        bottomRight: Radius.circular(spacer1)),
                    boxShadow: _isOverflowing
                        ? [
                            BoxShadow(
                              color: const Color(0xFF000000).withOpacity(.16),
                              offset: const Offset(0, -1),
                              spreadRadius: 0,
                              blurRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: ButtonListTile(
                    buttons: widget.actions!,
                    isVertical: widget.inlineActions != null
                        ? !widget.inlineActions!
                        : (isMobile ? true : false),
                    alignment: widget.actionAlignment ??
                        ((isMobile || isTab) || widget.type == PopUpType.alert
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.end),
                    spacing: widget.actionSpacing ??
                        (isMobile
                            ? spacer4
                            : isTab
                                ? spacer5
                                : spacer6),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
