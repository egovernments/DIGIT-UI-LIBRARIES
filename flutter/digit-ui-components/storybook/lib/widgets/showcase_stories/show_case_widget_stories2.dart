import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/widgets/atoms/digit_chip.dart';
import 'package:digit_ui_components/widgets/atoms/upload_drag.dart';
import 'package:flutter/material.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'package:digit_ui_components/widgets/showcase/showcase_widget.dart';
import 'package:digit_ui_components/widgets/showcase/showcase_1.dart';

List<Story> showcaseStories2() {
  return [
    Story(
      name: 'ShowcaseExample',
      builder: (context) {
        // Wrap the ShowcaseExample widget in ShowcaseWidget
        return ShowcaseWidget(
          builder: Builder(
            builder: (context) {
              return ShowcaseExample(); // This renders the ShowcaseExample widget
            },
          ),
        );
      },
    ),
    Story(
      name: 'ShowcaseExample2',
      builder: (context) {
        // Wrap the ShowcaseExample widget in ShowcaseWidget
        return ShowcaseWidget(
          builder: Builder(
            builder: (context) {
              return ShowcaseExample2(); // This renders the ShowcaseExample widget
            },
          ),
        );
      },
    ),
  ];
}

class ShowcaseExample extends StatefulWidget {
  @override
  _ShowcaseExampleState createState() => _ShowcaseExampleState();
}

class _ShowcaseExampleState extends State<ShowcaseExample> {
  GlobalKey one = GlobalKey();
  GlobalKey two = GlobalKey();
  GlobalKey three = GlobalKey();
  GlobalKey four = GlobalKey();
  GlobalKey five = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Schedule the showcase after the first frame has been rendered and give a slight delay to ensure layout is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (mounted) {
          // Start the showcase only if ShowcaseWidget context is available
          ShowcaseWidget.of(context)
              ?.startShowCase([one, two, three, four, five]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Showcase(
          key: one,
          disableMovingAnimation: true,
          disableScaleAnimation: true,
          title: 'Submit Button',
          description: 'This button allows you to submit a form.',
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DigitButton(
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
              onPressed: () {},
              label: 'Submit',
            ),
          ),
        ),
        Showcase(
            key: two,
            disableMovingAnimation: true,
            disableScaleAnimation: true,
            title: 'Search Field',
            description:
                'This is a text field where users can search for items.',
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: DigitSearchFormInput(),
            )),
        Showcase(
            key: three,
            disableMovingAnimation: true,
            disableScaleAnimation: true,
            title: 'Information Card',
            description:
                'This card displays additional information about the product or service.',
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: InfoCard(
                title: 'Info Card',
                type: InfoType.info,
                description:
                    'This is an information card. It is used to display additional information about the product or service.',
              ),
            )),
        Showcase(
          key: four,
          disableMovingAnimation: true,
          disableScaleAnimation: true,
          title: 'Chip',
          description: 'This is a chip component.',
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DigitChip(
              label: 'Chip Label',
              onItemDelete: () {},
            ),
          ),
        ),
        Showcase(
            key: five,
            disableMovingAnimation: true,
            disableScaleAnimation: true,
            title: 'File Upload',
            description:
                'This is file upload widget where users can upload files.',
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FileUploadWidget2(
                label: 'Upload',
                onFilesSelected: (file) {
                  return {};
                },
              ),
            )),
      ],
    );
  }
}

class ShowcaseExample2 extends StatefulWidget {
  @override
  _ShowcaseExample2State createState() => _ShowcaseExample2State();
}

