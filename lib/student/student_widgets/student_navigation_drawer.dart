import 'package:flutter/material.dart';
import 'package:inventory_mind/student/borrowing_request.dart';
import 'package:inventory_mind/widgets/widgets.dart';

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
              leading: Icon(Icons.person),
              title: Text("User ID : 180652A", style: TextStyle(fontSize: 16)),
            ),
            Divider(thickness: 2),
            buildNavItem("Borrowing Request", Icons.attach_email_rounded,
                context, BorrowingRequest()),
            // buildNavItem("Remove Equipment", Icons.do_not_disturb_on_rounded,
            //     context, RemoveEquipment()),
            // buildNavItem("Transfer Equipment", Icons.change_circle_rounded,
            //     context, TransferEquipment()),
            // buildNavItem("Returned Equipment", Icons.assignment_return_rounded,
            //     context, AcceptReturn()),
            Divider(thickness: 2),
          ],
        ),
      ),
    );
  }
}
