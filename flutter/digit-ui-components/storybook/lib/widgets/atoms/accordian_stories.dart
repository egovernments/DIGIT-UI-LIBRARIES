import 'package:digit_ui_components/widgets/atoms/accordion.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';


List<Story> accordionStories() {
  return [
    Story(
      name: 'Atom/Accordion/default',
      builder: (context) {

        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: const Text('Panel 1'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1'),
              ),
              initiallyExpanded: false,
            ),
            DigitAccordionItem(
              header: const Text('Panel 2'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2'),
              ),
            ),
            DigitAccordionItem(
              header: const Text('Panel 3'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 3'),
              ),
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with default one open',
      builder: (context) {

        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: const Text('Panel 1'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1'),
              ),
              initiallyExpanded: true,
            ),
            DigitAccordionItem(
              header: const Text('Panel 2'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2'),
              ),
            ),
            DigitAccordionItem(
              header: const Text('Panel 3'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 3'),
              ),
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with multiple open',
      builder: (context) {

        return DigitAccordion(
          allowMultipleOpen: true,
          items: [
            DigitAccordionItem(
              header: const Text('Panel 1'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1'),
              ),
              initiallyExpanded: true,
            ),
            DigitAccordionItem(
              header: const Text('Panel 2'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2'),
              ),
            ),
            DigitAccordionItem(
              header: const Text('Panel 3'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 3'),
              ),
            ),
          ],
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with shadow',
      builder: (context) {

        return DigitAccordion(
          allowMultipleOpen: false,
          items: [
            DigitAccordionItem(
              header: const Text('Panel 1'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1'),
              ),
              initiallyExpanded: true,
            ),
            DigitAccordionItem(
              header: const Text('Panel 2'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2'),
              ),
            ),
            DigitAccordionItem(
              header: const Text('Panel 3'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 3'),
              ),
            ),
          ],
          headerElevation: 2,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with icons',
      builder: (context) {

        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: const Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  SizedBox(width: 8),
                  Text('Panel 1 with Icon'),
                ],
              ),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1 with an icon.'),
              ),
            ),
            DigitAccordionItem(
              header: const Row(
                children: [
                  Icon(Icons.link, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Panel 2 with Icon'),
                ],
              ),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2 with an icon.'),
              ),
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),

    Story(
      name: 'Atom/Accordion/nested accordion',
      builder: (context) {

        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: const Text('Outer Panel 1'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DigitAccordion(
                  items: [
                    DigitAccordionItem(
                      header: const Text('Inner Panel 1'),
                      content: const Text('This is the content of inner panel 1'),
                    ),
                    DigitAccordionItem(
                      header: const Text('Inner Panel 2'),
                      content: const Text('This is the content of inner panel 2'),
                    ),
                  ],
                  allowMultipleOpen: true,
                ),
              ),
            ),
            DigitAccordionItem(
              header: const Text('Outer Panel 2'),
              content: const Text('This is the content of outer panel 2'),
            ),
          ],
          allowMultipleOpen: true,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with different content types',
      builder: (context) {

        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: const Text('Panel with Image'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            DigitAccordionItem(
              header: const Text('Panel with Buttons'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Button 1'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Button 2'),
                    ),
                  ],
                ),
              ),
            ),
          ],
          allowMultipleOpen: true,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),

    Story(
      name: 'Atom/Accordion/with long content',
      builder: (context) {

        return DigitAccordion(
          items: [
            DigitAccordionItem(
              header: const Text('Panel with Long Content'),
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'This is a very long content. ' * 50,
                ),
              ),
            ),
          ],
          allowMultipleOpen: true,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 200),
        );
      },
    ),
  ];
}