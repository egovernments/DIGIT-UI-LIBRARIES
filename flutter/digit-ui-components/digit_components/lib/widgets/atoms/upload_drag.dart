import 'dart:async';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/utils/fileService/file_service.dart';
import 'package:digit_ui_components/widgets/localized.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/fileService/file_download.dart';
import '../../utils/utils.dart';
import '../../utils/i18_key_constants.dart' as i18;

typedef OnFilesSelectedCallback = Map<DroppedFile, String?> Function(
    List<DroppedFile> files);

class FileUploadWidget2 extends LocalizedStatefulWidget {
  final OnFilesSelectedCallback onFilesSelected;
  final String label;
  final bool showPreview;
  final bool allowMultiples;
  final String? errorMessage;
  final String? downloadText;
  final bool isErrorChip;
  final String? reUploadText;

  const FileUploadWidget2(
      {Key? key,
      required this.onFilesSelected,
      required this.label,
      this.showPreview = false,
      this.allowMultiples = false,
      this.errorMessage,
      this.isErrorChip = false,
      this.downloadText,
      this.reUploadText})
      : super(key: key);

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends LocalizedState<FileUploadWidget2> {
  List<DroppedFile> files = [];
  late DropzoneViewController controller;
  bool isHighlighted = false;
  bool isUploading = false;
  bool isError = false;
  String currentFileName = '';
  Map<DroppedFile, String?> fileErrors = {};
  late bool isMobile;

  Widget _buildPreview(int index, BuildContext context) {
    return _buildFilePreview(index, context);
  }

  Widget _buildProgressBar(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    String currentSvg;

    switch (currentFileName.split('.').last.toLowerCase()) {
      case 'pdf':
        currentSvg = Base.pdfSvg;
        break;
      case 'jpg':
      case 'jpeg':
        currentSvg = Base.jpgSvg;
        break;
      case 'png':
        currentSvg = Base.pngSvg;
        break;
      case 'doc':
      case 'docx':
        currentSvg = Base.docSvg;
        break;
      case 'xlsx':
      case 'xls':
        currentSvg = Base.xlsxSvg;
        break;
      default:
        currentSvg = Base.fileSvg;
        break;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.colorTheme.generic.divider,
          width: Base.defaultBorderWidth,
        ),
        color: theme.colorTheme.paper.secondary,
      ),
      padding: const EdgeInsets.all(spacer4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(currentSvg),
          const SizedBox(
            width: spacer2,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentFileName,
                  style: textTheme.headingS.copyWith(
                    color: theme.colorTheme.text.secondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                isUploading
                    ? Text(
                        'Uploading...',
                        style: textTheme.bodyXS.copyWith(
                          color: theme.colorTheme.text.secondary,
                        ),
                      )
                    : isError
                        ? Text(
                            'Error',
                            style: textTheme.bodyXS.copyWith(
                              color: theme.colorTheme.alert.error,
                            ),
                          )
                        : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePreview(int index, BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    SvgPicture viewIcon;
    String fileType = files[index].name.split('.').last.toLowerCase();

    switch (fileType) {
      case 'pdf':
        viewIcon = SvgPicture.asset(Base.pdfSvg);
        break;
      case 'jpg':
        viewIcon = SvgPicture.asset(Base.jpgSvg);
        break;
      case 'png':
        viewIcon = SvgPicture.asset(Base.pngSvg);
        break;
      case 'doc':
      case 'docx':
        viewIcon = SvgPicture.asset(Base.docSvg);
        break;
      case 'xlsx':
      case 'xls':
        viewIcon = SvgPicture.asset(Base.xlsxSvg);
        break;
      default:
        viewIcon = SvgPicture.asset(Base.fileSvg);
        break;
    }

    bool isFileError = fileErrors.containsKey(files[index]);

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
              left: spacer4, right: spacer4, top: spacer4, bottom: spacer4),
          decoration: BoxDecoration(
            border: Border.all(
              color: isFileError
                  ? const DigitColors().light.alertError
                  : const DigitColors().light.genericDivider,
              width: Base.defaultBorderWidth,
            ),
          ),
          child: isMobile || AppView.isTabletView(MediaQuery.of(context).size)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            hoverColor: const DigitColors().transparent,
                            splashColor: const DigitColors().transparent,
                            highlightColor: const DigitColors().transparent,
                            onTap: widget.showPreview
                                ? () {
                                    _openFile(
                                        files[index].data, files[index].name);
                                  }
                                : null,
                            child: viewIcon),
                        const SizedBox(
                          width: spacer2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              hoverColor: const DigitColors().transparent,
                              splashColor: const DigitColors().transparent,
                              highlightColor: const DigitColors().transparent,
                              onTap: widget.showPreview
                                  ? () {
                                      _openFile(
                                          files[index].data, files[index].name);
                                    }
                                  : null,
                              child: Container(
                                width: MediaQuery.of(context).size.width * .7,
                                child: Text(
                                  files[index].name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headingS.copyWith(
                                    color:theme.colorTheme.text.secondary,
                                  ),
                                ),
                              ),
                            ),
                            if (isFileError && !widget.isErrorChip)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 1.5,
                                      ),
                                      Icon(
                                        Icons.info,
                                        color: theme.colorTheme.alert.error,
                                        size: spacer4,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: spacer1),
                                  Text(
                                    fileErrors[files[index]]!,
                                    maxLines: 2,
                                    style: textTheme.bodyS.copyWith(
                                        color: theme.colorTheme.alert.error),
                                  ),
                                ],
                              )
                          ],
                        ),
                      ],
                    ),
                    if (isFileError && widget.isErrorChip)
                      const SizedBox(
                        height: 12,
                      ),
                    if (isFileError && widget.isErrorChip)
                      InfoCard(
                          title: 'Error',
                          type: InfoType.error,
                          description: fileErrors[files[index]]!),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        DigitButton(
                            label: widget.reUploadText ?? localizations.translate(i18.common.reUpload),
                            onPressed: () {
                              _reUploadFile(index);
                            },
                            prefixIcon: Icons.file_upload,
                            type: DigitButtonType.secondary,
                            size: DigitButtonSize.medium),
                        const SizedBox(
                          width: spacer2,
                        ),
                        DigitButton(
                            label: widget.downloadText ?? localizations.translate(i18.common.download),
                            onPressed: () {
                              _downloadFile(files[index]);
                            },
                            // contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                            prefixIcon: Icons.file_download,
                            type: DigitButtonType.secondary,
                            size: DigitButtonSize.medium),
                      ],
                    )
                  ],
                )
              : (widget.isErrorChip && isFileError)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                                hoverColor: const DigitColors().transparent,
                                splashColor: const DigitColors().transparent,
                                highlightColor: const DigitColors().transparent,
                                onTap: widget.showPreview
                                    ? () {
                                        _openFile(files[index].data,
                                            files[index].name);
                                      }
                                    : null,
                                child: viewIcon),
                            const SizedBox(
                              width: spacer2,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  hoverColor: const DigitColors().transparent,
                                  splashColor: const DigitColors().transparent,
                                  highlightColor:
                                      const DigitColors().transparent,
                                  onTap: widget.showPreview
                                      ? () {
                                          _openFile(files[index].data,
                                              files[index].name);
                                        }
                                      : null,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .56,
                                    child: Text(
                                      files[index].name,
                                      style:
                                          textTheme.headingS.copyWith(
                                        color: isFileError
                                            ? theme.colorTheme.alert.error
                                            : theme.colorTheme.text.secondary,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (isFileError)
                          InfoCard(
                              title: 'Error',
                              type: InfoType.error,
                              description: fileErrors[files[index]]!),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DigitButton(
                                label: widget.reUploadText?? localizations.translate(i18.common.reUpload),
                                onPressed: () {
                                  _reUploadFile(index);
                                },
                                prefixIcon: Icons.file_upload,
                                type: DigitButtonType.secondary,
                                size: DigitButtonSize.medium),
                            const SizedBox(
                              width: spacer2,
                            ),
                            DigitButton(
                                label: widget.downloadText ?? localizations.translate(i18.common.download),
                                onPressed: () {
                                  _downloadFile(files[index]);
                                },
                                // contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                                prefixIcon: Icons.file_download,
                                type: DigitButtonType.secondary,
                                size: DigitButtonSize.medium),
                          ],
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                                hoverColor: const DigitColors().transparent,
                                splashColor: const DigitColors().transparent,
                                highlightColor: const DigitColors().transparent,
                                onTap: widget.showPreview
                                    ? () {
                                        _openFile(files[index].data,
                                            files[index].name);
                                      }
                                    : null,
                                child: viewIcon),
                            const SizedBox(
                              width: spacer2,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  hoverColor: const DigitColors().transparent,
                                  splashColor: const DigitColors().transparent,
                                  highlightColor:
                                      const DigitColors().transparent,
                                  onTap: widget.showPreview
                                      ? () {
                                          _openFile(files[index].data,
                                              files[index].name);
                                        }
                                      : null,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    child: Text(
                                      files[index].name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          textTheme.headingS.copyWith(
                                        color: isFileError
                                            ? theme.colorTheme.alert.error
                                            : theme.colorTheme.text.secondary,
                                      ),
                                    ),
                                  ),
                                ),
                                if (isFileError)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 1.5,
                                          ),
                                          Icon(
                                            Icons.info,
                                            color: theme.colorTheme.alert.error,
                                            size: spacer4,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: spacer1),
                                      Text(
                                        fileErrors[files[index]]!,
                                        style: textTheme.bodyS.copyWith(
                                            color: theme.colorTheme.alert.error),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: SizedBox(
                            // width: MediaQuery.of(context).size.width*.3,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .13,
                                  child: DigitButton(
                                      label: widget.reUploadText?? localizations.translate(i18.common.reUpload),
                                      onPressed: () {
                                        _reUploadFile(index);
                                      },
                                      mainAxisSize: MainAxisSize.min,
                                      prefixIcon: Icons.file_upload,
                                      type: DigitButtonType.secondary,
                                      size: DigitButtonSize.medium),
                                ),
                                const SizedBox(
                                  width: spacer4,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .13,
                                  child: DigitButton(
                                      mainAxisSize: MainAxisSize.min,
                                      label: widget.downloadText ?? localizations.translate(i18.common.download),
                                      onPressed: () {
                                        _downloadFile(files[index]);
                                      },
                                      // contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                                      prefixIcon: Icons.file_download,
                                      type: DigitButtonType.secondary,
                                      size: DigitButtonSize.medium),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            hoverColor: const DigitColors().transparent,
            highlightColor: const DigitColors().transparent,
            splashColor: const DigitColors().transparent,
            onTap: () {
              setState(() {
                files.removeAt(index);
              });
            },
            child: Container(
              width: spacer6,
              height: spacer6,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isFileError
                      ? const DigitColors().light.alertError
                      : const DigitColors().light.genericDivider,
                  width: Base.defaultBorderWidth,
                ),
                color: isFileError
                    ? const DigitColors().light.alertError
                    : const DigitColors().light.genericBackground,
              ),
              child: Icon(
                Icons.close,
                size: spacer6,
                color: isFileError
                    ? const DigitColors().light.paperPrimary
                    : const DigitColors().light.primary2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _downloadFile(DroppedFile file) async {
    final fileDownloaderService = FileDownloaderService();
    await fileDownloaderService.downloadFile(file);
  }

  void _reUploadFile(int index) async {
    final events = await controller.pickFiles();
    final mime = await controller.getFileMIME(events.first);
    final bytes = await controller.getFileSize(events.first);
    final getData = await controller.getFileData(events.first);
    final name = await controller.getFilename(events.first);
    if (events.isEmpty) return;

    setState(() {
      files[index] = DroppedFile(
        name: name,
        mime: mime,
        bytes: bytes,
        data: getData,
      );
    });

    setState(() {
      fileErrors.addAll(widget.onFilesSelected(files));
    });
  }

  void _openFile(Uint8List fileBytes, String fileName) async {
    final fileService = FileService();
    final result = await fileService.writeToTemporaryFile(fileBytes, fileName);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    String? capitalizedErrorMessage =
        convertInToSentenceCase(widget.errorMessage);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!(widget.allowMultiples == false &&
              (files.isNotEmpty || isUploading)))
            Stack(
              children: [
                Container(
                  height: isMobile ? 140 : 144,
                  decoration: BoxDecoration(
                    color: isHighlighted
                        ? theme.colorTheme.generic.background
                        : theme.colorTheme.paper.secondary,
                  ),
                  child: DropzoneView(
                    onCreated: (controller) {
                      this.controller = controller;
                    },
                    onDropMultiple: (events) {
                      if (events == null) return;
                      if (widget.allowMultiples) {
                        for (var event in events) {
                          acceptFile(event);
                        }
                      } else {
                        acceptFile(events.last);
                      }
                    },
                    onHover: () => setState(() => isHighlighted = true),
                    onLeave: () => setState(() => isHighlighted = false),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final events = await controller.pickFiles(
                        multiple: widget.allowMultiples);
                    if (events.isEmpty) return;
                    acceptFile(events.first);
                  },
                  child: DottedBorder(
                    padding: EdgeInsets.zero,
                    color: widget.errorMessage != null
                        ? theme.colorTheme.alert.error
                        : theme.colorTheme.generic.divider,
                    strokeWidth: 1.5,
                    dashPattern: const [4, 2],
                    child: SizedBox(
                      height: isMobile ? 140 : 144,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(spacer4),
                          child: Column(
                            children: [
                              Icon(
                                Icons.file_upload,
                                size: isMobile ? spacer12 : spacer4 * 4,
                                color: theme.colorTheme.text.disabled,
                              ),
                              const SizedBox(height: spacer4),
                              isMobile
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Drag and drop your file or ',
                                          style: textTheme.bodyS.copyWith(
                                            color:
                                                theme.colorTheme.text.disabled,
                                          ),
                                        ),
                                        InkWell(
                                          child: Text(
                                            'Browse in my files',
                                            style: textTheme.bodyS.copyWith(
                                                color: theme.colorTheme.primary
                                                    .primary1,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: theme
                                                    .colorTheme
                                                    .primary
                                                    .primary1),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          localizations.translate(i18.common.dragDropFile),
                                          style: textTheme.bodyS.copyWith(
                                            color:
                                                theme.colorTheme.text.disabled,
                                          ),
                                        ),
                                        InkWell(
                                          child: Text(
                                            localizations.translate(i18.common.browseFile),
                                            style: textTheme.bodyS.copyWith(
                                                color: theme.colorTheme.primary
                                                    .primary1,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor: theme
                                                    .colorTheme
                                                    .primary
                                                    .primary1),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (widget.errorMessage != null &&
              (widget.allowMultiples == true || files.isEmpty))
            const SizedBox(
              height: spacer1,
            ),
          if (widget.errorMessage != null &&
              (widget.allowMultiples == true || files.isEmpty))
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: spacer1 / 2,
                    ),
                    Icon(
                      Icons.info,
                      color: theme.colorTheme.alert.error,
                      size: BaseConstants.errorIconSize,
                    ),
                  ],
                ),
                const SizedBox(width: spacer1),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    capitalizedErrorMessage!.length > 256
                        ? '${capitalizedErrorMessage.substring(0, 256)}...'
                        : capitalizedErrorMessage,
                    style: textTheme.bodyS.copyWith(
                      color: theme.colorTheme.alert.error,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: spacer2),
          if (isUploading) _buildProgressBar(context),
          if (isUploading)
            const SizedBox(
              height: spacer2,
            ),
          Wrap(
            spacing: spacer2,
            runSpacing: spacer2,
            children: List.generate(files.length, (index) {
              return _buildPreview(index, context);
            }),
          ),
        ],
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    setState(() {
      isUploading = true;
      isHighlighted = false;
      isError = false;
      currentFileName = event.name;
    });

    try {
      final name = event.name;
      final mime = await controller.getFileMIME(event);
      final bytes = await controller.getFileSize(event);
      final getData = await controller.getFileData(event);

      final droppedFile = DroppedFile(
        name: name,
        mime: mime,
        bytes: bytes,
        data: getData,
      );

      setState(() {
        files.add(droppedFile);
        isUploading = false;
        isHighlighted = false;
      });

      setState(() {
        fileErrors.addAll(widget.onFilesSelected(files));
      });
    } catch (e) {
      setState(() {
        isUploading = false;
        isError = true;
      });
    }
  }
}

class DroppedFile {
  final String name;
  final String mime;
  final int bytes;
  final Uint8List data;

  const DroppedFile({
    required this.name,
    required this.bytes,
    required this.mime,
    required this.data,
  });
}
