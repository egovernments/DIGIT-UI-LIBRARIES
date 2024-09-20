import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';

class WebFileDownloader {
  Future<void> downloadFile(DroppedFile file) async {
    try {
      html.AnchorElement(
          href: html.Url.createObjectUrlFromBlob(html.Blob([file.data])))
        ..setAttribute("download", file.name)
        ..click();
    } catch (e) {
      // Handle the error, e.g., show an error message to the user
      if (kDebugMode) {
        print('Error downloading file: $e');
      }
    }
  }
}
