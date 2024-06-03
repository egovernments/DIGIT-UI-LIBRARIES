import 'dart:io';
import 'dart:html' as html;
import 'package:digit_ui_components/digit_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/utils.dart';
import '../../utils/validators/file_validator.dart';
import '../helper_widget/selection_chip.dart';
import 'package:path_provider/path_provider.dart';

typedef OnFilesSelectedCallback = Map<PlatformFile, String?> Function(
    List<PlatformFile> files);

class FileUploadWidget extends StatefulWidget {
  final OnFilesSelectedCallback onFilesSelected;
  final String label;
  final bool showPreview;
  final bool allowMultipleImages;
  final String? errorMessage;
  final List<FileValidator>? validators;
  final List<String>? allowedExtensions;

  const FileUploadWidget({
    super.key,
    required this.onFilesSelected,
    required this.label,
    this.showPreview = false,
    this.allowMultipleImages = false,
    this.errorMessage,
    this.validators,
    this.allowedExtensions,
  });

  @override
  _FileUploadWidgetState createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget>
    with SingleTickerProviderStateMixin {
  List<PlatformFile> files = [];
  List<String> fileNames = [];
  List<Uint8List> fileBytesList = [];
  List<bool> uploadingStatus = [];
  String fileErrorMessage = '';
  Map<PlatformFile, String?> fileErrors = {};
  late DigitTypography currentTypography;

  @override
  void initState() {
    super.initState();
  }

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultipleImages,
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions ??
          ['xlsx', 'xls', 'pdf', 'jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      if (widget.validators != null) {
        for (var platformFile in result.files) {
          String? validationError =
              _validateFile(platformFile, widget.validators!);
          if (validationError != null) {
            setState(() {
              fileErrorMessage = validationError;
            });
            return;
          }
        }
      }

      if (kIsWeb) {
        /// Handle file picking for web where paths are unavailable

        for (var file in result.files) {
          if (widget.allowMultipleImages) {
            setState(() {
              fileBytesList.add(file.bytes!);
              fileNames.add(file.name!);
            });
          } else {
            fileBytesList.clear();
            fileNames.clear();
            setState(() {
              fileBytesList.add(file.bytes!);
              fileNames.add(file.name!);
            });
          }
          files.add(file);
        }
      } else {
        //
        /// Handle file picking for mobile/desktop where paths are available
        for (var file in result.files) {
          if (widget.allowMultipleImages) {
            setState(() {
              fileBytesList.add(file.bytes!);
              fileNames.add(file.name);
            });
          } else {
            fileBytesList.clear();
            fileNames.clear();
            setState(() {
              fileBytesList.add(file.bytes!);
              fileNames.add(file.name);
            });
          }
          files.add(file);
        }
      }

      /// Call onFilesSelected with the selected files
      setState(() {
        fileErrors = widget.onFilesSelected(result.files);
      });
    }
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
  }

  Widget _buildFilePreview(int index, double width) {
    if (fileBytesList.length > index) {
      if (fileNames[index].toLowerCase().endsWith('.jpg') ||
          fileNames[index].toLowerCase().endsWith('.png')) {
        return _buildImageWidget(index, width);
      } else {
        return _buildFileWidget(index, width);
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildImageWidget(int index, double width) {
    bool showOverlay = false;

    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        width: widget.allowMultipleImages ? 100 : width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    _openFile(fileBytesList[index], fileNames[index]);
                  },
                  onHover: (hovering) {
                    setState(() {
                      showOverlay = hovering;
                    });
                  },
                  child: Container(
                    width: widget.allowMultipleImages ? 100 : width,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: fileErrors.containsKey(files[index])
                          ? const DigitColors().light.alertError
                          : const DigitColors().light.genericDivider,
                      width: 1,
                    )),
                    child: ClipRRect(
                      borderRadius: Base.radius,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(
                            fileBytesList[index],
                            fit: BoxFit.cover,
                          ),
                          if (!showOverlay)
                            Container(
                              color: fileErrors.containsKey(files[index])
                                  ? const DigitColors()
                                      .light
                                      .alertError
                                      .withOpacity(.20)
                                  : const DigitColors()
                                      .background
                                      .withOpacity(.70), // Light overlay color
                            ),
                        ],
                      ),
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
                      _removeFile(index);
                    },
                    onHover: (hovering) {
                      setState(() {
                        showOverlay = hovering;
                      });
                    },
                    child: Container(
                      width: spacer6,
                      height: spacer6,
                      decoration: BoxDecoration(
                        color: fileErrors.containsKey(files[index])
                            ? const DigitColors().light.alertError
                            : const DigitColors().light.primary2,
                      ),
                      child: Icon(
                        Icons.close,
                        size: spacer4,
                        color: const DigitColors().light.paperPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: spacer1,
            ),
            fileErrors.containsKey(files[index])
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: spacer1 / 2,
                          ),
                          Icon(
                            Icons.info,
                            color: const DigitColors().light.alertError,
                            size: spacer4,
                          ),
                        ],
                      ),
                      const SizedBox(width: spacer1),
                      Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            fileErrors[files[index]]!,
                            style: currentTypography.bodyXS.copyWith(
                                color: const DigitColors().light.alertError),
                          )),
                    ],
                  )
                : Text(
                    fileNames[index],
                    style: currentTypography.bodyXS
                        .copyWith(color: const DigitColors().light.textPrimary),
                  ),
          ],
        ),
      );
    });
  }

  Widget _buildFileWidget(int index, double width) {
    SvgPicture viewIcon;
    String fileType = fileNames[index].split('.').last.toLowerCase();
    bool showOverlay = false;

    switch (fileType) {
      case 'pdf':
        viewIcon = SvgPicture.asset(
          Base.pdfSvg,
        );
        break;
      case 'doc':
      case 'docx':
        viewIcon = SvgPicture.asset(
          Base.docSvg,
        );
        break;
      case 'xlsx':
      case 'xls':
        viewIcon = SvgPicture.asset(
          Base.xlsxSvg,
        );
        break;
      default:
        viewIcon = SvgPicture.asset(
          Base.fileSvg,
        );
        break;
    }

    return StatefulBuilder(builder: (context, setState) {
      return SizedBox(
        width: widget.allowMultipleImages ? 100 : width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    _openFile(fileBytesList[index], fileNames[index]);
                  },
                  onHover: (hovering) {
                    setState(() {
                      showOverlay = hovering;
                    });
                  },
                  child: Container(
                    width: widget.allowMultipleImages ? 100 : width,
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: fileErrors.containsKey(files[index])
                          ? const DigitColors().light.alertError
                          : const DigitColors().light.genericDivider,
                      width: 1,
                    )),
                    child: ClipRRect(
                      borderRadius: Base.radius,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          SizedBox(
                              width: 100,
                              height: 100,
                              child: Container(
                                  padding: const EdgeInsets.all(spacer6),
                                  child: viewIcon)),
                          if (!showOverlay)
                            Container(
                              color: fileErrors.containsKey(files[index])
                                  ? const DigitColors()
                                      .light
                                      .alertError
                                      .withOpacity(.20)
                                  : const DigitColors()
                                      .background
                                      .withOpacity(.70), // Light overlay color
                            ),
                        ],
                      ),
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
                      _removeFile(index);
                    },
                    onHover: (hovering) {
                      setState(() {
                        showOverlay = hovering;
                      });
                    },
                    child: Container(
                      width: spacer6,
                      height: spacer6,
                      decoration: BoxDecoration(
                        color: fileErrors.containsKey(files[index])
                            ? const DigitColors().light.alertError
                            : const DigitColors().light.primary2,
                      ),
                      child: Icon(
                        Icons.close,
                        size: spacer4,
                        color: const DigitColors().light.paperPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            fileErrors.containsKey(files[index])
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 2,
                          ),
                          Icon(
                            Icons.info,
                            color: const DigitColors().light.alertError,
                            size: spacer4,
                          ),
                        ],
                      ),
                      const SizedBox(width: spacer1),
                      Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            fileErrors[files[index]]!,
                            style: currentTypography.bodyXS.copyWith(
                                color: const DigitColors().light.alertError),
                          )),
                    ],
                  )
                : Text(
                    fileNames[index],
                    style: currentTypography.bodyXS
                        .copyWith(color: const DigitColors().light.textPrimary),
                  ),
          ],
        ),
      );
    });
  }

  void _removeFile(int index) {
    setState(() {
      fileBytesList.removeAt(index);
      fileNames.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    currentTypography = getTypography(context, false);
    String? capitalizedErrorMessage =
        convertInToSentenceCase(widget.errorMessage);

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
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  height: spacer10,
                  constraints: BoxConstraints(
                    maxWidth: minInputWidth,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          widget.errorMessage != null || fileErrorMessage != ''
                              ? const DigitColors().light.alertError
                              : const DigitColors().light.textPrimary,
                      width:
                          widget.errorMessage != null || fileErrorMessage != ''
                              ? Base.errorBorderWidth
                              : Base.defaultBorderWidth,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: spacer2, left: spacer2),
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
                width: spacer4,
              ),
              Button(
                contentPadding: const EdgeInsets.symmetric(horizontal: spacer5),
                label: !widget.allowMultipleImages && fileBytesList.isNotEmpty
                    ? 'Re-Upload'
                    : 'Upload',
                onPressed: () {
                  fileErrorMessage = '';
                  _openFileExplorer();
                },
                type: ButtonType.secondary,
                prefixIcon: Icons.file_upload,
                size: ButtonSize.large,
              ),
            ],
          ),
          if (widget.errorMessage != null || fileErrorMessage != '')
            const SizedBox(
              height: spacer1,
            ),
          if (widget.errorMessage != null || fileErrorMessage != '')
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
                  child: fileErrorMessage != ''
                      ? Text(
                          fileErrorMessage.length > 256
                              ? '${fileErrorMessage.substring(0, 256)}...'
                              : fileErrorMessage,
                          style: currentTypography.bodyS.copyWith(
                            color: const DigitColors().light.alertError,
                          ),
                        )
                      : Text(
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
          widget.showPreview
              ? Wrap(
                  spacing: spacer2,
                  children: List.generate(fileNames.length, (index) {
                    return _buildFilePreview(index, minWidth);
                  }),
                )
              : Wrap(
                  spacing: spacer2,
                  children: List.generate(fileNames.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: spacer2),
                      child: fileErrors.containsKey(files[index])
                          ? SelectionChip(
                              errorMessage: fileErrors[files[index]],
                              label: fileNames[index],
                              onItemDelete: () {
                                setState(() {
                                  fileNames.removeAt(index);
                                  fileBytesList.removeAt(index);
                                });
                              },
                            )
                          : SelectionChip(
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

String? _validateFile(PlatformFile file, List<FileValidator> validators) {
  // Perform validation for the given file using the provided validators
  for (var validator in validators) {
    switch (validator.type) {
      case FileValidatorType.fileType:
        if (!_isFileTypeAllowed(file, validator.value)) {
          return validator.errorMessage ?? 'Invalid file type';
        }
        break;
      case FileValidatorType.minSize:
        if (!_isFileSizeAboveMin(file, validator.value)) {
          return validator.errorMessage ?? 'File size is too small';
        }
        break;
      case FileValidatorType.maxSize:
        if (!_isFileSizeBelowMax(file, validator.value)) {
          return validator.errorMessage ?? 'File size exceeds maximum limit';
        }
        break;
    }
  }

  // If the file passes all validations, return null
  return null;
}

bool _isFileTypeAllowed(PlatformFile file, List<String> allowedExtensions) {
  // Get the file extension
  String fileExtension = file.name!.split('.').last.toLowerCase();

  // Check if the file extension is in the list of allowed file types
  return allowedExtensions.contains(fileExtension);
}

bool _isFileSizeAboveMin(PlatformFile file, int minFileSizeInBytes) {
  // Get the file size in bytes
  int fileSizeInBytes = file.size ?? 0;

  // Check if the file size is above the minimum threshold
  return fileSizeInBytes >= minFileSizeInBytes;
}

bool _isFileSizeBelowMax(PlatformFile file, int maxFileSizeInBytes) {
  // Get the file size in bytes
  int fileSizeInBytes = file.size ?? 0;

  // Check if the file size is below the maximum threshold
  return fileSizeInBytes <= maxFileSizeInBytes;
}
