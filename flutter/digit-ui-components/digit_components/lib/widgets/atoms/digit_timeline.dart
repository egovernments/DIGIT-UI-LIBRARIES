import 'package:flutter/material.dart';
import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';

class Timeline extends StatefulWidget {
  final String label;
  final List<String> description;
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
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

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
                        color: const DigitColors().light.textPrimary,
                      ),
                    ),
                    SizedBox(height: isMobile ? kPadding/2 : kPadding,),
                    Column(
                      // Change here
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.description
                          .map((desc) => Text(
                                // Change here
                                desc,
                                style: currentTypography.bodyS.copyWith(
                                  color:
                                      const DigitColors().light.textSecondary,
                                ),
                              ))
                          .toList(), // Change here
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 1,
                      color: const DigitColors().light.genericDivider,
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
            ? const DigitColors().light.primary1
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
                  padding: isMobile
                      ? const EdgeInsets.all(kPadding / 2)
                      : const EdgeInsets.all(6),
                  width: isMobile ? 24 : 32,
                  height: isMobile ? 24 : 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const DigitColors().light.primary1,
                      width: 2.0,
                    ),
                    color: const DigitColors().light.paperPrimary,
                  ),
                  child: Container(
                    height: isMobile ? 12 : 16,
                    width: isMobile ? 12 : 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const DigitColors().light.primary1,
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
              color: const DigitColors().light.primary1,
              decoration: TextDecoration.underline,
              decorationColor: const DigitColors().light.primary1,
            ),
          ),
          const SizedBox(width: kPadding / 2),
          Icon(
            isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: 24,
            color: const DigitColors().light.primary1,
          ),
        ],
      ),
    );
  }
}

enum TimelineStepState { completed, present, future }
