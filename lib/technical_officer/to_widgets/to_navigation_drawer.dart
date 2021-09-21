import 'package:flutter/material.dart';
import 'package:inventory_mind/technical_officer/accept_return.dart';
import 'package:inventory_mind/technical_officer/add_equipment.dart';
import 'package:inventory_mind/technical_officer/remove_equipment.dart';
import 'package:inventory_mind/widgets/widgets.dart';

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
              leading: Icon(Icons.person),
              title: Text("User ID : 180652A", style: TextStyle(fontSize: 16)),
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
          ],
        ),
      ),
    );
  }
}
