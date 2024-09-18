import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';

class RightSideSlider extends StatefulWidget {
  final Widget expandedContent; // Widget to display when expanded
  final double collapsedWidth; // Width when collapsed
  final double expandedWidth; // Width when expanded
  final Duration animationDuration; // Duration of the expansion animation

  const RightSideSlider({
    super.key,
    required this.expandedContent,
    this.collapsedWidth = 60.0, // Line width when collapsed
    this.expandedWidth = 300.0, // Full width when expanded
    this.animationDuration = const Duration(milliseconds: 300), // Animation time
  });

  @override
  _RightSideSliderState createState() => _RightSideSliderState();
}

class _RightSideSliderState extends State<RightSideSlider> {
  bool isExpanded = false; // Track if the slider is expanded

  void toggleSlider() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight, // Keep the slider on the right side
      child: GestureDetector(
        onTap: toggleSlider, // Toggle the slider on tap
        child: AnimatedContainer(
          curve: Curves.easeOut, // Smooth animation
          duration: widget.animationDuration,
          width: isExpanded ? widget.expandedWidth : widget.collapsedWidth,
          height: double.infinity,
          color: theme.colorTheme.paper.primary, // Custom theme color
          child: Stack(
            children: [
              // Expanded content goes below the icon
              if (isExpanded)
                Positioned.fill(
                  top: 60.0, // Padding below the icon to position content
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.expandedContent,
                  ),
                ),

              // Icon or handle to collapse/expand, positioned at the top
              Align(
                alignment: Alignment.centerLeft, // Align the icon to the top center
                child: Container(
                  width: widget.collapsedWidth,
                  color: Colors.white,
                  height: 60.0, // Set a fixed height for the icon container
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
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
