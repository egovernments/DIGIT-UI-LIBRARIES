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

class ImageUploader extends StatefulWidget {
  final Function(List<File>) onImagesSelected;
  final bool allowMultipleImages;

  const ImageUploader(
      {super.key,
      required this.onImagesSelected,
      this.allowMultipleImages = false});

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
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              surfaceTintColor: const DigitColors().light.paperPrimary,
              contentPadding: EdgeInsets.zero,
              content: SizedBox(
                width: isMobile ? 328 : isTab ? 440: 720,
                height: isMobile? 624 : isTab ? 508 : 448,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Camera',
                        style: currentTypography.headingM.copyWith(
                            color: const DigitColors().light.textPrimary),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: isMobile? 280 :isTab ? 392 :672,
                        height: isMobile? 416 : isTab ? 346 : 285,
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
                      const SizedBox(
                        height: 24,
                      ),
                      isMobile ?
                      Column(
                        // textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                            label: 'Cancel',
                            size: ButtonSize.large,
                            type: ButtonType.secondary,
                            onPressed: () {
                              Navigator.of(context).pop();
                              _closeCamera();
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Button(
                            label: 'Capture Image',
                            size: ButtonSize.large,
                            type: ButtonType.primary,
                            onPressed: () {
                              Navigator.of(context).pop();
                              _handleImageCapture();
                            },
                          ),
                        ],
                      )
                          :Row(
                        // textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Button(
                            label: 'Cancel',
                            size: ButtonSize.large,
                            type: ButtonType.secondary,
                            onPressed: () {
                              Navigator.of(context).pop();
                              _closeCamera();
                            },
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Button(
                            label: 'Capture Image',
                            size: ButtonSize.large,
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
              ),
            );
          },
        );
      });
    } else {
      ImagePicker().pickImage(source: source).then((pickedFile) {
        if (pickedFile != null) {
          setState(() {
            // For single image, replace the existing image file
            // For multiple images, add the new image file to the list
            widget.allowMultipleImages
                ? _imageFiles.add(File(pickedFile.path))
                : _imageFiles.add(File(pickedFile.path));
          });
          widget.onImagesSelected(_imageFiles);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  Future<void> _handleImageCapture() async {
    try {
      final XFile picture = await _cameraController!.takePicture();
      setState(() {
        // For single image, replace the existing image file
        // For multiple images, add the new image file to the list
        widget.allowMultipleImages
            ? _imageFiles.add(File(picture.path))
            : _imageFiles.add(File(picture.path));
      });
      widget.onImagesSelected(_imageFiles);
    } catch (e) {
      print('Error taking picture: $e');
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
    double minWidth = AppView.isMobileView(MediaQuery.of(context).size)
        ? 328
        : AppView.isTabletView(MediaQuery.of(context).size)
            ? 440
            : 600;

    return GestureDetector(
      onTap: () {
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
                                padding: const EdgeInsets.all(24.0),
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
                                  top: isTab ? 8 : 12.0,
                                  right: isTab ? 8 : 12.0,
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
                                      size: 32,
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
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
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
      child: _buildImageDisplay(minWidth),
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
        padding: const EdgeInsets.only(top: 32),
        child: InkWell(
          hoverColor: const DigitColors().transparent,
          highlightColor: const DigitColors().transparent,
          splashColor: const DigitColors().transparent,
          onTap: onTap,
          child: Column(
            children: [
              Icon(icon, size: 40, color: const DigitColors().light.primary1),
              const SizedBox(height: 8),
              Text(label,
                  style: typography.bodyL
                      .copyWith(color: const DigitColors().light.primary1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageDisplay(double minWidth) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!(widget.allowMultipleImages == false && _imageFiles.isNotEmpty))
            Container(
              constraints: BoxConstraints(
                minWidth: minWidth,
              ),
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const DigitColors().light.genericInputBorder,
                  width: 1,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_enhance,
                        size: 40, color: const DigitColors().light.primary1),
                    Text('Click to add photo',
                        style: TextStyle(
                            color: const DigitColors().light.primary1)),
                  ],
                ),
              ),
            ),
          if (!(widget.allowMultipleImages == false && _imageFiles.isNotEmpty))
            const SizedBox(
              height: 8,
            ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(_imageFiles.length, (index) {
                return _buildImageItem(index, minWidth);
              }),
            ),
          ),
        ]);
  }

  Widget _buildImageItem(int index, double minWidth) {
    if (_imageFiles.isNotEmpty && _imageFiles[index].path.isNotEmpty) {
      _closeCamera();
    }
    return _imageFiles.isNotEmpty
        ? Stack(
            children: [
              Container(
                color: const DigitColors().light.genericDivider,
                width: widget.allowMultipleImages ? 100 : minWidth,
                height: widget.allowMultipleImages ? 100 : 500,
                constraints: BoxConstraints(
                  minWidth: widget.allowMultipleImages ? 100 : minWidth,
                ),
                child: ClipRRect(
                  borderRadius: Common.radius,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      kIsWeb
                          ? Image.network(
                              _imageFiles[index].path,
                              width:
                                  widget.allowMultipleImages ? 100 : minWidth,
                              height: widget.allowMultipleImages ? 100 : 500,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _imageFiles[index],
                              width:
                                  widget.allowMultipleImages ? 100 : minWidth,
                              height: widget.allowMultipleImages ? 100 : 500,
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
          )
        : const SizedBox.shrink();
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles.removeAt(index);
    });
  }
}