class _ShowcaseExample2State extends State<ShowcaseExample2> {
  GlobalKey one = GlobalKey();
  GlobalKey two = GlobalKey();
  GlobalKey three = GlobalKey();
  GlobalKey four = GlobalKey();
  GlobalKey five = GlobalKey();
  GlobalKey six = GlobalKey();
  GlobalKey seven = GlobalKey();
  GlobalKey eight = GlobalKey();
  GlobalKey nine = GlobalKey();
  GlobalKey ten = GlobalKey();
  GlobalKey eleven = GlobalKey();
  GlobalKey twelve = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Schedule the showcase after the first frame has been rendered and give a slight delay to ensure layout is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 100), () {
        if (mounted) {
          // Start the showcase only if ShowcaseWidget context is available
          ShowcaseWidget.of(context)?.startShowCase([
            one,
            two,
            three,
            four,
            five,
            six,
            seven,
            eight,
            nine,
            ten,
            eleven,
            twelve
          ]);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Showcase(
            key: one,
            disableMovingAnimation: true,
            disableScaleAnimation: true,
            title: 'Submit Button',
            description: 'This button allows you to submit a form.',
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DigitButton(
                type: DigitButtonType.primary,
                size: DigitButtonSize.large,
                onPressed: () {},
                label: 'Submit',
              ),
            ),
          ),
          Showcase(
              key: two,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Search Field',
              description:
                  'This is a text field where users can search for items.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: DigitSearchFormInput(),
              ),),
          Showcase(
              key: three,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Information Card',
              description:
                  'This card displays additional information about the product or service.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: InfoCard(
                  title: 'Info Card',
                  type: InfoType.info,
                  description:
                      'This is an information card. It is used to display additional information about the product or service.',
                ),
              )),
          Showcase(
            key: four,
            disableMovingAnimation: true,
            disableScaleAnimation: true,
            title: 'Chip',
            description: 'This is a chip component.',
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: DigitChip(
                label: 'Chip Label',
                onItemDelete: () {},
              ),
            ),
          ),
          Showcase(
              key: five,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'File Upload',
              description:
                  'This is file upload widget where users can upload files.',
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FileUploadWidget2(
                  label: 'Upload',
                  onFilesSelected: (file) {
                    return {};
                  },
                ),
              )),
          Showcase(
              key: six,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Information Card',
              description:
                  'This card displays additional information about the product or service.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: InfoCard(
                  title: 'Info Card',
                  type: InfoType.info,
                  description:
                      'This is an information card. It is used to display additional information about the product or service.',
                ),
              )),
          Showcase(
              key: seven,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Information Card',
              description:
                  'This card displays additional information about the product or service.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: InfoCard(
                  title: 'Info Card',
                  type: InfoType.info,
                  description:
                      'This is an information card. It is used to display additional information about the product or service.',
                ),
              )),
          Showcase(
              key: eight,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Information Card',
              description:
                  'This card displays additional information about the product or service.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: InfoCard(
                  title: 'Info Card',
                  type: InfoType.info,
                  description:
                      'This is an information card. It is used to display additional information about the product or service.',
                ),
              )),
          Showcase(
              key: nine,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Information Card',
              description:
                  'This card displays additional information about the product or service.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: InfoCard(
                  title: 'Info Card',
                  type: InfoType.info,
                  description:
                      'This is an information card. It is used to display additional information about the product or service.',
                ),
              )),
          Showcase(
              key: ten,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Information Card',
              description:
                  'This card displays additional information about the product or service.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: InfoCard(
                  title: 'Info Card',
                  type: InfoType.info,
                  description:
                      'This is an information card. It is used to display additional information about the product or service.',
                ),
              )),
          Showcase(
              key: eleven,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Information Card',
              description:
                  'This card displays additional information about the product or service.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: InfoCard(
                  title: 'Info Card',
                  type: InfoType.info,
                  description:
                      'This is an information card. It is used to display additional information about the product or service.',
                ),
              )),
          Showcase(
              key: twelve,
              disableMovingAnimation: true,
              disableScaleAnimation: true,
              title: 'Information Card',
              description:
                  'This card displays additional information about the product or service.',
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: InfoCard(
                  title: 'Info Card',
                  type: InfoType.info,
                  description:
                      'This is an information card. It is used to display additional information about the product or service.',
                ),
              )),
        ],
      ),
    );
  }
}
