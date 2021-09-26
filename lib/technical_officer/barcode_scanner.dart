import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';

class BarcodeScanner extends StatefulWidget {
  const BarcodeScanner({Key? key}) : super(key: key);

  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
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
      appBar: getAppBar(context, "Barcode Scanner"),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text("Scan Barcode"),
                  onPressed: () => _scanBarcode(),
                  style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                ),
                SizedBox(height: 20.0),
                _barcode == null
                    ? Container()
                    : Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text("Equipment ID: $_barcode"),
                        decoration: BoxDecoration(
                          // color: kSecondaryColor,
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
