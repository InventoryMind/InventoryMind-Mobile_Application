import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../others/constants.dart';

class LecturerPieChartContainer extends StatelessWidget {
  final List<PieChartSectionData> _pieChartSectionData = [
    PieChartSectionData(
      value: 10,
      color: Colors.blue,
      showTitle: false,
      radius: 35,
    ),
    PieChartSectionData(
      value: 12,
      color: Colors.green,
      showTitle: false,
      radius: 32,
    ),
    PieChartSectionData(
      value: 5,
      color: Colors.red,
      showTitle: false,
      radius: 29,
    ),
  ];

  Widget _requestDetailCard(IconData icon, Color color, String title, int val) {
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
                sections: _pieChartSectionData,
                centerSpaceRadius: 50,
                // sectionsSpace: 0,
                // startDegreeOffset: 90,
              ),
            ),
          ),
          _requestDetailCard(
              Icons.pending, Colors.blue, "Pending Requests", 20),
          _requestDetailCard(
              Icons.check_circle, Colors.green, "Approved Requests", 10),
          _requestDetailCard(Icons.cancel, Colors.red, "Rejected Requests", 5),
        ],
      ),
    );
  }
}
