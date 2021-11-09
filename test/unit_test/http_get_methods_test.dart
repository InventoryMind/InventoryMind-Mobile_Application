import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_mind/others/http_methods.dart';
import 'package:inventory_mind/others/token_role_preferences.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'http_get_methods_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  String _url = "URL";
  WidgetsFlutterBinding.ensureInitialized();
  await TokenRolePreferences.init();
  group("HTTP GET", () {
    test("returns a Map, if successful", () async {
      final client = MockClient();
      when(client.get(Uri.parse(_url), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 200));
      expect(await getReq(client, _url), isA<Map>());
    });

    test("throws an exception, if failed", () async {
      final client = MockClient();
      when(client.get(Uri.parse(_url), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 201));
      expect(getReq(client, _url), throwsException);
    });

    test("throws an exception, if token is invalid", () async {
      final client = MockClient();
      when(client.get(Uri.parse(_url), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 400));
      expect(getReq(client, _url), throwsException);
    });

    test("throws an exception, if unauthorized", () async {
      final client = MockClient();
      when(client.get(Uri.parse(_url), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 401));
      expect(getReq(client, _url), throwsException);
    });

    test("throws an exception, if connection error", () async {
      final client = MockClient();
      when(client.get(Uri.parse(_url), headers: {
        "cookie": "auth-token=" + TokenRolePreferences.getToken()
      })).thenAnswer((_) async => http.Response('{}', 500));
      expect(getReq(client, _url), throwsException);
    });
  });
}
