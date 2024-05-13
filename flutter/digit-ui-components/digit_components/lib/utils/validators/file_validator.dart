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