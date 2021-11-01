import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';

class StuRequestDetails extends StatefulWidget {
  final String reqId;
  final String status;
  const StuRequestDetails({Key? key, required this.reqId, required this.status})
      : super(key: key);

  @override
  _StuRequestDetailsState createState() => _StuRequestDetailsState();
}

class _StuRequestDetailsState extends State<StuRequestDetails> {
  Map? _data;

  Future<Map> _loadData(BuildContext context) async {
    Map resBody = await getReq(context, Client(), stuViewReqURL + widget.reqId);
    return resBody["msg"];
  }

  Widget _detailedCard(IconData icon, String title, String subtitle) {
    return Card(
      child: ListTile(
        leading: IconButton(icon: Icon(icon), onPressed: () {}),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }

  Widget _tableHeaderText(String text) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[500],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _eqTable(Map _types) {
    List<TableRow> _rows = [
      TableRow(
        children: [
          TableCell(child: _tableHeaderText("Type")),
          TableCell(child: _tableHeaderText("Brand")),
          TableCell(child: _tableHeaderText("Total")),
        ],
      )
    ];
    _types.forEach((key, value) {
      _rows.add(
        TableRow(
          children: [
            TableCell(child: Center(child: Text(value["type"]))),
            TableCell(child: Center(child: Text(value["brand"]))),
            TableCell(child: Center(child: Text(value["count"].toString()))),
          ],
        ),
      );
    });
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Table(
        border: TableBorder.all(color: Colors.grey),
        children: _rows,
        columnWidths: const <int, TableColumnWidth>{2: FixedColumnWidth(60)},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "Request Details"),
      body: FutureBuilder(
          future: _loadData(context),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              _data = snapshot.data as Map;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    _detailedCard(Icons.code, _data!["request_id"].toString(),
                        "Request ID"),
                    _detailedCard(
                        Icons.person, _data!["lecturer"], "Lecturer's Name"),
                    _detailedCard(Icons.stacked_bar_chart, widget.status,
                        "Request Status"),
                    _detailedCard(Icons.next_plan, _data!["date_of_borrowing"],
                        "Date of Borrowing"),
                    _detailedCard(Icons.keyboard_return,
                        _data!["date_of_returning"], "Date of Returning"),
                    _detailedCard(Icons.comment, _data!["reason"], "Reason"),
                    Card(
                      child: ListTile(
                        leading: IconButton(
                            icon: Icon(Icons.format_list_bulleted),
                            onPressed: () {}),
                        title: _eqTable(_data!["types"]),
                        subtitle: Container(
                          child: Text("Equipment Details"),
                          margin: EdgeInsets.only(bottom: 10),
                        ),
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
