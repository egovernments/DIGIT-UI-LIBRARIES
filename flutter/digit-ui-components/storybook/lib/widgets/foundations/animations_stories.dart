import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

class LottieAnimationStory extends StatefulWidget {
  final String animationAsset;

  const LottieAnimationStory({
    Key? key,
    required this.animationAsset,
  }) : super(key: key);

  @override
  _LottieAnimationStoryState createState() => _LottieAnimationStoryState();
}

class _LottieAnimationStoryState extends State<LottieAnimationStory>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final animate = context.knobs.boolean(
      label: 'Animate',
      initial: true,
    );

    final repeat = context.knobs.boolean(
      label: 'Repeat',
      initial: true,
    );

    // Knobs for width and height input
    final width = double.tryParse(
      context.knobs.text(
        label: 'Width',
        initial: '200',
      ),
    ) ?? 200.0;

    final height = double.tryParse(
      context.knobs.text(
        label: 'Height',
        initial: '200',
      ),
    ) ?? 200.0;

    return Lottie.asset(
      repeat: repeat,
      animate: animate,
      widget.animationAsset,
      controller: _controller,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        if (animate) {
          if (repeat) {
            _controller.repeat();
          } else {
            _controller.forward();
          }
        } else {
          _controller.value = 1.0; // Move to the last frame
        }
      },
      width: width, // Use the width from the text input
      height: height, // Use the height from the text input
      fit: BoxFit.fill,
    );
  }
}

// Different animation panels

Widget successAnimationStory() {
  return LottieAnimationStory(animationAsset: 'assets/animated_json/success.json');
}

Widget errorAnimationStory() {
  return LottieAnimationStory(animationAsset: 'assets/animated_json/error.json');
}

Widget alertAnimationStory() {
  return LottieAnimationStory(animationAsset: 'assets/animated_json/alert.json');
}

// Add the stories to your story list

List<Story> animationStories() {
  return [
    Story(
      name: 'Foundations/Animations/Success',
      builder: (context) {
        return successAnimationStory();
      },
    ),
    Story(
      name: 'Foundations/Animations/Error',
      builder: (context) {
        return errorAnimationStory();
      },
    ),
    Story(
      name: 'Foundations/Animations/Alert',
      builder: (context) {
        return alertAnimationStory();
      },
    ),
  ];
}
