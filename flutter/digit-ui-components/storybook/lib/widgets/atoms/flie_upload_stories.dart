import 'dart:typed_data';

import 'package:digit_ui_components/utils/validators/file_validator.dart';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:digit_ui_components/widgets/atoms/upload_image.dart';
import 'package:digit_ui_components/widgets/atoms/upload_popUp.dart';
import 'package:flutter/services.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
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
          onFileTap: (file) => print(file.name),
          initialFiles: [PlatformFile(name: 'test.pdf', size: 0,), PlatformFile(name: 'test.png', size: 0,)],
          openFile: context.knobs.boolean(label: 'Open File', initial: false),
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
      ),
    ),
    Story(
      name: 'Atom/File Upload/Pop UP/Single Upload/File Error(only pdf)',
      builder: (context) => FileUploadWidget(
        label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
        Map<PlatformFile, String?> fileErrors = {};

        return fileErrors;
      },
        openFile: context.knobs.boolean(label: 'Open File', initial: false),
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
          }
        }
        return fileErrors;
      },
        openFile: context.knobs.boolean(label: 'Open File', initial: false),
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Pop UP/Multiple Upload/default',
      builder: (context) => Center(
        child: FileUploadWidget(
          allowMultiples: true,
          onFileTap: (file) => print(file.name),
          //initialFiles: [PlatformFile(name: 'test.pdf', size: 0,), PlatformFile(name: 'test.png', size: 0,)],
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
      name: 'Atom/File Upload/Pop UP/Multiple Upload/Field Error',
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
      name: 'Atom/File Upload/Pop UP/Multiple Upload/File Error(only pdf)',
      builder: (context) => FileUploadWidget(
        allowMultiples: true,
        label: 'Upload', onFilesSelected: (List<PlatformFile> files) {
        Map<PlatformFile, String?> fileErrors = {};

        return fileErrors;
      },
        openFile: context.knobs.boolean(label: 'Open File', initial: false),
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
        validators: [
          FileValidator(FileValidatorType.fileType, ['pdf'], errorMessage: 'Only PDF files are allowed'),
        ],
      ),
    ),
    Story(
      name: 'Atom/File Upload/Pop UP/Multiple Upload/File Validation Error(less than 50kb)',
      builder: (context) => FileUploadWidget(
        allowMultiples: true,
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
          }
        }
        return fileErrors;
      },
        openFile: context.knobs.boolean(label: 'Open File', initial: false),
        showPreview: context.knobs.boolean(label: 'Show preview', initial: false),
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Single file/default',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultiples: false,
        label: 'Upload', onFilesSelected: (files) {
          return {};
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Single file/field error',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultiples: false,
        errorMessage: context.knobs.text(label: 'Error Message', initial: 'error'),
        label: 'Upload', onFilesSelected: (files) {
          return {};
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Single file/file error',
      builder: (context) => FileUploadWidget2(
        showPreview: context.knobs.boolean(label: 'Open File', initial: false),
        allowMultiples: false,
        label: 'Upload', onFilesSelected: (files) {
        Map<DroppedFile, String?> fileErrors = {};
        // Perform validation for each file
        for (var file in files) {
          // Get the file size in bytes
          int fileSizeInBytes =file.bytes;

          // Convert bytes to kilobytes
          double fileSizeInKB = fileSizeInBytes / 1024;

          // Check if file size exceeds 50 KB
          if (fileSizeInKB > 50) {
            fileErrors[file] = 'File size exceeds 50 KB limit';
          }
        }
        return fileErrors;
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Single file/file error with error card',
      builder: (context) => FileUploadWidget2(
        showPreview: context.knobs.boolean(label: 'Open File', initial: false),
        allowMultiples: false,
        isErrorChip: true,
        label: 'Upload', onFilesSelected: (files) {
        Map<DroppedFile, String?> fileErrors = {};
        // Perform validation for each file
        for (var file in files) {
          // Get the file size in bytes
          int fileSizeInBytes =file.bytes;

          // Convert bytes to kilobytes
          double fileSizeInKB = fileSizeInBytes / 1024;

          // Check if file size exceeds 50 KB
          if (fileSizeInKB > 50) {
            fileErrors[file] = 'File size exceeds 50 KB limit';
          }
        }
        return fileErrors;
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Multiple files/default',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultiples: true,
        label: 'Upload', onFilesSelected: (files) {
          return {};
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Multiple files/field error',
      builder: (context) => FileUploadWidget2(
        showPreview: true,
        allowMultiples: true,
        errorMessage: context.knobs.text(label: 'Error Message', initial: "error"),
        label: 'Upload', onFilesSelected: (files) {
          return {};
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Multiple files/file error',
      builder: (context) => FileUploadWidget2(
        showPreview: context.knobs.boolean(label: 'Open File', initial: false),
        allowMultiples: true,
        label: 'Upload', onFilesSelected: (files) {
        Map<DroppedFile, String?> fileErrors = {};
        // Perform validation for each file
        for (var file in files) {
          // Get the file size in bytes
          int fileSizeInBytes =file.bytes;

          // Convert bytes to kilobytes
          double fileSizeInKB = fileSizeInBytes / 1024;

          // Check if file size exceeds 50 KB
          if (fileSizeInKB > 50) {
            fileErrors[file] = 'File size exceeds 50 KB limit';
          }
        }
        return fileErrors;
      },
      ),
    ),
    Story(
      name: 'Atom/File Upload/Drag/Multiple files/file error with error card',
      builder: (context) => FileUploadWidget2(
        showPreview: context.knobs.boolean(label: 'Open File', initial: false),
        allowMultiples: true,
        isErrorChip: true,
        label: 'Upload', onFilesSelected: (files) {
        Map<DroppedFile, String?> fileErrors = {};
        // Perform validation for each file
        for (var file in files) {
          // Get the file size in bytes
          int fileSizeInBytes =file.bytes;

          // Convert bytes to kilobytes
          double fileSizeInKB = fileSizeInBytes / 1024;

          // Check if file size exceeds 50 KB
          if (fileSizeInKB > 50) {
            fileErrors[file] = 'File size exceeds 50 KB limit';
          }
        }
        return fileErrors;
      },
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
      name: 'Atom/File Upload/Image/Single Upload/Initially Selected',
      builder: (context) {
        return FutureBuilder<File>(
          future: _loadSampleImage(), // Call to load the sample image
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading image'));
            } else if (snapshot.hasData) {
              final File sampleImageFile = snapshot.data!;
              return Center(
                child: ImageUploader(
                  onImagesSelected: (List<File> images) {
                    // Handle the selected image file here
                    // print('Image selected: ${images.first.path}');
                  },
                  initialImages: [sampleImageFile], // Pass the sample image here
                  allowMultiples: false, // Example setting, adjust as needed
                ),
              );
            } else {
              return Center(child: Text('No image found'));
            }
          },
        );
      },
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
            allowMultiples: true,
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
            allowMultiples: true,
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
            allowMultiples: true,
            validators: [
              FileValidator(FileValidatorType.fileType, ['png'], errorMessage: 'Only png files are allowed'),
            ],
          )
      ),
    ),
  ];
}

// Function to load the sample image
Future<File> _loadSampleImage() async {
  // Load the image from assets and get the temporary directory
  final ByteData data = await rootBundle.load('assets/images/digit_logo_dark.jpg');
  final List<int> bytes = data.buffer.asUint8List();
  final Directory tempDir = await getTemporaryDirectory();
  final String tempPath = '${tempDir.path}/digit_logo_dark.jpg';
  final File file = File(tempPath);

  // Write the image to a file
  await file.writeAsBytes(bytes);

  return file;
}