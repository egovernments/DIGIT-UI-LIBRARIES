import 'package:digit_ui_components/widgets/showcase/showcase_registry.dart';
import 'package:digit_ui_components/widgets/showcase/showcase_tooltip.dart';
import 'package:flutter/material.dart';

class Showcase extends StatefulWidget {
  final Function()? onStart;
  final Function()? onClose;
  final Function()? onNext;
  final Function()? onSkip;

  Showcase({super.key,
    this.onStart,
    this.onClose,
    this.onNext,
    this.onSkip,
  });

  @override
  ShowcaseState createState() => ShowcaseState();

}

class ShowcaseState extends State<Showcase> {
  int currentIndex = 0;

  void startShowcaseDemo() {
    setState(() {
      currentIndex = 0;
    });

    if (widget.onStart != null) {
      widget.onStart!();
    }
  }

  void _onNext() {
    if (currentIndex < ShowcaseRegistry.items.length - 1) {
      setState(() {
        currentIndex++;
      });
      if (widget.onNext != null) {
        widget.onNext!();
      }
    } else {
      _onClose();
    }
  }

  void _onClose() {
    if (widget.onClose != null) {
      widget.onClose!();
    }
  }

  void _onSkip() {
    if (widget.onSkip != null) {
      widget.onSkip!();
    }
    _onClose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= ShowcaseRegistry.items.length) {
      return Container();
    }

    final showcaseWrapper = ShowcaseRegistry.items[currentIndex];

    return ShowcaseTooltip(
      contentHeading: showcaseWrapper.contentHeading,
      contentDescription: showcaseWrapper.contentDescription,
      onNext: _onNext,
      onClose: _onClose,
      onSkip: _onSkip,
      child: showcaseWrapper.child,
    );
  }
}
