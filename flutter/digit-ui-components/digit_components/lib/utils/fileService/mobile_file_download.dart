import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import '../../widgets/atoms/upload_drag.dart';

class MobileFileDownloader {
  Future<void> downloadFile(DroppedFile file) async {
    final directory = await getTemporaryDirectory();
    final path = directory.path + io.Platform.pathSeparator + file.name;
    final localFile = io.File(path);
    await localFile.writeAsBytes(file.data);
  }
}
