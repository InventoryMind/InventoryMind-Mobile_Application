import 'package:flutter/material.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/lecturer/lecturer_widgets/lecturer_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';
import 'lecturer_widgets/lecturer_pie_chart_container.dart';

class LecturerDashboard extends StatelessWidget {
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
