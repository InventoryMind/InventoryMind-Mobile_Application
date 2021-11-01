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

class TransferEquipment extends StatefulWidget {
  const TransferEquipment({Key? key}) : super(key: key);

  @override
  _TransferEquipmentState createState() => _TransferEquipmentState();
}

class _TransferEquipmentState extends State<TransferEquipment> {
  bool _loading = false;
  String? _lab;
  String? _labId;
  List? _labs;
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

  Future<List> _loadData(BuildContext context) async {
    Map resBody = await getReq(context, Client(), getLabsURL);
    return resBody["msg"];
  }

  Future<void> _transferEq(String eqId, String labId) async {
    setState(() => _loading = true);
    try {
      await postReqWithBody(
          Client(), transferEqURL, {"eqId": eqId, "labId": labId});
      Fluttertoast.showToast(
        msg: "Successfully Transferred",
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
      appBar: getAppBar(context, "Transfer Equipment"),
      body: _loading
          ? Loading()
          : FutureBuilder(
              future: _loadData(context),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Loading();
                } else {
                  _labs = snapshot.data as List;
                  return Container(
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
                            items: _labs!.map((val) {
                              return DropdownMenuItem(
                                value: val["name"],
                                child:
                                    Text(val["lab_id"] + " - " + val["name"]),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                _lab = val.toString();
                                for (var x in _labs!) {
                                  if (x["name"] == _lab) {
                                    _labId = x["lab_id"];
                                    break;
                                  }
                                }
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
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[800]),
                        ),
                        SizedBox(height: 20.0),
                        _barcode == null
                            ? Container()
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Text("Equipment ID: $_barcode"),
                                decoration: BoxDecoration(
                                  // color: kSecondaryColor,
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
                                  child: Text("Transfer Equipment"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[800]),
                                  onPressed: () {
                                    if (_labId != null) {
                                      _transferEq(
                                        _barcode.toString(),
                                        _labId.toString(),
                                      );
                                      userProvider.decreaseAvailableByOne();
                                    }
                                  },
                                ),
                              ),
                      ],
                    ),
                  );
                }
              }),
    );
  }
}
