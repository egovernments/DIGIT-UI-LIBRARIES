import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DigitTextFormInput Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    late FocusNode myFocusNode;

    // testing rendering the widget

    testWidgets('Renders the widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextFormInput(
              controller: controller,
            ),
          ),
        ),
      );

      // Ensure the label is rendered
      expect(find.text('Test Label'), findsOneWidget);
    });

    // testing validation and error message

    testWidgets('Validates input using provided validators on focus loss', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                DigitTextFormInput(
                  controller: controller,
                  validations: [
                    Validator(ValidatorType.pattern, r'^[a-zA-Z0-9]+$', errorMessage: 'Invalid format.'),
                  ],
                ),
                // Use a FlatButton to simulate taps
                ElevatedButton(
                  onPressed: () {
                    // This is where you can put any logic you want
                    FocusScope.of(tester.element(find.byType(DigitTextFormInput))).unfocus();
                  },
                  child: const Text('Tap me'),
                ),
              ],
            ),
          ),
        ),
      );

      // Simulate typing
      await tester.enterText(find.byType(DigitTextFormInput), '@@');
      await tester.pump();

      // Tap on the FlatButton to simulate focus loss
      await tester.tap(find.text('Tap me'));


      // Ensure all asynchronous operations are completed
      await tester.pumpAndSettle(); // Ensure all asynchronous operations are completed


      // Ensure the validation error is shown after the focus loss
      expect(find.text('Invalid format.'), findsOneWidget);
    });


    // testing readonly and is disabled states


    testWidgets('Handles readOnly and isDisabled states',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                DigitTextFormInput(
                  key: const Key('Editable Field'),
                  controller: controller,
                ),
                DigitTextFormInput(
                  key: const Key('ReadOnly Field'),
                  controller: controller,
                  readOnly: true,
                ),
                DigitTextFormInput(
                  key: const Key('Disabled Field'),
                  controller: controller,
                  isDisabled: true,
                ),
              ],
            ),
          ),
        ),
      );

      // Verify the editable field is enabled
      expect(
        tester
            .widget<DigitTextFormInput>(find.byKey(const Key('Editable Field')))
            .readOnly,
        isFalse,
      );
      expect(
        tester
            .widget<DigitTextFormInput>(find.byKey(const Key('Editable Field')))
            .isDisabled,
        isFalse,
      );

      // Verify the readOnly field is readOnly and not enabled
      expect(
        tester
            .widget<DigitTextFormInput>(find.byKey(const Key('ReadOnly Field')))
            .readOnly,
        isTrue,
      );
      expect(
        tester
            .widget<DigitTextFormInput>(find.byKey(const Key('ReadOnly Field')))
            .isDisabled,
        isFalse,
      );

      // Verify the disabled field is disabled and not enabled
      expect(
        tester
            .widget<DigitTextFormInput>(find.byKey(const Key('Disabled Field')))
            .readOnly,
        isFalse,
      );
      expect(
        tester
            .widget<DigitTextFormInput>(find.byKey(const Key('Disabled Field')))
            .isDisabled,
        isTrue,
      );
    });

    // testing tooltip behavior

    testWidgets('Handles tooltip behavior', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextFormInput(
              controller: controller,
            ),
          ),
        ),
      );

      // Verify the tooltip is not initially present
      expect(find.text('Info Tooltip'), findsNothing);

      // Trigger the tooltip with a long press (simulate hover)
      await tester.longPress(find.byIcon(Icons.info_outline));

      // Pump the widget tree to allow time for the tooltip to appear
      await tester.pump();

      // Verify the tooltip is now present
      expect(find.text('Info Tooltip'), findsOneWidget);
    });

    //Testing Char Count Display

    testWidgets('Displays character count if charCount is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextFormInput(
              controller: controller,
              charCount: true,
              initialValue: 'helloworld',
              validations: [
                Validator(ValidatorType.maxLength, 10,
                    errorMessage: 'Maximum length is 10.'),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify the updated character count is displayed (should be capped at 10)
      expect(find.text('10/10'), findsOneWidget);
    });


    testWidgets('Sets initial value correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextFormInput(
              controller: controller,
              initialValue: 'Initial',
            ),
          ),
        ),
      );

      // Verify the initial value is set
      expect(find.text('Initial'), findsOneWidget);
    });
  });
}
