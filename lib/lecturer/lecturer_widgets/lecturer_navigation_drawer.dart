import 'package:flutter/material.dart';
import 'package:inventory_mind/lecturer/accepted_requests.dart';
import 'package:inventory_mind/lecturer/pending_requests.dart';
import 'package:inventory_mind/lecturer/rejected_requests.dart';
import 'package:inventory_mind/widgets/widgets.dart';

import '../../login.dart';

class LecturerNavigationDrawer extends StatelessWidget {
  const LecturerNavigationDrawer({Key? key}) : super(key: key);

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
                "Pending Requests", Icons.pending, context, PendingRequests()),
            buildNavItem("Approved Requests", Icons.check_circle, context,
                AcceptedRequests()),
            buildNavItem(
                "Rejected Requests", Icons.cancel, context, RejectedRequests()),
            Divider(thickness: 2),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout", style: TextStyle(fontSize: 16)),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
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
