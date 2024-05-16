import 'dart:typed_data';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'mobile_file_download.dart';
import 'web_file_download.dart';

class FileDownloaderService {
  final dynamic _fileDownloader;

  FileDownloaderService() : _fileDownloader = kIsWeb ? WebFileDownloader() : MobileFileDownloader();

  Future<void> downloadFile(DroppedFile file) {
    return _fileDownloader.downloadFile(file);
  }
}
