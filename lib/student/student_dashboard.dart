import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';

import '../others/constants.dart';
import 'borrowing_details.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  List? _data;

  Future<List> _loadData(BuildContext context) async {
    Map resBody = await getReq(context, Client(), stuDashURL);
    return resBody["msg"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavigationDrawer(),
      appBar: getAppBar(context, "Dashboard"),
      body: FutureBuilder(
          future: _loadData(context),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              _data = snapshot.data as List;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Calender(),
                    Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Pending Returns",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600)),
                          SizedBox(height: 20),
                          _data!.isEmpty
                              ? Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Text(
                                    "You do not have any pending equipment returns.",
                                    style: TextStyle(color: Colors.grey),
                                  ))
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(bottom: 10),
                                  itemCount: _data!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      color: kSecondaryColor,
                                      margin: EdgeInsets.all(5),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        side: BorderSide(color: Colors.white24),
                                      ),
                                      child: ListTile(
                                        leading: TextButton(
                                          child: Text(_data![index]["borrowId"]
                                              .toString()),
                                          onPressed: () {},
                                        ),
                                        title: Text(
                                            _data![index]["dateOfReturning"]),
                                        subtitle: Text("Returning Date"),
                                        trailing: IconButton(
                                          splashColor: Colors.blue,
                                          icon: Icon(
                                              Icons.remove_red_eye_rounded),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BorrowingDetails(
                                                  borrowId: _data![index]
                                                          ["borrowId"]
                                                      .toString(),
                                                  type: _data![index]["type"],
                                                  status: _data![index]
                                                      ["state"],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
