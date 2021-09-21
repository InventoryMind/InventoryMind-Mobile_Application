import 'package:flutter/material.dart';
import 'package:inventory_mind/technical_officer/add_equipment.dart';
import 'package:inventory_mind/widgets/widgets.dart';

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
            // _buildNavItem("Rejected Requests", Icons.cancel),
          ],
        ),
      ),
    );
  }
}
