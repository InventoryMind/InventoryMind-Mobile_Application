import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/providers/user_provider.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_pie_chart_container.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class TODashboard extends StatefulWidget {
  @override
  _TODashboardState createState() => _TODashboardState();
}

class _TODashboardState extends State<TODashboard> {
  Future<List> _loadData() async {
    Map resBody = await getReq(Client(), toDashURL);
    return resBody["msg"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TONavigationDrawer(),
      appBar: getAppBar(context, "Dashboard"),
      body: FutureBuilder(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Loading();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Calender(),
                  Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      userProvider.tODashboardData = snapshot.data as List;
                      return TOPieChartContainer(
                          data: userProvider.tODashboardData);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
