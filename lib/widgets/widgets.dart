import 'package:flutter/material.dart';
import 'package:inventory_mind/constants.dart';
import 'package:inventory_mind/lecturer/lecturer_dashboard.dart';
import 'package:inventory_mind/student/student_dashboard.dart';
import 'package:inventory_mind/technical_officer/to_dashboard.dart';
import 'package:inventory_mind/widgets/theme_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../token_role_preferences.dart';

// ----------------------Common ------------------------------------------------
PreferredSizeWidget getAppBar(BuildContext context, String title) {
  String _userRole = TokenRolePreferences.getUserRole();
  return AppBar(
    backgroundColor: kBgColor,
    title: Text(title),
    actions: [
      IconButton(
        icon: Icon(Icons.home),
        onPressed: () {
          if (_userRole == "Lecturer") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LecturerDashboard()),
              (route) => false,
            );
          } else if (_userRole == "Student") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => StudentDashboard()),
              (route) => false,
            );
          } else if (_userRole == "Technical Officer") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TODashboard()),
              (route) => false,
            );
          }
        },
      ),
      SizedBox(width: 20),
    ],
  );
}

Widget buildNavItem(
    String title, IconData icon, BuildContext context, Widget widget) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title, style: TextStyle(fontSize: 16)),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
    },
  );
}

RoundedRectangleBorder lecturerRequestsCardBorder() {
  return RoundedRectangleBorder(
    side: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.circular(4.0),
  );
}

IconButton lecturerRequestsListTieIcon(BuildContext context, Widget widget) {
  return IconButton(
    icon: Icon(Icons.remove_red_eye_rounded),
    onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
    },
  );
}

Alert alertDialogBox(
    BuildContext context, AlertType type, String title, String desc) {
  return Alert(
    context: context,
    type: type,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        child: Text("Go Back"),
        onPressed: () => Navigator.pop(context),
        color: Colors.blue,
      ),
    ],
    style: AlertStyle(
      titleStyle: TextStyle(color: Colors.white),
      descStyle: TextStyle(color: Colors.grey),
    ),
  );
}

TextField inputTextField(TextEditingController cont, String label) {
  return TextField(
    controller: cont,
    decoration: ThemeHelper().textInputDecoration(label),
  );
}
