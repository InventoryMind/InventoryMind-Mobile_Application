import 'package:flutter/material.dart';
import 'package:inventory_mind/student/borrowing_history.dart';
import 'package:inventory_mind/student/borrowing_request.dart';
import 'package:inventory_mind/student/request_history.dart';
import 'package:inventory_mind/student/temporary_borrowing.dart';
import 'package:inventory_mind/widgets/widgets.dart';

import '../../login.dart';

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
