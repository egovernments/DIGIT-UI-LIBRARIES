import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_slider.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> sliderStories() {
  return [
    // Basic Toggle Use Case
    Story(
      name: 'Basic Toggle Slider',
      builder: (context) => RightSideSlider(
        expandedContentAlignment: MainAxisAlignment.spaceBetween,
        footer: Column(
          children: [
            DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large, mainAxisSize: MainAxisSize.max,)
          ],
        ),
        sections: [
          Section(
            content: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            content: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            content: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
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
        footer: Column(
          children: [
            DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large, mainAxisSize: MainAxisSize.max,)
          ],
        ),
        sections: [
          Section(
            content: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            content: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            content: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
      ),
    ),

    // External Button to Open the Slider
    Story(
      name: 'External Button to Open Slider',
      builder: (context) => ExternalButtonSliderExample(),
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
      mainAxisSize: MainAxisSize.max,
      children: [
        ElevatedButton(
          onPressed: openSlider,
          child: Text("Open Slider"),
        ),
        RightSideSlider(
          key: _sliderKey,
          height: 600,
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Header Content',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              content: [
                Text('Item 1.1'),
                Text('Item 1.2'),
                Text('Item 1.3'),
              ],
            ),
            Section(
              content: [
                Text('Item 2.1'),
                Text('Item 2.2'),
              ],
            ),
            Section(
              content: [
                Text('Item 3.1'),
                Text('Item 3.2'),
                Text('Item 3.3'),
              ],
            ),
          ],
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
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            _sliderKey.currentState?.toggleSlider();
          },
          child: const Icon(Icons.menu),
        ),
        RightSideSlider(
          skipCollapsedState: true,
          height: 800,
          key: _sliderKey,
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Header Content',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              content: [
                Text('Item 1.1'),
                Text('Item 1.2'),
                Text('Item 1.3'),
              ],
            ),
            Section(
              content: [
                Text('Item 2.1'),
                Text('Item 2.2'),
              ],
            ),
            Section(
              content: [
                Text('Item 3.1'),
                Text('Item 3.2'),
                Text('Item 3.3'),
              ],
            ),
          ],
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
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Header Content',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              content: [
                Text('Item 1.1'),
                Text('Item 1.2'),
                Text('Item 1.3'),
              ],
            ),
            Section(
              content: [
                Text('Item 2.1'),
                Text('Item 2.2'),
              ],
            ),
            Section(
              content: [
                Text('Item 3.1'),
                Text('Item 3.2'),
                Text('Item 3.3'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
