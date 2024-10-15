import 'dart:html';
import 'dart:ui_web';
import 'package:flutter/material.dart';

class IframeWidget extends StatelessWidget {
  final String url; // The full URL
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
          (int viewId) {
        final IFrameElement iframe = IFrameElement()
          ..src = url
          ..style.border = 'none'
          ..width = width.toString()
          ..height = height.toString();

        // Inject JavaScript to manipulate the iframe's content
        iframe.onLoad.listen((event) {
          iframe.contentWindow!.postMessage(
            '''
              (function() {
                try {
                  // Find the tab list element
                  var tabList = document.querySelector('.group\\/tabs');
                  
                  if (tabList) {
                    // Find all buttons inside the tab list
                    var buttons = tabList.querySelectorAll('button');
                    
                    // If there are at least two buttons, switch the active class to the second button
                    if (buttons.length > 1) {
                      var firstButton = buttons[0];
                      var secondButton = buttons[1];
                      
                      // Remove active class from the first button
                      if (firstButton.classList.contains('active-tab')) {
                        firstButton.classList.remove('active-tab');
                      }
                      
                      // Add active class to the second button
                      if (!secondButton.classList.contains('active-tab')) {
                        secondButton.classList.add('active-tab');
                      }
                      
                      // Optionally, trigger a click event on the second tab to ensure content loads
                      secondButton.click();
                    } else {
                      console.log('Fallback: Only one button or no buttons found.');
                    }
                  } else {
                    console.log('Fallback: Tab list not found. Showing default content.');
                  }
                } catch (error) {
                  console.error('Error occurred while switching tabs:', error);
                }
              })();
            ''',
            '*', // Specify the target origin for security
          );
        });

        return iframe;
      },
    );

    return Center(
      child: Container(
        padding: EdgeInsets.all(40),
        child: HtmlElementView(viewType: viewType),
      ),
    );
  }
}
