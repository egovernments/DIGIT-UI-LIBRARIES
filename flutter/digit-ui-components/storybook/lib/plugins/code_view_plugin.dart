import 'dart:ui';

import 'package:any_syntax_highlighter/any_syntax_highlighter.dart';
import 'package:any_syntax_highlighter/themes/any_syntax_highlighter_theme.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import 'code_view_wrapper.dart';

class CodeViewPlugin extends Plugin {
  CodeViewPlugin({
    required bool enableCodeView,
    ValueSetter<bool>? onShowCodeView,
  }) : super(
    icon: enableCodeView ? _buildIcon : null,
    wrapperBuilder: _buildWrapper,
    onPressed: (context) => _onPressed(context, onShowCodeView),
  );

  static Widget _buildIcon(BuildContext context) => Icon(
    context.watch<CodeViewNotifier>().value
        ? Icons.remove_red_eye_outlined
        : Icons.code,
  );

  static void _onPressed(
      BuildContext context, ValueSetter<bool>? onShowCodeView) {
    final codeViewNotifier = context.read<CodeViewNotifier>();
    final newValue = !codeViewNotifier.value;
    codeViewNotifier.value = newValue;
    onShowCodeView?.call(newValue);
  }

  static Widget _buildWrapper(BuildContext context, Widget? child) =>
      ChangeNotifierProvider<CodeViewNotifier>(
        create: (_) => CodeViewNotifier(showCodeView: false),
        child: Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              if (context.read<CodeViewNotifier>().value) {
                context.read<CodeViewNotifier>().value = false;
              }
            },
            child: Stack(
              children: [
                child ?? const SizedBox.shrink(),
                if (context.watch<CodeViewNotifier>().value)
                  _buildCodeViewOverlay(context),
              ],
            ),
          ),
        ),
      );

  static Widget _buildCodeViewOverlay(BuildContext context) {
    final codeViewProvider = CodeViewProvider.of(context);
    return Positioned(
      bottom: 100,
      right: 400,
      left: 400,
      top: 100,
      child: GestureDetector(
        onTap: () {}, // Prevents taps inside the overlay from closing it
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Theme.of(context).colorTheme.paper.secondary,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Story Code',
                        style:
                        Theme.of(context).digitTextTheme(context).headingM),
                    ElevatedButton.icon(
                      onPressed: () {
                        final data = codeViewProvider?.codeString ?? '';
                        Clipboard.setData(ClipboardData(text: data));
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copy Code'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: SingleChildScrollView(
                    child: AnySyntaxHighlighter(
                      codeViewProvider?.codeString ?? '',
                      fontSize: 16,
                      padding: 16,
                      hasCopyButton: false,
                      isSelectableText: true,
                      reservedWordSets: const {'dart'},
                      theme: const AnySyntaxHighlighterTheme(
                        classStyle: TextStyle(
                          color: Color(0xff000000),
                        ),
                        staticStyle: TextStyle(
                          color: Color(0xffd73a49),
                        ),
                        constructor: TextStyle(
                          color: Color(0xff6f42c1),
                        ),
                        multilineComment: TextStyle(
                          color: Color(0xff6a737d),
                        ),
                        comment: TextStyle(
                          color: Color(0xff6a737d),
                        ),
                        keyword: TextStyle(
                          color: Color(0xffd73a49),
                          fontWeight: FontWeight.bold,
                        ),
                        identifier: TextStyle(
                          color: Color(0xff005cc5),
                        ),
                        private: TextStyle(
                          color: Color(0xff005cc5),
                        ),
                        function: TextStyle(
                          color: Color(0xff6f42c1),
                        ),
                        method: TextStyle(
                          color: Color(0xff005cc5),
                        ),
                        number: TextStyle(
                          color: Color(0xff005cc5),
                        ),
                        string: TextStyle(
                          color: Color(0xff032f62),
                        ),
                        operator: TextStyle(
                          color: Color(0xff000000),
                        ),
                        separator: TextStyle(
                          color: Color(0xff000000),
                        ),
                        fontFeatures: [FontFeature.slashedZero()],
                        fontFamily: 'RobotoMono',
                        letterSpacing: 0.5,
                        decoration: BoxDecoration(color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CodeViewNotifier extends ValueNotifier<bool> {
  CodeViewNotifier({required bool showCodeView}) : super(showCodeView);
}
