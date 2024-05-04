import 'package:digit_ui_components/widgets/atoms/file_uploader.dart';
import 'package:digit_ui_components/widgets/atoms/file_uploader2.dart';
import 'package:digit_ui_components/widgets/atoms/image_uploader.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'dart:io';

List<Story> fileUploaderStories() {
  return [
    Story(
      name: 'File Upload/Pop UP/Single Upload',
      builder: (context) => Center(
        child: FileUploadWidget(
          label: 'Upload', onFilesSelected: (List<File> files) {  },
          showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        ),
      ),
    ),
    Story(
      name: 'File Upload/Pop UP/Multiple Upload',
      builder: (context) => Center(
        child: FileUploadWidget(
          allowMultipleImages: true,
          label: 'Upload', onFilesSelected: (List<File> files) {  },
          showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        ),
      ),
    ),
    Story(
      name: 'File Upload/Drag/Single file',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultipleImages: false,
        label: 'Upload', onFilesSelected: (DroppedFile) {  },
      ),
    ),
    Story(
      name: 'File Upload/Drag/Multiple files',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultipleImages: true,
        label: 'Upload', onFilesSelected: (DroppedFile) {  },
      ),
    ),
    Story(
      name: 'File Upload/Image/Single Upload',
      builder: (context) => Center(
        child: ImageUploader(
          onImagesSelected: (List<File> imageFile) {
            // Handle the selected image file here
            // print('Image selected: ${imageFile.path}');
          },
        )

      ),
    ),
    Story(
      name: 'File Upload/Image/Multiple Upload',
      builder: (context) => Center(
        child: ImageUploader(
          onImagesSelected: (List<File> imageFile) {
            // Handle the selected image file here
            // print('Image selected: ${imageFile.path}');
          },
          allowMultipleImages: true,
        )

      ),
    ),
  ];
}








