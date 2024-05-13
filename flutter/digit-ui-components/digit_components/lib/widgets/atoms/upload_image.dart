import 'dart:io';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

import '../../constants/AppView.dart';
import '../../constants/app_constants.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';
import '../../utils/utils.dart';
import '../../utils/validators/file_validator.dart';
import '../helper_widget/button_list.dart';

class ImageUploader extends StatefulWidget {
  final Function(List<File>) onImagesSelected;
  final bool allowMultipleImages;
  final String? errorMessage;
  final List<FileValidator>? validators;

  const ImageUploader(
      {super.key,
      required this.onImagesSelected,
      this.allowMultipleImages = false,
      this.errorMessage,
      this.validators});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  late List<File> _imageFiles = []; // List to hold multiple images
  late CameraController? _cameraController;
  late Future<void>? _initializeControllerFuture;
  late DigitTypography currentTypography;
  late bool isMobile;
  late bool isTab;
  String? capitalizedErrorMessage;
  String fileError = '';

  Future<void> _initializeWebCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _initializeControllerFuture = _cameraController!.initialize();
  }

  void _getImage(ImageSource source) {
    if (kIsWeb && source == ImageSource.camera) {
      _initializeWebCamera().then((_) {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (BuildContext context) {
            return isMobile
                ? Dialog.fullscreen(
                    backgroundColor:
                        const DigitColors().overLayColor.withOpacity(.70),
                    child: Container(
                      margin: const EdgeInsets.all(spacer4),
                      color: const DigitColors().light.paperPrimary,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(spacer6),
                                child: Text(
                                  'Camera',
                                  style: currentTypography.headingM.copyWith(
                                      color: const DigitColors()
                                          .light
                                          .textPrimary),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: spacer2,
                                  right: spacer2,
                                ),
                                child: InkWell(
                                    hoverColor: const DigitColors().transparent,
                                    highlightColor:
                                        const DigitColors().transparent,
                                    splashColor:
                                        const DigitColors().transparent,
                                    onTap: () {
                                      _closeCamera();
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: spacer8,
                                      color: const DigitColors().light.primary2,
                                    )),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: spacer6),
                              child: FutureBuilder<void>(
                                future: _initializeControllerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return CameraPreview(_cameraController!);
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(spacer6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Button(
                                  mainAxisSize: MainAxisSize.max,
                                  prefixIcon: Icons.camera_enhance,
                                  label: 'Capture',
                                  size: ButtonSize.large,
                                  type: ButtonType.primary,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _handleImageCapture();
                                  },
                                ),
                                const SizedBox(
                                  height: spacer4,
                                ),
                                Button(
                                  mainAxisSize: MainAxisSize.max,
                                  label: 'Cancel',
                                  size: ButtonSize.large,
                                  type: ButtonType.secondary,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _closeCamera();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(spacer1),
                    ),
                    surfaceTintColor: const DigitColors().light.paperPrimary,
                    contentPadding: EdgeInsets.zero,
                    content: SizedBox(
                      width: isTab ? 440 : 720,
                      height: isTab ? 508 : 448,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(spacer6),
                                child: Text(
                                  'Camera',
                                  style: currentTypography.headingM.copyWith(
                                      color: const DigitColors()
                                          .light
                                          .textPrimary),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: isTab ? spacer2 : spacer3,
                                  right: isTab ? spacer2 : spacer3,
                                ),
                                child: InkWell(
                                    hoverColor: const DigitColors().transparent,
                                    highlightColor:
                                        const DigitColors().transparent,
                                    splashColor:
                                        const DigitColors().transparent,
                                    onTap: () {
                                      _closeCamera();
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: spacer8,
                                      color: const DigitColors().light.primary2,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: isTab ? 392 : 672,
                            height: isTab ? 346 : 285,
                            // padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: FutureBuilder<void>(
                              future: _initializeControllerFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return CameraPreview(_cameraController!);
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(spacer6),
                            child: Row(
                              // textDirection: TextDirection.rtl,
                              mainAxisAlignment: isTab
                                  ? MainAxisAlignment.start
                                  : MainAxisAlignment.end,
                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                ButtonListTile(
                                  spacing: spacer6,
                                  buttons: [
                                    Button(
                                      label: 'Cancel',
                                      mainAxisSize: MainAxisSize.max,
                                      size: ButtonSize.large,
                                      type: ButtonType.secondary,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _closeCamera();
                                      },
                                    ),
                                    Button(
                                      label: 'Capture',
                                      size: ButtonSize.large,
                                      mainAxisSize: MainAxisSize.max,
                                      prefixIcon: Icons.camera_enhance,
                                      type: ButtonType.primary,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        _handleImageCapture();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        );
      });
    } else {
      ImagePicker().pickImage(source: source).then((pickedFile) {
        if (pickedFile != null) {
          if (widget.validators != null) {
            String? validationError =
                _validateFile(pickedFile, widget.validators!, pickedFile.name);
            if (validationError != null) {
              setState(() {
                fileError = validationError;
              });
              return;
            }
          }
          setState(() {
            fileError = ''; // Clear the error message
            widget.allowMultipleImages
                ? _imageFiles.add(File(pickedFile.path))
                : _imageFiles.add(File(pickedFile.path));
          });
          widget.onImagesSelected(_imageFiles);
        } else {
          if (kDebugMode) {
            print('No image selected.');
          }
        }
      });
    }
  }

  Future<void> _handleImageCapture() async {
    try {
      final XFile picture = await _cameraController!.takePicture();
      if (widget.validators != null) {
        String? validationError =
            _validateFile(picture, widget.validators!, picture.name);
        if (validationError != null) {
          setState(() {
            fileError = validationError;
          });
          return;
        }
      }
      setState(() {
        fileError = ''; // Clear the error message
        widget.allowMultipleImages
            ? _imageFiles.add(File(picture.path))
            : _imageFiles.add(File(picture.path));
      });
      widget.onImagesSelected(_imageFiles);
    } catch (e) {
      if (kDebugMode) {
        print('Error taking picture: $e');
      }
    }
  }

  Future<void> _closeCamera() async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
      _cameraController = null;
    }
  }

  @override
  void dispose() {
    _closeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    currentTypography = getTypography(context, false);
    isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    isTab = AppView.isTabletView(MediaQuery.of(context).size);
    capitalizedErrorMessage = capitalizeFirstLetter(widget.errorMessage);

    return GestureDetector(
      onTap: () {
        setState(() {
          fileError = '';
        });
        !isMobile
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    contentPadding: EdgeInsets.zero,
                    surfaceTintColor: const DigitColors().light.paperPrimary,
                    content: SizedBox(
                      height: isTab ? 228 : 240,
                      width: isTab ? 440 : 600,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(spacer6),
                                child: Text(
                                  'Choose an option to upload',
                                  style: currentTypography.headingM.copyWith(
                                      color: const DigitColors()
                                          .light
                                          .textPrimary),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: isTab ? spacer2 : spacer3,
                                  right: isTab ? spacer2 : spacer3,
                                ),
                                child: InkWell(
                                    hoverColor: const DigitColors().transparent,
                                    highlightColor:
                                        const DigitColors().transparent,
                                    splashColor:
                                        const DigitColors().transparent,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: spacer8,
                                      color: const DigitColors().light.primary2,
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _buildInkWell(Icons.camera_enhance, "Camera", () {
                                Navigator.of(context).pop();
                                _getImage(ImageSource.camera);
                              }, currentTypography),
                              _buildInkWell(Icons.perm_media, "My Files", () {
                                Navigator.of(context).pop();
                                _getImage(ImageSource.gallery);
                              }, currentTypography),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(spacer2),
                      topRight: Radius.circular(spacer2)),
                ),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: 120,
                  maxHeight: 120,
                ),
                backgroundColor: const DigitColors().light.paperPrimary,
                builder: (BuildContext context) {
                  return _buildBottomSheetContent();
                },
              );
      },
      child: _buildImageDisplay(),
    );
  }

  Widget _buildBottomSheetContent() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildInkWell(Icons.camera_enhance, "Camera", () {
            Navigator.of(context).pop();
            _getImage(ImageSource.camera);
          }, currentTypography),
          _buildInkWell(Icons.perm_media, "My Files", () {
            Navigator.of(context).pop();
            _getImage(ImageSource.gallery);
          }, currentTypography),
        ],
      ),
    );
  }

  Widget _buildInkWell(IconData icon, String label, VoidCallback onTap,
      DigitTypography typography) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: spacer8),
        child: InkWell(
          hoverColor: const DigitColors().transparent,
          highlightColor: const DigitColors().transparent,
          splashColor: const DigitColors().transparent,
          onTap: onTap,
          child: Column(
            children: [
              Icon(icon,
                  size: spacer10, color: const DigitColors().light.primary1),
              const SizedBox(height: spacer2),
              Text(label,
                  style: typography.bodyL
                      .copyWith(color: const DigitColors().light.primary1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageDisplay() {
    if (fileError != '') {
      _closeCamera();
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!(widget.allowMultipleImages == false && _imageFiles.isNotEmpty))
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.errorMessage != null || fileError != ''
                      ? const DigitColors().light.alertError
                      : const DigitColors().light.genericInputBorder,
                  width: 1,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_enhance,
                        size: spacer10,
                        color: const DigitColors().light.primary1),
                    Text('Click to add photo',
                        style: TextStyle(
                            color: const DigitColors().light.primary1)),
                  ],
                ),
              ),
            ),
          if (widget.errorMessage != null || fileError != '')
            const SizedBox(
              height: spacer1,
            ),
          if (widget.errorMessage != null || fileError != '')
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 2,
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
                  child: fileError != ''
                      ? Text(
                          fileError.length > 256
                              ? '${fileError.substring(0, 256)}...'
                              : fileError,
                          style: currentTypography.bodyS.copyWith(
                            color: const DigitColors().light.alertError,
                          ),
                        )
                      : Text(
                          capitalizedErrorMessage!.length > 256
                              ? '${capitalizedErrorMessage?.substring(0, 256)}...'
                              : capitalizedErrorMessage!,
                          style: currentTypography.bodyS.copyWith(
                            color: const DigitColors().light.alertError,
                          ),
                        ),
                ),
              ],
            ),
          if (!(widget.allowMultipleImages == false && _imageFiles.isNotEmpty))
            const SizedBox(
              height: spacer2,
            ),
          Wrap(
            spacing: spacer2,
            runSpacing: spacer2,
            children: List.generate(_imageFiles.length, (index) {
              return _buildImageItem(index);
            }),
          ),
        ]);
  }

  Widget _buildImageItem(int index) {
    if ((_imageFiles.isNotEmpty && _imageFiles[index].path.isNotEmpty) ||
        fileError != '') {
      _closeCamera();
    }
    return _imageFiles.isNotEmpty
        ? Stack(
            children: [
              widget.allowMultipleImages
                  ? Container(
                      color: const DigitColors().light.genericDivider,
                      width: 100,
                      height: 100,
                      constraints: const BoxConstraints(
                        minWidth: 100,
                      ),
                      child: ClipRRect(
                        borderRadius: Common.radius,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            kIsWeb
                                ? Image.network(
                                    _imageFiles[index].path,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    _imageFiles[index],
                                    width: 100,
                                    height: 100,
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
                                  _removeImage(index);
                                },
                                child: Container(
                                  width: spacer6,
                                  height: spacer6,
                                  decoration: BoxDecoration(
                                    color: const DigitColors().light.primary2,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: spacer4,
                                    color:
                                        const DigitColors().light.paperPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: 3 / 2,
                      child: ClipRRect(
                        borderRadius: Common.radius,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            kIsWeb
                                ? Image.network(
                                    _imageFiles[index].path,
                                    fit: BoxFit.fitHeight,
                                  )
                                : Image.file(
                                    _imageFiles[index],
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
                                  _removeImage(index);
                                },
                                child: Container(
                                  width: spacer6,
                                  height: spacer6,
                                  decoration: BoxDecoration(
                                    color: const DigitColors().light.primary2,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    size: spacer4,
                                    color:
                                        const DigitColors().light.paperPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          )
        : const SizedBox.shrink();
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }

  // Validate the file against all validators
  String? _validateFile(
      XFile xFile, List<FileValidator> validators, String? name) {
    final file = File(xFile.path);
    for (var validator in validators) {
      switch (validator.type) {
        case FileValidatorType.fileType:
          final List<String> allowedTypes = validator.value;
          print(name);
          final fileType = name?.split('.').last.toLowerCase();

          if (!allowedTypes.contains(fileType)) {
            print(fileType);
            return validator.errorMessage;
          }
          break;
        case FileValidatorType.minSize:
          final int minSize = validator.value;
          final fileSize = file.lengthSync();
          if (fileSize < minSize) {
            return validator.errorMessage;
          }
          break;
        case FileValidatorType.maxSize:
          final int maxSize = validator.value;
          final fileSize = file.lengthSync();
          if (fileSize > maxSize) {
            return validator.errorMessage;
          }
          break;
      }
    }
    return null; // Validation passed
  }
}
