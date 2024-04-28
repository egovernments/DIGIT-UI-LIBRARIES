import 'package:digit_ui_components/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/digit_theme.dart';
import '../../theme/typography.dart';
import '../../utils/utils.dart';

class Timeline extends StatefulWidget {
  final String label;
  final List<String> description;
  final TimelineStepState currentStep;
  final List<Widget>? additionalWidgets;
  final List<Widget>? additionalHideWidgets;
  final String viewDetailText;
  final String hideDetailText;
  final bool capitalizedLetter;

  const Timeline({
    Key? key,
    required this.currentStep,
    required this.label,
    required this.description,
    this.additionalWidgets,
    this.additionalHideWidgets,
    this.viewDetailText = 'View Details',
    this.hideDetailText = 'Hide Details',
    this.capitalizedLetter = true,
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
    String capitalizedLabel = widget.capitalizedLetter
        ? capitalizeFirstLetterOfEveryWord(widget.label)
        : widget.label;

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
                child: Padding(
                  padding: EdgeInsets.only(top: isMobile ? 2.5 : 6.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        capitalizedLabel,
                        style: currentTypography.headingS.copyWith(
                          color: const DigitColors().light.textPrimary,
                        ),
                      ),
                      SizedBox(
                        height: isMobile ? kPadding / 2 : kPadding,
                      ),
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
                          (widgets) => Padding(
                            padding: const EdgeInsets.only(
                              right: kPadding,
                              bottom: kPadding,
                            ),
                            child: widgets is TimelineFiles
                                ? widgets
                                : widgets,
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
                          (widgets) => Padding(
                            padding: const EdgeInsets.only(
                              right: kPadding,
                              bottom: kPadding,
                            ),
                            child: widgets is TimelineFiles
                                ? widgets
                                : widgets,
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

class TimelineFiles {
  final String url;
  final String name;
  final String fileType;

  TimelineFiles({
    required this.url,
    required this.name,
    required this.fileType,
  });
}

class TimelineFileWidget extends StatelessWidget {
  final TimelineFiles file;
  final bool openFile;

  const TimelineFileWidget({
    Key? key,
    required this.file,
    required this.openFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildFileWidget(context, file);
  }

  Widget _buildFileWidget(BuildContext context, TimelineFiles file) {
    String fileType = file.fileType.toLowerCase();

    return InkWell(
      highlightColor: const DigitColors().transparent,
      hoverColor: const DigitColors().transparent,
      splashColor: const DigitColors().transparent,
      onTap: () {
        // Check isPreview here before calling _viewDocument
        print(openFile);
        if (openFile) {
          _viewDocument(file.url);
        }
      },
      child: SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFileIcon(fileType),
              Text(file.name),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileIcon(String fileType) {
    switch (fileType) {
      case 'pdf':
        return SvgPicture.asset(Common.pdfSvg);
      case 'jpg':
        return SvgPicture.asset(Common.jpgSvg);
      case 'png':
        return SvgPicture.asset(Common.pngSvg);
      case 'doc':
        return SvgPicture.asset(Common.docSvg);
      case 'xlsx':
        return SvgPicture.asset(Common.xlsxSvg);
      default:
        return Container();
    }
  }

  void _viewDocument(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

}

