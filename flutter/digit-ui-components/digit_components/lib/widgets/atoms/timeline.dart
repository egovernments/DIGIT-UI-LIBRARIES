import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/localized.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/utils.dart';
import '../../utils/i18_key_constants.dart' as i18;

class DigitTimeline extends LocalizedStatefulWidget {
  final String label;
  final List<String> description;
  final TimelineStepState currentStep;
  final List<Widget>? additionalWidgets;
  final List<Widget>? additionalHideWidgets;
  final String? viewDetailText;
  final String? hideDetailText;
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
    this.viewDetailText,
    this.hideDetailText,
    this.capitalizedLetter = true,
    this.isFirstFuture = false,
  }) : super(key: key);

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends LocalizedState<DigitTimeline> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);
    String capitalizedLabel = widget.capitalizedLetter
        ? capitalizeFirstLetterOfEveryWord(widget.label)
        : widget.label;

    return Container(
      color: widget.currentStep == TimelineStepState.failed
          ? theme.colorTheme.alert.errorBg
          : theme.colorTheme.paper.primary,

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                _buildTimelineIcon(isMobile, context),
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
                      style: textTheme.headingS.copyWith(
                        color: widget.currentStep == TimelineStepState.future
                            ? theme.colorTheme.text.secondary
                            : widget.currentStep == TimelineStepState.failed ? theme.colorTheme.alert.error : theme.colorTheme.text.primary
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
                                style: textTheme.bodyS.copyWith(
                                  color: widget.currentStep == TimelineStepState.failed ? theme.colorTheme.alert.error : theme.colorTheme.text.secondary,
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: spacer1),
                    Container(
                      height: 1,
                      color: widget.currentStep == TimelineStepState.failed ? theme.colorTheme.alert.error : theme.colorTheme.generic.divider,
                    ),
                    const SizedBox(height: spacer2),
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
                      _buildExpandDigitButton(context),
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
                          _buildExpandDigitButton(context),
                        ],
                      ),
                    if (!widget.isLastStep)
                      SizedBox(
                        height: isMobile
                            ? spacer4
                            : isTab
                                ? spacer5
                                : spacer6,
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectingLine() {
    return Expanded(
      child: CustomPaint(
        painter: widget.isFirstFuture
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

  Widget _buildTimelineIcon(bool isMobile, BuildContext context) {
    final theme = Theme.of(context);

    double size = isMobile ? spacer6 : spacer8;
    double innerSize = isMobile ? spacer6 : spacer8;
    double paddingSize = isMobile ? spacer1 : 6;
    double smallCircleSize = isMobile ? spacer3 : spacer4;

    Color iconColor = widget.currentStep == TimelineStepState.completed
        ? theme.colorTheme.primary.primary1
        : widget.currentStep == TimelineStepState.failed
            ? theme.colorTheme.paper.primary
            : theme.colorTheme.text.disabled;

    Color backgroundColor = widget.currentStep == TimelineStepState.completed
        ? theme.colorTheme.primary.primary1
        : widget.currentStep == TimelineStepState.present
            ? theme.colorTheme.paper.primary
            : widget.currentStep == TimelineStepState.future
                ? theme.colorTheme.text.disabled
                : theme.colorTheme.alert.error;

    Widget content;

    switch (widget.currentStep) {
      case TimelineStepState.completed:
        content = Icon(
          Icons.check,
          color: theme.colorTheme.paper.primary,
          size: isMobile ? 18 : 24,
        );
        break;
      case TimelineStepState.present:
        content = Container(
          padding: EdgeInsets.all(paddingSize),
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorTheme.primary.primary1,
              width: 2.0,
            ),
            color: backgroundColor,
          ),
          child: Container(
            height: smallCircleSize,
            width: smallCircleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorTheme.primary.primary1,
            ),
          ),
        );
        break;
      case TimelineStepState.future:
        content = Container(
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(50),
          ),
        );
        break;
      default:
        content = Container(
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            Icons.error,
            color: iconColor,
            size: isMobile ? 18 : 24,
          ),
        );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: content,
    );
  }

  Widget _buildExpandDigitButton(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    return DigitButton(
      type: DigitButtonType.link,
      size: DigitButtonSize.medium,
      onPressed: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      suffixIcon: isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
      label: isExpanded
          ? widget.hideDetailText ??
              localizations.translate(i18.common.hideDetails)
          : widget.viewDetailText ??
              localizations.translate(i18.common.viewDetails),
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
