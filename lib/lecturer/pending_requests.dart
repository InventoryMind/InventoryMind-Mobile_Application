import 'package:flutter/material.dart';
import 'package:inventory_mind/lecturer/lecturer_widgets/lecturer_navigation_drawer.dart';
import 'package:inventory_mind/lecturer/request_details.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/others/user_provider.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class PendingRequests extends StatefulWidget {
  const PendingRequests({Key? key}) : super(key: key);

  @override
  _PendingRequestsState createState() => _PendingRequestsState();
}

class _PendingRequestsState extends State<PendingRequests> {
  List? _data;

  Future<List> _loadData(BuildContext context) async {
    Map resBody = await getReq(context, Client(), getPendReqsURL);
    return resBody["msg"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LecturerNavigationDrawer(),
      appBar: getAppBar(context, "Pending Requests"),
      body: FutureBuilder(
          future: _loadData(context),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              _data = snapshot.data as List;
              return Consumer<UserProvider>(
                  builder: (context, userProvider, _) {
                userProvider.lecPending = _data!;
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
                        trailing: lecturerRequestsListTieIcon(context,
                            RequestDetails(reqId: _data![index]["requestId"])),
                      ),
                    );
                  },
                );
              });
            }
          }),
    );
  }
}
