import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

import '../../constants/AppView.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';

class CustomImageUploader extends StatefulWidget {
  final Function(File) onImageSelected;

  CustomImageUploader({required this.onImageSelected});

  @override
  _CustomImageUploaderState createState() => _CustomImageUploaderState();
}

class _CustomImageUploaderState extends State<CustomImageUploader> {
  late File _imageFile = File(''); // Default empty file
  late CameraController? _cameraController;
  late Future<void>? _initializeControllerFuture;

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
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 300,
            maxHeight: 500,
          ),
          backgroundColor: const DigitColors().light.paperPrimary,
          builder: (BuildContext context) {
            return FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: CameraPreview(_cameraController!),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            final XFile picture = await _cameraController!.takePicture();
                            setState(() {
                              _imageFile = File(picture.path);
                            });
                            widget.onImageSelected(_imageFile);
                          } catch (e) {
                            print('Error taking picture: $e');
                          } finally {
                            await _cameraController!.stopImageStream();
                            Navigator.of(context).pop(); // Close the bottom sheet
                          }
                        },
                        child: Text('Capture Image'),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        );
      });
    } else {
      ImagePicker().pickImage(source: source).then((pickedFile) {
        if (pickedFile != null) {
          setState(() {
            _imageFile = File(pickedFile.path);
          });
          widget.onImageSelected(_imageFile);
        } else {
          print('No image selected.');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // typography based on screen
    DigitTypography currentTypography = getTypography(context, false);

    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);

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
              title: const Text("Select Image Source"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera_enhance),
                    title: Text("Camera"),
                    onTap: () {
                      Navigator.of(context).pop();
                      _getImage(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.perm_media),
                    title: Text("My Files"),
                    onTap: () {
                      Navigator.of(context).pop();
                      _getImage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            );
          },
        )
            : showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 120,
            maxHeight: 120,
          ),
          backgroundColor: const DigitColors().light.paperPrimary,
          builder: (BuildContext context) {
            return _buildBottomSheetContent(currentTypography);
          },
        );
      },
      child: _buildImageDisplay(minWidth),
    );
  }

  Widget _buildBottomSheetContent(DigitTypography currentTypography) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildInkWell(Icons.camera_enhance, "Camera", () => _getImage(ImageSource.camera), currentTypography),
          _buildInkWell(Icons.perm_media, "My Files", () => _getImage(ImageSource.gallery), currentTypography),
        ],
      ),
    );
  }

  Widget _buildInkWell(IconData icon, String label, VoidCallback onTap, DigitTypography typography) {
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
              Text(label, style: typography.bodyL.copyWith(color: const DigitColors().light.primary1)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageDisplay(double minWidth) {
    return _imageFile.path.isEmpty
        ? Container(
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
            Icon(Icons.camera_enhance, size: 40, color: const DigitColors().light.primary1),
            Text('Click to add photo', style: TextStyle(color: const DigitColors().light.primary1)),
          ],
        ),
      ),
    )
        : kIsWeb
        ? Image.network(
      _imageFile.path,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    )
        : Image.file(
      _imageFile,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }
}
