import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/student/stu_request_details.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';

class RequestHistory extends StatefulWidget {
  const RequestHistory({Key? key}) : super(key: key);

  @override
  _RequestHistoryState createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  List? _data;

  Future<List> _loadData(BuildContext context) async {
    Map resBody = await getReq(context, Client(), getAllReqsURL);
    return resBody["msg"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavigationDrawer(),
      appBar: getAppBar(context, "Request History"),
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
                        child: Text(_data![index]["requestId"].toString()),
                        onPressed: () {},
                      ),
                      title: Text(_data![index]["dateOfBorrowing"]),
                      subtitle: Text("Date of Borrowing"),
                      trailing: lecturerRequestsListTieIcon(
                          context,
                          StuRequestDetails(
                            reqId: _data![index]["requestId"],
                            status: _data![index]["state"],
                          )),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
