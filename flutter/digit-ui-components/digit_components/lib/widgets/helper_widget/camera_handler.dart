import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../constants/AppView.dart';

typedef CameraHandlerCreatedCallback = void Function(CameraHandlerState);

class CameraHandler extends StatefulWidget {
  final ImageSource source;
  final Function(File) onImageCaptured;
  final CameraHandlerCreatedCallback? onCameraHandlerCreated;

  const CameraHandler({
    Key? key,
    required this.source,
    required this.onImageCaptured,
    this.onCameraHandlerCreated,
  }) : super(key: key);

  @override
  CameraHandlerState createState() => CameraHandlerState();
}

class CameraHandlerState extends State<CameraHandler> {
  CameraController? _cameraController;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    if (widget.source == ImageSource.camera) {
      _initializeCamera();
    } else {
      _pickImageFromGallery();
    }
    // Notify parent about the created state
    if (widget.onCameraHandlerCreated != null) {
      widget.onCameraHandlerCreated!(this);
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    _initializeControllerFuture = _cameraController!.initialize();
    setState(() {});
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: widget.source);
    if (pickedFile != null) {
      widget.onImageCaptured(File(pickedFile.path));
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  Future<void> captureImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      if (kDebugMode) {
        print('Error: Camera is not initialized');
      }
      return;
    }
    try {
      final XFile picture = await _cameraController!.takePicture();
      widget.onImageCaptured(File(picture.path));
    } catch (e) {
      if (kDebugMode) {
        print('Error taking picture: $e');
      }
    }
  }

  Future<void> _disposeCamera() async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
      _cameraController = null;
    }
  }

  @override
  void dispose() {
    _disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppView.isMobileView(MediaQuery.of(context).size);
    bool isTab = AppView.isTabletView(MediaQuery.of(context).size);

    return SizedBox(
      width: isTab ? 392 : 672,
      height: isTab ? 350 : 285,
      child: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}