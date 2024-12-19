import 'package:file_picker/file_picker.dart';

enum FileValidatorType {
  fileType,
  minSize,
  maxSize,
}

class FileValidator {
  final FileValidatorType type;
  final dynamic value;
  final String? errorMessage;

  FileValidator(this.type, this.value, {this.errorMessage});
}


String? validateFile(PlatformFile file, List<FileValidator> validators) {
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

  /// If the file passes all validations, return null
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