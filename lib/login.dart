import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inventory_mind/lecturer/lecturer_dashboard.dart';
import 'package:inventory_mind/widgets/header_widget.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/theme_helper.dart';
import 'package:inventory_mind/urls.dart';
import 'package:inventory_mind/widgets/widgets.dart';
import 'dart:convert';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:jwt_decode/jwt_decode.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  String? _userRole;
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _pwCont = TextEditingController();
  List<String> _roles = ["Lecturer", "Student", "Technical Officer"];
  bool _loading = false;

  Future<void> _login(
      String email, String password, BuildContext context) async {
    // String? _temp = _userRole.toString();
    // if (_temp == "Technical Officer") {
    //   _temp = "technical_officer";
    // } else {
    //   _temp = _temp.toLowerCase();
    // }
    // setState(() => _loading = true);
    // Response response1 = await post(Uri.parse(loginURL),
    //     body: {"email": email, "userType": _temp, "password": password});
    // Map resBody1 = jsonDecode(response1.body);
    // if (response1.statusCode == 200) {
    //   if (_temp == "technical_officer") {
    //     kTOToken = resBody1["token"];
    //     Response response2 = await get(Uri.parse(toDashURL), headers: {
    //       "cookie": {"auth-token": kTOToken}.toString()
    //     });
    //     Map resBody2 = jsonDecode(response2.body);
    //
    //     print(kTOToken);
    //     print(resBody2);
    //   }
    userRole = _userRole.toString();
    Response response2 = await get(Uri.parse(toDashURL),
        headers: {"cookie": "auth-token=" + kTOToken});
    Map resBody2 = jsonDecode(response2.body);
    Map<String, dynamic> payload = Jwt.parseJwt(kTOToken);
    // Print the payload
    print(payload);
    DateTime? expiryDate = Jwt.getExpiryDate(kTOToken);
//   Print the expiry date
    print(expiryDate);

    print(kTOToken);
    print(resBody2);
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             LecturerDashboard(content: resBody["msg"]["data"])));
    // } else {
    //   setState(() => _loading = false);
    //   alertDialogBox(context, AlertType.error, "Access Denied",
    //           "Your email or password may be invalid or there may be an issue in your internet connection")
    //       .show();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: _headerHeight,
                    child:
                        HeaderWidget(_headerHeight, true, Icons.login_rounded),
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
                            SizedBox(height: 30.0),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: DropdownButton(
                                    value: _userRole,
                                    hint: Text("User Role"),
                                    items: _roles.map((val) {
                                      return DropdownMenuItem(
                                          value: val, child: Text(val));
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        _userRole = val.toString();
                                      });
                                    },
                                    isExpanded: true,
                                    underline: Container(),
                                  ),
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    border: Border.all(
                                        color: Colors.grey, width: 1),
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                inputTextField(_emailCont, "Email"),
                                SizedBox(height: 20.0),
                                TextField(
                                  controller: _pwCont,
                                  decoration: ThemeHelper()
                                      .textInputDecoration("Password"),
                                  obscureText: true,
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (await canLaunch(
                                          "https://google.com")) {
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
                                  decoration: ThemeHelper()
                                      .buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text(
                                        'Sign In'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await _login(_emailCont.text,
                                          _pwCont.text, context);
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Text.rich(TextSpan(
                                    text: 'Register as a Student',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        if (await canLaunch(studentRegURL)) {
                                          await launch(studentRegURL);
                                        } else {
                                          alertDialogBox(
                                                  context,
                                                  AlertType.warning,
                                                  "Loading Failed",
                                                  "Please check your int  ernet connection and try again")
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
                          ],
                        )),
                  ),
                ],
              ),
            ),
          );
  }
}
