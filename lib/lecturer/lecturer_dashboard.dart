import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/lecturer/lecturer_widgets/lecturer_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'lecturer_widgets/lecturer_pie_chart_container.dart';

class LecturerDashboard extends StatefulWidget {
  @override
  _LecturerDashboardState createState() => _LecturerDashboardState();
}

class _LecturerDashboardState extends State<LecturerDashboard> {
  Future<void> _loadData() async {
    Map resBody = await getReq(Client(), lecDashURL);
    print(resBody);
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LecturerNavigationDrawer(),
      appBar: getAppBar(context, "Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Calender(),
            LecturerPieChartContainer(),
          ],
        ),
      ),
    );
  }
}
