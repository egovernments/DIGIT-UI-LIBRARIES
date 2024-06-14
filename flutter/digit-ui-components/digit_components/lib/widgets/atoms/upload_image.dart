import 'dart:io';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/utils/utils.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/validators/file_validator.dart';
import '../../utils/validators/image_validator.dart';
import '../helper_widget/camera_handler.dart';

class ImageUploader extends StatefulWidget {
  final Function(List<File>) onImagesSelected;
  final bool allowMultiples;
  final String? errorMessage;
  final List<FileValidator>? validators;

  const ImageUploader(
      {super.key,
      required this.onImagesSelected,
      this.allowMultiples = false,
      this.errorMessage,
      this.validators});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  late final List<File> _imageFiles = [];
  late DigitTypography currentTypography;
  late bool isMobile;
  late bool isTab;
  String? capitalizedErrorMessage;
  String fileError = '';

  void _getImage(ImageSource source) {
    if (kIsWeb && source == ImageSource.camera) {
      showDialog(
        context: context,
        useSafeArea: false,
        builder: (BuildContext context) {
          CameraHandlerState? cameraHandlerState;
          return Popup(
            onCrossTap: () {
              Navigator.of(context).pop();
            },
            title: 'Camera',
            type: PopUpType.simple,
            width: isTab ? 440 : 720,
            // height: isTab ? 508 : 448,
            actions: [
              Button(
                mainAxisSize: MainAxisSize.max,
                prefixIcon: Icons.camera_enhance,
                label: 'Capture',
                size: ButtonSize.large,
                type: ButtonType.primary,
                onPressed: () {
                  Navigator.of(context).pop();
                  cameraHandlerState?.captureImage();

                  /// Trigger the capture
                },
              ),
              Button(
                mainAxisSize: MainAxisSize.max,
                label: 'Cancel',
                size: ButtonSize.large,
                type: ButtonType.secondary,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            additionalWidgets: [
              CameraHandler(
                source: source,
                onImageCaptured: (image) {
                  _handleImageCapture(image);
                },
                onCameraHandlerCreated: (CameraHandlerState state) {
                  cameraHandlerState = state; // Capture the state instance
                },
              ),
            ],
          );
        },
      );
    } else {
      ImagePicker().pickImage(source: source).then((pickedFile) {
        if (pickedFile != null) {
          if (widget.validators != null) {
            String? validationError =
                validateImage(pickedFile, widget.validators!, pickedFile.name);
            if (validationError != null) {
              setState(() {
                fileError = validationError;
              });
              return;
            }
          }
          setState(() {
            fileError = ''; // Clear the error message
            widget.allowMultiples
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

  Future<void> _handleImageCapture(File image) async {
    setState(() {
      widget.allowMultiples ? _imageFiles.add(image) : _imageFiles.add(image);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// typography based on screen
    currentTypography = getTypography(context, false);
    isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    isTab = AppView.isTabletView(MediaQuery.of(context).size);
    capitalizedErrorMessage = convertInToSentenceCase(widget.errorMessage);

    return GestureDetector(
      onTap: () {
        setState(() {
          fileError = '';
        });
        !isMobile
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Popup(
                    title: 'Choose an option to upload',
                    onCrossTap: () {
                      Navigator.of(context).pop();
                    },
                    // height: isTab ? 228 : 240,
                     width: isTab ? 440 : 600,
                    additionalWidgets: [
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
      //_closeCamera();
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!(widget.allowMultiples == false && _imageFiles.isNotEmpty))
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
          if (!(widget.allowMultiples == false && _imageFiles.isNotEmpty))
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
      // _closeCamera();
    }
    return _imageFiles.isNotEmpty
        ? Stack(
            children: [
              widget.allowMultiples
                  ? Container(
                      color: const DigitColors().light.genericDivider,
                      width: Base.imageSize,
                      height: Base.imageSize,
                      constraints: const BoxConstraints(
                        minWidth: Base.imageSize,
                      ),
                      child: ClipRRect(
                        borderRadius: Base.radius,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            kIsWeb
                                ? Image.network(
                                    _imageFiles[index].path,
                                    width: Base.imageSize,
                                    height: Base.imageSize,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    _imageFiles[index],
                                    width: Base.imageSize,
                                    height: Base.imageSize,
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
                        borderRadius: Base.radius,
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
}
