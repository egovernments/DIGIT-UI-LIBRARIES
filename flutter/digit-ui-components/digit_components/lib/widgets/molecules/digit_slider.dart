import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

class RightSideSlider extends StatefulWidget {
  final Widget? header; // Widget to display at the top of the slider
  final Widget? footer; // Widget to display at the bottom of the slider
  final List<Section>? sections; // List of sections with tappable titles and content
  final double collapsedWidth; // Width when collapsed
  final double expandedWidth; // Width when expanded
  final Duration animationDuration; // Duration of the expansion animation
  final VoidCallback? onToggle; // Optional callback for external toggle
  final MainAxisAlignment expandedContentAlignment; // Alignment of the expanded content
  final double? height;
  final bool skipCollapsedState; // If true, skip the collapsed state and directly open

  const RightSideSlider({
    super.key,
    this.header,
    this.footer,
    this.sections,
    this.collapsedWidth = 60.0, // Line width when collapsed
    this.expandedWidth = 300.0, // Full width when expanded
    this.animationDuration = const Duration(milliseconds: 300), // Animation time
    this.onToggle, // Initialize the onToggle callback
    this.expandedContentAlignment = MainAxisAlignment.start,
    this.height,
    this.skipCollapsedState = false, // Default behavior is not to skip collapsed state
  });

  @override
  RightSideSliderState createState() => RightSideSliderState();
}

class RightSideSliderState extends State<RightSideSlider> {
  bool isExpanded = false; // Track if the slider is expanded

  @override
  void initState() {
    super.initState();

  }

  void toggleSlider() {
      setState(() {
        isExpanded = !isExpanded;
      });
      // Call the external toggle function if provided
      widget.onToggle?.call();

  }

  void openSlider() {
    if (!isExpanded) {
      setState(() {
        isExpanded = true;
      });
      // Call the external toggle function if provided
      widget.onToggle?.call();
    }
  }

  void closeSlider() {
    if (isExpanded) {
      setState(() {
        isExpanded = false;
      });
      // Call the external toggle function if provided
      widget.onToggle?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return widget.skipCollapsedState && !isExpanded ? Container() : Align(
      alignment: Alignment.centerRight, // Keep the slider on the right side
      child: GestureDetector(
        onTap: toggleSlider, // Toggle the slider on tap
        child: AnimatedContainer(
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
            ),
            color: theme.colorTheme.paper.primary,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(-1, 0),
                blurRadius: 4.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          curve: Curves.easeOut,
          duration: widget.animationDuration,
          width: isExpanded ? widget.expandedWidth : widget.collapsedWidth,
          child: Stack(
            children: [
              // Expanded content goes behind the icon
              if (isExpanded || widget.skipCollapsedState) ...[
                Positioned.fill(
                  child: ScrollableContent(
                    header: widget.header != null
                        ? DigitCard(children: [widget.header!])
                        : null,
                    footer: widget.footer != null
                        ? DigitCard(children: [widget.footer!])
                        : null,
                    children: [
                      if (widget.sections != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              for (int i = 0; i < widget.sections!.length; i++) ...[
                                SectionWidget(section: widget.sections![i]),
                                if (i != widget.sections!.length - 1)
                                  const DigitDivider(
                                    dividerType: DividerType.small,
                                  ),
                                // Divider between sections
                              ],
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],

              // Icon always stays on top and aligned
              if (!widget.skipCollapsedState)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
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
                        isExpanded ? Icons.chevron_right : Icons.chevron_left,
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
  final List<Widget> content; // List of widgets inside the section

  Section({required this.content});
}

// Section widget that handles expanding/collapsing the content on tap
class SectionWidget extends StatefulWidget {
  final Section section;

  const SectionWidget({super.key, required this.section});

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.section.content,
      ),
    );
  }
}
