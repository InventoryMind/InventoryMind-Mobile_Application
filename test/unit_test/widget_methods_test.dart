import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_mind/others/token_role_preferences.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:mockito/mockito.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MockBuildContext extends Mock implements BuildContext {}

// ignore: must_be_immutable
class MockIconData extends Mock implements IconData {}

class MockTextEditingController extends Mock implements TextEditingController {}

void main() {
  MockBuildContext _mockContext = MockBuildContext();
  MockTextEditingController _mockTxtCont = MockTextEditingController();

  test("should return a PreferredSizeWidget", () async {
    WidgetsFlutterBinding.ensureInitialized();
    await TokenRolePreferences.init();
    var result = getAppBar(_mockContext, "title");
    expect(result, isA<PreferredSizeWidget>());
  });

  test("should return a Widget", () {
    MockIconData _mockIconData = MockIconData();
    var result =
        buildNavItem("title", _mockIconData, _mockContext, Text("Widget"));
    expect(result, isA<Widget>());
  });

  test("should return a RoundedRectangleBorder", () {
    var result = lecturerRequestsCardBorder();
    expect(result, isA<RoundedRectangleBorder>());
  });

  test("should return a IconButton", () {
    var result = lecturerRequestsListTieIcon(_mockContext, Text("Widget"));
    expect(result, isA<IconButton>());
  });

  test("should return a TextField", () {
    var result = inputTextField(_mockTxtCont, "label");
    expect(result, isA<TextField>());
  });

  test("should return a TextFormField", () {
    var result = inputTextFormField(_mockTxtCont, "label");
    expect(result, isA<TextFormField>());
  });

  test("should return a Alert", () {
    var result = commonErrorAlert(_mockContext);
    expect(result, isA<Alert>());
  });
}
