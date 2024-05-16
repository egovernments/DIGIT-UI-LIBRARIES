import 'dart:async';
import 'package:digit_ui_components/constants/AppView.dart';
import 'package:digit_ui_components/utils/fileService/file_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../../utils/fileService/file_download.dart';
import '../../utils/utils.dart';

class FileUploadWidget2 extends StatefulWidget {
  final Function(List<DroppedFile>) onFilesSelected;
  final String label;
  final bool showPreview;
  final bool allowMultipleImages;
  final String? errorMessage;

  const FileUploadWidget2({
    Key? key,
    required this.onFilesSelected,
    required this.label,
    this.showPreview = false,
    this.allowMultipleImages = false,
    this.errorMessage,
  }) : super(key: key);

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget2> {
  List<DroppedFile> files = [];
  late DropzoneViewController controller;
  bool isHighlighted = false;
  bool isUploading = false;
  bool isError = false;
  String currentFileName = '';
  late DigitTypography currentTypography;
  late bool isMobile;

  Widget _buildPreview(int index) {
    return _buildFilePreview(index);
  }

  Widget _buildProgressBar() {
    String currentSvg;
    IconData downloadIcon;

    switch (currentFileName.split('.').last.toLowerCase()) {
      case 'pdf':
        currentSvg = Common.pdfSvg;
        downloadIcon = Icons.download;
        break;
      case 'jpg':
      case 'jpeg':
        currentSvg = Common.jpgSvg;
        downloadIcon = Icons.download;
        break;
      case 'png':
        currentSvg = Common.pngSvg;
        downloadIcon = Icons.download;
        break;
      case 'doc':
      case 'docx':
        currentSvg = Common.docSvg;
        downloadIcon = Icons.download;
        break;
      case 'xlsx':
      case 'xls':
        currentSvg = Common.xlsxSvg;
        downloadIcon = Icons.download;
        break;
      default:
        currentSvg = Common.fileSvg;
        downloadIcon = Icons.replay;
        break;
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: const DigitColors().light.genericDivider,
          width: Common.defaultBorderWidth,
        ),
        color: const DigitColors().light.paperSecondary,
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
                  style: currentTypography.headingS.copyWith(
                    color: const DigitColors().light.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                isUploading
                    ? Text(
                        'Uploading...',
                        style: currentTypography.bodyXS.copyWith(
                          color: const DigitColors().light.textSecondary,
                        ),
                      )
                    : isError
                        ? Text(
                            'Error',
                            style: currentTypography.bodyXS.copyWith(
                              color: const DigitColors().light.alertError,
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

  Widget _buildFilePreview(int index) {
    SvgPicture viewIcon;
    String fileType = files[index].name.split('.').last.toLowerCase();

    switch (fileType) {
      case 'pdf':
        viewIcon = SvgPicture.asset(Common.pdfSvg);
        break;
      case 'jpg':
        viewIcon = SvgPicture.asset(Common.jpgSvg);
        break;
      case 'png':
        viewIcon = SvgPicture.asset(Common.pngSvg);
        break;
      case 'doc':
      case 'docx':
        viewIcon = SvgPicture.asset(Common.docSvg);
        break;
      case 'xlsx':
      case 'xls':
        viewIcon = SvgPicture.asset(Common.xlsxSvg);
        break;
      default:
        viewIcon = SvgPicture.asset(Common.fileSvg);
        break;
    }

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
              left: spacer4, right: spacer10, top: spacer4, bottom: spacer4),
          decoration: BoxDecoration(
            border: Border.all(
              color: const DigitColors().light.genericDivider,
              width: Common.defaultBorderWidth,
            ),
          ),
          child: isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        viewIcon,
                        const SizedBox(
                          width: spacer2,
                        ),
                        InkWell(
                          hoverColor: const DigitColors().transparent,
                          splashColor: const DigitColors().transparent,
                          highlightColor: const DigitColors().transparent,
                          onTap: () {
                            _openFile(files[index].data, files[index].name);
                          },
                          child: Text(
                            files[index].name,
                            style: currentTypography.headingS.copyWith(
                              color: const DigitColors().light.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spacer4,
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        Button(
                            label: 'Re-Upload',
                            onPressed: () {
                              _reUploadFile(index);
                            },
                            prefixIcon: Icons.file_upload,
                            type: ButtonType.secondary,
                            size: ButtonSize.medium),
                        const SizedBox(
                          width: spacer2,
                        ),
                        Button(
                            label: 'Download',
                            onPressed: () {
                              _downloadFile(files[index]);
                            },
                            // contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                            prefixIcon: Icons.file_download,
                            type: ButtonType.secondary,
                            size: ButtonSize.medium),
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
                        viewIcon,
                        const SizedBox(
                          width: spacer2,
                        ),
                        InkWell(
                          hoverColor: const DigitColors().transparent,
                          splashColor: const DigitColors().transparent,
                          highlightColor: const DigitColors().transparent,
                          onTap: () {
                            _openFile(files[index].data, files[index].name);
                          },
                          child: Text(
                            files[index].name,
                            style: currentTypography.headingS.copyWith(
                              color: const DigitColors().light.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Button(
                            label: 'Re-Upload',
                            onPressed: () {
                              _reUploadFile(index);
                            },
                            prefixIcon: Icons.file_upload,
                            type: ButtonType.secondary,
                            size: ButtonSize.medium),
                        const SizedBox(
                          width: spacer2,
                        ),
                        Button(
                            label: 'Download',
                            onPressed: () {
                              _downloadFile(files[index]);
                            },
                            // contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                            prefixIcon: Icons.file_download,
                            type: ButtonType.secondary,
                            size: ButtonSize.medium),
                      ],
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
                  color: const DigitColors().light.genericDivider,
                  width: Common.defaultBorderWidth,
                ),
                color: const DigitColors().light.genericBackground,
              ),
              child: Icon(
                Icons.close,
                size: spacer6,
                color: const DigitColors().light.primary2,
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
    final url = await controller.createFileUrl(events.first);
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
    widget.onFilesSelected(files);
  }

  void _openFile(Uint8List fileBytes, String fileName) async {
    FileService();
  }

  @override
  Widget build(BuildContext context) {
    currentTypography = getTypography(context, false);
    isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    String? capitalizedErrorMessage =
        capitalizeFirstLetter(widget.errorMessage);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!(widget.allowMultipleImages == false &&
              (files.isNotEmpty || isUploading)))
            Stack(
              children: [
                Container(
                  height: isMobile ? 140 : 144,
                  decoration: BoxDecoration(
                    color: isHighlighted
                        ? const DigitColors().light.genericBackground
                        : const DigitColors().light.paperSecondary,
                  ),
                  child: DropzoneView(
                    onCreated: (controller) {
                      this.controller = controller;
                    },
                    onDrop: acceptFile,
                    onHover: () => setState(() => isHighlighted = true),
                    onLeave: () => setState(() => isHighlighted = false),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final events = await controller.pickFiles();
                    if (events.isEmpty) return;
                    acceptFile(events.first);
                  },
                  child: DottedBorder(
                    color: widget.errorMessage != null
                        ? const DigitColors().light.alertError
                        : const DigitColors().light.genericDivider,
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
                                color: const DigitColors().light.textDisabled,
                              ),
                              const SizedBox(height: spacer4),
                              isMobile
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                            'Drag and drop your file or '),
                                        Text(
                                          'Browse in my files',
                                          style: currentTypography.bodyS
                                              .copyWith(
                                                  color: const DigitColors()
                                                      .light
                                                      .primary1,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      const DigitColors()
                                                          .light
                                                          .primary1),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                            'Drag and drop your file or '),
                                        Text(
                                          'Browse in my files',
                                          style: currentTypography.bodyS
                                              .copyWith(
                                                  color: const DigitColors()
                                                      .light
                                                      .primary1,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor:
                                                      const DigitColors()
                                                          .light
                                                          .primary1),
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
          if (widget.errorMessage != null)
            const SizedBox(
              height: spacer1,
            ),
          if (widget.errorMessage != null)
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
                      color: const DigitColors().light.alertError,
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
                    style: currentTypography.bodyS.copyWith(
                      color: const DigitColors().light.alertError,
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: spacer2),
          if (isUploading) _buildProgressBar(),
          if (isUploading)
            const SizedBox(
              height: spacer2,
            ),
          Wrap(
            spacing: spacer2,
            runSpacing: spacer2,
            children: List.generate(files.length, (index) {
              return _buildPreview(index);
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

    // await Future.delayed(const Duration(seconds: 3));

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
      widget.onFilesSelected(files);
    } catch (e) {
      print('error');
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
