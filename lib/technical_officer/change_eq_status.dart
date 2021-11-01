import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/providers/user_provider.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../others/constants.dart';

class ChangeStatus extends StatefulWidget {
  const ChangeStatus({Key? key}) : super(key: key);

  @override
  _ChangeStatusState createState() => _ChangeStatusState();
}

class _ChangeStatusState extends State<ChangeStatus> {
  bool _loading = false;
  String? _cond;
  List _conditions = ["Mark As Available", "Mark As Not Usable"];
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

  Future<void> _change(String eqId, String? cond) async {
    String? _url;
    if (cond.toString() == "Mark As Available") {
      _url = mAvailableURL + eqId;
    } else if (cond.toString() == "Mark As Not Usable") {
      _url = mNotUsableURL + eqId;
    }
    setState(() => _loading = true);
    try {
      await postReqWithoutBody(Client(), _url.toString());
      Fluttertoast.showToast(
        msg: "Successfully Changed",
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
      appBar: getAppBar(context, "Change Eq. Status"),
      body: _loading
          ? Loading()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: DropdownButton(
                      value: _cond,
                      hint: Text("Equipment Status"),
                      items: _conditions.map((val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _cond = val.toString();
                        });
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
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                      : Consumer<UserProvider>(
                          builder: (context, userProvider, _) => ElevatedButton(
                            child: Text("Change Status"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue[800]),
                            onPressed: () {
                              if (_cond != null) {
                                _change(_barcode.toString(), _cond);
                                if (_cond.toString() == "Mark As Available") {
                                  userProvider.markAsAvailable();
                                } else if (_cond.toString() ==
                                    "Mark As Not Usable") {
                                  userProvider.markAsNotUsable();
                                }
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
