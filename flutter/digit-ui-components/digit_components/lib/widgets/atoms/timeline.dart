import 'package:digit_ui_components/digit_components.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/utils.dart';

class DigitTimeline extends StatefulWidget {
  final String label;
  final List<String> description;
  final TimelineStepState currentStep;
  final List<Widget>? additionalWidgets;
  final List<Widget>? additionalHideWidgets;
  final String viewDetailText;
  final String hideDetailText;
  final bool capitalizedLetter;
  final bool isLastStep;
  final bool isFirstFuture;

  const DigitTimeline({
    Key? key,
    required this.currentStep,
    required this.label,
    required this.description,
    this.additionalWidgets,
    this.additionalHideWidgets,
    this.isLastStep = true,
    this.viewDetailText = 'View Details',
    this.hideDetailText = 'Hide Details',
    this.capitalizedLetter = true,
    this.isFirstFuture = false,
  }) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<DigitTimeline> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    String capitalizedLabel = widget.capitalizedLetter
        ? capitalizeFirstLetterOfEveryWord(widget.label)
        : widget.label;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              _buildTimelineIcon(isMobile),
              if (!widget.isLastStep) _buildConnectingLine(),
            ],
          ),
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
                    height: isMobile ? spacer1 : spacer2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.description
                        .map((desc) => Text(
                              desc,
                              style: currentTypography.bodyS.copyWith(
                                color: const DigitColors().light.textSecondary,
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 1,
                    color: const DigitColors().light.genericDivider,
                  ),
                  const SizedBox(height: 8),
                  if (widget.additionalWidgets != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: widget.additionalWidgets!
                              .map(
                                (widgets) => Padding(
                                  padding: const EdgeInsets.only(
                                    right: spacer2,
                                    bottom: spacer2,
                                  ),
                                  child: widgets,
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  if (!isExpanded && widget.additionalHideWidgets != null)
                    _buildExpandButton(currentTypography),
                  if (isExpanded && widget.additionalHideWidgets != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: widget.additionalHideWidgets!
                              .map(
                                (widgets) => Padding(
                                  padding: const EdgeInsets.only(
                                    right: spacer2,
                                    bottom: spacer2,
                                  ),
                                  child: widgets,
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: spacer2),
                        _buildExpandButton(currentTypography),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectingLine() {
    return Expanded(
      child: CustomPaint(
        painter:  widget.isFirstFuture
            ? DottedLinePainter(color: const DigitColors().light.primary1)
            : null,
        child: Container(
          width: 2,
          color: widget.isFirstFuture
              ? Colors.transparent
              : widget.currentStep == TimelineStepState.completed ||
              widget.currentStep == TimelineStepState.present
              ? const DigitColors().light.primary1
              : const DigitColors().light.textDisabled,
        ),
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
                      ? const EdgeInsets.all(spacer1)
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
          const SizedBox(width: spacer1),
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
        return SvgPicture.asset(Base.pdfSvg);
      case 'jpg':
        return SvgPicture.asset(Base.jpgSvg);
      case 'png':
        return SvgPicture.asset(Base.pngSvg);
      case 'doc':
        return SvgPicture.asset(Base.docSvg);
      case 'xlsx':
        return SvgPicture.asset(Base.xlsxSvg);
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



class DottedLinePainter extends CustomPainter {
  final Color color;

  DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 4, dashSpace = 3, startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(DottedLinePainter oldDelegate) => false;
}
