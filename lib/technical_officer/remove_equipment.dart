import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/others/user_provider.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class RemoveEquipment extends StatefulWidget {
  const RemoveEquipment({Key? key}) : super(key: key);

  @override
  _RemoveEquipmentState createState() => _RemoveEquipmentState();
}

class _RemoveEquipmentState extends State<RemoveEquipment> {
  bool _loading = false;
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

  Future<void> _removeEq(String eqId) async {
    setState(() => _loading = true);
    try {
      await postReqWithoutBody(Client(), removeEqURL + eqId);
      Fluttertoast.showToast(
        msg: "Successfully Removed",
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      throw Exception("Loading Failed");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TONavigationDrawer(),
      appBar: getAppBar(context, "Remove Equipment"),
      body: _loading
          ? Loading()
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      ElevatedButton(
                        child: Text("Scan Barcode"),
                        onPressed: () => _scanBarcode(),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blue[800]),
                      ),
                      SizedBox(height: 20.0),
                      _barcode == null
                          ? Container()
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Text("Equipment ID: $_barcode"),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                      SizedBox(height: 20.0),
                      _barcode == null
                          ? Container()
                          : Consumer<UserProvider>(
                              builder: (context, userProvider, _) =>
                                  ElevatedButton(
                                child: Text("Remove Equipment"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue[800]),
                                onPressed: () {
                                  _removeEq(_barcode.toString());
                                  userProvider.removeEquipment();
                                },
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
