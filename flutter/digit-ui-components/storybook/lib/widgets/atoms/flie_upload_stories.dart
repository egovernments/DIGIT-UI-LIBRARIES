import 'package:digit_ui_components/utils/validators/file_validator.dart';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:digit_ui_components/widgets/atoms/upload_image.dart';
import 'package:digit_ui_components/widgets/atoms/upload_popUp.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import '../../iframe/iframe_widget.dart';

List<Story> fileUploaderStories() {
  return [
    Story(
      name: 'Atom/File Upload/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/File Upload/Uploader Field/Single Upload',
      builder: (context) => Center(
        child: FileUploadWidget(
          label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
          Map<PlatformFile, String?> fileErrors = {};

          return fileErrors;
        },
          openFile: context.knobs.boolean(label: 'Open File', initial: false),
          showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        ),
      ),
    ),

    Story(
      name: 'Atom/File Upload/Uploader Field/Multiple Upload',
      builder: (context) => Center(
        child: FileUploadWidget(
          allowMultiples: true,
          label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
          Map<PlatformFile, String?> fileErrors = {};

          return fileErrors;
        },
          openFile: context.knobs.boolean(label: 'Open File', initial: false),
          showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        ),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Uploader Field/Error',
      builder: (context) => FileUploadWidget(
        allowMultiples: true,
        label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
        Map<PlatformFile, String?> fileErrors = {};

        return fileErrors;
      },
        openFile: context.knobs.boolean(label: 'Open File', initial: false),
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        errorMessage: context.knobs.text(label: 'Error Message', initial: 'error'),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Uploader Widget/Single Upload',
      builder: (context) => FileUploadWidget2(
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        allowMultiples: false,
        label: 'Upload', onFilesSelected: (files) {
          return {};
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Uploader Widget/Multiple Upload',
      builder: (context) => FileUploadWidget2(
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        allowMultiples: true,
        label: 'Upload', onFilesSelected: (files) {
          return {};
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Uploader Widget/Error',
      builder: (context) => FileUploadWidget2(
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        allowMultiples: context.knobs.boolean(label: 'Allow Multiples', initial: false),
        errorMessage: context.knobs.text(label: 'Error Message', initial: "error"),
        label: 'Upload', onFilesSelected: (files) {
          return {};
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Image Uploader/Single Upload',
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
      name: 'Atom/File Upload/Image Uploader/Multiple Upload',
      builder: (context) => Center(
          child: ImageUploader(
            onImagesSelected: (List<File> imageFile) {
              // Handle the selected image file here
              // print('Image selected: ${imageFile.path}');
            },
            allowMultiples: true,
          )

      ),
    ),
    Story(
      name: 'Atom/File Upload/Image Uploader/Error',
      builder: (context) => Center(
          child: ImageUploader(
            errorMessage: context.knobs.text(label: 'Error Message', initial: 'error'),
            onImagesSelected: (List<File> imageFile) {
              // Handle the selected image file here
              // print('Image selected: ${imageFile.path}');
            },
            allowMultiples: true,
          )
      ),
    ),
  ];
}