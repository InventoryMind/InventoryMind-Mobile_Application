import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_pie_chart_container.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/widgets/widgets.dart';
import 'package:inventory_mind/urls.dart';
import 'package:http/http.dart';
import '../constants.dart';

class TODashboard extends StatefulWidget {
  @override
  _TODashboardState createState() => _TODashboardState();
}

class _TODashboardState extends State<TODashboard> {
  bool _loading = false;

  // @override
  // Future<void> initState() async {
  //   super.initState();
  //   Response response = await get(Uri.parse(toDashURL),
  //       headers: {"cookie": "auth-token=" + kToken});
  //   Map resBody = jsonDecode(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TONavigationDrawer(),
      appBar: getAppBar(context, "Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Calender(),
            TOPieChartContainer(),
          ],
        ),
      ),
    );
  }
}
