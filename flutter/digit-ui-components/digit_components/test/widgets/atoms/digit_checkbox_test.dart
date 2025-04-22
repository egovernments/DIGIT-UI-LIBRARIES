import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DigitCheckbox should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitCheckbox(
            label: 'Accept terms',
            onChanged: (value) {},
          ),
        ),
      ),
    );

    expect(find.text('Accept terms'), findsOneWidget);
    expect(find.byType(DigitCheckboxIcon), findsOneWidget);
  });

  testWidgets('DigitCheckbox should toggle state on tap', (WidgetTester tester) async {
    bool isChecked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitCheckbox(
            label: 'Enable Feature',
            value: isChecked,
            onChanged: (value) {
              isChecked = value;
            },
          ),
        ),
      ),
    );

    final checkboxFinder = find.byType(DigitCheckboxIcon);

    // Initial state should be unchecked
    expect(isChecked, isFalse);

    // Tap the checkbox
    await tester.tap(checkboxFinder);
    await tester.pump();

    // Ensure state is updated
    expect(isChecked, isTrue);
  });

  testWidgets('DigitCheckbox should not be toggled when disabled', (WidgetTester tester) async {
    bool isChecked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitCheckbox(
            label: 'Disabled Checkbox',
            value: isChecked,
            onChanged: (value) {
              isChecked = value;
            },
            isDisabled: true,
          ),
        ),
      ),
    );

    final checkboxFinder = find.byType(DigitCheckboxIcon);

    // Tap the checkbox (should not change state)
    await tester.tap(checkboxFinder);
    await tester.pump();

    // Ensure state is still unchanged
    expect(isChecked, isFalse);
  });

  testWidgets('DigitCheckbox should not be toggled when readOnly', (WidgetTester tester) async {
    bool isChecked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitCheckbox(
            label: 'ReadOnly Checkbox',
            value: isChecked,
            onChanged: (value) {
              isChecked = value;
            },
            readOnly: true,
          ),
        ),
      ),
    );

    final checkboxFinder = find.byType(DigitCheckboxIcon);

    // Tap the checkbox (should not change state)
    await tester.tap(checkboxFinder);
    await tester.pump();

    // Ensure state is still unchanged
    expect(isChecked, isFalse);
  });

  testWidgets('DigitCheckbox should display the correct label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitCheckbox(
            label: 'Checkbox label test',
            onChanged: (value) {},
          ),
        ),
      ),
    );

    expect(find.text('Checkbox label test'), findsOneWidget);
  });

  testWidgets('DigitCheckbox should have correct semantics', (WidgetTester tester) async {
    final semanticsHandle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitCheckbox(
            label: 'Accessible checkbox',
            semanticLabel: 'Custom semantic label',
            onChanged: (value) {},
          ),
        ),
      ),
    );

    // Check if the semantics label is properly applied
    expect(find.bySemanticsLabel('Custom semantic label'), findsOneWidget);

    semanticsHandle.dispose();
  });
}
