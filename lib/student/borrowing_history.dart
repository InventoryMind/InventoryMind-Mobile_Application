import 'package:flutter/material.dart';
import 'package:inventory_mind/lecturer/lecturer_widgets/lecturer_navigation_drawer.dart';
import 'package:inventory_mind/lecturer/request_details.dart';
import 'package:inventory_mind/student/stu_request_details.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';

import 'borrowing_details.dart';

class BorrowingHistory extends StatefulWidget {
  const BorrowingHistory({Key? key}) : super(key: key);

  @override
  _BorrowingHistoryState createState() => _BorrowingHistoryState();
}

class _BorrowingHistoryState extends State<BorrowingHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavigationDrawer(),
      appBar: getAppBar("Borrowing History"),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              leading: TextButton(
                child: Text(index.toString()),
                onPressed: () {},
              ),
              title: Text("2021/10/10"),
              subtitle: Text("Date of Borrowing"),
              trailing:
                  lecturerRequestsListTieIcon(context, BorrowingDetails()),
            ),
          );
        },
      ),
    );
  }
}
