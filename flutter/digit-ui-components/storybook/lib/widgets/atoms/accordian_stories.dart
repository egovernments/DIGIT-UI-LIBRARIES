import 'package:digit_ui_components/widgets/atoms/accordion.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../../plugins/code_view_wrapper.dart';

List<Story> accordionStories() {
  return [
    Story(
      name: 'Atom/Accordion/default',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString(
            '''
CustomAccordion(
  items: [
    CustomAccordionItem(
      header: const Text('Panel 1'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 1'),
      ),
      initiallyExpanded: false,
    ),
    CustomAccordionItem(
      header: const Text('Panel 2'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 2'),
      ),
    ),
    CustomAccordionItem(
      header: const Text('Panel 3'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 3'),
      ),
    ),
  ],
  allowMultipleOpen: false,
  headerElevation: 0,
  animationDuration: const Duration(milliseconds: 500),
)
          ''',
          );
        });


        return CustomAccordion(
          items: [
            CustomAccordionItem(
              header: const Text('Panel 1'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1'),
              ),
              initiallyExpanded: false,
            ),
            CustomAccordionItem(
              header: const Text('Panel 2'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2'),
              ),
            ),
            CustomAccordionItem(
              header: const Text('Panel 3'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 3'),
              ),
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 500),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with default one open',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString(
            '''
CustomAccordion(
  items: [
    CustomAccordionItem(
      header: const Text('Panel 1'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 1'),
      ),
      initiallyExpanded: true,
    ),
    CustomAccordionItem(
      header: const Text('Panel 2'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 2'),
      ),
    ),
    CustomAccordionItem(
      header: const Text('Panel 3'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 3'),
      ),
    ),
  ],
  allowMultipleOpen: false,
  headerElevation: 0,
  animationDuration: Duration(milliseconds: 500),
)
          ''',
          );
        });


        return CustomAccordion(
          items: [
            CustomAccordionItem(
              header: const Text('Panel 1'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1'),
              ),
              initiallyExpanded: true,
            ),
            CustomAccordionItem(
              header: const Text('Panel 2'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2'),
              ),
            ),
            CustomAccordionItem(
              header: const Text('Panel 3'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 3'),
              ),
            ),
          ],
          allowMultipleOpen: false,
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 500),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with multiple open',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString(
            '''
CustomAccordion(
  allowMultipleOpen: true,
  items: [
    CustomAccordionItem(
      header: const Text('Panel 1'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 1'),
      ),
      initiallyExpanded: true,
    ),
    CustomAccordionItem(
      header: const Text('Panel 2'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 2'),
      ),
    ),
    CustomAccordionItem(
      header: const Text('Panel 3'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 3'),
      ),
    ),
  ],
  headerElevation: 0,
  animationDuration: Duration(milliseconds: 500),
)
          ''',
          );
        });


        return CustomAccordion(
          allowMultipleOpen: true,
          items: [
            CustomAccordionItem(
              header: const Text('Panel 1'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1'),
              ),
              initiallyExpanded: true,
            ),
            CustomAccordionItem(
              header: const Text('Panel 2'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2'),
              ),
            ),
            CustomAccordionItem(
              header: const Text('Panel 3'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 3'),
              ),
            ),
          ],
          headerElevation: 0,
          animationDuration: const Duration(milliseconds: 500),
        );
      },
    ),
    Story(
      name: 'Atom/Accordion/with shadow',
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CodeViewProvider.of(context)?.updateCodeString(
            '''
CustomAccordion(
  allowMultipleOpen: false,
  items: [
    CustomAccordionItem(
      header: const Text('Panel 1'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 1'),
      ),
      initiallyExpanded: true,
    ),
    CustomAccordionItem(
      header: const Text('Panel 2'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 2'),
      ),
    ),
    CustomAccordionItem(
      header: const Text('Panel 3'),
      content: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('This is the content of panel 3'),
      ),
    ),
  ],
  headerElevation: 2,
  animationDuration: Duration(milliseconds: 500),
)
          ''',
          );
        });


        return CustomAccordion(
          allowMultipleOpen: false,
          items: [
            CustomAccordionItem(
              header: const Text('Panel 1'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 1'),
              ),
              initiallyExpanded: true,
            ),
            CustomAccordionItem(
              header: const Text('Panel 2'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 2'),
              ),
            ),
            CustomAccordionItem(
              header: const Text('Panel 3'),
              content: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('This is the content of panel 3'),
              ),
            ),
          ],
          headerElevation: 2,
          animationDuration: const Duration(milliseconds: 500),
        );
      },
    ),
  ];
}
