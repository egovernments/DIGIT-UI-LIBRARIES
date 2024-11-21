import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import '../../models/privacy_notice/privacy_notice_model.dart';
import '../localized.dart';

class ExpandableSection extends LocalizedStatefulWidget {
  final ContentNoticeModel content;

  const ExpandableSection({
    super.key,
    super.appLocalizations,
    required this.content,
  });

  @override
  ExpandableSectionState createState() => ExpandableSectionState();
}

class ExpandableSectionState extends LocalizedState<ExpandableSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorTheme.paper.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(spacer1)),
        border: Border.all(color: theme.colorTheme.text.secondary, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: _isExpanded
                  ? const EdgeInsets.only(
                  top: spacer4,
                  left: spacer4,
                  right: spacer4)
                  : const EdgeInsets.all(spacer4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.content.header != null)
                    Flexible(
                      child: Text(
                        localizations.translate(widget.content.header!),
                        maxLines: 3,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.chevron_right,
                    size: spacer6,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded && widget.content.descriptions != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: spacer4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                widget.content.descriptions!.asMap().entries.map((entry) {
                  int index = entry.key;
                  DescriptionNoticeModel desc = entry.value;
                  int? stepNumber = desc.type == 'step' ? index + 1 : null;
                  return DescriptionWidget(
                    description: desc,
                    stepNumber: stepNumber,
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class DescriptionWidget extends LocalizedStatefulWidget {
  final DescriptionNoticeModel description;
  final int? stepNumber;

  const DescriptionWidget({
    super.key,
    super.appLocalizations,
    required this.description,
    this.stepNumber,
  });

  @override
  DescriptionWidgetState createState() => DescriptionWidgetState();
}

class DescriptionWidgetState extends LocalizedState<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final descriptionText = widget.description.text ?? '';
    final descriptionType = widget.description.type ?? "null";
    final isBold = widget.description.isBold ?? false;
    final hasSubDescriptions = widget.description.subDescriptions != null;

    return Padding(
      padding: const EdgeInsets.only(top: spacer2, bottom: spacer2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionText(
              descriptionText, descriptionType, isBold, widget.stepNumber),
          if (hasSubDescriptions)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.description.subDescriptions!
                  .asMap()
                  .entries
                  .map((entry) {
                final index = entry.key;
                final subDesc = entry.value;
                return SubDescriptionWidget(
                  subDescription: subDesc,
                  stepNumber: subDesc.type == 'step'
                      ? index + 1
                      : null, // Pass step number if type is 'step'
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildDescriptionText(String descriptionText, String descriptionType,
      bool isBold, int? stepNumber) {
    if (descriptionType == 'step') {
      return RichText(
        text: TextSpan(
          text: '$stepNumber. ',
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
          children: [
            TextSpan(
              text: localizations.translate(descriptionText),
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.justify,
      );
    } else if (descriptionType == 'points') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              SizedBox(
                height: 2,
              ),
              Icon(Icons.circle, size: spacer2),
            ],
          ),
          const SizedBox(width: spacer2),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: localizations.translate(descriptionText),
                style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      );
    } else {
      return Text(
        localizations.translate(descriptionText),
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      );
    }
  }
}

class SubDescriptionWidget extends LocalizedStatefulWidget {
  final SubDescriptionNoticeModel subDescription;
  final int? stepNumber;

  const SubDescriptionWidget({
    super.key,
    super.appLocalizations,
    required this.subDescription,
    this.stepNumber,
  });

  @override
  SubDescriptionWidgetState createState() => SubDescriptionWidgetState();
}

class SubDescriptionWidgetState extends LocalizedState<SubDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    final subDescriptionText = widget.subDescription.text ?? '';
    final subDescriptionType = widget.subDescription.type ?? "null";
    final isBold = widget.subDescription.isBold ?? false;
    final isSpaceRequired = widget.subDescription.isSpaceRequired ?? false;

    return Padding(
      padding: EdgeInsets.only(
          left: isSpaceRequired ? spacer4 : 0.0,
          top: spacer1,
          bottom: spacer1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubDescriptionText(subDescriptionText, subDescriptionType,
              isBold, widget.stepNumber),
        ],
      ),
    );
  }

  Widget _buildSubDescriptionText(String subDescriptionText,
      String subDescriptionType, bool isBold, int? stepNumber) {
    if (subDescriptionType == 'step') {
      return Text(
        '$stepNumber. ${localizations.translate(subDescriptionText)}',
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      );
    } else if (subDescriptionType == 'points') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              SizedBox(
                height: 2,
              ),
              Icon(Icons.circle, size: spacer2),
            ],
          ),
          const SizedBox(width: spacer2),
          Expanded(
            child: Text(
              localizations.translate(subDescriptionText),
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      );
    } else {
      return Text(
        localizations.translate(subDescriptionText),
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      );
    }
  }
}