import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/constants.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/others/user_provider.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AcceptReturn extends StatefulWidget {
  const AcceptReturn({Key? key}) : super(key: key);

  @override
  _AcceptReturnState createState() => _AcceptReturnState();
}

class _AcceptReturnState extends State<AcceptReturn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idCont = TextEditingController();
  String? _borrowType;
  List _idList = [];
  List<bool> _selected = [];
  bool _successful = true;
  bool _loading = false;

  void _scanBarcode() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#FFFF00", "Cancel", true, ScanMode.BARCODE)
        .then((data) => setState(() {
              if ((data != "-1") && (_idList.contains(data))) {
                _selected[_idList.indexOf(data)] = true;
              }
            }));
  }

  Future<List> _getBorrowDetails(String borrowId, String type) async {
    setState(() => _loading = true);
    if (type == "Normal Borrowing") {
      type = "normal";
    } else {
      type = "temporary";
    }
    Map? resBody;
    try {
      resBody = await postReqWithBody(
          Client(), getBorDetailsURL, {"borrowId": borrowId, "type": type});
    } catch (e) {
      throw Exception("Loading Failed");
    } finally {
      setState(() => _loading = false);
    }
    return resBody["msg"];
  }

  Future<void> _mark(String borrowId, String type) async {
    if (type == "Normal Borrowing") {
      type = "normal";
    } else {
      type = "temporary";
    }
    try {
      await postReqWithBody(
          Client(), acceptReturnURL, {"borrowId": borrowId, "type": type});
      Fluttertoast.showToast(
        msg: "Equipment Returned Successfully",
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
      appBar: getAppBar(context, "Returned Equipment"),
      body: _loading
          ? Loading()
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      inputTextFormField(_idCont, "Borrowing ID"),
                      SizedBox(height: 30.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton(
                          value: _borrowType,
                          hint: Text("Borrowing Type"),
                          items: ["Normal Borrowing", "Temporary Borrowing"]
                              .map((val) {
                            return DropdownMenuItem(
                                value: val, child: Text(val));
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              _borrowType = val.toString();
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
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        child: Text("Get Details"),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blue[800]),
                        onPressed: () async {
                          if ((_formKey.currentState!.validate()) &&
                              (_borrowType != null)) {
                            List _temp = await _getBorrowDetails(
                                _idCont.text, _borrowType!);
                            setState(() {
                              _idList = _temp;
                              _selected = List<bool>.generate(
                                  _idList.length, (int index) => false);
                            });
                          }
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
                                  cells: <DataCell>[
                                    DataCell(Text(_idList[index]))
                                  ],
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
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[800]),
                            ),
                      SizedBox(height: 20.0),
                      Consumer<UserProvider>(
                        builder: (context, userProvider, _) => ElevatedButton(
                          child: Text("Mark As Returned"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[800]),
                          onPressed: () {
                            _selected.forEach((e) {
                              if (!e) {
                                _successful = false;
                              }
                            });
                            if (_successful) {
                              _mark(_idCont.text, _borrowType!);
                              userProvider.increaseAvailable(_idList.length);
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
