import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Button renders correctly and handles tap', (WidgetTester tester) async {
    // Primary button
    await _testButton(tester, ButtonType.primary);

    // Secondary button
    await _testButton(tester, ButtonType.secondary);

    // Tertiary button
    await _testButton(tester, ButtonType.tertiary);

    // Link button
    await _testButton(tester, ButtonType.link);
  });

  testWidgets('Button is disabled and handles tap', (WidgetTester tester) async {
    // Primary button disabled
    await _testDisabledButton(tester, ButtonType.primary);

    // Secondary button disabled
    await _testDisabledButton(tester, ButtonType.secondary);

    // Tertiary button disabled
    await _testDisabledButton(tester, ButtonType.tertiary);

    // Link button disabled
    await _testDisabledButton(tester, ButtonType.link);
  });
}

Future<void> _testButton(WidgetTester tester, ButtonType buttonType) async {
  bool onPressedCalled = false;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Button(
          size: ButtonSize.large,
          label: 'Click me',
          onPressed: () {
            onPressedCalled = true;
          },
          type: buttonType,
        ),
      ),
    ),
  );

  expect(find.text('Click me'), findsOneWidget);
  expect(tester.widget<Button>(find.byType(Button)).isDisabled, false);

  await tester.tap(find.byType(Button));
  await tester.pump();

  expect(onPressedCalled, true);
}

Future<void> _testDisabledButton(WidgetTester tester, ButtonType buttonType) async {
  bool onPressedCalled = false;

  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Button(
          size: ButtonSize.large,
          label: 'Click me',
          onPressed: () {
            onPressedCalled = true;
          },
          type: buttonType,
          isDisabled: true,
        ),
      ),
    ),
  );

  expect(find.text('Click me'), findsOneWidget);
  expect(tester.widget<Button>(find.byType(Button)).isDisabled, true);

  await tester.tap(find.byType(Button));
  await tester.pump();

  expect(onPressedCalled, false);
}
