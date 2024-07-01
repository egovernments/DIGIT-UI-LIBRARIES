/// A customizable popup dialog widget.

/// Example use
///``` Popup(
///      title: 'Example Popup',
///      type: PopUpType.simple,
///      description: 'This is a simple example of a popup dialog.',
///      actions: [
///          Button(
///              label: 'OK',
///              onPressed: () {
///                 Navigator.pop(context);
///              },
///          ),
///      ],
///  )```

import 'package:digit_ui_components/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../enum/app_enums.dart';
import '../../theme/ComponentTheme/pop_up_card_theme.dart';
import '../../theme/colors.dart';
import '../../theme/spacers.dart';
import '../../theme/typography.dart';
import '../helper_widget/button_list.dart';
import 'digit_button.dart';
import 'package:flutter/scheduler.dart';

class Popup extends StatefulWidget {
  /// The title of the popup.
  final String title;

  /// The type of the popup. Defaults to PopUpType.simple.
  final PopUpType type;

  /// The width of the popup. If null, it defaults to a responsive width based on the screen size.
  final double? width;

  /// The height of the popup. If null, it defaults to a responsive height based on the screen size.
  final double? height;

  /// The icon to be displayed next to the title.
  final Icon? titleIcon;

  /// The subheading of the popup.
  final String? subHeading;

  /// The description text of the popup.
  final String? description;

  /// Additional widgets to be displayed in the popup.
  final List<Widget>? additionalWidgets;

  /// The list of action buttons to be displayed in the popup.
  final List<Button>? actions;

  /// Callback function when the close button is tapped.
  final void Function()? onCrossTap;

  /// Whether to display action buttons inline or not.
  final bool? inlineActions;

  /// The spacing between action buttons.
  final double? actionSpacing;

  /// The alignment of action buttons.
  final MainAxisAlignment? actionAlignment;

  final DigitPopupTheme? popupTheme;

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
    this.popupTheme,
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

  Widget _buildSimplePopUp(BuildContext context,
      DigitPopupTheme themeData, bool isMobile, bool isTab) {

    final theme = Theme.of(context);

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
                          style: themeData.titleTextStyle,
                        ),
                        if (widget.subHeading != null)
                          const SizedBox(
                            height: spacer2,
                          ),
                        if (widget.subHeading != null)
                          Text(
                            widget.subHeading!,
                            style: themeData.subHeadingTextStyle,
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

  Widget _buildAlertPopUp(BuildContext context,
      DigitPopupTheme themeData, bool isMobile, bool isTab) {
    return Container(
      width: themeData.width,
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
            style: themeData.titleTextStyle,
          ),
          if (widget.subHeading != null)
            const SizedBox(
              height: spacer2,
            ),
          if (widget.subHeading != null)
            Text(
              widget.subHeading!,
              textAlign: TextAlign.center,
              style: themeData.subHeadingTextStyle,
            ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context,
      DigitPopupTheme themeData, bool isMobile, bool isTab) {
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
              style: themeData.descriptionTextStyle,
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
    /// Check if it's the first build to avoid rebuilding unnecessarily
    if (!firstBuild) {
      firstBuild = true;

      /// Post frame callback to check if content is overflowing after rendering
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          if (_scrollController.hasClients) {
            _isOverflowing = (_scrollController.position.maxScrollExtent > 0);
          }
        });
      });
    }

    final theme = Theme.of(context);
    final themeData = widget.popupTheme ??
        theme.extension<DigitPopupTheme>() ??
        DigitPopupTheme.defaultTheme(context);

    /// Get current typography and screen size information
    //DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    // final double? cardWidth = widget.width;
    // final double? cardHeight = widget.height;

    return Dialog.fullscreen(
      backgroundColor: const DigitColors().transparent,
      child: Center(
        child: Container(
          width: themeData.width,
          height: themeData.height,
          decoration: themeData.decoration,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: widget.type == PopUpType.alert
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              widget.type == PopUpType.simple
                  ? _buildSimplePopUp(context, themeData, isMobile, isTab)
                  : _buildAlertPopUp(context, themeData, isMobile, isTab),
              if (widget.description != null ||
                  widget.additionalWidgets != null)
                Flexible(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: _buildContent(context, themeData, isMobile, isTab),
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
