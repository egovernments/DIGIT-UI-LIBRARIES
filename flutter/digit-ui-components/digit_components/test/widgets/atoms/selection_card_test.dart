import 'package:digit_ui_components/theme/spacers.dart';
import 'package:digit_ui_components/widgets/atoms/selection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildCard(List<String> options) => SelectionCard<String>(
        options: options,
        valueMapper: (v) => v,
        title: 'Gender',
        showParentContainer: true,
        equalWidthOptions: true,
        initialSelection: [options.first],
        onSelectionChanged: (_) {},
      );

  Future<void> pump(WidgetTester tester, Widget child) async {
    tester.view.physicalSize = const Size(1080, 2340);
    tester.view.devicePixelRatio = 2.8125;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: child)));
    await tester.pumpAndSettle();
  }

  List<RenderBox> optionBoxes(WidgetTester tester) => find
      .descendant(
        of: find.byType(SelectionCard<String>),
        matching: find.byType(GestureDetector),
      )
      .evaluate()
      .map((e) => e.renderObject as RenderBox)
      .toList();

  testWidgets('equal-width options share the container width evenly',
      (tester) async {
    await pump(tester, buildCard(['Female', 'Male']));

    final boxes = optionBoxes(tester);
    expect(boxes.length, 2);

    final first = boxes[0];
    final second = boxes[1];
    final firstLeft = first.localToGlobal(Offset.zero).dx;
    final secondLeft = second.localToGlobal(Offset.zero).dx;

    // Both options are the same width and separated by exactly one gutter.
    expect(second.size.width, closeTo(first.size.width, 0.5));
    expect(secondLeft - (firstLeft + first.size.width), closeTo(spacer6, 0.5));

    // Symmetric inset: whatever padding the container applies on the left it
    // also applies on the right, so no bare background shows on one side.
    final parent = find
        .descendant(
          of: find.byType(SelectionCard<String>),
          matching: find.byType(Container),
        )
        .evaluate()
        .first
        .renderObject as RenderBox;
    final parentLeft = parent.localToGlobal(Offset.zero).dx;
    final leftInset = firstLeft - parentLeft;
    final rightInset =
        (parentLeft + parent.size.width) - (secondLeft + second.size.width);
    expect(leftInset, closeTo(rightInset, 0.5));
  });

  testWidgets('lays out under an ancestor that asks for intrinsic dimensions',
      (tester) async {
    // Regression guard: an earlier implementation used a LayoutBuilder here,
    // which throws "LayoutBuilder does not support returning intrinsic
    // dimensions" whenever an ancestor measures intrinsics (as the search
    // results table does), taking the surrounding screen down with it.
    await pump(tester, IntrinsicWidth(child: buildCard(['Female', 'Male'])));

    expect(tester.takeException(), isNull);
    expect(optionBoxes(tester).length, 2);
  });

  testWidgets('larger option sets keep wrapping instead of squashing',
      (tester) async {
    await pump(
      tester,
      buildCard([
        'Absent',
        'Refusal',
        'Not Visited',
        'House Not Revisited',
        'Asleep',
        'Other',
      ]),
    );

    expect(tester.takeException(), isNull);
    final boxes = optionBoxes(tester);
    expect(boxes.length, 6);
    // Each option keeps a usable width rather than being divided six ways.
    for (final box in boxes) {
      expect(box.size.width, greaterThan(200));
    }
  });
}
