import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraHandler extends StatefulWidget {
  final ImageSource source;
  final Function(File) onImageCaptured;

  const CameraHandler({
    Key? key,
    required this.source,
    required this.onImageCaptured,
  }) : super(key: key);

  @override
  _CameraHandlerState createState() => _CameraHandlerState();
}

class _CameraHandlerState extends State<CameraHandler> {
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

  Future<void> _handleImageCapture() async {
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
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_cameraController!);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
