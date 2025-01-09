import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/models/RadioButtonModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RadioList Widget Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RadioList(
              radioDigitButtons: [
                RadioButtonModel(code: 'A', name: 'Option A'),
                RadioButtonModel(code: 'B', name: 'Option B'),
              ],
              onChanged: (selectedValue) {},
            ),
          ),
        ),

      );

      // Verify that the widget renders correctly
      expect(find.text('Option A'), findsOneWidget);
      expect(find.text('Option B'), findsOneWidget);
    });

    testWidgets('Selecting a radio DigitButton triggers onChanged callback', (WidgetTester tester) async {
      String selectedValue = '';

      // Build our widget and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RadioList(
              radioDigitButtons: [
                RadioButtonModel(code: 'A', name: 'Option A'),
                RadioButtonModel(code: 'B', name: 'Option B'),
              ], onChanged: (value) {},
            ),
          ),
        ),

      );

      // Tap on the first radio DigitButton
      await tester.tap(find.text('Option A'));
      await tester.pump();

      // Verify that the onChanged callback is called with the correct value
      expect(selectedValue, 'A');
    });

    testWidgets('Radio DigitButtons are disabled when isDisabled is true', (WidgetTester tester) async {
      // Build our widget with isDisabled set to true
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RadioList(
              radioDigitButtons: [
                RadioButtonModel(code: 'A', name: 'Option A'),
                RadioButtonModel(code: 'B', name: 'Option B'),
              ],
              onChanged: (selectedValue) {},
              isDisabled: true,
            ),
          ),
        ),
      );

      // Verify that the radio DigitButtons are disabled and selected value doesn't change
      await tester.tap(find.text('Option A'));
      await tester.pump();
      expect(tester.widget<RadioList>(find.byType(RadioList)).groupValue, ''); // No change in selected value
    });

    testWidgets('Radio DigitButtons are enabled when isDisabled is false', (WidgetTester tester) async {
      // Build our widget with isDisabled set to false
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RadioList(
              radioDigitButtons: [
                RadioButtonModel(code: 'A', name: 'Option A'),
                RadioButtonModel(code: 'B', name: 'Option B'),
              ],
              onChanged: (selectedValue) {},
              isDisabled: false,
            ),
          ),
        ),
      );

      // Verify that the radio DigitButtons are enabled and selected value changes
      await tester.tap(find.text('Option A'));
      await tester.pump();
      expect(tester.widget<RadioList>(find.byType(RadioList)).groupValue, 'A'); // Change in selected value
    });

  });
}
