import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_mind/lecturer/lecturer_widgets/lecturer_navigation_drawer.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';

void main() {
  testWidgets("Lecturer", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LecturerNavigationDrawer()));

    final listTileFinder = find.byType(ListTile);
    final iconFinder = find.byType(Icon);
    final profileFinder = find.widgetWithText(ListTile, "Profile Page");
    final chPwFinder = find.widgetWithText(ListTile, "Change Password");
    final logoutFinder = find.widgetWithText(ListTile, "Logout");

    expect(listTileFinder, findsNWidgets(7));
    expect(iconFinder, findsNWidgets(6));
    expect(profileFinder, findsOneWidget);
    expect(chPwFinder, findsOneWidget);
    expect(logoutFinder, findsOneWidget);
  });

  testWidgets("Student", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: StudentNavigationDrawer()));

    final listTileFinder = find.byType(ListTile);
    final iconFinder = find.byType(Icon);
    final profileFinder = find.widgetWithText(ListTile, "Profile Page");
    final chPwFinder = find.widgetWithText(ListTile, "Change Password");
    final logoutFinder = find.widgetWithText(ListTile, "Logout");

    expect(listTileFinder, findsNWidgets(8));
    expect(iconFinder, findsNWidgets(7));
    expect(profileFinder, findsOneWidget);
    expect(chPwFinder, findsOneWidget);
    expect(logoutFinder, findsOneWidget);
  });

  testWidgets("Technical Officer", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: TONavigationDrawer()));

    final listTileFinder = find.byType(ListTile);
    final iconFinder = find.byType(Icon);
    final profileFinder = find.widgetWithText(ListTile, "Profile Page");
    final chPwFinder = find.widgetWithText(ListTile, "Change Password");
    final logoutFinder = find.widgetWithText(ListTile, "Logout");

    expect(listTileFinder, findsNWidgets(10));
    expect(iconFinder, findsNWidgets(9));
    expect(profileFinder, findsOneWidget);
    expect(chPwFinder, findsOneWidget);
    expect(logoutFinder, findsOneWidget);
  });
}
