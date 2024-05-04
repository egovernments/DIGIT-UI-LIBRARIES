import 'dart:async';
import 'package:digit_ui_components/constants/AppView.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'dart:html' as html;
import 'package:path_provider/path_provider.dart';

import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';

class FileUploadWidget2 extends StatefulWidget {
  final Function(List<DroppedFile>) onFilesSelected;
  final String label;
  final bool showPreview;
  final bool allowMultipleImages;

  const FileUploadWidget2({
    Key? key,
    required this.onFilesSelected,
    required this.label,
    this.showPreview = false,
    this.allowMultipleImages = false,
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
          width: 1,
        ),
        color: const DigitColors().light.paperSecondary,
      ),
      padding: const EdgeInsets.all(kPadding * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(currentSvg),
          const SizedBox(
            width: 8,
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

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(kPadding * 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: const DigitColors().light.genericDivider,
          width: 1,
        ),
      ),
      child: isMobile ?
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              viewIcon,
              const SizedBox(width: 8,),
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
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                width: 8,
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
              const SizedBox(width: 8,),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                width: 8,
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
    );
  }

  Future<void> _downloadFile(DroppedFile file) async {
    if (kIsWeb) {
      // For web, create a download link and trigger a download
      html.AnchorElement(
          href: html.Url.createObjectUrlFromBlob(html.Blob([file.data])))
        ..setAttribute("download", file.name)
        ..click();
    } else {
      // For non-web platforms, write the file to the temporary directory
      final directory = await getTemporaryDirectory();
      final path = directory.path + Platform.pathSeparator + file.name;
      final localFile = File(path); // Renamed from 'file' to 'localFile'
      await localFile.writeAsBytes(file.data);
    }
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
        url: url,
        name: name,
        mime: mime,
        bytes: bytes,
        data: getData,
      );
    });
    widget.onFilesSelected(files);
  }

  Future<String> writeToTemporaryFile(
      Uint8List dataBytes, String fileName) async {
    if (!kIsWeb) {
      // Use path_provider for mobile or desktop platforms.
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(dataBytes);
      return file.path;
    } else {
      // Handle the web case where writing to the disk is not possible.
      // Map file extensions to MIME types
      final Map<String, String> mimeTypes = {
        'pdf': 'application/pdf',
        'doc': 'application/msword',
        'docx':
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'xls': 'application/vnd.ms-excel',
        'xlsx':
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'png': 'image/png',
      };

      // Extract file extension from the file name
      final extension = fileName.split('.').last.toLowerCase();
      final mimeType = mimeTypes[extension];

      if (mimeType != null) {
        // Create a Blob with the appropriate MIME type
        final blob = html.Blob([dataBytes], mimeType);
        final url = html.Url.createObjectUrlFromBlob(blob);
        // Open the URL in a new tab/window.
        html.window.open(url, '_blank');
        return url; // Returning URL for potential further use
      } else {
        // Handle unsupported file types
        print('Unsupported file type: $extension');
        // You can provide feedback to the user or handle the unsupported file type in a different way.
        return '';
      }
    }
  }

  void _openFile(Uint8List fileBytes, String fileName) async {
    String tempFilePath = await writeToTemporaryFile(fileBytes, fileName);
    print('heeeeeeeeeeeeeee');
  }

  @override
  Widget build(BuildContext context) {
    currentTypography = getTypography(context, false);
    isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(!(widget.allowMultipleImages==false && (files.isNotEmpty || isUploading)))Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? const DigitColors().light.genericBackground
                      : const DigitColors().light.paperPrimary,
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
                child: Container(
                  height: 155,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const DigitColors().light.genericInputBorder,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.file_upload,
                            size: 64,
                            color: const DigitColors().light.textDisabled,
                          ),
                          const SizedBox(height: 20),
                          isMobile ?
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Drag and drop your file or'),
                              Button(
                                  label: 'Browse in my files',
                                  onPressed: () async {
                                    final events = await controller.pickFiles();
                                    if (events.isEmpty) return;
                                    acceptFile(events.first);
                                  },
                                  type: ButtonType.link,
                                  size: ButtonSize.large)
                            ],
                          )
                              : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Drag and drop your file or'),
                              Button(
                                  label: 'Browse in my files',
                                  onPressed: () async {
                                    final events = await controller.pickFiles();
                                    if (events.isEmpty) return;
                                    acceptFile(events.first);
                                  },
                                  type: ButtonType.link,
                                  size: ButtonSize.large)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (isUploading) _buildProgressBar(),
          if (isUploading) const SizedBox(height: 8,),
          widget.showPreview
              ? Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(files.length, (index) {
                    return _buildPreview(index);
                  }),
                )
              : Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(files.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: _buildPreview(index),
                    );
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

    await Future.delayed(const Duration(seconds: 3));

    try {
      final name = event.name;
      final mime = await controller.getFileMIME(event);
      final bytes = await controller.getFileSize(event);
      final url = await controller.createFileUrl(event);
      final getData = await controller.getFileData(event);
      await controller.releaseFileUrl(url);

      final droppedFile = DroppedFile(
        url: url,
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
  final String url;
  final String name;
  final String mime;
  final int bytes;
  final Uint8List data;

  const DroppedFile({
    required this.url,
    required this.name,
    required this.bytes,
    required this.mime,
    required this.data,
  });
}
