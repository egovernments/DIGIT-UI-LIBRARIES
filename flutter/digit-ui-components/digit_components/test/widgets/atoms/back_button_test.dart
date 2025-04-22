import 'package:digit_ui_components/theme/ComponentTheme/back_button_theme.dart';
import 'package:digit_ui_components/widgets/atoms/digit_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DigitBackButton should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitBackButton(
            label: 'Go Back',
            handleBack: () {},
          ),
        ),
      ),
    );

    expect(find.text('Go Back'), findsOneWidget);
    expect(find.byType(DigitBackButton), findsOneWidget);
  });

  testWidgets('DigitBackButton should call handleBack on tap', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitBackButton(
            label: 'Back',
            handleBack: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(InkWell);

    // Ensure button exists
    expect(buttonFinder, findsOneWidget);

    // Tap the back button
    await tester.tap(buttonFinder);
    await tester.pump();

    // Verify the callback was triggered
    expect(tapped, isTrue);
  });

  testWidgets('DigitBackButton should not trigger handleBack when disabled', (WidgetTester tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitBackButton(
            label: 'Back',
            handleBack: null, // Disabled
          ),
        ),
      ),
    );

    final buttonFinder = find.byType(InkWell);

    // Ensure button exists
    expect(buttonFinder, findsOneWidget);

    // Try tapping the button (should not trigger handleBack)
    await tester.tap(buttonFinder);
    await tester.pump();

    // Verify the callback was NOT triggered
    expect(tapped, isFalse);
  });

  testWidgets('DigitBackButton should display correct label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitBackButton(
            label: 'Exit',
            handleBack: () {},
          ),
        ),
      ),
    );

    expect(find.text('Exit'), findsOneWidget);
  });

  testWidgets('DigitBackButton should have correct semantics label', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitBackButton(
            label: 'Exit',
            semanticLabel: 'Go back to previous page',
            handleBack: () {},
          ),
        ),
      ),
    );

    final semantics = tester.getSemantics(find.text('Exit'));
    expect(semantics, isNotNull);
    expect(semantics.label, contains('Go back to previous page'));
  });

  testWidgets('DigitBackButton should render correct icon based on state', (WidgetTester tester) async {
    final backIcon = Icon(Icons.arrow_back);
    final disabledIcon = Icon(Icons.block);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitBackButton(
            label: 'Back',
            handleBack: () {},
            digitBackButtonThemeData: DigitBackButtonThemeData(
              backDigitButtonIcon: backIcon,
              disabledBackDigitButtonIcon: disabledIcon,
            ),
          ),
        ),
      ),
    );

    // Verify enabled icon is shown
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byIcon(Icons.block), findsNothing);

    // Now test the disabled state
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitBackButton(
            label: 'Back',
            handleBack: null, // Disabled
            digitBackButtonThemeData: DigitBackButtonThemeData(
              backDigitButtonIcon: backIcon,
              disabledBackDigitButtonIcon: disabledIcon,
            ),
          ),
        ),
      ),
    );

    // Verify disabled icon is shown
    expect(find.byIcon(Icons.block), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsNothing);
  });
}
