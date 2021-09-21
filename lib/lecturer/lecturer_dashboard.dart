import 'package:flutter/material.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/lecturer/lecturer_widgets/lecturer_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';
import 'lecturer_widgets/lecturer_pie_chart_container.dart';

class LecturerDashboard extends StatefulWidget {
  @override
  _LecturerDashboardState createState() => _LecturerDashboardState();
}

class _LecturerDashboardState extends State<LecturerDashboard> {
  // String _code = "";
  // _scanBarcode() async {
  //   await FlutterBarcodeScanner.scanBarcode(
  //       "#FFFF00", "Cancel", true, ScanMode.BARCODE)
  //       .then((data) => setState(() => _code = data));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LecturerNavigationDrawer(),
      appBar: getAppBar("Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Calender(),
            LecturerPieChartContainer(),
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
