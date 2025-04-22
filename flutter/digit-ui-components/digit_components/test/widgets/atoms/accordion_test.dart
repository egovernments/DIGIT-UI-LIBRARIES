import 'package:digit_ui_components/models/accordionModel.dart';
import 'package:digit_ui_components/widgets/atoms/accordion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:digit_ui_components/digit_components.dart';

void main() {
  testWidgets('DigitAccordion should render correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitAccordion(
            items: [
              DigitAccordionItem(header: Text('Header 1'), content: Text('Content 1')),
              DigitAccordionItem(header: Text('Header 2'), content: Text('Content 2')),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Header 1'), findsOneWidget);
    expect(find.text('Header 2'), findsOneWidget);
  });

  testWidgets('DigitAccordion should allow multiple open items if allowMultipleOpen is true', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitAccordion(
            allowMultipleOpen: true,
            items: [
              DigitAccordionItem(header: Text('Header 1'), content: Text('Content 1')),
              DigitAccordionItem(header: Text('Header 2'), content: Text('Content 2')),
            ],
          ),
        ),
      ),
    );

    final header1Finder = find.text('Header 1');
    final header2Finder = find.text('Header 2');
    final content1Finder = find.text('Content 1');
    final content2Finder = find.text('Content 2');

    // Expand first item
    await tester.tap(header1Finder);
    await tester.pumpAndSettle();
    expect(content1Finder, findsOneWidget);

    // Expand second item (first should remain open)
    await tester.tap(header2Finder);
    await tester.pumpAndSettle();
    expect(content1Finder, findsOneWidget);
    expect(content2Finder, findsOneWidget);
  });

  testWidgets('DigitAccordion should have initially expanded items open by default', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitAccordion(
            items: [
              DigitAccordionItem(header: Text('Header 1'), content: Text('Content 1'), initiallyExpanded: true),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Content 1'), findsOneWidget);
  });

  testWidgets('DigitAccordion should render dividers when divider is true', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitAccordion(
            divider: true,
            items: [
              DigitAccordionItem(header: Text('Header 1'), content: Text('Content 1')),
              DigitAccordionItem(header: Text('Header 2'), content: Text('Content 2')),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(Divider), findsWidgets);
  });

  testWidgets('DigitAccordion should display borders when showBorder is true', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitAccordion(
            items: [
              DigitAccordionItem(header: Text('Header 1'), content: Text('Content 1'), showBorder: true),
            ],
          ),
        ),
      ),
    );

    final containerFinder = find.ancestor(of: find.text('Header 1'), matching: find.byType(Container));

    final Container containerWidget = tester.widget(containerFinder);
    final BoxDecoration? decoration = containerWidget.decoration as BoxDecoration?;
    expect(decoration?.border, isNotNull);
  });

  testWidgets('DigitAccordion should have correct semantic labels', (WidgetTester tester) async {
    final semanticsHandle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DigitAccordion(
            items: [
              DigitAccordionItem(header: Text('Header 1'), content: Text('Content 1'), semanticLabel: 'Accordion Item 1'),
            ],
          ),
        ),
      ),
    );

    expect(find.bySemanticsLabel('Accordion Item 1'), findsOneWidget);

    semanticsHandle.dispose();
  });
}
