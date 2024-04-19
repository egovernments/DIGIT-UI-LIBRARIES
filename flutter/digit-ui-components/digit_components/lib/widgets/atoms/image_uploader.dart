import 'dart:async';
import 'dart:io';
import 'package:digit_ui_components/constants/app_constants.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ImageUploader extends StatefulWidget {
  final Function(List<File> files) onFilesSelected;
  final String label;
  final bool allowMultipleImages;

  const ImageUploader({super.key,
    required this.onFilesSelected,
    required this.label,
    this.allowMultipleImages = false,
  });

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  double _uploadProgress = 0.0;
  Timer? _uploadTimer;
  List<String> fileNames = []; // Store file names for chip display
  List<Uint8List> imageBytesList = [
  ]; // To store the bytes of the selected images

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: widget.allowMultipleImages);

    if (result != null) {
      List<File> files = [];

      if (!widget.allowMultipleImages && imageBytesList.isNotEmpty) {
        // If allowMultipleImages is false and there is already a file, clear the lists
        imageBytesList.clear();
        fileNames.clear();
      }

      if (kIsWeb) {
        // On web, use bytes instead of path
        files =
            result.files.map((file) => File(file.bytes!.toString())).toList();
        for (var file in result.files) {
          setState(() {
            imageBytesList.add(file.bytes!);
            fileNames.add(file.name); // Add file name to the list
          });
        }
      } else {
        files = result.paths.map((path) => File(path!)).toList();
        for (var path in result.paths) {
          fileNames.add(
              path!.split('/').last); // Extract and add file name to the list
        }
      }
      // Simulate upload progress
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

    _uploadTimer?.cancel(); // Cancel previous timer if exists

    _uploadTimer = Timer.periodic(uploadInterval, (timer) {
      setState(() {
        _uploadProgress += 0.05; // Increase upload progress
      });

      if (_uploadProgress >= 1.0) {
        _uploadTimer?.cancel(); // Stop timer when upload is complete
      }
    });
  }


  Widget _buildImagePreview(int index) {
    if (imageBytesList.length > index) {
      return Stack(
        children: [
          Container(
            color: const DigitColors().light.genericDivider,
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: Common.radius,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(
                    imageBytesList[index],
                    fit: BoxFit.cover,
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
                          fileNames.removeAt(index);
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
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink(); // Return an empty SizedBox if no image is selected
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                highlightColor: const DigitColors().transparent,
                hoverColor: const DigitColors().transparent,
                splashColor: const DigitColors().transparent,
                onTap: _openFileExplorer,
                child: Container(
                  width: 600,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const DigitColors().light.genericInputBorder,
                      width: 1,
                    ),
                  ),
                  child:  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 31.5),
                      child: Column(
                        children: [
                          Icon(Icons.camera_enhance, size: 40, color: const DigitColors().light.primary1,),
                           Text('Click to add photo', style: TextStyle(color: const DigitColors().light.primary1),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: List.generate(fileNames.length, (index) {
              return _buildImagePreview(index);
            }),
          )
        ],
      ),
    );
  }
}