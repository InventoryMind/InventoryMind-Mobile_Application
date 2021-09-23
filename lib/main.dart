import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inventory_mind/lecturer/request_details.dart';
import 'package:inventory_mind/student/borrowing_request.dart';
import 'package:inventory_mind/student/request_history.dart';
import 'package:inventory_mind/student/student_dashboard.dart';
import 'package:inventory_mind/student/temporary_borrowing.dart';
import 'package:inventory_mind/technical_officer/accept_return.dart';
import 'package:inventory_mind/technical_officer/add_equipment.dart';
import 'package:inventory_mind/technical_officer/remove_equipment.dart';
import 'package:inventory_mind/technical_officer/to_dashboard.dart';
import 'package:inventory_mind/technical_officer/transfer_equipment.dart';
import 'package:inventory_mind/urls.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'constants.dart';
import 'lecturer/accepted_requests.dart';
import 'student/borrowing_history.dart';
import 'lecturer/pending_requests.dart';
import 'lecturer/lecturer_dashboard.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _decide() {
      if (userRole.isEmpty) {
        return LoginPage();
      }
      switch (userRole) {
        case "Technical Officer":
          if ((Jwt.isExpired(kTOToken)) && kTOToken.isEmpty) {
            return LoginPage();
          } else {
            return TODashboard();
          }
        case "Lecturer":
          if ((Jwt.isExpired(kLecToken)) && kLecToken.isEmpty) {
            return LoginPage();
          } else {
            return LecturerDashboard();
          }
        case "Student":
          if ((Jwt.isExpired(kStuToken)) && kStuToken.isEmpty) {
            return LoginPage();
          } else {
            return StudentDashboard();
          }
      }
      return LoginPage();
    }

    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBgColor,
        canvasColor: kSecondaryColor,
        // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        //     .apply(bodyColor: Colors.white),
      ),
      home: StudentDashboard(),
      // home: _decide(),
    );
  }
}
