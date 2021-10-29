import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/token_role_preferences.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'common_methods_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenRolePreferences.init();
  group("loadDashboard of the lecturer", () {
    test("returns a Map, if successful", () async {
      final client = MockClient();
      when(client.get(Uri.parse(lecDashURL), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 200));
      expect(await getReq(client, lecDashURL), isA<Map>());
    });

    test("throws an exception, if failed", () async {
      final client = MockClient();
      when(client.get(Uri.parse(lecDashURL), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 201));
      expect(getReq(client, lecDashURL), throwsException);
    });

    test("throws an exception, if token is invalid", () async {
      final client = MockClient();
      when(client.get(Uri.parse(lecDashURL), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 400));
      expect(getReq(client, lecDashURL), throwsException);
    });

    test("throws an exception, if connection error", () async {
      final client = MockClient();
      when(client.get(Uri.parse(lecDashURL), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 500));
      expect(getReq(client, lecDashURL), throwsException);
    });
  });
}
