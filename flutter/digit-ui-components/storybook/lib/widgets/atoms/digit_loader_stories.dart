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
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
      name: 'Atom/Loader/Basic Loader',
      builder: (context) =>  DigitLoaders.circularLoader(
        context: context,
        fullPageOverlay: false,
        label: context.knobs.text(label: 'Loader label', initial: 'Loading...'),
      ),
    ),
    Story(
      name: 'Atom/Loader/Page Loader',
      builder: (context) =>  DigitLoaders.circularLoader(
        context: context,
        fullPageOverlay: true,
        label: context.knobs.text(label: 'Loader label', initial: 'Loading...'),
      ),
    ),
    Story(
      name: 'Atom/Loader/Overlay Loader',
      builder: (context) =>  ElevatedButton(
        onPressed: () {
          DigitLoaders.showLoadingDialog(
            context: context,
            label: "Loading Content...",
            barrierDismissible: false,
          );
           Future.delayed(const Duration(seconds: 2), (){
             DigitLoaders.hideLoadingDialog(context);
           });
        },
        child: const Text("Show Overlay Loader"),
      ),
    ),
  ];
}