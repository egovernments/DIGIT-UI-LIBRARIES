import 'dart:io';
import 'package:camera/camera.dart';
import 'file_validator.dart';

String? validateImage(
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