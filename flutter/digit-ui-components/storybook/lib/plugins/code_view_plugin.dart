import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'code_view_wrapper.dart';

class CodeViewPlugin extends Plugin {
  CodeViewPlugin({
    required bool enableCodeView,
    ValueSetter<bool>? onShowCodeView,
  }) : super(
    icon: (context) => Icon(
      context.watch<CodeViewNotifier>().value ? Icons.remove_red_eye_outlined : Icons.code,
    ),
    wrapperBuilder: (context, child) => _buildWrapper(context, child),
    onPressed: (context) => _onPressed(context, onShowCodeView),
  );

  static Widget _buildWrapper(BuildContext context, Widget? child) {
    return ChangeNotifierProvider<CodeViewNotifier>(
      create: (_) => CodeViewNotifier(showCodeView: false),
      child: Builder(
        builder: (context) => ValueListenableBuilder<bool>(
          valueListenable: context.watch<CodeViewNotifier>(),
          builder: (context, showCodeView, child) {
            return Stack(
              children: [
                child ?? const SizedBox.shrink(),
                if (showCodeView)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: _CurrentStoryCode(
                      panelBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  static void _onPressed(BuildContext context, ValueSetter<bool>? onShowCodeView) {
    final notifier = context.read<CodeViewNotifier>();
    final newValue = !notifier.value;
    notifier.value = newValue;
    onShowCodeView?.call(newValue);
  }
}

class CodeViewNotifier extends ValueNotifier<bool> {
  CodeViewNotifier({required bool showCodeView}) : super(showCodeView);
}

class _CurrentStoryCode extends StatelessWidget {
  final Color panelBackgroundColor;

  const _CurrentStoryCode({
    required this.panelBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final storyNotifier = context.watch<StoryNotifier>();
    final codeProvider = CodeViewProvider.of(context);
    final codeString = codeProvider?.codeString;

    return Container(
      color: panelBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: codeString != null
            ? SingleChildScrollView(
          child: Text(
            codeString,
            style: TextStyle(fontFamily: 'monospace'),
          ),
        )
            : Text('No code available for this story.'),
      ),
    );
  }
}

