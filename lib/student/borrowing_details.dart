import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';

class BorrowingDetails extends StatefulWidget {
  final String borrowId;
  final String type;
  final String status;
  const BorrowingDetails(
      {Key? key,
      required this.borrowId,
      required this.type,
      required this.status})
      : super(key: key);

  @override
  _BorrowingDetailsState createState() => _BorrowingDetailsState();
}

class _BorrowingDetailsState extends State<BorrowingDetails> {
  Map? _data;
  String? _type;

  Future<Map> _loadData() async {
    Map? resBody;
    String? _temp;
    if (widget.type == "Temporary Borrowed") {
      _temp = "temporary";
    } else if (widget.type == "Normal Borrowed") {
      _temp = "normal";
    }
    try {
      resBody = await postReqWithBody(Client(), stuViewBorURL,
          {"borrowId": widget.borrowId, "type": _temp});
    } catch (e) {
      throw Exception("Loading Failed");
    }
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
      appBar: getAppBar(context, "Borrowing Details"),
      body: FutureBuilder(
          future: _loadData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Loading();
            } else {
              _data = snapshot.data as Map;
              if (widget.type == "Temporary Borrowed") {
                _type = "Temporary Borrowing";
              } else if (widget.type == "Normal Borrowed") {
                _type = "Normal Borrowing";
              }
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    _detailedCard(Icons.code, widget.borrowId, "Borrow ID"),
                    _detailedCard(Icons.category, _type!, "Borrowing Type"),
                    _detailedCard(Icons.next_plan, _data!["date_of_borrowing"],
                        "Date of Borrowing"),
                    _detailedCard(Icons.stacked_bar_chart, widget.status,
                        "Borrowing Status"),
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
