import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FocusContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback arrowUp;
  final VoidCallback arrowDown;
  final VoidCallback enter;
  final VoidCallback escape;

  const FocusContainer({Key? key, required this.child, required this.arrowDown, required this.escape, required this.arrowUp, required this.enter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (hasFocus) {
          if (hasFocus) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        child: RawKeyboardListener(
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) {
            if (event is RawKeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                print('heeeeeeeeeeeeeeee');
                arrowUp;
              } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                print('ttttttttttttttttttttttttt');
                arrowDown;
              } else if (event.logicalKey == LogicalKeyboardKey.enter) {
                enter();
              } else if (event.logicalKey == LogicalKeyboardKey.escape) {
                escape();
              }
            }
          },
          child: Builder(
            builder: (BuildContext context) {
              // Wrap child in FocusTraversalGroup to handle traversal
              return FocusTraversalGroup(
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
