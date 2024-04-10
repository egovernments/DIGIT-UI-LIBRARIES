import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:digit_ui_components/digit_components.dart';

class FileUploadWidget2 extends StatefulWidget {
  final Function(List<File> files) onFilesSelected;
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
  double _uploadProgress = 0.0;
  Timer? _uploadTimer;
  List<String> fileNames = [];
  List<Uint8List> imageBytesList = [];

  // final GlobalKey<DropzoneState> _dropzoneKey = GlobalKey<DropzoneState>();

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultipleImages,
    );

    if (result != null) {
      List<File> files = [];

      if (!widget.allowMultipleImages && imageBytesList.isNotEmpty) {
        imageBytesList.clear();
        fileNames.clear();
      }

      if (kIsWeb) {
        files =
            result.files.map((file) => File(file.bytes!.toString())).toList();
        for (var file in result.files) {
          setState(() {
            imageBytesList.add(file.bytes!);
            fileNames.add(file.name);
          });
        }
      } else {
        files = result.paths.map((path) => File(path!)).toList();
        for (var path in result.paths) {
          fileNames.add(path!.split('/').last);
        }
      }

      _startUploadProgress();
      widget.onFilesSelected(files);
    } else {
      // User canceled the picker
    }

    setState(() {});
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
      }
    });
  }

  Widget _buildImagePreview(int index) {
    if (imageBytesList.length > index) {
      return Stack(
        children: [
          Image.memory(
            imageBytesList[index],
            fit: BoxFit.cover,
            width: 100,
            height: 100,
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
                  imageBytesList.removeAt(index);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.7),
                ),
                child: const Icon(Icons.close, size: 16),
              ),
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 1300,
                height: 150,
                child: DropzoneView(
                  operation: DragOperation.copy,
                  cursor: CursorType.grab,
                  // onCreated: (ctrl) => _dropzoneKey.currentState = ctrl,
                  onDrop: (ev) async {
                    print(ev);

                    if (ev is PlatformFile) { // Using PlatformFile for non-web platforms
                      print('File dropped: ${ev.name}');
                      final bytes = await ev.bytes; // Use bytes property to get file content
                      setState(() {
                        imageBytesList.add(bytes!);
                        fileNames.add(ev.name!);
                      });

                    } else if (ev is String) {
                      print('Text dropped: $ev');
                      // Handle text drop if needed
                    } else {
                      print('Unknown type dropped: ${ev.runtimeType}');
                    }
                  },
                ),
              ),
              InkWell(
                highlightColor: const DigitColors().transparent,
                hoverColor: const DigitColors().transparent,
                splashColor: const DigitColors().transparent,
                onTap: _openFileExplorer,
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
          widget.showPreview
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: imageBytesList.length,
                  itemBuilder: (context, index) {
                    return _buildImagePreview(index);
                  },
                )
              : Wrap(
                  spacing: 8.0,
                  children: List.generate(fileNames.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Chip(
                        label: Text(fileNames[index]),
                        onDeleted: () {
                          setState(() {
                            fileNames.removeAt(index);
                            imageBytesList.removeAt(index);
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
}
