import 'package:flutter/material.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/calendar.dart';
import 'package:inventory_mind/widgets/widgets.dart';

import '../constants.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  List<String> _approvals = ["12345"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavigationDrawer(),
      appBar: getAppBar("Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Calender(),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Pending Approvals",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  SizedBox(height: 20),
                  _approvals.isEmpty
                      ? Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Text(
                            "You do not have any pending approvals at the moment.",
                            style: TextStyle(color: Colors.grey),
                          ))
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.only(bottom: 10),
                          itemCount: _approvals.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: kSecondaryColor,
                              margin: EdgeInsets.all(5),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                side: BorderSide(color: Colors.white24),
                              ),
                              child: ListTile(
                                leading: TextButton(
                                  child: Text(_approvals[index]),
                                  onPressed: () {},
                                ),
                                title: Text("2021/10/10"),
                                subtitle: Text("Date of Borrowing"),
                                trailing: IconButton(
                                  splashColor: Colors.blue,
                                  icon: Icon(Icons.remove_red_eye_rounded),
                                  onPressed: () {},
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
      ),
    );
  }
}
