// import 'package:flutter/material.dart';
//
// class CodeViewWrapper extends StatefulWidget {
//   final Widget child;
//
//   const CodeViewWrapper({super.key, required this.child});
//
//   @override
//   _CodeViewWrapperState createState() => _CodeViewWrapperState();
// }
//
// class _CodeViewWrapperState extends State<CodeViewWrapper> {
//   String codeString = '';
//
//   void updateCodeString(String newCodeString) {
//     setState(() {
//       codeString = newCodeString;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CodeViewProvider(
//       codeString: codeString,
//       updateCodeString: updateCodeString,
//       child: widget.child,
//     );
//   }
// }
//
// class CodeViewProvider extends InheritedWidget {
//   final String codeString;
//   final void Function(String) updateCodeString;
//
//   const CodeViewProvider({super.key,
//     required this.codeString,
//     required this.updateCodeString,
//     required Widget child,
//   }) : super(child: child);
//
//   static CodeViewProvider? of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<CodeViewProvider>();
//   }
//
//   @override
//   bool updateShouldNotify(CodeViewProvider oldWidget) {
//     return oldWidget.codeString != codeString;
//   }
// }
