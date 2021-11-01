import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/others/user_provider.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/lecturer/lecturer_widgets/lecturer_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:provider/provider.dart';
import 'lecturer_widgets/lecturer_pie_chart_container.dart';

class LecturerDashboard extends StatefulWidget {
  @override
  _LecturerDashboardState createState() => _LecturerDashboardState();
}

class _LecturerDashboardState extends State<LecturerDashboard> {
  Future<List> _loadData(BuildContext context) async {
    Map resBody = await getReq(context, Client(), lecDashURL);
    return resBody["msg"]["data"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LecturerNavigationDrawer(),
      appBar: getAppBar(context, "Dashboard"),
      body: FutureBuilder(
          future: _loadData(context),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Calender(),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, _) {
                        userProvider.lecDashboardData = snapshot.data as List;
                        return LecturerPieChartContainer(
                            data: userProvider.lecDashboardData);
                      },
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
