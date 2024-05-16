import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'mobile_file_service.dart';
import 'web_file_service.dart';

class FileService {
  final dynamic _fileWriter;

  FileService() : _fileWriter = kIsWeb ? WebFileWriter() : MobileFileWriter();

  Future<String> writeToTemporaryFile(Uint8List dataBytes, String fileName) {
    return _fileWriter.writeToTemporaryFile(dataBytes, fileName);
  }
}
