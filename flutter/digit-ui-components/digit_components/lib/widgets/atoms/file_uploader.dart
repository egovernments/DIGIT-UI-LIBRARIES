import 'dart:io';
import 'dart:html' as html;
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../enum/app_enums.dart';
import '../helper_widget/selection_chip.dart';
import 'package:path_provider/path_provider.dart';


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
  List<String> fileNames = [];
  List<Uint8List> fileBytesList = [];  // Generalized list for both images and PDFs
  List<bool> uploadingStatus = [];

  @override
  void initState() {
    super.initState();
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultipleImages,
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      List<File> files = [];

      if (kIsWeb) {
        /// Handle file picking for web where paths are unavailable
        files = result.files.map((file) => File(file.bytes!.toString())).toList();
        for (var file in result.files) {
          if(widget.allowMultipleImages){
            setState(() {
              fileBytesList.add(file.bytes!);
              fileNames.add(file.name!);
            });
          }else{
            fileBytesList.clear();
            fileNames.clear();
            setState(() {
              fileBytesList.add(file.bytes!);
              fileNames.add(file.name!);
            });
          }
        }
      } else {
        //
        /// Handle file picking for mobile/desktop where paths are available
        files = result.files.map((file) => File(file.path!)).toList();
        for (var file in result.files) {
          if(widget.allowMultipleImages){
            setState(() {
              fileBytesList.add(file.bytes!);
              fileNames.add(file.name);
            });
          }else{
            fileBytesList.clear();
            fileNames.clear();
            setState(() {
              fileBytesList.add(file.bytes!);
              fileNames.add(file.name);
            });
          }
        }
      }
      widget.onFilesSelected(files);
    }
  }

  Future<String> writeToTemporaryFile(Uint8List dataBytes, String fileName) async {
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
        'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
        'xls': 'application/vnd.ms-excel',
        'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        'jpg': 'image/jpeg',
        'jpeg': 'image/jpeg',
        'png': 'image/png',
        // Add more file types as needed
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

  Widget _buildFilePreview(int index) {
  if (fileBytesList.length > index) {
      if (fileNames[index].toLowerCase().endsWith('.jpg') || fileNames[index].toLowerCase().endsWith('.png')){
        return _buildImageWidget(index);
      } else {
        return _buildFileWidget(index);
      }
    } else {
      return const SizedBox.shrink();
    }
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
                  fileBytesList[index],
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
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _openFile(fileBytesList[index], fileNames[index]);
                      },
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

  Widget _buildFileWidget(int index) {
    SvgPicture viewIcon;
    String fileType = fileNames[index].split('.').last.toLowerCase();

    switch (fileType) {
      case 'pdf':
        viewIcon = SvgPicture.asset(Common.pdfSvg);
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
          color: const DigitColors().light.genericDivider,
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: Common.radius,
            child: Stack(
              alignment: Alignment.center,
              // fit: StackFit.expand,
              children: [
                viewIcon,
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
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        _openFile(fileBytesList[index], fileNames[index]);
                      },
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

  void _removeFile(int index) {
    setState(() {
      fileBytesList.removeAt(index);
      fileNames.removeAt(index);
      uploadingStatus.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    DigitTypography currentTypography = getTypography(context, false);

    double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? 328
        : AppView.isTabletView(MediaQuery.of(context).size)
        ? 440
        : 600;

    double minInputWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? 198
        : AppView.isTabletView(MediaQuery.of(context).size)
        ? 304
        : 468;

    return Container(
      constraints: BoxConstraints(
        maxWidth: minWidth,
      ),
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
              Expanded(
                child: Container(
                  height: 40,
                  constraints: BoxConstraints(
                    maxWidth: minInputWidth,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const DigitColors().light.textPrimary,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: fileBytesList.isEmpty
                        ? Text(
                      'No File Selected',
                      style: currentTypography.bodyS.copyWith(
                        color: const DigitColors().light.textDisabled,
                      ),
                    )
                        : Text(
                      '${fileBytesList.length} Selected',
                      style: currentTypography.bodyS.copyWith(
                        color: const DigitColors().light.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Button(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                label: !widget.allowMultipleImages && fileBytesList.isNotEmpty
                    ? 'Re-Upload'
                    : 'Upload',
                onPressed: _openFileExplorer,
                type: ButtonType.secondary,
                prefixIcon: Icons.file_upload,
                size: ButtonSize.large,
              ),
            ],
          ),
          const SizedBox(height: 8),
          widget.showPreview
              ? Wrap(
            spacing: 8.0,
            children: List.generate(fileNames.length, (index) {
              return _buildFilePreview(index);
            }),
          )
              : Wrap(
            spacing: 8.0,
            children: List.generate(fileNames.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SelectionChip(
                  label: fileNames[index],
                  onItemDelete: () {
                    setState(() {
                      fileNames.removeAt(index);
                      fileBytesList.removeAt(index);
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

  FillProgressPainter({
    required this.progress,
    required this.color,
    required this.initialColor,
  });

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
