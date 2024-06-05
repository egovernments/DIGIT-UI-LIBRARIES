import 'dart:typed_data';
import 'dart:html' as html;

class WebFileWriter {
  Future<String> writeToTemporaryFile(Uint8List dataBytes, String fileName) async {
    final Map<String, String> mimeTypes = {
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx': 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls': 'application/vnd.ms-excel',
      'xlsx': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
    };

    final extension = fileName.split('.').last.toLowerCase();
    final mimeType = mimeTypes[extension];

    if (mimeType != null) {
      final blob = html.Blob([dataBytes], mimeType);
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.window.open(url, '_blank');
      return url;
    } else {
      print('Unsupported file type: $extension');
      return '';
    }
  }
}
