import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_mind/student/register.dart';

void main() {
  Widget _testable = MaterialApp(home: RegistrationPage());

  final buttonFinder = find.byType(ElevatedButton);
  final indexErrorFinder = find.text("Please enter your index number");
  final fNameErrorFinder = find.text("Please enter your first name");
  final lNameErrorFinder = find.text("Please enter your last name");
  final emailErrorFinder = find.text("Enter a valid email address");
  final contactErrorFinder = find.text("Enter a valid contact number");

  testWidgets("Presence of Child Widgets", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    final textFieldFinder = find.byType(TextFormField);

    expect(textFieldFinder, findsNWidgets(5));
    expect(buttonFinder, findsOneWidget);
  });

  testWidgets("When no inputs provided", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    await tester.ensureVisible(buttonFinder);
    await tester.pumpAndSettle();
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(indexErrorFinder, findsOneWidget);
    expect(fNameErrorFinder, findsOneWidget);
    expect(lNameErrorFinder, findsOneWidget);
    expect(emailErrorFinder, findsOneWidget);
    expect(contactErrorFinder, findsOneWidget);
  });

  testWidgets("When some valid inputs provided", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    await tester.enterText(find.byKey(Key("Index")), "12345");
    await tester.enterText(find.byKey(Key("FName")), "First");
    await tester.enterText(find.byKey(Key("LName")), "Last");

    await tester.ensureVisible(buttonFinder);
    await tester.pumpAndSettle();
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text("12345"), findsOneWidget);
    expect(find.text("First"), findsOneWidget);
    expect(find.text("Last"), findsOneWidget);

    expect(indexErrorFinder, findsNothing);
    expect(fNameErrorFinder, findsNothing);
    expect(lNameErrorFinder, findsNothing);
    expect(emailErrorFinder, findsOneWidget);
    expect(contactErrorFinder, findsOneWidget);
  });

  testWidgets("When some invalid inputs provided", (WidgetTester tester) async {
    await tester.pumpWidget(_testable);

    await tester.enterText(find.byKey(Key("Index")), "12345");
    await tester.enterText(find.byKey(Key("FName")), "Alex");
    await tester.enterText(find.byKey(Key("LName")), "Johnson");
    await tester.enterText(find.byKey(Key("Email")), "abcgmail.com");
    await tester.enterText(find.byKey(Key("Contact")), "07112345");

    await tester.ensureVisible(buttonFinder);
    await tester.pumpAndSettle();
    await tester.tap(buttonFinder);
    await tester.pump();

    expect(find.text("12345"), findsOneWidget);
    expect(find.text("Alex"), findsOneWidget);
    expect(find.text("Johnson"), findsOneWidget);
    expect(find.text("abcgmail.com"), findsOneWidget);
    expect(find.text("07112345"), findsOneWidget);

    expect(indexErrorFinder, findsNothing);
    expect(fNameErrorFinder, findsNothing);
    expect(lNameErrorFinder, findsNothing);
    expect(emailErrorFinder, findsOneWidget);
    expect(contactErrorFinder, findsOneWidget);
  });
}
