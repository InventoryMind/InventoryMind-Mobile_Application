import 'dart:convert';
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
  Map _body = {};
  WidgetsFlutterBinding.ensureInitialized();
  await TokenRolePreferences.init();

  group("HTTP POST with Normal Body", () {
    test("returns a Map, if successful", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
          headers: {"cookie": "auth-token=" + TokenRolePreferences.getToken()},
          body: {})).thenAnswer((_) async => http.Response('{}', 200));
      expect(await postReqWithBody(client, _url, _body), isA<Map>());
    });

    test("throws an exception, if failed", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
          headers: {"cookie": "auth-token=" + TokenRolePreferences.getToken()},
          body: {})).thenAnswer((_) async => http.Response('{}', 201));
      expect(postReqWithBody(client, _url, _body), throwsException);
    });

    test("throws an exception, if token is invalid", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
          headers: {"cookie": "auth-token=" + TokenRolePreferences.getToken()},
          body: {})).thenAnswer((_) async => http.Response('{}', 400));
      expect(postReqWithBody(client, _url, _body), throwsException);
    });

    test("throws an exception, if unauthorized", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
          headers: {"cookie": "auth-token=" + TokenRolePreferences.getToken()},
          body: {})).thenAnswer((_) async => http.Response('{}', 401));
      expect(postReqWithBody(client, _url, _body), throwsException);
    });

    test("throws an exception, if connection error", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
          headers: {"cookie": "auth-token=" + TokenRolePreferences.getToken()},
          body: {})).thenAnswer((_) async => http.Response('{}', 500));
      expect(postReqWithBody(client, _url, _body), throwsException);
    });
  });

  group("HTTP POST with Encoded Body", () {
    test("returns a Map, if successful", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
              headers: {
                "cookie": "auth-token=" + TokenRolePreferences.getToken(),
                "Content-Type": "application/json;charset=UTF-8",
                "Charset": "utf-8",
              },
              body: jsonEncode({})))
          .thenAnswer((_) async => http.Response('{}', 200));
      expect(await postReqWithEncodedBody(client, _url, _body), isA<Map>());
    });

    test("throws an exception, if failed", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
              headers: {
                "cookie": "auth-token=" + TokenRolePreferences.getToken(),
                "Content-Type": "application/json;charset=UTF-8",
                "Charset": "utf-8",
              },
              body: jsonEncode({})))
          .thenAnswer((_) async => http.Response('{}', 201));
      expect(postReqWithEncodedBody(client, _url, _body), throwsException);
    });

    test("throws an exception, if token is invalid", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
              headers: {
                "cookie": "auth-token=" + TokenRolePreferences.getToken(),
                "Content-Type": "application/json;charset=UTF-8",
                "Charset": "utf-8",
              },
              body: jsonEncode({})))
          .thenAnswer((_) async => http.Response('{}', 400));
      expect(postReqWithEncodedBody(client, _url, _body), throwsException);
    });

    test("throws an exception, if unauthorized", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
              headers: {
                "cookie": "auth-token=" + TokenRolePreferences.getToken(),
                "Content-Type": "application/json;charset=UTF-8",
                "Charset": "utf-8",
              },
              body: jsonEncode({})))
          .thenAnswer((_) async => http.Response('{}', 401));
      expect(postReqWithEncodedBody(client, _url, _body), throwsException);
    });

    test("throws an exception, if connection error", () async {
      final client = MockClient();
      when(client.post(Uri.parse(_url),
              headers: {
                "cookie": "auth-token=" + TokenRolePreferences.getToken(),
                "Content-Type": "application/json;charset=UTF-8",
                "Charset": "utf-8",
              },
              body: jsonEncode({})))
          .thenAnswer((_) async => http.Response('{}', 500));
      expect(postReqWithEncodedBody(client, _url, _body), throwsException);
    });
  });
}
