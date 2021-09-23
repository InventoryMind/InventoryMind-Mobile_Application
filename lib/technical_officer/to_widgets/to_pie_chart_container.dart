import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class TOPieChartContainer extends StatelessWidget {
  final List<PieChartSectionData> _pieChartSectionData = [
    PieChartSectionData(
      value: 10,
      color: Colors.yellow,
      showTitle: false,
    ),
    PieChartSectionData(
      value: 12,
      color: Colors.deepOrange,
      showTitle: false,
    ),
    PieChartSectionData(
      value: 5,
      color: Colors.red,
      showTitle: false,
    ),
    PieChartSectionData(
      value: 5,
      color: Colors.purpleAccent,
      showTitle: false,
    ),
    PieChartSectionData(
      value: 5,
      color: Colors.blue,
      showTitle: false,
    ),
    PieChartSectionData(
      value: 5,
      color: Colors.green,
      showTitle: false,
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
            "Equipment Details",
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
              Icons.check_circle, Colors.green, "Available Equipment", 10),
          _requestDetailCard(
              Icons.timelapse_rounded, Colors.blue, "Requested Equipment", 10),
          _requestDetailCard(Icons.refresh_rounded, Colors.deepOrange,
              "Temporarily Borrowed", 10),
          _requestDetailCard(
              Icons.forward, Colors.purpleAccent, "Borrowed Equipment", 10),
          _requestDetailCard(Icons.report_problem_rounded, Colors.yellow,
              "Not Usable Equipment", 20),
          _requestDetailCard(Icons.cancel, Colors.red, "Removed Equipment", 5),
        ],
      ),
    );
  }
}
