import 'dart:async';
import 'package:digit_ui_components/utils/fileService/file_service.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/fileService/file_download.dart';
import '../../utils/utils.dart';

typedef OnFilesSelectedCallback = Map<DroppedFile, String?> Function(
    List<DroppedFile> files);

class FileUploadWidget2 extends StatefulWidget {
  final OnFilesSelectedCallback onFilesSelected;
  final String label;
  final bool showPreview;
  final bool allowMultiples;
  final String? errorMessage;
  final String downloadText;
  final bool isErrorChip;
  final String reUploadText;

  const FileUploadWidget2(
      {Key? key,
      required this.onFilesSelected,
      required this.label,
      this.showPreview = false,
      this.allowMultiples = false,
      this.errorMessage,
        this.isErrorChip = false,
      this.downloadText = 'Download',
      this.reUploadText = 'Re-Upload'})
      : super(key: key);

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
  Map<DroppedFile, String?> fileErrors = {};
  late bool isMobile;

  Widget _buildPreview(int index) {
    return _buildFilePreview(index);
  }

  Widget _buildProgressBar() {
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
          color: const DigitColors().light.genericDivider,
          width: Base.defaultBorderWidth,
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
          child: isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: spacer7),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          viewIcon,
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
                                onTap: () {
                                  _openFile(files[index].data, files[index].name);
                                },
                                child: Text(
                                  files[index].name,
                                  overflow: TextOverflow.ellipsis,
                                  style: currentTypography.headingS.copyWith(
                                    color: const DigitColors().light.textSecondary,
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
                                          color: const DigitColors()
                                              .light
                                              .alertError,
                                          size: spacer4,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: spacer1),
                                    Text(
                                      fileErrors[files[index]]!,
                                      style: currentTypography.bodyS.copyWith(
                                          color: const DigitColors()
                                              .light
                                              .alertError),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                    if(isFileError && widget.isErrorChip)
                    const SizedBox(
                      height: 12,
                    ),
                    if(isFileError && widget.isErrorChip)
                      InfoCard(title:'Error', type: InfoType.error  , description: fileErrors[files[index]]!),
                    const SizedBox(height: 12,),
                    Row(

                      children: [
                        Button(
                            label: widget.reUploadText,
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
                            label: widget.downloadText,
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
              : (widget.isErrorChip && isFileError) ?
              Column(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            child: Text(
                              files[index].name,
                              style: currentTypography.headingS.copyWith(
                                color: isFileError
                                    ? const DigitColors().light.alertError
                                    : const DigitColors().light.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  if(isFileError)
                  InfoCard(title:'Error', type: InfoType.error  , description: fileErrors[files[index]]!),
                  const SizedBox(height: 12,),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Button(
                          label: widget.reUploadText,
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
                          label: widget.downloadText,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        child: Text(
                          files[index].name,
                          style: currentTypography.headingS.copyWith(
                            color: isFileError
                                ? const DigitColors().light.alertError
                                : const DigitColors().light.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isFileError)
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
                                  color: const DigitColors()
                                      .light
                                      .alertError,
                                  size: spacer4,
                                ),
                              ],
                            ),
                            const SizedBox(width: spacer1),
                            Text(
                              fileErrors[files[index]]!,
                              style: currentTypography.bodyS.copyWith(
                                  color: const DigitColors()
                                      .light
                                      .alertError),
                            ),
                          ],
                        )
                    ],
                  ),
                ],
              ),
              Row(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Button(
                      label: widget.reUploadText,
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
                      label: widget.downloadText,
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
    currentTypography = getTypography(context, false);
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
                        ? const DigitColors().light.genericBackground
                        : const DigitColors().light.paperSecondary,
                  ),
                  child: DropzoneView(
                    onCreated: (controller) {
                      this.controller = controller;
                    },
                    onDropMultiple: (events) {
                      if(events==null) return;
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
          if (widget.errorMessage != null && (widget.allowMultiples==true || files.isEmpty))
            const SizedBox(
              height: spacer1,
            ),
          if (widget.errorMessage != null && (widget.allowMultiples==true || files.isEmpty))
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
