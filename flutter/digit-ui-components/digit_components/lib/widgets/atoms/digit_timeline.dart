import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';

class Timeline extends StatefulWidget {
  final String label;
  final String description;
  final TimelineStepState currentStep;
  final List<Widget>? additionalWidgets;
  final List<Widget>? additionalHideWidgets;
  final String viewDetailText;
  final String hideDetailText;

  const Timeline({
    Key? key,
    required this.currentStep,
    required this.label,
    required this.description,
    this.additionalWidgets,
    this.additionalHideWidgets,
    this.viewDetailText = 'View Details',
    this.hideDetailText = 'Hide Details',
  }) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size.width);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineIcon(isMobile),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: currentTypography.headingS.copyWith(
                        height: 1.172,
                        color: const DigitColors().light.textPrimary,
                      ),
                    ),
                    Text(
                      widget.description,
                      style: currentTypography.bodyS.copyWith(
                        height: 1.25,
                        color: const DigitColors().light.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Transform.rotate(
                      angle: 0.21 * (3.141592653589793 / 180), // Converting 0.21 degrees to radians
                      child: Container(
                        height: 1,
                        color: const DigitColors().light.genericDivider,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: isMobile ? 40 : 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.additionalWidgets != null)
                  Wrap(
                    children: widget.additionalWidgets!
                        .map(
                          (widget) => Padding(
                        padding: const EdgeInsets.only(
                          right: kPadding,
                          bottom: kPadding,
                        ),
                        child: widget,
                      ),
                    )
                        .toList(),
                  ),
                if (!isExpanded && widget.additionalHideWidgets != null)
                  _buildExpandButton(currentTypography),
                if (isExpanded && widget.additionalHideWidgets != null)
                  Wrap(
                    children: widget.additionalHideWidgets!
                        .map(
                          (widget) => Padding(
                        padding: const EdgeInsets.only(
                          right: kPadding,
                          bottom: kPadding,
                        ),
                        child: widget,
                      ),
                    )
                        .toList(),
                  ),
                if (isExpanded && widget.additionalHideWidgets != null)
                  const SizedBox(
                    height: kPadding,
                  ),
                if (isExpanded && widget.additionalHideWidgets != null)
                  _buildExpandButton(currentTypography),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineIcon(bool isMobile) {
    return Container(
      width: isMobile ? 24 : 32,
      height: isMobile ? 24 : 32,
      decoration: BoxDecoration(
        color: widget.currentStep == TimelineStepState.completed
            ? const DigitColors().light.primaryOrange
            : widget.currentStep == TimelineStepState.present
            ? const DigitColors().light.paperPrimary
            : const DigitColors().light.textDisabled,
        borderRadius: BorderRadius.circular(50),
      ),
      child: widget.currentStep == TimelineStepState.completed
          ? Icon(
        Icons.check,
        color: const DigitColors().light.paperPrimary,
        size: isMobile ? 18 : 24,
      )
          : widget.currentStep == TimelineStepState.present
          ? Container(
        padding: isMobile ? const EdgeInsets.all(kPadding / 2) : const EdgeInsets.all(6),
        width: isMobile ? 24 : 32,
        height: isMobile ? 24 : 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const DigitColors().light.primaryOrange,
            width: 2.0,
          ),
          color: const DigitColors().light.paperPrimary,
        ),
        child: Container(
          height: isMobile ? 12 : 16,
          width: isMobile ? 12 : 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const DigitColors().light.primaryOrange,
          ),
        ),
      )
          : Container(
        width: isMobile ? 24 : 32,
        height: isMobile ? 24 : 32,
        decoration: BoxDecoration(
          color: const DigitColors().light.textDisabled,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget _buildExpandButton(DigitTypography currentTypography) {
    return InkWell(
      highlightColor: const DigitColors().transparent,
      splashColor: const DigitColors().transparent,
      hoverColor: const DigitColors().transparent,
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isExpanded ? widget.hideDetailText : widget.viewDetailText,
            style: currentTypography.bodyL.copyWith(
              color: const DigitColors().light.primaryOrange,
              height: 1.5,
              decoration: TextDecoration.underline,
              decorationColor: const DigitColors().light.primaryOrange,
            ),
          ),
          const SizedBox(width: kPadding / 2),
          Icon(
            isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: 24,
            color: const DigitColors().light.primaryOrange,
          ),
        ],
      ),
    );
  }
}

enum TimelineStepState { completed, present, future }