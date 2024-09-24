import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/scheduler.dart';

// Enum to represent the layout type
enum FilterCardLayout { horizontal, vertical }

class FilterCard {
  // Method to display FilterCard as an overlay or dialog with animation
  static Future<void> showFilterOverlay({
    required BuildContext context,
    String? title,
    IconData? titleIcon,
    required List<Widget> contentList,
    String? primaryActionLabel,
    String? secondaryActionLabel,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
    FilterCardLayout layoutType =
        FilterCardLayout.horizontal, // Pass the layout type here
    VoidCallback? onCrossTap,
  }) async {
    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: '',
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(spacer1),
            ),
            child: FilterCardWidget(
              title: title,
              titleIcon: titleIcon,
              contentList: contentList,
              primaryActionLabel: primaryActionLabel,
              secondaryActionLabel: secondaryActionLabel,
              onPrimaryPressed: onPrimaryPressed,
              onSecondaryPressed: onSecondaryPressed,
              layoutType: layoutType,
              onCrossTap: onCrossTap,
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        const curve = Curves.easeInOut;
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  // Standalone FilterCard Widget
  static Widget buildFilterCard({
    required BuildContext context,
    String? title,
    IconData? titleIcon,
    required List<Widget> contentList,
    String? primaryActionLabel,
    String? secondaryActionLabel,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    FilterCardLayout layoutType = FilterCardLayout.horizontal,
    VoidCallback? onCrossTap,
  }) {
    return FilterCardWidget(
      titleIcon: titleIcon,
      title: title,
      contentList: contentList,
      primaryActionLabel: primaryActionLabel,
      secondaryActionLabel: secondaryActionLabel,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
      layoutType: layoutType,
      onCrossTap: onCrossTap,
    );
  }
}

class FilterCardWidget extends StatefulWidget {
  final String? title;
  final IconData? titleIcon;
  final List<Widget> contentList;
  final String? primaryActionLabel;
  final String? secondaryActionLabel;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final FilterCardLayout layoutType;
  final VoidCallback? onCrossTap;

  const FilterCardWidget({
    Key? key,
    this.title,
    this.titleIcon,
    required this.contentList,
    this.primaryActionLabel,
    this.secondaryActionLabel,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.layoutType = FilterCardLayout.horizontal,
    this.onCrossTap,
  }) : super(key: key);

  @override
  State<FilterCardWidget> createState() => _FilterCardWidgetState();
}

class _FilterCardWidgetState extends State<FilterCardWidget> {
  late bool isMobile;
  late bool isTab;
  final ScrollController _scrollController = ScrollController();
  bool _isOverflowing = false;
  bool firstBuild = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    isTab = AppView.isTabletView(MediaQuery.of(context).size);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

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

