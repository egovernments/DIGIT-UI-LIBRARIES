import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


import '../../constants/app_constants.dart';

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
  double _uploadProgress = 0.0;
  Timer? _uploadTimer;
  bool isHighlighted = false;
  bool isUploading = false;
  bool isError = false;
  String currentFileName = '';
  late DigitTypography currentTypography;

  Widget _buildPreview(int index){
    String fileType = files[index].name.split('.').last.toLowerCase();
    switch (fileType) {
      case 'pdf':
        return _buildFilePreview(index);
      case 'png' :
        return _buildImagePreview(index);
      default:
        return _buildImagePreview(index);
    }
  }

  Widget _buildImagePreview(int index) {
    return Container(
      height: 280,
      width: 1300,
      padding: const EdgeInsets.all(kPadding * 2),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  files[index].url,
                ),
                fit: BoxFit.cover,
              ),
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
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const DigitColors().light.primary2,
                ),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: const DigitColors().light.paperPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
      width: 1300,
      height: 100,
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
          const SizedBox(width: 8,),
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
    IconData viewIcon;
    String fileType = files[index].name.split('.').last.toLowerCase();

    switch (fileType) {
      case 'pdf':
        viewIcon = Icons.picture_as_pdf;
        break;
      case 'jpg':
      case 'jpeg':
      case 'png':
        viewIcon = Icons.image;
        break;
      case 'doc':
      case 'docx':
        viewIcon = Icons.description;
        break;
      case 'xlsx':
      case 'xls':
        viewIcon = Icons.table_chart;
        break;
      default:
        viewIcon = Icons.insert_drive_file;
        break;
    }

    return GestureDetector(
      onTap: () {
        if (fileType == 'pdf') {
          _viewDocument(files[index].url);
        } else {
          _downloadFile(files[index].url, files[index].name);
        }
      },
      child: Container(
        height: 60,
        width: 1300,
        padding: const EdgeInsets.all(kPadding * 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              files[index].name,
              style: currentTypography.headingS.copyWith(
                color: const DigitColors().light.textSecondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Icon(
              viewIcon,
              color: const DigitColors().light.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadFile(String url, String name) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Save the file
      // You can save the file to a local directory or use other methods
      // For this example, we will show a dialog to save or view the file
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Downloaded $name'),
          content: Text('What would you like to do with $name?'),
          actions: [
            TextButton(
              onPressed: () {
                // Implement the code to save the file to local storage
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                _viewDocument(url);
                Navigator.pop(context);
              },
              child: Text('View'),
            ),
          ],
        ),
      );
    } else {
      throw Exception('Failed to download file');
    }
  }

  void _viewDocument(String url) async {
    if (await canLaunchUrl(url as Uri)) {
      await canLaunchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    currentTypography = getTypography(context, false);
    return SizedBox(
      width: 1300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 1300,
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
              InkWell(
                highlightColor: const DigitColors().transparent,
                hoverColor: const DigitColors().transparent,
                splashColor: const DigitColors().transparent,
                onTap: () async {
                  final events = await controller.pickFiles();
                  if (events.isEmpty) return;
                  acceptFile(events.first);
                },
                child: Container(
                  width: 1300,
                  height: 150,
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
                          const Text(
                              'Drag and drop your file or Browse in my files'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          isUploading
              ? _buildProgressBar()
              : widget.showPreview
              ? Wrap(
            spacing: 8.0,
            children: List.generate(files.length, (index) {
              return _buildPreview(index);
            }),
          )
              : Wrap(
            spacing: 8.0,
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

    await Future.delayed(const Duration(seconds: 5));

    try {
      final name = event.name;
      final mime = await controller.getFileMIME(event);
      final bytes = await controller.getFileSize(event);
      final url = await controller.createFileUrl(event);
      await controller.releaseFileUrl(url);

      final droppedFile = DroppedFile(
        url: url,
        name: name,
        mime: mime,
        bytes: bytes,
      );

      setState(() {
        files.add(droppedFile);
        isUploading = false;
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

  const DroppedFile({
    required this.url,
    required this.name,
    required this.bytes,
    required this.mime,
  });
}
