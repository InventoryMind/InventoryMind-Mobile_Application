import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';
import '../others/constants.dart';
import 'package:inventory_mind/others/urls.dart';

class BorrowingRequest extends StatefulWidget {
  const BorrowingRequest({Key? key}) : super(key: key);

  @override
  _BorrowingRequestState createState() => _BorrowingRequestState();
}

class _BorrowingRequestState extends State<BorrowingRequest> {
  final _formKey = GlobalKey<FormState>();
  String? _labId;
  String? _lecId;
  String? _borrowing;
  String? _returning;
  final TextEditingController _reasonCont = TextEditingController();
  String? _id;
  List<String> _barcodes = [];
  dynamic _borDate;
  Map? _data;
  bool _loading = false;

  Future<Map> _loadData(BuildContext context) async {
    Map _temp = {};
    Map resBody1 = await getReq(context, Client(), stuGetLabsURL);
    _temp["labs"] = resBody1["msg"] as List;
    Map resBody2 = await getReq(context, Client(), stuGetLecsURL);
    _temp["lecs"] = resBody2["msg"] as List;
    return _temp;
  }

  Future<void> _submit(Map body) async {
    setState(() => _loading = true);
    try {
      await postReqWithEncodedBody(Client(), borReqURL, body);
      Fluttertoast.showToast(
        msg: "Successfully Submitted",
        gravity: ToastGravity.BOTTOM,
      );
    } catch (e) {
      throw Exception("Loading Failed");
    } finally {
      setState(() => _loading = false);
      Navigator.pop(context);
    }
  }

  _scanID() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#FFFF00", "Cancel", true, ScanMode.BARCODE)
        .then((data) => setState(() {
              if (data != "-1") {
                _id = data;
              }
            }));
  }

  _scanBarcode() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#FFFF00", "Cancel", true, ScanMode.BARCODE)
        .then((data) => setState(() {
              if ((!_barcodes.contains(data)) && (data != "-1")) {
                _barcodes.add(data);
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavigationDrawer(),
      appBar: getAppBar(context, "Borrowing Request"),
      body: _loading
          ? Loading()
          : FutureBuilder(
              future: _loadData(context),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Loading();
                } else {
                  _data = snapshot.data as Map;
                  // print(_data);
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton(
                                value: _labId,
                                hint: Text("Laboratory"),
                                items: (_data!["labs"] as List).map((val) {
                                  return DropdownMenuItem(
                                    value: val["lab_id"],
                                    child: Text(
                                        val["lab_id"] + " - " + val["name"]),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _labId = val.toString();
                                  });
                                },
                                isExpanded: true,
                                underline: Container(),
                              ),
                              decoration: BoxDecoration(
                                color: kSecondaryColor,
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton(
                                value: _lecId,
                                hint: Text("Lecturer"),
                                items: (_data!["lecs"] as List).map((val) {
                                  return DropdownMenuItem(
                                    value: val["user_id"],
                                    child: Text(val["first_name"] +
                                        " " +
                                        val["last_name"]),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() => _lecId = val.toString());
                                },
                                isExpanded: true,
                                underline: Container(),
                              ),
                              decoration: BoxDecoration(
                                color: kSecondaryColor,
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Text("Borrowing Date"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[800]),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100),
                                      errorInvalidText: "Invalid Date",
                                    ).then((value) {
                                      setState(() {
                                        _borDate = value;
                                        _borrowing =
                                            "${value!.day}/${value.month}/${value.year}";
                                      });
                                    });
                                  },
                                ),
                                _borrowing == null
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.only(left: 30),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: Text(_borrowing.toString()),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Text("Returning Date"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[800]),
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate:
                                          _borDate.add(Duration(days: 1)),
                                      firstDate:
                                          _borDate.add(Duration(days: 1)),
                                      lastDate:
                                          _borDate.add(Duration(days: 14)),
                                      errorInvalidText: "Invalid Date",
                                    ).then((value) {
                                      setState(() {
                                        _returning =
                                            "${value!.day}/${value.month}/${value.year}";
                                      });
                                    });
                                  },
                                ),
                                _returning == null
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.only(left: 30),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: Text(_returning.toString()),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            inputTextFormField(_reasonCont, "Reason"),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  child: Text("Scan Student ID"),
                                  onPressed: () => _scanID(),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue[800]),
                                ),
                                _id == null
                                    ? Container()
                                    : Container(
                                        margin: EdgeInsets.only(left: 30),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        child: Text(_id.toString()),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                      ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              child: Text("Scan Equipment Barcode"),
                              onPressed: () => _scanBarcode(),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[800]),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Text(
                                  "No. of Equipment : ${_barcodes.length}"),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              child: Text("Submit Request"),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue[800]),
                              onPressed: () {
                                if ((_formKey.currentState!.validate()) &&
                                    (_labId != null) &&
                                    (_lecId != null) &&
                                    (_borrowing != null) &&
                                    (_returning != null) &&
                                    (_barcodes.isNotEmpty)) {
                                  _submit({
                                    "lecturerId": _lecId,
                                    "dateOfBorrowing": _borrowing,
                                    "dateOfReturning": _returning,
                                    "reason": _reasonCont.text,
                                    "eqIds": _barcodes,
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
    );
  }
}
