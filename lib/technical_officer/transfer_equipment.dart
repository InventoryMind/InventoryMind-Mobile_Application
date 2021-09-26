import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';

import '../constants.dart';

class TransferEquipment extends StatefulWidget {
  const TransferEquipment({Key? key}) : super(key: key);

  @override
  _TransferEquipmentState createState() => _TransferEquipmentState();
}

class _TransferEquipmentState extends State<TransferEquipment> {
  String? _lab;
  List<String> _labs = [
    "03 - 1st Year Lab",
    "08 - Final Year Lab",
    "10 - ICE Lab"
  ];
  String? _barcode;
  _scanBarcode() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#FFFF00", "Cancel", true, ScanMode.BARCODE)
        .then((data) => setState(() {
              if (data != "-1") {
                _barcode = data;
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TONavigationDrawer(),
      appBar: getAppBar(context, "Transfer Equipment"),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: DropdownButton(
                value: _lab,
                hint: Text("Laboratory"),
                items: _labs.map((val) {
                  return DropdownMenuItem(value: val, child: Text(val));
                }).toList(),
                onChanged: (val) {
                  setState(() => _lab = val.toString());
                },
                isExpanded: true,
                underline: Container(),
              ),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              child: Text("Scan Barcode"),
              onPressed: () => _scanBarcode(),
              style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
            ),
            SizedBox(height: 20.0),
            _barcode == null
                ? Container()
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text("Equipment ID: $_barcode"),
                    decoration: BoxDecoration(
                      // color: kSecondaryColor,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
            SizedBox(height: 20.0),
            _barcode == null
                ? Container()
                : ElevatedButton(
                    child: Text("Transfer Equipment"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                    onPressed: () {},
                  ),
          ],
        ),
      ),
    );
  }
}
