import 'dart:async';
import 'dart:io';
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../helper_widget/selection_chip.dart';

class FileUploadWidget extends StatefulWidget {
  final Function(List<File> files) onFilesSelected;
  final String label;
  final bool showPreview;
  final bool allowMultipleImages;

  const FileUploadWidget({
    super.key,
    required this.onFilesSelected,
    required this.label,
    this.showPreview = false,
    this.allowMultipleImages = false,
  });

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget>
    with SingleTickerProviderStateMixin {
  double _uploadProgress = 0.0;
  late AnimationController _animationController;
  Timer? _uploadTimer;
  List<String> fileNames = []; // Store file names for chip display
  List<Uint8List> imageBytesList =
      []; // To store the bytes of the selected images
  List<bool> uploadingStatus = []; // To track uploading status

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 5), // 5 seconds duration for the progress
    );

    _animationController.addListener(() {
      setState(() {
        _uploadProgress = _animationController.value;
      });
    });
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultipleImages,
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      List<File> files = [];

      if (!widget.allowMultipleImages && imageBytesList.isNotEmpty) {
        // If allowMultipleImages is false and there is already a file, clear the lists
        imageBytesList.clear();
        fileNames.clear();
        uploadingStatus.clear();
      }

      for (var file in result.files) {
        setState(() {
          imageBytesList.add(file.bytes!);
          fileNames.add(file.name!); // Add file name to the list
          uploadingStatus.add(true); // Set uploading status to true
        });
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
    _animationController.forward(from: 0.0);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        for (int i = 0; i < uploadingStatus.length; i++) {
          setState(() {
            uploadingStatus[i] = false;
          });
        }
      }
    });
  }

  Widget _buildImagePreview(int index) {
    if (uploadingStatus[index]) {
      // Display custom box during upload
      return _buildUploadProgressWidget(index);
    } else if (imageBytesList.length > index) {
      // Check file extension to determine if it's an image or not
      String fileName = fileNames[index].toLowerCase();
      if (fileName.endsWith('.jpg') ||
          fileName.endsWith('.jpeg') ||
          fileName.endsWith('.png')) {
        /// Display actual image preview after upload
        return _buildImageWidget(index);
      } else if (fileName.endsWith('.pdf')) {
        // Display PDF preview and allow opening full PDF on tap
        // return _buildPdfPreviewWidget(index);
        return const SizedBox();
      } else if (fileName.endsWith('.xlsx') || fileName.endsWith('.xls')) {
        // Display Excel preview and allow opening full Excel on tap
        // return _buildExcelPreviewWidget(index);
        return const SizedBox();
      } else {

        // Display file preview for other file types
        return const SizedBox();
        // return _buildFilePreviewWidget(index);
        return const SizedBox();
      }
    } else {
      return const SizedBox.shrink(); // Return an empty SizedBox if no image is selected
    }
  }


  Widget _buildUploadProgressWidget(int index) {
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
                CustomPaint(
                  painter: FillProgressPainter(
                    progress: _uploadProgress,
                    color: const DigitColors().light.textDisabled,
                    initialColor: const DigitColors().light.genericBackground,
                  ),
                  child: Icon(
                    Icons.insert_drive_file,
                    size: 48,
                    color: const DigitColors().light.genericInputBorder,
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
                      _cancelUpload(index);
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
  }

  Widget _buildImageWidget(int index) {
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
                      _removeFile(index);
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
  }


  // Widget _buildPdfPreviewWidget(int index) {
  //   return Stack(
  //     children: [
  //       Container(
  //         color: const DigitColors().light.genericDivider,
  //         width: 100,
  //         height: 100,
  //         child: ClipRRect(
  //           borderRadius: BorderRadius.circular(0),
  //           child: Stack(
  //             fit: StackFit.expand,
  //             children: [
  //               FutureBuilder<PdfDocument>(
  //                 future: PdfDocument.openData(imageBytesList[index]),
  //                 builder: (context, snapshot) {
  //                   if (snapshot.connectionState == ConnectionState.done &&
  //                       snapshot.hasData) {
  //                     return const PdfViewer(
  //
  //
  //                     );
  //                   } else if (snapshot.hasError) {
  //                     return Center(
  //                       child: Text('Error loading PDF'),
  //                     );
  //                   } else {
  //                     return Center(
  //                       child: CircularProgressIndicator(),
  //                     );
  //                   }
  //                 },
  //               ),
  //               Positioned(
  //                 top: 0,
  //                 right: 0,
  //                 child: InkWell(
  //                   hoverColor: const DigitColors().transparent,
  //                   highlightColor: const DigitColors().transparent,
  //                   splashColor: const DigitColors().transparent,
  //                   onTap: () {
  //                     _removeFile(index);
  //                   },
  //                   child: Container(
  //                     width: 24,
  //                     height: 24,
  //                     decoration: BoxDecoration(
  //                       color: const DigitColors().light.primary2,
  //                     ),
  //                     child: Icon(
  //                       Icons.close,
  //                       size: 16,
  //                       color: const DigitColors().light.paperPrimary,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }



  // Widget _buildExcelPreviewWidget(int index) {
  //   return Stack(
  //     children: [
  //       Container(
  //         color: const DigitColors().light.genericDivider,
  //         width: 100,
  //         height: 100,
  //         child: ClipRRect(
  //           borderRadius: Common.radius,
  //           child: Stack(
  //             fit: StackFit.expand,
  //             children: [
  //               Image.memory(
  //                 _generateExcelPreview(imageBytesList[index]),
  //                 fit: BoxFit.cover,
  //               ),
  //               Positioned(
  //                 top: 0,
  //                 right: 0,
  //                 child: InkWell(
  //                   hoverColor: const DigitColors().transparent,
  //                   highlightColor: const DigitColors().transparent,
  //                   splashColor: const DigitColors().transparent,
  //                   onTap: () {
  //                     _removeFile(index);
  //                   },
  //                   child: Container(
  //                     width: 24,
  //                     height: 24,
  //                     decoration: BoxDecoration(
  //                       color: const DigitColors().light.primary2,
  //                     ),
  //                     child: Icon(
  //                       Icons.close,
  //                       size: 16,
  //                       color: const DigitColors().light.paperPrimary,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildFilePreviewWidget(int index) {
  //   return Stack(
  //     children: [
  //       Container(
  //         color: const DigitColors().light.genericDivider,
  //         width: 100,
  //         height: 100,
  //         child: ClipRRect(
  //           borderRadius: Common.radius,
  //           child: Stack(
  //             fit: StackFit.expand,
  //             children: [
  //               Icon(
  //                 Icons.insert_drive_file,
  //                 size: 48,
  //                 color: const DigitColors().light.genericInputBorder,
  //               ),
  //               Positioned(
  //                 top: 0,
  //                 right: 0,
  //                 child: InkWell(
  //                   hoverColor: const DigitColors().transparent,
  //                   highlightColor: const DigitColors().transparent,
  //                   splashColor: const DigitColors().transparent,
  //                   onTap: () {
  //                     _removeFile(index);
  //                   },
  //                   child: Container(
  //                     width: 24,
  //                     height: 24,
  //                     decoration: BoxDecoration(
  //                       color: const DigitColors().light.primary2,
  //                     ),
  //                     child: Icon(
  //                       Icons.close,
  //                       size: 16,
  //                       color: const DigitColors().light.paperPrimary,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Uint8List _generateExcelPreview(Uint8List excelBytes) {
  //   final excel = ex.Excel.decodeBytes(excelBytes);
  //   final sheet = excel.tables.keys.first;
  //   final image = excel.tables[sheet]!.rows[0].first?.value; // Get the first cell as an image
  //
  //   return image;
  // }

  void _removeFile(int index) {
    setState(() {
      imageBytesList.removeAt(index);
      fileNames.removeAt(index);
      uploadingStatus.removeAt(index);
    });
  }

  void _cancelUpload(int index) {
    setState(() {
      _animationController.stop();
      _uploadProgress = 0.0;
      uploadingStatus[index] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    double inputWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width *.91
        : AppView.isTabletView(MediaQuery.of(context).size)
        ? MediaQuery.of(context).size.width* .59
        : MediaQuery.of(context).size.width*.416;

    return SizedBox(
      width: inputWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 468,
                height: 42,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const DigitColors().light.textPrimary,
                    width: 1,
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: imageBytesList.isEmpty
                        ? Text(
                            'No File Selected',
                            style: currentTypography.bodyS.copyWith(
                              color: const DigitColors().light.textDisabled,
                              height: 1.5,
                            ),
                          )
                        : Text(
                            '${imageBytesList.length} Selected',
                            style: currentTypography.bodyS.copyWith(
                              color: const DigitColors().light.textPrimary,
                              height: 1.5,
                            ),
                          )),
              ),
              const SizedBox(
                width: 16,
              ),
              // Button(
              //   width: 200,
              //   label: !widget.allowMultipleImages && imageBytesList.isNotEmpty
              //       ? 'Re-Upload'
              //       : 'Upload',
              //   onPressed: _openFileExplorer,
              //   type: ButtonType.secondary,
              //   prefixIcon: Icons.file_upload,
              //   // contentPadding: const EdgeInsets.all(),
              // ),
            ],
          ),
          const SizedBox(height: 8),
          widget.showPreview
              ? Wrap(
                  spacing: 8.0,
                  children: List.generate(fileNames.length, (index) {
                    return _buildImagePreview(index);
                  }),
                )
              : Wrap(
                  spacing: 8.0,
                  children: List.generate(fileNames.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: SelectionChip(
                        item: FileData(name: fileNames[index], code: '1'),
                        onItemDelete: (dynamic) {
                          setState(() {
                            fileNames.removeAt(index);
                            imageBytesList.removeAt(index);
                            uploadingStatus.removeAt(index);
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

class FillProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color initialColor;

  FillProgressPainter(
      {required this.progress,
      required this.color,
      required this.initialColor});

  @override
  void paint(Canvas canvas, Size size) {
    final fillHeight = size.height * progress;
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, size.height - fillHeight, size.width, size.height),
      fillPaint,
    );

    final initialFillHeight = size.height * (1 - progress);
    final initialFillPaint = Paint()
      ..color = initialColor
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, initialFillHeight),
      initialFillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
