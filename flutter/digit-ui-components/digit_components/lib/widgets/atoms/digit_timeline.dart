import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';

class DigitTimeline extends StatefulWidget {
  final String label;
  final String description;
  final TimelineStepState currentStep;
  final List<Widget>? additionalWidgets;
  final List<Widget>? additionalHideWidgets;

  const DigitTimeline({
    Key? key,
    required this.currentStep,
    required this.label,
    required this.description,
    this.additionalWidgets,
    this.additionalHideWidgets,
  }) : super(key: key);

  @override
  _DigitTimelineState createState() => _DigitTimelineState();
}

class _DigitTimelineState extends State<DigitTimeline> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context);
    bool isDesktop = AppView.isDesktopView(MediaQuery.of(context).size.width);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineIcon(isDesktop),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: currentTypography.headingS.copyWith(
                        color: const DigitColors().lightTextPrimary,
                      ),
                    ),
                    Text(
                      widget.description,
                      style: currentTypography.bodyS.copyWith(
                        color: const DigitColors().lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 1,
                      color: const DigitColors().lightGenericDivider,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: isDesktop ? 48 : 40),
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

  Widget _buildTimelineIcon(bool isDesktop) {
    return Container(
      width: isDesktop ? 32 : 24,
      height: isDesktop ? 32 : 24,
      decoration: BoxDecoration(
        color: widget.currentStep == TimelineStepState.completed
            ? const DigitColors().lightPrimaryOrange
            : widget.currentStep == TimelineStepState.present
                ? const DigitColors().lightPaperPrimary
                : const DigitColors().lightTextDisabled,
        borderRadius: BorderRadius.circular(50),
      ),
      child: widget.currentStep == TimelineStepState.completed
          ? Icon(
              Icons.check,
              color: const DigitColors().lightPaperPrimary,
              size: isDesktop ? 24 : 18,
            )
          : widget.currentStep == TimelineStepState.present
              ? Container(
                  padding: const EdgeInsets.all(kPadding / 2),
                  width: isDesktop ? 32 : 24,
                  height: isDesktop ? 32 : 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const DigitColors().lightPrimaryOrange,
                      width: 2.0,
                    ),
                    color: const DigitColors().lightPaperPrimary,
                  ),
                  child: Container(
                    height: isDesktop ? 16 : 12,
                    width: isDesktop ? 16 : 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const DigitColors().lightPrimaryOrange,
                    ),
                  ),
                )
              : Container(
                  width: isDesktop ? 32 : 24,
                  height: isDesktop ? 32 : 24,
                  decoration: BoxDecoration(
                    color: const DigitColors().lightTextDisabled,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
    );
  }

  Widget _buildExpandButton(DigitTypography currentTypography) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isExpanded ? 'Hide Details' : 'View Details',
            style: currentTypography.bodyL.copyWith(
              color: const DigitColors().lightPrimaryOrange,
              height: 1.5,
              decoration: TextDecoration.underline,
              decorationColor: const DigitColors().lightPrimaryOrange,
            ),
          ),
          const SizedBox(width: kPadding / 2),
          Icon(
            isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: 24,
            color: const DigitColors().lightPrimaryOrange,
          ),
        ],
      ),
    );
  }
}

enum TimelineStepState { completed, present, future }
