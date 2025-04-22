import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DigitButton has correct label in Semantics tree', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitButton(
            label: 'Primary Button',
            semanticLabel: 'Primary Button Semantic',
            onPressed: () {},
            type: DigitButtonType.primary,
            size: DigitButtonSize.large,
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.text('Primary Button'));
    expect(semantics, isNotNull);
    expect(semantics.label, contains('Primary Button Semantic'));
  });

  testWidgets('DigitButton should be tappable when enabled', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitButton(
            label: 'Tap Me',
            onPressed: () {
              pressed = true;
            },
            type: DigitButtonType.primary,
            size: DigitButtonSize.medium,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tap Me'));
    await tester.pump();
    expect(pressed, isTrue);
  });

  testWidgets('DigitButton should not be tappable when disabled', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitButton(
            label: 'Disabled Button',
            onPressed: () {
              pressed = true;
            },
            type: DigitButtonType.primary,
            size: DigitButtonSize.medium,
            isDisabled: true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Disabled Button'));
    await tester.pump();
    expect(pressed, isFalse);
  });

  testWidgets('DigitButton should display prefix and suffix icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitButton(
            label: 'Button',
            onPressed: () {},
            type: DigitButtonType.primary,
            size: DigitButtonSize.large,
            prefixIcon: Icons.star,
            suffixIcon: Icons.arrow_forward,
          ),
        ),
      ),
    );

    expect(find.text('Button'), findsOneWidget);
    expect(find.byIcon(Icons.star), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
  });

  testWidgets('DigitButton should support different button sizes', (WidgetTester tester) async {
    for (final size in DigitButtonSize.values) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitButton(
              label: 'Size Test',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: size,
            ),
          ),
        ),
      );

      expect(find.text('Size Test'), findsOneWidget);
    }
  });

  testWidgets('DigitButton should support different button types', (WidgetTester tester) async {
    for (final type in DigitButtonType.values) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DigitButton(
              label: 'Type Test',
              onPressed: () {},
              type: type,
              size: DigitButtonSize.large,
            ),
          ),
        ),
      );

      expect(find.text('Type Test'), findsOneWidget);
    }
  });

  testWidgets('DigitButton should handle focus state', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Focus(
            child: DigitButton(
              label: 'Focusable Button',
              onPressed: () {},
              type: DigitButtonType.primary,
              size: DigitButtonSize.large,
            ),
          ),
        ),
      ),
    );

    final buttonFinder = find.text('Focusable Button');
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();
    expect(tester.binding.focusManager.primaryFocus, isNotNull);
  });
}
