import 'package:digit_ui_components/widgets/atoms/digit_loader.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';
import 'package:flutter/material.dart';

List<Story> loaderStories() {
  return [
    Story(
      name: 'Atom/Loader/Page Loader',
      builder: (context) =>  DigitLoaders.circularLoader(
        context: context,
        fullPageOverlay: false,
        label: "Fetching Data...",
      ),
    ),
    Story(
      name: 'Atom/Loader/Full Page Loader',
      builder: (context) =>  DigitLoaders.circularLoader(
        context: context,
        fullPageOverlay: true,
        label: "Fetching Data...",
      ),
    ),
    Story(
      name: 'Atom/Loader/Dialog Loader',
      builder: (context) =>  ElevatedButton(
        onPressed: () {
          DigitLoaders.showLoadingDialog(
            context: context,
            label: "Please Wait...",
            barrierDismissible: false,
          );
           Future.delayed(const Duration(seconds: 2), (){
             DigitLoaders.hideLoadingDialog(context);
           });
        },
        child: const Text("Show Toast"),
      ),
    ),
  ];
}