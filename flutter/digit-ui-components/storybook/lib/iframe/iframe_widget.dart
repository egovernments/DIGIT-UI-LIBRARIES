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
                  // Find the main content element
                  var mainContent = document.querySelector('.flex-1.relative.py-8.lg\\:px-12.break-anywhere.page-api-block\\:xl\\:max-2xl\\:pr-0.page-api-block\\:max-w-\\[1654px\\].page-api-block\\:mx-auto');
                  
                  if (mainContent) {
                    // Remove all other elements from the body except the main content
                    var allChildren = Array.from(document.body.children);
                    
                    allChildren.forEach(function(child) {
                      if (child !== mainContent) {
                        child.parentNode.removeChild(child);
                      }
                    });
                    
                    console.log('Main content displayed, all other content removed.');
                  } else {
                    console.log('Main content not found, showing default content.');
                  }

                  // Tab switching logic
                  var tabList = document.querySelector('.group\\/tabs');
                  
                  if (tabList) {
                    var buttons = tabList.querySelectorAll('button');
                    
                    if (buttons.length > 1) {
                      var firstButton = buttons[0];
                      var secondButton = buttons[1];
                      
                      if (firstButton.classList.contains('active-tab')) {
                        firstButton.classList.remove('active-tab');
                      }
                      
                      if (!secondButton.classList.contains('active-tab')) {
                        secondButton.classList.add('active-tab');
                      }
                      
                      secondButton.click();  // Trigger content load for the second tab
                      console.log('Switched to second tab.');
                    } else {
                      console.log('Fallback: Only one button or no buttons found.');
                    }
                  } else {
                    console.log('Fallback: Tab list not found. Showing default content.');
                  }
                } catch (error) {
                  console.error('Error occurred while processing the iframe content:', error);
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