    final buttonWidgets = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.secondaryActionLabel != null &&
            widget.onSecondaryPressed != null)
          Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: DigitButton(
              label: widget.secondaryActionLabel!,
              onPressed: widget.onSecondaryPressed!,
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large,
            ),
          ),
        SizedBox(
            width: isTab
                ? spacer5
                : isMobile
                    ? spacer4
                    : spacer6),
        if (widget.primaryActionLabel != null &&
            widget.onPrimaryPressed != null)
          Padding(
            padding: const EdgeInsets.only(top: 26.0),
            child: DigitButton(
              label: widget.primaryActionLabel!,
              onPressed: widget.onPrimaryPressed!,
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
            ),
          ),
      ],
    );

    return widget.layoutType == FilterCardLayout.horizontal
        ? DigitCard(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.title != null)
                    Row(
                      children: [
                        if (widget.titleIcon != null)
                          Icon(widget.titleIcon,
                              size: isMobile ? spacer6 : spacer8,
                              color: theme.colorTheme.primary.primary1),
                        if (widget.titleIcon != null) const SizedBox(width: 8),
                        Text(
                          widget.title!,
                          style: textTheme.headingM.copyWith(
                            color: theme.colorTheme.text.primary,
                          ),
                        ),
                      ],
                    ),
                  if (widget.onCrossTap != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: spacer2,
                        right: spacer2,
                      ),
                      child: InkWell(
                        hoverColor: const DigitColors().transparent,
                        highlightColor: const DigitColors().transparent,
                        splashColor: const DigitColors().transparent,
                        onTap: widget.onCrossTap!,
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
              LayoutBuilder(
                builder: (context, constraints) {
                  final double availableWidth = constraints.maxWidth;
                  double usedWidth = 0.0;
                  List<Widget> rowItems = [];
                  List<List<Widget>> rows = [];
                  bool buttonsAddedToRow = false;

                  for (var widget in widget.contentList) {
                    const double widgetWidth = 224.0;
                    const double spacing = 24.0;

                    if (usedWidth + widgetWidth <= availableWidth) {
                      rowItems.add(Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: spacing),
                          width: widgetWidth,
                          child: widget,
                        ),
                      ));
                      usedWidth += widgetWidth + spacing;
                    } else {
                      rows.add(rowItems);
                      rowItems = [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(right: spacing),
                            width: widgetWidth,
                            child: widget,
                          ),
                        )
                      ];
                      usedWidth = widgetWidth + spacing;
                    }
                  }

                  if (rowItems.isNotEmpty &&
                      widget.layoutType == FilterCardLayout.horizontal) {
                    rows.add(rowItems);
                  }

                  const double buttonWidth = 300;
                  if (widget.layoutType == FilterCardLayout.horizontal &&
                      usedWidth + buttonWidth <= availableWidth) {
                    rows.last.add(const Spacer());
                    rows.last.add(buttonWidgets);
                    buttonsAddedToRow = true;
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ...rows.map(
                        (row) => Row(
                          mainAxisAlignment:
                              widget.layoutType == FilterCardLayout.horizontal
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.center,
                          children: row,
                        ),
                      ),
                      if (!buttonsAddedToRow)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: buttonWidgets,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          )
        : _buildVerticalLayout(context, buttonWidgets);
  }

  Widget _buildVerticalLayout(BuildContext context, Widget buttonWidgets) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(theme.spacerTheme.spacer1),
        color: theme.colorTheme.paper.primary,
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
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: isMobile
                    ? spacer4
                    : isTab
                        ? spacer5
                        : spacer6),
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
            width: isTab ? 480 : 648,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (widget.title != null)
                  Padding(
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
                      children: [
                        if (widget.titleIcon != null)
                          Icon(
                            widget.titleIcon,
                            size: isMobile ? spacer6 : spacer8,
                            color: theme.colorTheme.primary.primary1,
                          ),
                        if (widget.titleIcon != null) const SizedBox(width: 8),
                        Text(
                          widget.title!,
                          style: textTheme.headingM.copyWith(
                            color: theme.colorTheme.text.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (widget.onCrossTap != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: spacer2,
                      right: spacer2,
                    ),
                    child: InkWell(
                      hoverColor: const DigitColors().transparent,
                      highlightColor: const DigitColors().transparent,
                      splashColor: const DigitColors().transparent,
                      onTap: widget.onCrossTap!,
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
          ),
          Flexible(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
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
                  bottom: !_isOverflowing &&
                          (widget.primaryActionLabel != null ||
                              widget.secondaryActionLabel != null)
                      ? 0
                      : isMobile
                          ? spacer4
                          : isTab
                              ? spacer5
                              : spacer6,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.contentList.expand((child) {
                    return [
                      child,
                      SizedBox(
                        height: isMobile
                            ? spacer4
                            : isTab
                                ? spacer5
                                : spacer6,
                      ), // Adjust the height as needed
                    ];
                  }).toList()
                    ..removeLast(), // Remove the last SizedBox to avoid extra spacing at the end
                ),
              ),
            ),
          ),
          if(widget.primaryActionLabel != null || widget.secondaryActionLabel != null)
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
              top: isMobile
                  ? spacer4
                  : isTab
                      ? spacer5
                      : spacer6,
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
            width: isTab ? 480 : 648,
            child: Row(
              mainAxisAlignment: widget.primaryActionLabel == null ||
                      widget.secondaryActionLabel == null
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (widget.secondaryActionLabel != null &&
                    widget.onSecondaryPressed != null)
                  Flexible(
                    child: SizedBox(
                      width: isTab ? 210 : 288,
                      child: DigitButton(
                        mainAxisSize: MainAxisSize.max,
                        label: widget.secondaryActionLabel!,
                        onPressed: widget.onSecondaryPressed!,
                        type: DigitButtonType.tertiary,
                        size: DigitButtonSize.large,
                      ),
                    ),
                  ),
                if (widget.primaryActionLabel != null &&
                    widget.secondaryActionLabel != null)
                  SizedBox(
                      width: isTab
                          ? spacer5
                          : isMobile
                              ? spacer4
                              : spacer6),
                if (widget.primaryActionLabel != null &&
                    widget.onPrimaryPressed != null)
                  Flexible(
                    child: SizedBox(
                      width: isTab ? 210 : 288,
                      child: DigitButton(
                        mainAxisSize: MainAxisSize.max,
                        label: widget.primaryActionLabel!,
                        onPressed: widget.onPrimaryPressed!,
                        type: DigitButtonType.primary,
                        size: DigitButtonSize.large,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
