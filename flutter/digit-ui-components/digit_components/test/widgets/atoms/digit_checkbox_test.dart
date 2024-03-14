import 'package:digit_flutter_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Checkbox Widget Tests', () {
    testWidgets('Checkbox should render with initial state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Checkbox(
              label: 'Test Checkbox',
              onChanged: (value) {},
            ),
          ),
        ),
      );

      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.byType(CheckboxIcon), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('Checkbox should change state on tap', (WidgetTester tester) async {
      bool isChecked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Checkbox(
              label: 'Test Checkbox',
              value: isChecked,
              onChanged: (value) {
                isChecked = value ?? false;
              },
            ),
          ),
        ),
      );

      expect(find.byType(CheckboxIcon), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(find.byType(CheckboxIcon), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(isChecked, true);
    });

    testWidgets('Checkbox should be disabled and not change state on tap', (WidgetTester tester) async {
      bool isChecked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Checkbox(
              label: 'Test Checkbox',
              value: isChecked,
              onChanged: (value) {
                isChecked = value ?? false;
              },
              disabled: true,
            ),
          ),
        ),
      );

      expect(find.byType(CheckboxIcon), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(find.byType(CheckboxIcon), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
      expect(isChecked, false);
    });

    testWidgets('Checkbox should change state on multiple taps', (WidgetTester tester) async {
      bool isChecked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Checkbox(
              label: 'Test Checkbox',
              value: isChecked,
              onChanged: (value) {
                isChecked = value ?? false;
              },
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(isChecked, true);

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(find.byIcon(Icons.check), findsNothing);
      expect(isChecked, false);
    });

    testWidgets('Checkbox should have a custom icon color', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Checkbox(
              label: 'Test Checkbox',
              iconColor: Colors.red,
              onChanged: (value) {},
            ),
          ),
        ),
      );

      final iconWidget = tester.widget<CheckboxIcon>(find.byType(CheckboxIcon));
      expect(iconWidget.color, equals(Colors.red));
    });

    testWidgets('Checkbox should trigger onChanged with correct value', (WidgetTester tester) async {
      bool isChecked = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Checkbox(
              label: 'Test Checkbox',
              value: isChecked,
              onChanged: (value) {
                isChecked = value ?? false;
              },
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(isChecked, true);
    });

  });
}
