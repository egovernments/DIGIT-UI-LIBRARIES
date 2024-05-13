import 'package:digit_ui_components/utils/validators/file_validator.dart';
import 'package:digit_ui_components/widgets/atoms/file_uploader.dart';
import 'package:digit_ui_components/widgets/atoms/file_uploader2.dart';
import 'package:digit_ui_components/widgets/atoms/image_uploader.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

List<Story> fileUploaderStories() {
  return [
    Story(
      name: 'Atom/File Upload/Pop UP/Single Upload/default',
      builder: (context) => Center(
        child: FileUploadWidget(
          label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
          Map<PlatformFile, String?> fileErrors = {};

          return fileErrors;
        },
          showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        ),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Pop UP/Single Upload/Field Error',
      builder: (context) => FileUploadWidget(
        label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
        Map<PlatformFile, String?> fileErrors = {};

        return fileErrors;
      },
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        errorMessage: context.knobs.text(label: 'Error Message', initial: 'error'),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Pop UP/Single Upload/File Error(only pdf)',
      builder: (context) => FileUploadWidget(
        label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
        Map<PlatformFile, String?> fileErrors = {};

        return fileErrors;
      },
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        validators: [
          FileValidator(FileValidatorType.fileType, ['pdf'], errorMessage: 'Only PDF files are allowed'),
        ],
      ),
    ),
      Story(
        name: 'Atom/File Upload/Pop UP/Single Upload/File Validation Error(less than 50kb)',
        builder: (context) => FileUploadWidget(
          label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
          Map<PlatformFile, String?> fileErrors = {};

          // Perform validation for each file
          for (var file in files) {
            // Get the file size in bytes
            int fileSizeInBytes = file.size;

            // Convert bytes to kilobytes
            double fileSizeInKB = fileSizeInBytes / 1024;

            // Check if file size exceeds 50 KB
            if (fileSizeInKB > 50) {
              fileErrors[file] = 'File size exceeds 50 KB limit';
            } else {
              // If no error, set the error message as null
              fileErrors[file] = null;
            }
          }
          return fileErrors;
        },
          showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        ),
      ),
    Story(
      name: 'Atom/File Upload/Pop UP/Multiple Upload/default',
      builder: (context) => Center(
        child: FileUploadWidget(
          allowMultipleImages: true,
          label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
          Map<PlatformFile, String?> fileErrors = {};

          return fileErrors;
        },
          showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        ),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Pop UP/Multiple Upload/Field Error',
      builder: (context) => FileUploadWidget(
        allowMultipleImages: true,
        label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
        Map<PlatformFile, String?> fileErrors = {};

        return fileErrors;
      },
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        errorMessage: context.knobs.text(label: 'Error Message', initial: 'error'),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Pop UP/Multiple Upload/File Error(only pdf)',
      builder: (context) => FileUploadWidget(
        allowMultipleImages: true,
        label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
        Map<PlatformFile, String?> fileErrors = {};

        return fileErrors;
      },
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        validators: [
          FileValidator(FileValidatorType.fileType, ['pdf'], errorMessage: 'Only PDF files are allowed'),
        ],
      ),
    ),
    Story(
      name: 'Atom/File Upload/Pop UP/Multiple Upload/File Validation Error(less than 50kb)',
      builder: (context) => FileUploadWidget(
        allowMultipleImages: true,
        label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
        Map<PlatformFile, String?> fileErrors = {};

        // Perform validation for each file
        for (var file in files) {
          // Get the file size in bytes
          int fileSizeInBytes = file.size;

          // Convert bytes to kilobytes
          double fileSizeInKB = fileSizeInBytes / 1024;

          // Check if file size exceeds 50 KB
          if (fileSizeInKB > 50) {
            fileErrors[file] = 'File size exceeds 50 KB limit';
          } else {
            // If no error, set the error message as null
            fileErrors[file] = null;
          }
        }
        return fileErrors;
      },
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Single file/default',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultipleImages: false,
        label: 'Upload', onFilesSelected: (DroppedFile) {  },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Single file/field error',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultipleImages: false,
        errorMessage: context.knobs.text(label: 'Error Message', initial: 'error'),
        label: 'Upload', onFilesSelected: (DroppedFile) {  },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Multiple files/default',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultipleImages: true,
        label: 'Upload', onFilesSelected: (DroppedFile) {  },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Multiple files/field error',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultipleImages: true,
        errorMessage: context.knobs.text(label: 'Error Message', initial: "error"),
        label: 'Upload', onFilesSelected: (DroppedFile) {  },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Image/Single Upload/default',
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
      name: 'Atom/File Upload/Image/Single Upload/Field Error',
      builder: (context) => Center(
          child: ImageUploader(
            errorMessage: context.knobs.text(label: 'Error Message', initial: 'error'),
            onImagesSelected: (List<File> imageFile) {
              // Handle the selected image file here
              // print('Image selected: ${imageFile.path}');
            },
          )

      ),
    ),
    Story(
      name: 'Atom/File Upload/Image/Single Upload/File Error',
      builder: (context) => Center(
          child: ImageUploader(
            validators: [
              FileValidator(FileValidatorType.fileType, ['png'], errorMessage: 'Only png files are allowed'),
            ],
            onImagesSelected: (List<File> imageFile) {
              // Handle the selected image file here
              // print('Image selected: ${imageFile.path}');
            },
          )

      ),
    ),
    Story(
      name: 'Atom/File Upload/Image/Multiple Upload/default',
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
    Story(
      name: 'Atom/File Upload/Image/Multiple Upload/Field Error',
      builder: (context) => Center(
          child: ImageUploader(
            errorMessage: context.knobs.text(label: 'Error Message', initial: 'error'),
            onImagesSelected: (List<File> imageFile) {
              // Handle the selected image file here
              // print('Image selected: ${imageFile.path}');
            },
            allowMultipleImages: true,
          )
      ),
    ),
    Story(
      name: 'Atom/File Upload/Image/Multiple Upload/File Error',
      builder: (context) => Center(
          child: ImageUploader(
            onImagesSelected: (List<File> imageFile) {
              // Handle the selected image file here
              // print('Image selected: ${imageFile.path}');
            },
            allowMultipleImages: true,
            validators: [
              FileValidator(FileValidatorType.fileType, ['png'], errorMessage: 'Only png files are allowed'),
            ],
          )
      ),
    ),
  ];
}








