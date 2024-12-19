import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DigitButton renders correctly and handles tap', (WidgetTester tester) async {
    // Primary DigitButton
    await _testDigitButton(tester, DigitButtonType.primary);

    // Secondary DigitButton
    await _testDigitButton(tester, DigitButtonType.secondary);

    // Tertiary DigitButton
    await _testDigitButton(tester, DigitButtonType.tertiary);

    // Link DigitButton
    await _testDigitButton(tester, DigitButtonType.link);
  });

  testWidgets('DigitButton is disabled and handles tap', (WidgetTester tester) async {
    // Primary DigitButton disabled
    await _testDisabledDigitButton(tester, DigitButtonType.primary);

    // Secondary DigitButton disabled
    await _testDisabledDigitButton(tester, DigitButtonType.secondary);

    // Tertiary DigitButton disabled
    await _testDisabledDigitButton(tester, DigitButtonType.tertiary);

    // Link DigitButton disabled
    await _testDisabledDigitButton(tester, DigitButtonType.link);
  });
}

Future<void> _testDigitButton(WidgetTester tester, DigitButtonType DigitButtonType) async {
  bool onPressedCalled = false;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DigitButton(
          size: DigitButtonSize.large,
          label: 'Click me',
          onPressed: () {
            onPressedCalled = true;
          },
          type: DigitButtonType,
        ),
      ),
    ),
  );

  expect(find.text('Click me'), findsOneWidget);
  expect(tester.widget<DigitButton>(find.byType(DigitButton)).isDisabled, false);

  await tester.tap(find.byType(DigitButton));
  await tester.pump();

  expect(onPressedCalled, true);
}

Future<void> _testDisabledDigitButton(WidgetTester tester, DigitButtonType DigitButtonType) async {
  bool onPressedCalled = false;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: DigitButton(
          size: DigitButtonSize.large,
          label: 'Click me',
          onPressed: () {
            onPressedCalled = true;
          },
          type: DigitButtonType,
          isDisabled: true,
        ),
      ),
    ),
  );

  expect(find.text('Click me'), findsOneWidget);
  expect(tester.widget<DigitButton>(find.byType(DigitButton)).isDisabled, true);

  await tester.tap(find.byType(DigitButton));
  await tester.pump();

  expect(onPressedCalled, false);
}
