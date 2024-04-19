import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:digit_ui_components/digit_components.dart';

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
              )
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
      padding: const EdgeInsets.all(kPadding*2),

      child: Column(
        children: [
          const Text('File Name'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const DigitColors().light.textDisabled,
                width: 1,
              )
            ),
            child: LinearProgressIndicator(
              value: _uploadProgress,
              backgroundColor: const DigitColors().light.paperPrimary,
              valueColor: AlwaysStoppedAnimation<Color>(
                const DigitColors().light.primary2,
              ),
              minHeight: 8,
            ),
          ),
          Text('$_uploadProgress % progress'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: 1300,
                height: 150,
                child: DropzoneView(
                  onCreated: (controller) => this.controller = controller,
                  onDrop: acceptFile,
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
          _buildProgressBar(),
          const SizedBox(height: 8),
          widget.showPreview
              ? Wrap(
            spacing: 8.0,
            children: List.generate(files.length, (index) {
              return _buildImagePreview(index);
            }),
          )
              : Wrap(
            spacing: 8.0,
            children: List.generate(files.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Chip(
                  label: Text(files[index].name),
                  onDeleted: () {
                    setState(() {
                      files.removeAt(index);
                    });
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    try {
      final name = event.name;
      final mime = await controller.getFileMIME(event);
      final bytes = await controller.getFileSize(event);
      final url = await controller.createFileUrl(event);

      final droppedFile = DroppedFile(
        url: url,
        name: name,
        mime: mime,
        bytes: bytes,
      );

      _startUploadProgress();

      setState(() {
        files.add(droppedFile);
      });

      widget.onFilesSelected(files);
    } catch (e) {
      if (kDebugMode) {
        print('Error accepting file: $e');
      }
    }
  }

  void _startUploadProgress() {
    _uploadProgress = 0.0;
    const uploadInterval = Duration(milliseconds: 100);

    _uploadTimer?.cancel();

    _uploadTimer = Timer.periodic(uploadInterval, (timer) {
      setState(() {
        _uploadProgress += 0.05;
      });

      if (_uploadProgress >= 1.0) {
        _uploadTimer?.cancel();
        _uploadProgress = 0.0;
      }
    });
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
