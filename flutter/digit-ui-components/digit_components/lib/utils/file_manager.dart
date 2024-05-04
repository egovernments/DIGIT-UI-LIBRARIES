// import 'dart:io' as io;
// // Implementation for web platforms using dart:html
// import 'dart:html' as html;
// import 'dart:typed_data';
// import 'file_manager.dart' if (dart.library.html) 'web_file_manager.dart' if (dart.library.io) 'desktop_file_manager.dart';
//
// // Define a common interface
// abstract class FileManager {
//   Future<void> saveFile(Uint8List data, String filename);
// }
//
// // Implementation for non-web platforms using dart:io
//
// class DesktopFileManager implements FileManager {
//   @override
//   Future<void> saveFile(Uint8List data, String filename) async {
//     var file = io.File(filename);
//     await file.writeAsBytes(data);
//   }
// }
//
//
// class WebFileManager implements FileManager {
//   @override
//   Future<void> saveFile(Uint8List data, String filename) async {
//     var blob = html.Blob([data]);
//     var url = html.Url.createObjectUrlFromBlob(blob);
//     var anchor = html.AnchorElement(href: url)
//       ..setAttribute('download', filename)
//       ..click();
//     html.Url.revokeObjectUrl(url);
//   }
// }
//
// // Usage example with conditional imports
//
//
// final fileManager = FileManager();
//
// void saveData(Uint8List data, String name) {
//   fileManager.saveFile(data, name);
// }
