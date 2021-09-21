import 'package:flutter/material.dart';
import 'package:inventory_mind/lecturer/accepted_requests.dart';
import 'package:inventory_mind/lecturer/pending_requests.dart';
import 'package:inventory_mind/widgets/widgets.dart';

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
              leading: Icon(Icons.person),
              title: Text("User ID : 180652A", style: TextStyle(fontSize: 16)),
            ),
            Divider(thickness: 2),
            buildNavItem(
                "Pending Requests", Icons.pending, context, PendingRequests()),
            buildNavItem("Accepted Requests", Icons.check_circle, context,
                AcceptedRequests()),
            // _buildNavItem("Rejected Requests", Icons.cancel),
            // Divider(thickness: 2),
            // _buildNavItem("Change Password", Icons.password),
            // _buildNavItem("Logout", Icons.login_outlined),
          ],
        ),
      ),
    );
  }
}
