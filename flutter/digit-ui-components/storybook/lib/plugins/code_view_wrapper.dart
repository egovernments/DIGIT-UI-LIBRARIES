import 'package:flutter/material.dart';

class CodeViewWrapper extends StatelessWidget {
  final String codeString;
  final Widget child;

  const CodeViewWrapper({super.key,
    required this.codeString,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CodeViewProvider(
      codeString: codeString,
      child: child,
    );
  }
}

class CodeViewProvider extends InheritedWidget {
  final String codeString;

  const CodeViewProvider({super.key,
    required this.codeString,
    required Widget child,
  }) : super(child: child);

  static CodeViewProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CodeViewProvider>();
  }

  @override
  bool updateShouldNotify(CodeViewProvider oldWidget) {
    return codeString != oldWidget.codeString;
  }
}
