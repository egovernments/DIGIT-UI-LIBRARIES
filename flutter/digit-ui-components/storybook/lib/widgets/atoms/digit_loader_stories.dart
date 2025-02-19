import 'package:digit_ui_components/widgets/atoms/digit_loader.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';
import '../../iframe/iframe_widget.dart';

List<Story> loaderStories() {
  return [
    Story(
      name: 'Atom/Loader/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://core.digit.org/guides/developer-guide/ui-developer-guide/digit-ui/ui-components-standardisation/digit-ui-components0.2.0',
        );
      },
    ),
    Story(
      name: 'Atom/Loader/Basic Loader',
      builder: (context) =>  DigitLoaders.inlineLoader(),
    ),
    Story(
      name: 'Atom/Loader/Page Loader',
      builder: (context) =>  DigitLoaders.showFullPageLoader(
        context: context,
        label: context.knobs.text(label: 'Loader label', initial: 'Loading...'),
      ),
    ),
    Story(
      name: 'Atom/Loader/Overlay Loader',
      builder: (context) =>  ElevatedButton(
        onPressed: () {
          DigitLoaders.overlayLoader(
            // size: 100,
            context: context,
            label: "Loading Content...",
            barrierDismissible: false,
          );
           Future.delayed(const Duration(seconds: 5), (){
             DigitLoaders.hideLoaderDialog(context);
           });
        },
        child: const Text("Show Overlay Loader"),
      ),
    ),
  ];
}