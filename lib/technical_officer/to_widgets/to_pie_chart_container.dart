import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../others/constants.dart';

class TOPieChartContainer extends StatefulWidget {
  late final List data;
  TOPieChartContainer({required this.data});

  @override
  _TOPieChartContainerState createState() => _TOPieChartContainerState();
}

class _TOPieChartContainerState extends State<TOPieChartContainer> {
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
                sections: [
                  PieChartSectionData(
                    value: double.parse(widget.data[4]["count"].toString()),
                    color: Colors.yellow,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: double.parse(widget.data[2]["count"].toString()),
                    color: Colors.deepOrange,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: double.parse(widget.data[5]["count"].toString()),
                    color: Colors.red,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: double.parse(widget.data[3]["count"].toString()),
                    color: Colors.purpleAccent,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: double.parse(widget.data[1]["count"].toString()),
                    color: Colors.blue,
                    showTitle: false,
                  ),
                  PieChartSectionData(
                    value: double.parse(widget.data[0]["count"].toString()),
                    color: Colors.green,
                    showTitle: false,
                  ),
                ],
                centerSpaceRadius: 50,
                // sectionsSpace: 0,
                // startDegreeOffset: 90,
              ),
            ),
          ),
          _requestDetailCard(Icons.check_circle, Colors.green,
              "Available Equipment", widget.data[0]["count"]),
          _requestDetailCard(Icons.timelapse_rounded, Colors.blue,
              "Requested Equipment", widget.data[1]["count"]),
          _requestDetailCard(Icons.refresh_rounded, Colors.deepOrange,
              "Temporarily Borrowed", widget.data[2]["count"]),
          _requestDetailCard(Icons.forward, Colors.purpleAccent,
              "Borrowed Equipment", widget.data[3]["count"]),
          _requestDetailCard(Icons.report_problem_rounded, Colors.yellow,
              "Not Usable Equipment", widget.data[4]["count"]),
          _requestDetailCard(Icons.cancel, Colors.red, "Removed Equipment",
              widget.data[5]["count"]),
        ],
      ),
    );
  }
}
