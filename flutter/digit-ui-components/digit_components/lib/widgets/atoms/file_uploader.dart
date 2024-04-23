// import 'dart:async';
// import 'dart:io';
// import 'package:digit_ui_components/digit_components.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';  // <-- Import the PDFView widget
// import '../../constants/AppView.dart';
// import '../../constants/app_constants.dart';
// import '../../enum/app_enums.dart';
// import '../helper_widget/selection_chip.dart';
//
// class FileUploadWidget extends StatefulWidget {
//   final Function(List<File> files) onFilesSelected;
//   final String label;
//   final bool showPreview;
//   final bool allowMultipleImages;
//
//   const FileUploadWidget({
//     super.key,
//     required this.onFilesSelected,
//     required this.label,
//     this.showPreview = false,
//     this.allowMultipleImages = false,
//   });
//
//   @override
//   _FileUploadWidgetState createState() => _FileUploadWidgetState();
// }
//
// class _FileUploadWidgetState extends State<FileUploadWidget>
//     with SingleTickerProviderStateMixin {
//   double _uploadProgress = 0.0;
//   late AnimationController _animationController;
//   Timer? _uploadTimer;
//   List<String> fileNames = [];
//   List<Uint8List> fileBytesList = [];  // Generalized list for both images and PDFs
//   List<bool> uploadingStatus = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 5),
//     );
//
//     _animationController.addListener(() {
//       setState(() {
//         _uploadProgress = _animationController.value;
//       });
//     });
//   }
//
//   void _openFileExplorer() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: widget.allowMultipleImages,
//       type: FileType.custom,
//       allowedExtensions: ['xlsx', 'xls', 'pdf', 'jpg', 'jpeg', 'png'],
//     );
//
//     if (result != null) {
//       if (!widget.allowMultipleImages && fileBytesList.isNotEmpty) {
//         fileBytesList.clear();
//         fileNames.clear();
//         uploadingStatus.clear();
//       }
//
//       for (var file in result.files) {
//         setState(() {
//           fileBytesList.add(file.bytes!);
//           fileNames.add(file.name!);
//           uploadingStatus.add(true);
//         });
//       }
//
//       _startUploadProgress();
//       widget.onFilesSelected(result.files.map((e) => File(e.path!)).toList());
//     }
//   }
//
//   void _startUploadProgress() {
//     _uploadProgress = 0.0;
//     _animationController.forward(from: 0.0);
//
//     _animationController.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         for (int i = 0; i < uploadingStatus.length; i++) {
//           setState(() {
//             uploadingStatus[i] = false;
//           });
//         }
//       }
//     });
//   }
//
//   Widget _buildFilePreview(int index) {
//     if (uploadingStatus[index]) {
//       return _buildUploadProgressWidget(index);
//     } else if (fileBytesList.length > index) {
//       if (fileNames[index].toLowerCase().endsWith('.pdf')) {
//         return _buildPDFPreviewWidget(index);
//       } else {
//         return _buildImageWidget(index);
//       }
//     } else {
//       return const SizedBox.shrink();
//     }
//   }
//
//   Widget _buildUploadProgressWidget(int index) {
//     return Stack(
//       children: [
//         Container(
//           color: const DigitColors().light.genericDivider,
//           width: 100,
//           height: 100,
//           child: ClipRRect(
//             borderRadius: Common.radius,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 CustomPaint(
//                   painter: FillProgressPainter(
//                     progress: _uploadProgress,
//                     color: const DigitColors().light.textDisabled,
//                     initialColor: const DigitColors().light.genericBackground,
//                   ),
//                   child: Icon(
//                     Icons.insert_drive_file,
//                     size: 48,
//                     color: const DigitColors().light.genericInputBorder,
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: InkWell(
//                     hoverColor: const DigitColors().transparent,
//                     highlightColor: const DigitColors().transparent,
//                     splashColor: const DigitColors().transparent,
//                     onTap: () {
//                       _cancelUpload(index);
//                     },
//                     child: Container(
//                       width: 24,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         color: const DigitColors().light.primary2,
//                       ),
//                       child: Icon(
//                         Icons.close,
//                         size: 16,
//                         color: const DigitColors().light.paperPrimary,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildImageWidget(int index) {
//     return Stack(
//       children: [
//         Container(
//           color: const DigitColors().light.genericDivider,
//           width: 100,
//           height: 100,
//           child: ClipRRect(
//             borderRadius: Common.radius,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 Image.memory(
//                   fileBytesList[index],
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: InkWell(
//                     hoverColor: const DigitColors().transparent,
//                     highlightColor: const DigitColors().transparent,
//                     splashColor: const DigitColors().transparent,
//                     onTap: () {
//                       _removeFile(index);
//                     },
//                     child: Container(
//                       width: 24,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         color: const DigitColors().light.primary2,
//                       ),
//                       child: Icon(
//                         Icons.close,
//                         size: 16,
//                         color: const DigitColors().light.paperPrimary,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () {
//                         _showFilePreviewDialog(fileBytesList[index], fileNames[index]);
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPDFPreviewWidget(int index) {
//     return Stack(
//       children: [
//         Container(
//           color: const DigitColors().light.genericDivider,
//           width: 100,
//           height: 100,
//           child: ClipRRect(
//             borderRadius: Common.radius,
//             child: Stack(
//               fit: StackFit.expand,
//               children: [
//                 PDFView(
//                   filePath: '',
//                   document: PdfDocument.openData(fileBytesList[index]),
//                   pageLoader: Center(child: CircularProgressIndicator()),
//                   onError: (error) {
//                     print(error);
//                   },
//                   onPageChanged: (int page, int total) {
//                     print('page change: $page/$total');
//                   },
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: InkWell(
//                     hoverColor: const DigitColors().transparent,
//                     highlightColor: const DigitColors().transparent,
//                     splashColor: const DigitColors().transparent,
//                     onTap: () {
//                       _removeFile(index);
//                     },
//                     child: Container(
//                       width: 24,
//                       height: 24,
//                       decoration: BoxDecoration(
//                         color: const DigitColors().light.primary2,
//                       ),
//                       child: Icon(
//                         Icons.close,
//                         size: 16,
//                         color: const DigitColors().light.paperPrimary,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _showFilePreviewDialog(Uint8List fileBytes, String fileName) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         if (fileName.toLowerCase().endsWith('.pdf')) {
//           return Dialog(
//             child: Stack(
//               children: [
//                 PDFView(
//                   filePath: '',
//                   document: PdfDocument.openData(fileBytes),
//                   pageLoader: Center(child: CircularProgressIndicator()),
//                   onError: (error) {
//                     print(error);
//                   },
//                   onPageChanged: (int page, int total) {
//                     print('page change: $page/$total');
//                   },
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the dialog
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return Dialog(
//             child: Stack(
//               children: [
//                 Image.memory(
//                   fileBytes,
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.close,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the dialog
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   void _removeFile(int index) {
//     setState(() {
//       fileBytesList.removeAt(index);
//       fileNames.removeAt(index);
//       uploadingStatus.removeAt(index);
//     });
//   }
//
//   void _cancelUpload(int index) {
//     setState(() {
//       _animationController.stop();
//       _uploadProgress = 0.0;
//       uploadingStatus[index] = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DigitTypography currentTypography = getTypography(context, false);
//
//     double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
//         ? 328
//         : AppView.isTabletView(MediaQuery.of(context).size)
//         ? 440
//         : 600;
//
//     double minInputWidth = AppView.isMobileView(MediaQuery.of(context).size)
//         ? 198
//         : AppView.isTabletView(MediaQuery.of(context).size)
//         ? 304
//         : 468;
//
//     return Container(
//       constraints: BoxConstraints(
//         maxWidth: minWidth,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 40,
//                   constraints: BoxConstraints(
//                     maxWidth: minInputWidth,
//                   ),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: const DigitColors().light.textPrimary,
//                       width: 1,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 8.0, left: 8),
//                     child: fileBytesList.isEmpty
//                         ? Text(
//                       'No File Selected',
//                       style: currentTypography.bodyS.copyWith(
//                         color: const DigitColors().light.textDisabled,
//                       ),
//                     )
//                         : Text(
//                       '${fileBytesList.length} Selected',
//                       style: currentTypography.bodyS.copyWith(
//                         color: const DigitColors().light.textPrimary,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 16,
//               ),
//               Button(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 20),
//                 label: !widget.allowMultipleImages && fileBytesList.isNotEmpty
//                     ? 'Re-Upload'
//                     : 'Upload',
//                 onPressed: _openFileExplorer,
//                 type: ButtonType.secondary,
//                 prefixIcon: Icons.file_upload,
//                 size: ButtonSize.large,
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           widget.showPreview
//               ? Wrap(
//             spacing: 8.0,
//             children: List.generate(fileNames.length, (index) {
//               return _buildFilePreview(index);
//             }),
//           )
//               : Wrap(
//             spacing: 8.0,
//             children: List.generate(fileNames.length, (index) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: SelectionChip(
//                   label: fileNames[index],
//                   onItemDelete: () {
//                     setState(() {
//                       fileNames.removeAt(index);
//                       fileBytesList.removeAt(index);
//                       uploadingStatus.removeAt(index);
//                     });
//                   },
//                 ),
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class FillProgressPainter extends CustomPainter {
//   final double progress;
//   final Color color;
//   final Color initialColor;
//
//   FillProgressPainter({
//     required this.progress,
//     required this.color,
//     required this.initialColor,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final fillHeight = size.height * progress;
//     final fillPaint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(
//       Rect.fromLTRB(0, size.height - fillHeight, size.width, size.height),
//       fillPaint,
//     );
//
//     final initialFillHeight = size.height * (1 - progress);
//     final initialFillPaint = Paint()
//       ..color = initialColor
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(
//       Rect.fromLTRB(0, 0, size.width, initialFillHeight),
//       initialFillPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
