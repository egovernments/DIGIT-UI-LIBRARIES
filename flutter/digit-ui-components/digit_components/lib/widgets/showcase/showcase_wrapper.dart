import 'package:digit_ui_components/widgets/showcase/showcase_registry.dart';
import 'package:flutter/material.dart';

class ShowcaseWrapper extends StatefulWidget {
  final String contentHeading;
  final String contentDescription;
  final Widget child;

  const ShowcaseWrapper({super.key,
    required this.contentHeading,
    required this.contentDescription,
    required this.child,
  });

  @override
  _ShowcaseWrapperState createState() => _ShowcaseWrapperState();
}

class _ShowcaseWrapperState extends State<ShowcaseWrapper> {
  @override
  void initState() {
    super.initState();
    // Register this ShowcaseWrapper instance in the ShowcaseRegistry
    ShowcaseRegistry.register(widget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
