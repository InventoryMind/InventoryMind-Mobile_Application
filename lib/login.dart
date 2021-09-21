import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inventory_mind/lecturer/lecturer_dashboard.dart';
import 'package:inventory_mind/widgets/header_widget.dart';
import 'package:inventory_mind/widgets/theme_helper.dart';
import 'package:inventory_mind/urls.dart';
import 'package:inventory_mind/widgets/widgets.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();
  String _userRole = "User Role";
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _pwCont = TextEditingController();

  Future<void> _login(
      String email, String password, BuildContext context) async {
    Response response = await post(Uri.parse(loginURL),
        body: {"email": email, "password": password});
    if (response.statusCode == 200) {
      Map resBody = jsonDecode(response.body);
      // print(resBody["token"]);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LecturerDashboard()));
    } else {
      alertDialogBox(context, AlertType.error, "Access Denied",
              "Your email or password may be invalid or there may be an issue in your internet connection")
          .show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded),
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: [
                      Text(
                        'InventoryMind',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Inventory Management System',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 20.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            DropdownButton<String>(
                              hint: Text("User Role"),
                              value: _userRole,
                              items: <String>[
                                "User Role",
                                "Lecturer",
                                "Student",
                                "Technical Officer"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() => _userRole = newValue!);
                              },
                              underline: Container(),
                            ),
                            SizedBox(height: 20.0),
                            inputTextField(_emailCont, "Email"),
                            SizedBox(height: 30.0),
                            TextField(
                              controller: _pwCont,
                              decoration:
                                  ThemeHelper().textInputDecoration("Password"),
                              obscureText: true,
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () async {
                                  if (await canLaunch("https://google.com")) {
                                    await launch("https://google.com");
                                  } else {
                                    alertDialogBox(
                                            context,
                                            AlertType.warning,
                                            "Loading Failed",
                                            "Please check your internet connection and try again")
                                        .show();
                                  }
                                },
                                child: Text(
                                  "Forgot Password ?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration:
                                  ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text(
                                    'Sign In'.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await _login(
                                      _emailCont.text, _pwCont.text, context);
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                              child: Text.rich(TextSpan(
                                text: 'Register as a Student',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    if (await canLaunch(
                                        "https://flutter.dev/docs")) {
                                      await launch("https://flutter.dev/docs");
                                    } else {
                                      alertDialogBox(
                                              context,
                                              AlertType.warning,
                                              "Loading Failed",
                                              "Please check your internet connection and try again")
                                          .show();
                                    }
                                  },
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).accentColor,
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
