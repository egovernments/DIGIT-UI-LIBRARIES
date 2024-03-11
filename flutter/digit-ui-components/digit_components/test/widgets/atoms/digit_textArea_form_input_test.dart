import 'package:digit_flutter_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DigitTextFormInput Tests', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    testWidgets('Renders without error', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextAreaFormInput(
              controller: TextEditingController(),
            ),
          ),
        ),
      );

      expect(find.byType(DigitTextAreaFormInput), findsOneWidget);
    });

    testWidgets('Displays the specified number of lines', (WidgetTester tester) async {
      const int minLines = 4;
      const int maxLines = 8;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextAreaFormInput(
              controller: TextEditingController(),
              maxLine: maxLines,
            ),
          ),
        ),
      );

      final textField = tester.widget<DigitTextAreaFormInput>(find.byType(DigitTextAreaFormInput));
      expect(textField.minLine, minLines);
      expect(textField.maxLine, maxLines);
    });

    testWidgets('Updates value on text input', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextAreaFormInput(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(DigitTextAreaFormInput), 'newTextAreaText');
      expect(controller.text, 'newTextAreaText');
    });

    testWidgets('Handles readOnly state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextAreaFormInput(
              controller: TextEditingController(),
              readOnly: true,
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(DigitTextAreaFormInput), 'newTextAreaText');
      expect(controller.text, '');
    });

    testWidgets('Handles disabled state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextAreaFormInput(
              controller: TextEditingController(),
              isDisabled: true,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(DigitTextAreaFormInput), 'newTextAreaText');
      expect(controller.text, '');
    });

    testWidgets('Displays help text', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextAreaFormInput(
              controller: controller,
              helpText: 'Enter text',
            ),
          ),
        ),
      );

      await tester.pump();

      // Perform assertions based on help text
      expect(find.text('Enter text'), findsOneWidget);

    });

    testWidgets('Handles char count properly', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextAreaFormInput(
              controller: controller,
              charCount: true,
            ),
          ),
        ),
      );

      // Trigger validation by losing focus
      await tester.tap(find.byType(TextFormField));
      await tester.pump();

      // Perform assertions based on char count display
      expect(find.text('0/64'), findsOneWidget);

    });

    testWidgets('Updates value on text input', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitTextAreaFormInput(
              controller: controller,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(DigitTextAreaFormInput), 'newTextAreaText');
      expect(controller.text, 'newTextAreaText');
    });

  });
}
