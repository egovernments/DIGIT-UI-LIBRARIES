import 'dart:typed_data';
import 'dart:html' as html;

import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';

class WebFileDownloader {
  Future<void> downloadFile(DroppedFile file) async {
    html.AnchorElement(
        href: html.Url.createObjectUrlFromBlob(html.Blob([file.data])))
      ..setAttribute("download", file.name)
      ..click();
  }
}
