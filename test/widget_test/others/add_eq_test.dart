import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_mind/others/token_role_preferences.dart';
import 'package:inventory_mind/technical_officer/accept_return.dart';

void main() async {
  await TokenRolePreferences.init();
  Widget _testable = MaterialApp(home: AcceptReturn());

  final buttonFinder = find.widgetWithText(DropdownButton, "Borrowing Type");

  testWidgets("Presence of Child Widgets", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    expect(buttonFinder, findsOneWidget);
  });
}
