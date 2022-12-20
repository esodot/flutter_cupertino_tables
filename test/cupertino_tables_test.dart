import 'package:cupertino_tables/cupertino_table_row.dart';
import 'package:cupertino_tables/cupertino_table_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Define a test.
  testWidgets('widget test', (tester) async {
    var pressed = false;
    onPressed() => pressed = true;

    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(CupertinoApp(
        home: CupertinoTableSection(
      header: const Text("header"),
      footer: const Text("footer"),
      children: [
        CupertinoTableRow(
          title: const Text("title"),
          leading: const CupertinoTableRowIcon(
            icon: CupertinoIcons.settings,
          ),
          helper: const Text("helper"),
          trailing: const CupertinoTableRowNavigationIndicator(),
          onPress: onPressed,
        ),
      ],
    )));

    // Create the Finders.
    final headerFinder = find.text('header');
    final footerFinder = find.text('footer');
    final titleFinder = find.text('title');
    final helperFinder = find.text("helper");
    final iconFinder =
        find.widgetWithIcon(CupertinoTableRowIcon, CupertinoIcons.settings);
    final indicatorFinder = find.widgetWithIcon(
        CupertinoTableRowNavigationIndicator, CupertinoIcons.forward);

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the widgets appear exactly once in the widget tree.
    expect(headerFinder, findsOneWidget);
    expect(footerFinder, findsOneWidget);
    expect(titleFinder, findsOneWidget);
    expect(helperFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
    expect(indicatorFinder, findsOneWidget);

    // We are testing the tap
    await tester.tap(titleFinder);
    expect(pressed, isTrue);
  });
}
