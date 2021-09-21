import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AcceptReturn extends StatefulWidget {
  const AcceptReturn({Key? key}) : super(key: key);

  @override
  _AcceptReturnState createState() => _AcceptReturnState();
}

class _AcceptReturnState extends State<AcceptReturn> {
  final TextEditingController _idCont = TextEditingController();
  List<String> _idList = [];
  List<bool> _selected = [];
  bool _successful = true;

  String? _barcode;
  void _scanBarcode() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#FFFF00", "Cancel", true, ScanMode.BARCODE)
        .then((data) => setState(() {
              if (_idList.contains(data)) {
                _selected[_idList.indexOf(data)] = true;
              }
              _selected[_idList.indexOf("12345")] = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TONavigationDrawer(),
      appBar: getAppBar("Returned Equipment"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              inputTextField(_idCont, "Borrowing ID"),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("Get Details"),
                style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                onPressed: () {
                  setState(() {
                    _idList = ["12345", "67891", "23456"];
                    _selected = List<bool>.generate(
                        _idList.length, (int index) => false);
                  });
                },
              ),
              SizedBox(height: 10.0),
              _idList == []
                  ? Container()
                  : DataTable(
                      columns: const <DataColumn>[
                        DataColumn(label: Text('Equipment IDs')),
                      ],
                      rows: List<DataRow>.generate(
                        _idList.length,
                        (int index) => DataRow(
                          cells: <DataCell>[DataCell(Text(_idList[index]))],
                          selected: _selected[index],
                          onSelectChanged: (bool? val) {},
                        ),
                      ),
                    ),
              SizedBox(height: 10.0),
              _idList == []
                  ? Container()
                  : ElevatedButton(
                      child: Text("Scan Barcode"),
                      onPressed: () => _scanBarcode(),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.blue[800]),
                    ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("Mark As Returned"),
                style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                onPressed: () {
                  _selected.forEach((e) {
                    if (!e) {
                      _successful = false;
                    }
                  });
                  if (_successful) {
                    print("Yay !");
                  } else {
                    alertDialogBox(
                            context,
                            AlertType.warning,
                            "Request Unsuccessful",
                            "Every equipment should be returned to complete the request.")
                        .show();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
