import 'package:flutter/material.dart';
import 'package:inventory_mind/student/student_dashboard.dart';
import 'package:inventory_mind/technical_officer/to_dashboard.dart';
import 'package:inventory_mind/token_role_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'constants.dart';
import 'lecturer/lecturer_dashboard.dart';
import 'login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokenRolePreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String _token = TokenRolePreferences.getToken();
  final String _userRole = TokenRolePreferences.getUserRole();

  @override
  Widget build(BuildContext context) {
    Widget _decide() {
      try {
        if ((_userRole == "empty") || _token == "empty") {
          return LoginPage();
        } else if (Jwt.isExpired(_token)) {
          return LoginPage();
        }
        switch (_userRole) {
          case "Technical Officer":
            return TODashboard();
          case "Lecturer":
            return LecturerDashboard();
          case "Student":
            return StudentDashboard();
        }
      } catch (e) {
        return LoginPage();
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
      home: _decide(),
    );
  }
}
