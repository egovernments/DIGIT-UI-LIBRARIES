import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:digit_flutter_components/digit_components.dart';
import 'package:digit_flutter_components/enum/app_enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../theme/digit_theme.dart';
import 'labelled_fields.dart';

class FileUploadWidget extends StatefulWidget {
  final Function(List<File> files) onFilesSelected;
  final String label;

  FileUploadWidget({
    required this.onFilesSelected,
    required this.label,
  });

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  double _uploadProgress = 0.0;
  Timer? _uploadTimer;

  List<Uint8List> imageBytesList = []; // To store the bytes of the selected images

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = [];

      if (kIsWeb) {
        // On web, use bytes instead of path
        files = result.files.map((file) => File(file.bytes!.toString())).toList();
        for (var file in result.files) {
          setState(() {
            imageBytesList.add(file.bytes!);
          });
        }
      } else {
        files = result.paths.map((path) => File(path!)).toList();
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
          Image.memory(
            imageBytesList[index],
            fit: BoxFit.cover,
            // width: 100,
            // height: 100,
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
      return const SizedBox.shrink(); // Return an empty SizedBox if no image is selected
    }
  }

  @override
  Widget build(BuildContext context) {
    return LabeledField(
      label: widget.label,
      child: SizedBox(
        width: 640,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 480,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const DigitColors().lightTextPrimary,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: Text(imageBytesList.isEmpty ? 'No File Selected':
                      '${imageBytesList.length} Selected',
                      style: TextStyle(
                        color: const DigitColors().lightTextPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                DigitButton(
                  label: 'Upload',
                  onPressed: _openFileExplorer,
                  type: ButtonType.secondary,
                  prefixIcon: Icons.file_upload,
                  contentPadding: const EdgeInsets.all(4),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GridView.builder(
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
            ),
          ],
        ),
      ),
    );
  }
}
