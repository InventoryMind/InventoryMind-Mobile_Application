import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../others/constants.dart';

class LecturerPieChartContainer extends StatefulWidget {
  late final List data;
  LecturerPieChartContainer({required this.data});

  @override
  _LecturerPieChartContainerState createState() =>
      _LecturerPieChartContainerState();
}

class _LecturerPieChartContainerState extends State<LecturerPieChartContainer> {
  Widget _requestDetailCard(
      IconData icon, Color color, String title, dynamic val) {
    return Card(
      color: kSecondaryColor,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        side: BorderSide(color: Colors.white24),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        trailing: Text(val.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text(
            "Request Details",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 215,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: double.parse(widget.data[0]["count"].toString()),
                    color: Colors.blue,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: double.parse(widget.data[1]["count"].toString()),
                    color: Colors.green,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: double.parse(widget.data[2]["count"].toString()),
                    color: Colors.red,
                    showTitle: false,
                  ),
                ],
                centerSpaceRadius: 50,
              ),
            ),
          ),
          _requestDetailCard(Icons.pending, Colors.blue, "Pending Requests",
              widget.data[0]["count"]),
          _requestDetailCard(Icons.check_circle, Colors.green,
              "Approved Requests", widget.data[1]["count"]),
          _requestDetailCard(Icons.cancel, Colors.red, "Rejected Requests",
              widget.data[2]["count"]),
        ],
      ),
    );
  }
}
