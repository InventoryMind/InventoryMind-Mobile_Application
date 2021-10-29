import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';

class BorrowingDetails extends StatelessWidget {
  const BorrowingDetails({Key? key}) : super(key: key);

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

  Widget _eqTable() {
    List<TableRow> _rows = [
      TableRow(
        children: [
          TableCell(child: _tableHeaderText("Type")),
          TableCell(child: _tableHeaderText("Brand")),
          TableCell(child: _tableHeaderText("Total")),
        ],
      )
    ];
    for (int i = 0; i < 3; i++) {
      _rows.add(
        TableRow(
          children: [
            TableCell(child: Center(child: Text(i.toString()))),
            TableCell(child: Center(child: Text(i.toString()))),
            TableCell(child: Center(child: Text(i.toString()))),
          ],
        ),
      );
    }
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            _detailedCard(Icons.code, "96587", "Borrow ID"),
            _detailedCard(
                Icons.category, "Temporary Borrowing", "Borrowing Type"),
            _detailedCard(Icons.next_plan, "2021/10/10", "Date of Borrowing"),
            _detailedCard(
                Icons.stacked_bar_chart, "Returned", "Borrowing Status"),
            _detailedCard(Icons.comment, "For a Guest Lecture", "Reason"),
            Card(
              child: ListTile(
                leading: IconButton(
                    icon: Icon(Icons.format_list_bulleted), onPressed: () {}),
                title: _eqTable(),
                subtitle: Container(
                  child: Text("Equipment Details"),
                  margin: EdgeInsets.only(bottom: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
