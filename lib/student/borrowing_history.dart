import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';
import 'borrowing_details.dart';

class BorrowingHistory extends StatefulWidget {
  const BorrowingHistory({Key? key}) : super(key: key);

  @override
  _BorrowingHistoryState createState() => _BorrowingHistoryState();
}

class _BorrowingHistoryState extends State<BorrowingHistory> {
  List? _data;

  Future<List> _loadData(BuildContext context) async {
    Map resBody = await getReq(context, Client(), viewBorHistURL);
    return resBody["msg"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavigationDrawer(),
      appBar: getAppBar(context, "Borrowing History"),
      body: FutureBuilder(
          future: _loadData(context),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              _data = snapshot.data as List;
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: _data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: ListTile(
                      leading: TextButton(
                        child: Text(_data![index]["borrowId"].toString()),
                        onPressed: () {},
                      ),
                      title: Text(_data![index]["dateOfBorrowing"]),
                      subtitle: Text("Date of Borrowing"),
                      trailing: lecturerRequestsListTieIcon(
                        context,
                        BorrowingDetails(
                          borrowId: _data![index]["borrowId"].toString(),
                          type: _data![index]["type"],
                          status: _data![index]["state"],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
