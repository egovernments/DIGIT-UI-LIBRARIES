import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_divider.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:flutter/material.dart';

class RightSideSlider extends StatefulWidget {
  final Widget? header; // Widget to display at the top of the slider
  final Widget? footer; // Widget to display at the bottom of the slider
  final List<Section>?
      sections; // List of sections with tappable titles and content
  final Widget expandedContent; // Widget to display when expanded
  final double collapsedWidth; // Width when collapsed
  final double expandedWidth; // Width when expanded
  final Duration animationDuration; // Duration of the expansion animation
  final VoidCallback? onToggle; // Optional callback for external toggle
  final MainAxisAlignment
      expandedContentAlignment; // Alignment of the expanded content

  const RightSideSlider({
    super.key,
    this.header,
    this.footer,
    this.sections,
    required this.expandedContent,
    this.collapsedWidth = 60.0, // Line width when collapsed
    this.expandedWidth = 300.0, // Full width when expanded
    this.animationDuration =
        const Duration(milliseconds: 300), // Animation time
    this.onToggle, // Initialize the onToggle callback
    this.expandedContentAlignment = MainAxisAlignment.start,
  });

  @override
  RightSideSliderState createState() => RightSideSliderState();
}

class RightSideSliderState extends State<RightSideSlider> {
  bool isExpanded = false; // Track if the slider is expanded

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
    return Align(
      alignment: Alignment.centerRight, // Keep the slider on the right side
      child: GestureDetector(
        onTap: toggleSlider, // Toggle the slider on tap
        child: AnimatedContainer(
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
          // Smooth animation
          duration: widget.animationDuration,
          width: isExpanded ? widget.expandedWidth : widget.collapsedWidth,
          child: Stack(
            children: [
              // Expanded content goes behind the icon
              Positioned.fill(
                child: ScrollableContent(
                  header: widget.header != null
                      ? DigitCard(children: [widget.header!])
                      : null,
                  footer: widget.footer != null
                      ? DigitCard(children: [widget.footer!])
                      : null,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: widget.expandedContentAlignment,
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
                    )
                  ],
                ),
              ),

              // Icon always stays on top and aligned
              Align(
                alignment: Alignment.centerLeft,
                // Align the icon to the top center
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
  final String title; // Section title
  final List<Widget> content; // List of widgets inside the section

  Section({required this.title, required this.content});
}

// Section widget that handles expanding/collapsing the content on tap
class SectionWidget extends StatefulWidget {
  final Section section;

  const SectionWidget({super.key, required this.section});

  @override
  _SectionWidgetState createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  bool isExpanded = false; // Track if section is expanded

  void toggleSection() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.section.title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Content of the section, only visible if expanded
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.section.content,
            ),
          ),
      ],
    );
  }
}
