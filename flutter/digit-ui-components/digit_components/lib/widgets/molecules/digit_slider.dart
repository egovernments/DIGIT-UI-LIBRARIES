import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

class SlideOverMenu extends StatefulWidget {
  final bool isLeft; // Determines if the slider is on the left or right
  final Widget? collapsedHeader; // Header for the collapsed state
  final Widget? expandedHeader; // Header for the expanded state
  final Widget? collapsedFooter; // Footer for the collapsed state
  final Widget? expandedFooter; // Footer for the expanded state
  final List<Section>?
      sections; // List of sections with separate content for collapsed and expanded state
  final double collapsedWidth; // Width when collapsed
  final double expandedWidth; // Width when expanded
  final Duration animationDuration; // Duration of the expansion animation
  final VoidCallback? onToggle; // Optional callback for external toggle
  final MainAxisAlignment
      expandedContentAlignment; // Alignment of the expanded content
  final double? height;
  final bool
      skipCollapsedState; // If true, skip the collapsed state and directly open
  final VoidCallback? onCrossTap;

  const SlideOverMenu({
    super.key,
    this.isLeft =
        false, // Default is right side, set this to true for left side
    this.collapsedHeader,
    this.expandedHeader,
    this.collapsedFooter,
    this.expandedFooter,
    this.sections,
    this.collapsedWidth = 60.0,
    this.expandedWidth = 300.0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onToggle,
    this.expandedContentAlignment = MainAxisAlignment.start,
    this.height,
    this.skipCollapsedState = false,
    this.onCrossTap,
  });

  @override
  SlideOverMenuState createState() => SlideOverMenuState();
}

class SlideOverMenuState extends State<SlideOverMenu> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  void toggleSlider() {
    setState(() {
      isExpanded = !isExpanded;
    });
    widget.onToggle?.call();
  }

  void openSlider() {
    if (!isExpanded) {
      setState(() {
        isExpanded = true;
      });
      widget.onToggle?.call();
    }
  }

  void closeSlider() {
    if (isExpanded) {
      setState(() {
        isExpanded = false;
      });
      widget.onToggle?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return widget.skipCollapsedState && !isExpanded
        ? Container()
        : Align(
            alignment: widget.isLeft
                ? Alignment.centerLeft
                : Alignment.centerRight, // Choose side based on `isLeft`
            child: GestureDetector(
              onTap: toggleSlider,
              child: AnimatedContainer(
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: widget.isLeft
                        ? const Radius.circular(spacer2)
                        : Radius.zero, // Adjust border for left
                    bottomRight: widget.isLeft
                        ? const Radius.circular(spacer2)
                        : Radius.zero,
                    topLeft: widget.isLeft
                        ? Radius.zero
                        : const Radius.circular(
                            spacer2), // Adjust border for right
                    bottomLeft: widget.isLeft
                        ? Radius.zero
                        : const Radius.circular(spacer2),
                  ),
                  color: theme.colorTheme.paper.primary,
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorTheme.text.primary.withOpacity(.16),
                      offset: const Offset(1, 0), // Adjust shadow offset
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                curve: Curves.easeOut,
                duration: widget.animationDuration,
                width:
                    isExpanded ? widget.expandedWidth : widget.collapsedWidth,
                child: Stack(
                  children: [
                    ...[
                      Positioned.fill(
                        child: ScrollableContent(
                          backgroundColor: theme.colorTheme.paper.primary,
                          header: widget.expandedHeader != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const DigitColors().light.paperPrimary,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(spacer1),
                                        topRight: Radius.circular(spacer1)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF000000)
                                            .withOpacity(.16),
                                        offset: const Offset(0, 1),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (widget.expandedHeader != null)
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
                                            bottom: isMobile
                                                ? spacer4
                                                : isTab
                                                    ? spacer5
                                                    : spacer6,
                                          ),
                                          child: isExpanded
                                              ? widget.expandedHeader
                                              : widget.collapsedHeader,
                                        ),
                                      if (widget.onCrossTap != null)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: spacer2,
                                            right: spacer2,
                                          ),
                                          child: InkWell(
                                            hoverColor:
                                                const DigitColors().transparent,
                                            highlightColor:
                                                const DigitColors().transparent,
                                            splashColor:
                                                const DigitColors().transparent,
                                            onTap: widget.onCrossTap!,
                                            child: Icon(
                                              Icons.close,
                                              size: isMobile
                                                  ? spacer6
                                                  : isTab
                                                      ? spacer6
                                                      : spacer7,
                                              color: const DigitColors()
                                                  .light
                                                  .textPrimary,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                )
                              : null,
                          footer: widget.expandedFooter != null
                              ? DigitCard(children: [
                                  isExpanded
                                      ? widget.expandedFooter!
                                      : widget.collapsedFooter ?? Container(),
                                ])
                              : null,
                          children: [
                            if (widget.sections != null)
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  for (int i = 0;
                                      i < widget.sections!.length;
                                      i++) ...[
                                    SectionWidget(
                                      section: widget.sections![i],
                                      isExpanded: isExpanded,
                                    ),
                                  ],
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],

                    // Icon for expanding/collapsing
                    if (!widget.skipCollapsedState)
                      Align(
                        alignment: widget.isLeft
                            ? Alignment.centerRight
                            : Alignment.centerLeft, // Adjust icon alignment
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: widget.isLeft ? 4.0 : 0,
                              left: widget.isLeft ? 0 : 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: theme.colorTheme.generic.divider,
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Icon(
                              widget.isLeft
                                  ? (isExpanded
                                      ? Icons.chevron_left
                                      : Icons.chevron_right)
                                  : isExpanded
                                      ? Icons.chevron_right
                                      : Icons.chevron_left,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
  }
}

class Section {
  final List<Widget>? collapsedContent; // Collapsed state content
  final List<Widget> expandedContent; // Expanded state content

  Section({
    this.collapsedContent,
    required this.expandedContent,
  });
}

class SectionWidget extends StatelessWidget {
  final Section section;
  final bool isExpanded;

  const SectionWidget({
    super.key,
    required this.section,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the section has content for the current state (collapsed/expanded)
    bool hasContent = isExpanded
        ? section.expandedContent.isNotEmpty
        : section.collapsedContent != null &&
            section.collapsedContent!.isNotEmpty;

    return hasContent
        ? Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Wrap content in padding
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: isExpanded
                      ? section.expandedContent
                      : section.collapsedContent ?? [],
                ),
              ),
              const DigitDivider(
                dividerType: DividerType.small,
              ),
            ],
          )
        : Container(); // If there's no content, show nothing
  }
}
