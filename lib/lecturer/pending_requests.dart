import 'package:flutter/material.dart';
import 'package:inventory_mind/lecturer/lecturer_widgets/lecturer_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({Key? key}) : super(key: key);

  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LecturerNavigationDrawer(),
      appBar: getAppBar("Pending Requests"),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
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
              title: Text("Borrowing : 2021/10/10"),
              subtitle: Text("Returning : 2021/10/15"),
              trailing: lecturerRequestsListTieIcon(),
            ),
            shape: lecturerRequestsCardBorder(),
          );
        },
      ),
    );
  }
}
