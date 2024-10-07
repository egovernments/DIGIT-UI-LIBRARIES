import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/molecules/digit_slider.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> sliderStories() {
  return [
    // Basic Toggle Use Case
    Story(
      name: 'Molecule/Side Menu Slider/default right',
      builder: (context) => SlideOverMenu(
        expandedContentAlignment: MainAxisAlignment.spaceBetween,
        expandedFooter: Column(
          children: [
            DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large, mainAxisSize: MainAxisSize.max,)
          ],
        ),
        sections: [
          Section(
            expandedContent: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            expandedContent: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            expandedContent: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Side Menu Slider/left',
      builder: (context) => SlideOverMenu(
       isLeft: true,
        expandedContentAlignment: MainAxisAlignment.spaceBetween,
        expandedFooter: Column(
          children: [
            DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large, mainAxisSize: MainAxisSize.max,)
          ],
        ),
        sections: [
          Section(
            expandedContent: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            expandedContent: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            expandedContent: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Side Menu Slider/Basic Toggle Slider with different content',
      builder: (context) => SlideOverMenu(
        collapsedHeader: const Row(
          children: [
            Icon(Icons.settings),
          ],
        ),
        expandedHeader: const Row(
          children: [
            Text('Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        expandedFooter: Column(
          children: [
            DigitButton(
              label: 'Save Changes',
              mainAxisSize: MainAxisSize.max,
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
            ),
            const SizedBox(height: 16,),
            DigitButton(
              label: 'Cancel',
              mainAxisSize: MainAxisSize.max,
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large,
            ),
          ],
        ),
        sections: [
          Section(
            collapsedContent: [
              const Icon(Icons.security),
            ],
            expandedContent: [
              Text('Two-Factor Authentication: Enabled'),
              Text('Password Last Changed: 2 months ago'),
            ],
          ),
          Section(
            collapsedContent: [
              const Icon(Icons.privacy_tip),
            ],
            expandedContent: [
              Text('Public Profile: Disabled'),
              Text('Ad Preferences: Personalized'),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Side Menu Slider/Basic Toggle Slider with different content(left)',
      builder: (context) => SlideOverMenu(
        isLeft: true,
        collapsedHeader: const Row(
          children: [
            Icon(Icons.settings),
          ],
        ),
        expandedHeader: const Row(
          children: [
            Text('Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        expandedFooter: Column(
          children: [
            DigitButton(
              label: 'Save Changes',
              mainAxisSize: MainAxisSize.max,
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
            ),
            const SizedBox(height: 16,),
            DigitButton(
              label: 'Cancel',
              mainAxisSize: MainAxisSize.max,
              onPressed: () {},
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large,
            ),
          ],
        ),
        sections: [
          Section(
            collapsedContent: [
              const Icon(Icons.security),
            ],
            expandedContent: [
              Text('Two-Factor Authentication: Enabled'),
              Text('Password Last Changed: 2 months ago'),
            ],
          ),
          Section(
            collapsedContent: [
              const Icon(Icons.privacy_tip),
            ],
            expandedContent: [
              Text('Public Profile: Disabled'),
              Text('Ad Preferences: Personalized'),
            ],
          ),
        ],
      ),
    ),

    Story(
      name: 'Molecule/Side Menu Slider/Basic Toggle Slider with different content and cross button',
      builder: (context) => SlideOverMenu(
        onCrossTap: (){},
        expandedHeader: Row(
          children: [
            Text('Header Content',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        expandedFooter: Column(
          children: [
            DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large, mainAxisSize: MainAxisSize.max,)
          ],
        ),
        sections: [
          Section(
            collapsedContent: [const Icon(Icons.first_page)],
            expandedContent: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            collapsedContent: [const Icon(Icons.first_page)],
            expandedContent: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            collapsedContent: [const Icon(Icons.first_page)],
            expandedContent: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Side Menu Slider/Basic Toggle Slider with different content and cross button(left)',
      builder: (context) => SlideOverMenu(
        onCrossTap: (){},
        isLeft: true,
        expandedHeader: const Row(
          children: [
            Text('Header Content',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        expandedFooter: Column(
          children: [
            DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large, mainAxisSize: MainAxisSize.max,)
          ],
        ),
        sections: [
          Section(
            collapsedContent: [const Icon(Icons.first_page)],
            expandedContent: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            collapsedContent: [const Icon(Icons.first_page)],
            expandedContent: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            collapsedContent: [const Icon(Icons.first_page)],
            expandedContent: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
      ),
    ),

    // Combined Open and Close Buttons
    Story(
      name: 'Molecule/Side Menu Slider/Combined Open and Close Buttons',
      builder: (context) => CombinedSliderExample(),
    ),
    Story(
      name: 'Molecule/Side Menu Slider/custom width',
      builder: (context) => SlideOverMenu(
        expandedWidth: 600,
        expandedContentAlignment: MainAxisAlignment.spaceBetween,
        expandedFooter: Column(
          children: [
            DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large, mainAxisSize: MainAxisSize.max,)
          ],
        ),
        sections: [
          Section(
            expandedContent: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            expandedContent: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            expandedContent: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
      ),
    ),
    Story(
      name: 'Molecule/Side Menu Slider/custom width (left)',
      builder: (context) => SlideOverMenu(
        isLeft: true,
        expandedWidth: 600,
        expandedContentAlignment: MainAxisAlignment.spaceBetween,
        expandedFooter: Column(
          children: [
            DigitButton(label: 'Action', onPressed: (){}, type: DigitButtonType.secondary, size: DigitButtonSize.large, mainAxisSize: MainAxisSize.max,)
          ],
        ),
        sections: [
          Section(
            expandedContent: [
              Text('Item 1.1'),
              Text('Item 1.2'),
              Text('Item 1.3'),
            ],
          ),
          Section(
            expandedContent: [
              Text('Item 2.1'),
              Text('Item 2.2'),
            ],
          ),
          Section(
            expandedContent: [
              Text('Item 3.1'),
              Text('Item 3.2'),
              Text('Item 3.3'),
            ],
          ),
        ],
      ),
    ),
  ];
}


// Combined Slider Example
class CombinedSliderExample extends StatefulWidget {
  @override
  _CombinedSliderExampleState createState() => _CombinedSliderExampleState();
}

class _CombinedSliderExampleState extends State<CombinedSliderExample> {
  final GlobalKey<SlideOverMenuState> _sliderKey =
      GlobalKey<SlideOverMenuState>();

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
        SlideOverMenu(
          skipCollapsedState: true,
          height: 800,
          key: _sliderKey,
          expandedHeader: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Header Content',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          expandedFooter: Padding(
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
              collapsedContent: [const Icon(Icons.first_page)],
              expandedContent: [
                Text('Item 1.1'),
                Text('Item 1.2'),
                Text('Item 1.3'),
              ],
            ),
            Section(
              collapsedContent: [const Icon(Icons.first_page)],
              expandedContent: [
                Text('Item 2.1'),
                Text('Item 2.2'),
              ],
            ),
            Section(
              collapsedContent: [const Icon(Icons.first_page)],
              expandedContent: [
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

