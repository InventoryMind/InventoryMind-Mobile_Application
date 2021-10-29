import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_mind/others/input_validator.dart';
import 'package:inventory_mind/widgets/header_widget.dart';
import 'package:inventory_mind/widgets/theme_helper.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String? _password;
  // bool _checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
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
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
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
                        SizedBox(height: 30),
                        TextFormField(
                          decoration:
                              ThemeHelper().textInputDecoration("Index Number"),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your index number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              ThemeHelper().textInputDecoration('First Name'),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your first name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                              ThemeHelper().textInputDecoration('Last Name'),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return "Please enter your last name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration:
                              ThemeHelper().textInputDecoration("Email"),
                          keyboardType: TextInputType.emailAddress,
                          validator: InputValidator.validateEmail,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: ThemeHelper()
                              .textInputDecoration("Contact Number (WhatsApp)"),
                          keyboardType: TextInputType.phone,
                          validator: InputValidator.validateContactNo,
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: true,
                          decoration:
                              ThemeHelper().textInputDecoration('Password'),
                          validator: (val) {
                            _password = val;
                            if (val!.isEmpty) {
                              return "Please enter a password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          obscureText: true,
                          decoration: ThemeHelper()
                              .textInputDecoration('Confirm Password'),
                          validator: (val) {
                            if ((val!.isEmpty) || (val != _password)) {
                              return "Please confirm the password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // FormField<bool>(
                        //   builder: (state) {
                        //     return Column(
                        //       children: <Widget>[
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: <Widget>[
                        //             Checkbox(
                        //                 value: _checkboxValue,
                        //                 onChanged: (value) {
                        //                   setState(() {
                        //                     _checkboxValue = value!;
                        //                     state.didChange(value);
                        //                   });
                        //                 }),
                        //             Text(
                        //               "I accept all terms and conditions.",
                        //               style: TextStyle(color: Colors.grey),
                        //             ),
                        //           ],
                        //         ),
                        //         Container(
                        //           child: Center(
                        //             child: Text(
                        //               state.errorText ?? '',
                        //               style: TextStyle(
                        //                 color: Theme.of(context).errorColor,
                        //                 fontSize: 12,
                        //               ),
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     );
                        //   },
                        //   validator: (value) {
                        //     if (!_checkboxValue) {
                        //       return 'You need to accept terms and conditions';
                        //     } else {
                        //       return null;
                        //     }
                        //   },
                        // ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
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
                                Navigator.pop(context);
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
