import 'dart:convert';
import 'dart:io';

import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:universal_html/html.dart' as html;

List<Story> illustrationStories() {
  return [
    Story(
      name: 'Foundations/Illustrations',
      builder: (context) {
        return IllustrationStory();
      },
    ),
  ];
}

class IllustrationStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    // List of images (replace with your actual asset paths)
    final images = [

      {'name': 'Storybook logo', 'asset': 'assets/images/Group 1079.png'},
      {'name': 'Digit logo', 'asset': 'assets/images/powered_by_digit.png'},
      {'name' : 'No result found', 'asset' : 'assets/icons/svg/no_result.svg'},
      {'name' : 'Default Search Placeholder', 'asset' : 'assets/icons/svg/default_search_placeholder.svg'},
    ];

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Top description
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Explore the illustrations available. '
                'Click on any image to see it in detail and download it in SVG or PNG format.',
                style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(
                      color: themeData.colorTheme.text.primary,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            // Images grid
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 24.0, // Spacing between images horizontally
              runSpacing: 24.0, // Spacing between images vertically
              children: _buildImageWidgets(images, context),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImageWidgets(
      List<Map<String, String>> images, BuildContext context) {
    return images.map((imageData) {
      final imageName = imageData['name']!;
      final imageAsset = imageData['asset']!;

      return InkWell(
        onTap: () => _showImageDialog(context, imageName, imageAsset),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorTheme.paper.secondary,
            border: Border.all(
                color: Theme.of(context).colorTheme.generic.inputBorder,
                width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildImage(imageAsset),
              const SizedBox(height: 16),
              Text(
                imageName, // Display the name of the image
                style: Theme.of(context).digitTextTheme(context).bodyS.copyWith(
                      color: Theme.of(context).colorTheme.text.primary,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }).toList();


  }

  Widget _buildImage(String imageAsset, {bool isOverlay = false}) {
    if (imageAsset.endsWith('.svg')) {
      print('here');
      // Use flutter_svg package to render SVG images
      return Center(
        child: SvgPicture.asset(
          imageAsset,
          width: isOverlay ? null : 100, // Fixed width for the image
          height: isOverlay ? 300 : 100, // Fixed height for the image
          fit: BoxFit.contain,
        ),
      );
    } else {
      // For non-SVG images (e.g., PNG)
      return Center(
        child: Image.asset(
          imageAsset,
          width: 100,
          height: 100,
          fit: BoxFit.contain,
        ),
      );
    }
  }

  void _showImageDialog(
      BuildContext context, String imageName, String imageAsset) {
    showCustomPopup(
      context: context,
      builder: (popupContext) => Popup(
        title: imageName,
        onOutsideTap: () {
          Navigator.of(popupContext).pop();
        },
        onCrossTap: () {
          Navigator.of(popupContext).pop();
        },
        additionalWidgets: [
          _buildImage(imageAsset, isOverlay: true)
        ],
        type: PopUpType.simple,
        actions: [
          DigitButton(
            label: 'Download as PNG',
            onPressed: () {
              _downloadImage(imageAsset, 'png');
            },
            mainAxisSize: MainAxisSize.max,
            type: DigitButtonType.secondary,
            size: DigitButtonSize.large,
          ),

          DigitButton(label: 'Download as SVG',
              mainAxisSize: MainAxisSize.max,
              onPressed: () {
            _downloadImage(imageAsset, 'svg');
          }, type: DigitButtonType.secondary, size: DigitButtonSize.large),
        ],
      ),
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       backgroundColor: Theme.of(context).colorTheme.paper.primary,
    //       shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.all(Radius.circular(4.0))),
    //       title: Text(imageName),
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           // Display the full image
    //           Image.asset(
    //             imageAsset,
    //             fit: BoxFit.cover,
    //             height: 200, // Adjust as necessary
    //           ),
    //           SizedBox(height: 16),
    //           Text('Download as:'),
    //           SizedBox(height: 8),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               TextButton(
    //                 onPressed: () {
    //                   // Logic to download as SVG
    //                   _downloadImage(imageAsset, 'svg');
    //                 },
    //                 child: Text('SVG'),
    //               ),
    //               TextButton(
    //                 onPressed: () {
    //                   // Logic to download as PNG
    //                   _downloadImage(imageAsset, 'png');
    //                 },
    //                 child: Text('PNG'),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //       actions: [
    //         TextButton(
    //           child: Text('Close'),
    //           onPressed: () {
    //             Navigator.of(context).pop(); // Close the dialog
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _downloadImage(String imageAsset, String format) async {
    try {
      if (format == 'png' && imageAsset.endsWith('.svg')) {
        // Convert SVG to PNG and download
        await _convertSvgToPng(imageAsset);
      } else if (format == 'svg' && imageAsset.endsWith('.png')) {
        // Handle PNG download
        await _convertPngToSvg(imageAsset);
      } else if (format == 'png' || imageAsset.endsWith('.png')) {
        // Convert PNG to SVG and download
        await _saveImageToBrowser(imageAsset, 'png');
      } else if (format == 'svg' || imageAsset.endsWith('.svg')) {
        // Handle direct SVG download
        await _saveSvgToBrowser(imageAsset, 'svg');
      } else {
        print('Unsupported file format: $format');
      }
    } catch (e) {
      print('Error downloading image: $e');
    }
  }

// Convert SVG to PNG and download
  Future<void> _convertSvgToPng(String assetPath) async {
    try {
      // Load SVG as string
      String svgString = await rootBundle.loadString(assetPath);

      // Create a canvas element to draw the SVG
      final svgBlob = html.Blob([svgString], 'image/svg+xml');
      final svgUrl = html.Url.createObjectUrlFromBlob(svgBlob);

      // Create an image element and load the SVG data into it
      final imageElement = html.ImageElement(src: svgUrl);
      await imageElement.onLoad.first; // Wait for the image to load

      // Create a canvas to draw the SVG image
      final canvas = html.CanvasElement(width: imageElement.width, height: imageElement.height);
      final context = canvas.context2D;

      // Draw the SVG image on the canvas
      context.drawImage(imageElement, 0, 0);

      // Convert the canvas content to PNG and trigger download
      final pngDataUrl = canvas.toDataUrl("image/png");

      // Create an anchor element and trigger download
      final anchor = html.AnchorElement(href: pngDataUrl)
        ..setAttribute('download', '${assetPath.split('/').last.replaceAll('.svg', '.png')}')
        ..click();

      // Revoke the object URL to release memory
      html.Url.revokeObjectUrl(svgUrl);
      print('SVG converted and downloaded as PNG');
    } catch (e) {
      print('Failed to convert and download SVG as PNG: $e');
    }
  }

// Save PNG image to browser (unchanged)
  Future<void> _saveImageToBrowser(String assetPath, String format) async {
    try {
      ByteData byteData = await rootBundle.load(assetPath);
      Uint8List bytes = byteData.buffer.asUint8List();

      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', assetPath.split('/').last)
        ..click();

      html.Url.revokeObjectUrl(url);
      print('PNG image downloaded');
    } catch (e) {
      print('Failed to download PNG image: $e');
    }
  }

// Save SVG image to browser (unchanged)
  Future<void> _saveSvgToBrowser(String assetPath, String format) async {
    try {
      String svgString = await rootBundle.loadString(assetPath);

      final blob = html.Blob([svgString], 'image/svg+xml');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', assetPath.split('/').last)
        ..click();

      html.Url.revokeObjectUrl(url);
      print('SVG image downloaded');
    } catch (e) {
      print('Failed to download SVG image: $e');
    }
  }

// Convert PNG to SVG (unchanged)
  Future<void> _convertPngToSvg(String assetPath) async {
    try {
      ByteData byteData = await rootBundle.load(assetPath);
      Uint8List bytes = byteData.buffer.asUint8List();

      String base64Png = base64Encode(bytes);

      String svgContent = '''
<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500">
  <image href="data:image/png;base64,$base64Png" width="100%" height="100%"/>
</svg>
    ''';

      final blob = html.Blob([svgContent], 'image/svg+xml');
      final url = html.Url.createObjectUrlFromBlob(blob);

      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', '${assetPath.split('/').last.replaceAll('.png', '.svg')}')
        ..click();

      html.Url.revokeObjectUrl(url);
      print('PNG converted and downloaded as SVG');
    } catch (e) {
      print('Failed to convert and download PNG as SVG: $e');
    }
  }


}
