import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/widgets/atoms/digit_toast.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import '../../iframe/iframe_widget.dart';

List<Story> toastStories() {
  return [
    Story(
      name: 'Atom/Toast/Documentation',
      builder: (context) {
        return IframeWidget(
          url: 'https://egov-digit.gitbook.io/docs-templates-repo/ui-component-name-2',
        );
      },
    ),
    Story(
        name: 'Atom/Toast/Success',
        builder: (context) => Toast.buildToastWidget(
              context.knobs
                  .text(label: 'Message', initial: 'This is a success toast!'),
              ToastType.success,
              context,
              null,
            ),),
    Story(
        name: 'Atom/Toast/Error',
        builder: (context) => Toast.buildToastWidget(
              context.knobs
                  .text(label: 'Message', initial: 'This is an error toast!'),
              ToastType.error,
              context,
              null,
            )),
    Story(
        name: 'Atom/Toast/Warning',
        builder: (context) => Toast.buildToastWidget(
              context.knobs
                  .text(label: 'Message', initial: 'This is a warning toast!'),
              ToastType.warning,
              context,
              null,
            )),
    Story(
      name: 'Atom/Toast/Info',
      builder: (context) => Toast.buildToastWidget(
          context.knobs
              .text(label: 'Message', initial: 'This is a info toast!'),
          ToastType.info,
          context,
          null),
    ),
    Story(
      name: 'Atom/Toast/Show toast',
      builder: (context) => ElevatedButton(
        onPressed: () {
          Toast.showToast(context,
              message: 'This is a toast!',
              type: ToastType.info,
          );
        },
        child: const Text("Show Toast"),
      ),
    ),
  ];
}
