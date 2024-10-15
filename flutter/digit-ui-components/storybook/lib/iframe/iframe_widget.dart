import 'dart:html';
import 'dart:ui_web';
import 'package:flutter/material.dart';

class IframeWidget extends StatelessWidget {
  final String url; // This is the full URL
  final double width;
  final double height;

  const IframeWidget({
    Key? key,
    required this.url,
    this.width = 1220,
    this.height = 800,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Register the viewType for the HTML iframe element
    final String viewType = 'iframeElement-$url';
    platformViewRegistry.registerViewFactory(
      viewType,
          (int viewId) => IFrameElement()
        ..src = url
        ..style.border = 'none'
    );

    return Center(
      child: Container(
        padding: EdgeInsets.all(40),
        child: HtmlElementView(viewType: viewType),
      ),
    );
  }
}



// import 'dart:html';
// import 'dart:ui';
// import 'package:flutter/material.dart';
//
// class IframeWidget extends StatelessWidget {
//   final String url;
//   final double width;
//   final double height;
//
//   const IframeWidget({
//     Key? key,
//     required this.url,
//     this.width = 800,
//     this.height = 600,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Register the viewType for the HTML iframe element
//     final String viewType = 'iframeElement-$url';
//     platformViewRegistry.registerViewFactory(
//       viewType,
//           (int viewId) {
//         final IFrameElement iframe = IFrameElement()
//           ..src = url
//           ..style.border = 'none'
//           ..width = width.toString()
//           ..height = height.toString();
//
//         // Inject custom JavaScript to manipulate the iframe's content
//         iframe.onLoad.listen((event) {
//           // Example: Hide an element with a specific class name
//           iframe.contentWindow!.postMessage(
//             '''
//               (function() {
//                 var elementToHide = document.querySelector('.class-to-hide');
//                 if (elementToHide) {
//                   elementToHide.style.display = 'none';
//                 }
//               })();
//             ''',
//             '*', // You can specify the target origin here for security
//           );
//         });
//
//         return iframe;
//       },
//     );
//
//     return Center(
//       child: SizedBox(
//         width: width,
//         height: height,
//         child: HtmlElementView(viewType: viewType),
//       ),
//     );
//   }
// }

