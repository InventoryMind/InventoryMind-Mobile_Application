import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_mind/common/login.dart';

void main() {
  Widget _testable = MaterialApp(home: LoginPage());

  final buttonFinder = find.byType(ElevatedButton);
  final emailErrorFinder = find.text("Enter a valid email address");
  final pwErrorFinder = find.text("Please enter the password");

  testWidgets("Presence of Child Widgets", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    final userRoleFinder = find.text("User Role");
    final textFieldFinder = find.byType(TextFormField);

    expect(userRoleFinder, findsOneWidget);
    expect(textFieldFinder, findsNWidgets(2));
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets("When no inputs provided", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    await tester.ensureVisible(buttonFinder);
    await tester.pumpAndSettle();
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(emailErrorFinder, findsOneWidget);
    expect(pwErrorFinder, findsOneWidget);
  });

  testWidgets("When some valid inputs provided", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    await tester.enterText(find.byKey(Key("Email")), "abc@gmail.com");

    await tester.ensureVisible(buttonFinder);
    await tester.pumpAndSettle();
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text("abc@gmail.com"), findsOneWidget);

    expect(emailErrorFinder, findsNothing);
    expect(pwErrorFinder, findsOneWidget);
  });

  testWidgets("When some invalid inputs provided", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    await tester.enterText(find.byKey(Key("Email")), "abcgmail.com");
    await tester.enterText(find.byKey(Key("Password")), "");

    await tester.ensureVisible(buttonFinder);
    await tester.pumpAndSettle();
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text("abcgmail.com"), findsOneWidget);
    expect(find.text(""), findsOneWidget);

    expect(emailErrorFinder, findsOneWidget);
    expect(pwErrorFinder, findsOneWidget);
  });

  testWidgets("When all valid inputs provided", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    await tester.enterText(find.byKey(Key("Email")), "abc@gmail.com");
    await tester.enterText(find.byKey(Key("Password")), "abc123");

    await tester.ensureVisible(buttonFinder);
    await tester.pumpAndSettle();
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text("abc@gmail.com"), findsOneWidget);
    expect(find.text("abc123"), findsOneWidget);

    expect(emailErrorFinder, findsNothing);
    expect(pwErrorFinder, findsNothing);
  });
}
