import 'package:flutter/material.dart';
import 'package:inventory_mind/lecturer/request_details.dart';
import 'package:inventory_mind/technical_officer/add_equipment.dart';
import 'package:inventory_mind/technical_officer/to_dashboard.dart';
import 'constants.dart';
import 'lecturer/accepted_requests.dart';
import 'lecturer/pending_requests.dart';
import 'lecturer/lecturer_dashboard.dart';
import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kBgColor,
        canvasColor: kSecondaryColor,
        // textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
        //     .apply(bodyColor: Colors.white),
      ),
      home: AddEquipment(),
      // routes: {
      //   "/": (context) => LecturerDashboard(),
      //   "/lecturer/pending_requests": (context) => PendingRequests(),
      //   "/lecturer/accepted_requests": (context) => AcceptedRequests(),
      // },
    );
  }
}
