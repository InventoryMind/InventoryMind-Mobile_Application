import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/input_validator.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/widgets/header_widget.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/theme_helper.dart';
import 'package:http/http.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _indCont = TextEditingController();
  final TextEditingController _fnCont = TextEditingController();
  final TextEditingController _lnCont = TextEditingController();
  final TextEditingController _emailCont = TextEditingController();
  final TextEditingController _numCont = TextEditingController();
  bool _loading = false;

  Future<void> _register(Map body) async {
    setState(() => _loading = true);
    try {
      await postReqWithoutToken(Client(), stuRegURL, body);
      Fluttertoast.showToast(
        msg: "Successfully Registered",
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      throw Exception("Loading Failed");
    } finally {
      setState(() => _loading = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Loading()
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    child: HeaderWidget(
                        200, false, Icons.person_add_alt_1_rounded),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 50, 20, 10),
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey,
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade300,
                                        size: 80.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 40),
                              TextFormField(
                                controller: _indCont,
                                decoration: ThemeHelper()
                                    .textInputDecoration("Index Number"),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please enter your index number";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _fnCont,
                                decoration: ThemeHelper()
                                    .textInputDecoration('First Name'),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please enter your first name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _lnCont,
                                decoration: ThemeHelper()
                                    .textInputDecoration('Last Name'),
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Please enter your last name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: _emailCont,
                                decoration:
                                    ThemeHelper().textInputDecoration("Email"),
                                keyboardType: TextInputType.emailAddress,
                                validator: InputValidator.validateEmail,
                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: _numCont,
                                decoration: ThemeHelper().textInputDecoration(
                                    "Contact Number (WhatsApp)"),
                                keyboardType: TextInputType.phone,
                                validator: InputValidator.validateContactNo,
                              ),
                              // SizedBox(height: 20.0),
                              // TextFormField(
                              //   obscureText: true,
                              //   decoration:
                              //       ThemeHelper().textInputDecoration('Password'),
                              //   validator: (val) {
                              //     _password = val;
                              //     if (val!.isEmpty) {
                              //       return "Please enter a password";
                              //     }
                              //     return null;
                              //   },
                              // ),
                              // SizedBox(height: 20.0),
                              // TextFormField(
                              //   obscureText: true,
                              //   decoration: ThemeHelper()
                              //       .textInputDecoration('Confirm Password'),
                              //   validator: (val) {
                              //     if ((val!.isEmpty) || (val != _password)) {
                              //       return "Please confirm the password";
                              //     }
                              //     return null;
                              //   },
                              // ),
                              SizedBox(height: 30),
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "Register".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _register({
                                        "userId": _indCont.text,
                                        "firstName": _fnCont.text,
                                        "lastName": _lnCont.text,
                                        "email": _emailCont.text,
                                        "contactNo": _numCont.text,
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
