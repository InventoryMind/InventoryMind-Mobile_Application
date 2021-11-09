import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:http/http.dart';

class TemporaryBorrowing extends StatefulWidget {
  const TemporaryBorrowing({Key? key}) : super(key: key);

  @override
  _TemporaryBorrowingState createState() => _TemporaryBorrowingState();
}

class _TemporaryBorrowingState extends State<TemporaryBorrowing> {
  final _formKey = GlobalKey<FormState>();
  DateTime _borrowing = DateTime.now();
  final TextEditingController _reasonCont = TextEditingController();
  String? _id;
  List<String> _barcodes = [];
  bool _isChecked = false;
  bool _loading = false;

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
              if ((!_barcodes.contains(data.toString())) && (data != "-1")) {
                _barcodes.add(data.toString());
              }
            }));
  }

  Future<void> _tempBorrow(String reason, List eqIds) async {
    setState(() => _loading = true);
    try {
      await postReqWithEncodedBody(
          Client(), tempBorURL, {"reason": reason, "eqIds": eqIds});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StudentNavigationDrawer(),
      appBar: getAppBar(context, "Temporary Borrowing"),
      body: _loading
          ? Loading()
          : Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                                      borderRadius: BorderRadius.circular(20.0),
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
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text("No. of Equipment : ${_barcodes.length}"),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                            ),
                            Text(
                                "Return Date : ${_borrowing.year}/${_borrowing.month}/${_borrowing.day}")
                          ],
                        ),
                        SizedBox(height: 15.0),
                        ElevatedButton(
                          child: Text("Borrow Equipment"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[800]),
                          onPressed: () {
                            if ((_formKey.currentState!.validate()) &&
                                (_id != null) &&
                                (_barcodes.isNotEmpty)) {
                              _tempBorrow(_reasonCont.text, _barcodes);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
