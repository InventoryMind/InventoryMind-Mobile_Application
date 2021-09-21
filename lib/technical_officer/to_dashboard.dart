import 'package:flutter/material.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/widgets/widgets.dart';

class TODashboard extends StatefulWidget {
  const TODashboard({Key? key}) : super(key: key);

  @override
  _TODashboardState createState() => _TODashboardState();
}

class _TODashboardState extends State<TODashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TONavigationDrawer(),
      appBar: getAppBar("Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Calender(),
            // LecturerPieChartContainer(),
            //   ElevatedButton(
            //     child: Text("Scan Barcode"),
            //     onPressed: () => _scanBarcode(),
            //   ),
            //   Text(_code),
          ],
        ),
      ),
    );
  }
}
