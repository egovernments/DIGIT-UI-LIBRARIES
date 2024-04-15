import 'package:digit_ui_components/widgets/atoms/file_uploader.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'dart:io';

List<Story> fileUploaderStories() {
  return [
    Story(
      name: 'File Upload/Single Upload',
      builder: (context) => FileUploadWidget(
        label: 'Upload', onFilesSelected: (List<File> files) {  },
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
      ),
    ),
    Story(
      name: 'File Upload/Multiple Upload',
      builder: (context) => FileUploadWidget(
        allowMultipleImages: true,
        label: 'Upload', onFilesSelected: (List<File> files) {  },
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
      ),
    ),
  ];
}


