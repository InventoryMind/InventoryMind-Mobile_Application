import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inventory_mind/common/login.dart';
import 'package:inventory_mind/common/profile_page.dart';
import 'package:inventory_mind/technical_officer/accept_return.dart';
import 'package:inventory_mind/technical_officer/add_equipment.dart';
import 'package:inventory_mind/technical_officer/barcode_scanner.dart';
import 'package:inventory_mind/technical_officer/remove_equipment.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../../others/token_role_preferences.dart';
import '../../others/urls.dart';
import '../change_eq_status.dart';
import '../transfer_equipment.dart';

class TONavigationDrawer extends StatelessWidget {
  const TONavigationDrawer({Key? key}) : super(key: key);

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
            buildNavItem(
                "Add Equipment", Icons.add_circle, context, AddEquipment()),
            buildNavItem("Remove Equipment", Icons.do_not_disturb_on_rounded,
                context, RemoveEquipment()),
            buildNavItem("Transfer Equipment", Icons.change_circle_rounded,
                context, TransferEquipment()),
            buildNavItem("Returned Equipment", Icons.assignment_return_rounded,
                context, AcceptReturn()),
            buildNavItem("Change Eq. Status", Icons.compare_arrows, context,
                ChangeStatus()),
            buildNavItem(
                "Barcode Scanner", Icons.camera, context, BarcodeScanner()),
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
