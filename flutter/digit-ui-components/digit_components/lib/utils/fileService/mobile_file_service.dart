import 'dart:typed_data';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class MobileFileWriter {
  Future<String> writeToTemporaryFile(Uint8List dataBytes, String fileName) async {
    final directory = await getTemporaryDirectory();
    final file = io.File('${directory.path}/$fileName');
    await file.writeAsBytes(dataBytes);
    return file.path;
  }
}
