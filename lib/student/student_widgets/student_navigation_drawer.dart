import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inventory_mind/student/borrowing_history.dart';
import 'package:inventory_mind/student/borrowing_request.dart';
import 'package:inventory_mind/student/request_history.dart';
import 'package:inventory_mind/student/temporary_borrowing.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../../common/login.dart';
import '../../common/profile_page.dart';
import '../../others/token_role_preferences.dart';
import '../../others/urls.dart';

class StudentNavigationDrawer extends StatelessWidget {
  const StudentNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: ListView(
          children: [
            ListTile(
              title: Center(
                  child: Text("InventoryMind", style: TextStyle(fontSize: 16))),
              subtitle: Center(child: Text("Inventory Management System")),
            ),
            Divider(thickness: 2),
            buildNavItem("Borrowing Request", Icons.attach_email_rounded,
                context, BorrowingRequest()),
            buildNavItem("Temporary Borrowing", Icons.timelapse_rounded,
                context, TemporaryBorrowing()),
            buildNavItem("Request History", Icons.history_edu_rounded, context,
                RequestHistory()),
            buildNavItem("Borrowing History", Icons.format_list_bulleted,
                context, BorrowingHistory()),
            Divider(thickness: 2),
            buildNavItem(
                "Profile Page", Icons.account_circle, context, ProfilePage()),
            ListTile(
              leading: Icon(Icons.password),
              title: Text("Change Password", style: TextStyle(fontSize: 16)),
              onTap: () async {
                if (await canLaunch(changePwURL)) {
                  await launch(changePwURL);
                } else {
                  alertDialogBox(context, AlertType.warning, "Loading Failed",
                          "Please check your internet connection and try again")
                      .show();
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout", style: TextStyle(fontSize: 16)),
              onTap: () async {
                Response response = await get(Uri.parse(logoutURL), headers: {
                  "cookie": "auth-token=" + TokenRolePreferences.getToken()
                });
                Map resBody = jsonDecode(response.body);
                if (response.statusCode == 200) {
                  await TokenRolePreferences.setToken("clear");
                  await TokenRolePreferences.setUserRole("clear");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false);
                } else {
                  alertDialogBox(context, AlertType.error, "Logout Failed",
                          "There may be an issue in your internet connection")
                      .show();
                }
              },
            ),
            SizedBox(height: 20),
            Center(child: Text("v 1.0.0 © 2021 | UoM CSE")),
          ],
        ),
      ),
    );
  }
}
