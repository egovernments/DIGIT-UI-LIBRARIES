import 'package:digit_ui_components/widgets/molecules/digit_slider.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> sliderStories() {
  return [
    // Basic Toggle Use Case
    Story(
      name: 'Basic Toggle Slider',
      builder: (context) => RightSideSlider(
        expandedContent: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Expanded Content"),
            ElevatedButton(
              onPressed: () {
                print("Action triggered!");
              },
              child: Text("Trigger Action"),
            ),
          ],
        ),
      ),
    ),
    Story(
      name: 'Basic Toggle Slider with different content',
      builder: (context) => RightSideSlider(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Header Content',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        footer: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Footer Content',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ),
        sections: [
          Section(
            title: 'Section 1',
            content: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            title: 'Section 2',
            content: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            title: 'Section 3',
            content: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
        expandedContent: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Expanded Content"),
            ElevatedButton(
              onPressed: () {
                print("Action triggered!");
              },
              child: Text("Trigger Action"),
            ),
          ],
        ),
      ),
    ),

    // External Button to Open the Slider
    Story(
      name: 'External Button to Open Slider',
      builder: (context) => ExternalButtonSliderExample(),
    ),

    // Button to Close the Slider
    Story(
      name: 'Close Button Slider Example',
      builder: (context) => CloseButtonSliderExample(),
    ),

    // Combined Open and Close Buttons
    Story(
      name: 'Combined Open and Close Buttons',
      builder: (context) => CombinedSliderExample(),
    ),

    // Dynamic Content in Expanded State
    Story(
      name: 'Dynamic Content in Expanded State',
      builder: (context) => DynamicContentSliderExample(),
    ),
  ];
}

// External Button Slider Example
class ExternalButtonSliderExample extends StatefulWidget {
  @override
  _ExternalButtonSliderExampleState createState() =>
      _ExternalButtonSliderExampleState();
}

class _ExternalButtonSliderExampleState
    extends State<ExternalButtonSliderExample> {
  final GlobalKey<RightSideSliderState> _sliderKey =
      GlobalKey<RightSideSliderState>();

  void openSlider() {
    _sliderKey.currentState?.openSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: openSlider,
          child: Text("Open Slider"),
        ),
        RightSideSlider(
          key: _sliderKey,
          expandedContent: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Expanded Content"),
              ElevatedButton(
                onPressed: () {
                  print("Action triggered!");
                },
                child: Text("Trigger Action"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Close Button Slider Example
class CloseButtonSliderExample extends StatefulWidget {
  @override
  _CloseButtonSliderExampleState createState() =>
      _CloseButtonSliderExampleState();
}

class _CloseButtonSliderExampleState extends State<CloseButtonSliderExample> {
  final GlobalKey<RightSideSliderState> _sliderKey =
      GlobalKey<RightSideSliderState>();

  void closeSlider() {
    _sliderKey.currentState?.closeSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RightSideSlider(
          key: _sliderKey,
          expandedContent: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Expanded Content"),
              ElevatedButton(
                onPressed: closeSlider,
                child: Text("Close Slider"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Combined Slider Example
class CombinedSliderExample extends StatefulWidget {
  @override
  _CombinedSliderExampleState createState() => _CombinedSliderExampleState();
}

class _CombinedSliderExampleState extends State<CombinedSliderExample> {
  final GlobalKey<RightSideSliderState> _sliderKey =
      GlobalKey<RightSideSliderState>();

  void openSlider() {
    _sliderKey.currentState?.openSlider();
  }

  void closeSlider() {
    _sliderKey.currentState?.closeSlider();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: openSlider,
          child: Text("Open Slider"),
        ),
        ElevatedButton(
          onPressed: closeSlider,
          child: Text("Close Slider"),
        ),
        RightSideSlider(
          key: _sliderKey,
          expandedContent: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Expanded Content"),
              ElevatedButton(
                onPressed: () {
                  print("Action triggered!");
                },
                child: Text("Trigger Action"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Dynamic Content Slider Example
class DynamicContentSliderExample extends StatefulWidget {
  @override
  _DynamicContentSliderExampleState createState() =>
      _DynamicContentSliderExampleState();
}

class _DynamicContentSliderExampleState
    extends State<DynamicContentSliderExample> {
  final GlobalKey<RightSideSliderState> _sliderKey =
      GlobalKey<RightSideSliderState>();
  String _content = "Initial Content";

  void changeContent() {
    setState(() {
      _content = "New Dynamic Content";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            _sliderKey.currentState?.openSlider();
          },
          child: Text("Open Slider"),
        ),
        ElevatedButton(
          onPressed: changeContent,
          child: Text("Change Content"),
        ),
        RightSideSlider(
          key: _sliderKey,
          expandedContent: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_content),
              ElevatedButton(
                onPressed: () {
                  print("Action triggered!");
                },
                child: Text("Trigger Action"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
