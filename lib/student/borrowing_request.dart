import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_mind/student/student_widgets/student_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';

import '../constants.dart';

class BorrowingRequest extends StatefulWidget {
  const BorrowingRequest({Key? key}) : super(key: key);

  @override
  _BorrowingRequestState createState() => _BorrowingRequestState();
}

class _BorrowingRequestState extends State<BorrowingRequest> {
  String? _lab;
  List<String> _labs = ["03 - 1st Year", "08 - Final Year", "10 - ICE"];
  String? _lecturer;
  List<String> _lecturers = ["Dr. ABC", "Dr. UYZ", "Dr LKM"];
  String? _borrowing;
  String? _returning;
  final TextEditingController _reasonCont = TextEditingController();
  String? _id;
  List<String> _barcodes = [];
  dynamic _borDate;

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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
          padding: EdgeInsets.all(20),
          child: Column(
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  value: _lecturer,
                  hint: Text("Lecturer"),
                  items: _lecturers.map((val) {
                    return DropdownMenuItem(value: val, child: Text(val));
                  }).toList(),
                  onChanged: (val) {
                    setState(() => _lecturer = val.toString());
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text("Borrowing Date"),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
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
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text(_borrowing.toString()),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20.0),
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
                    style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: _borDate.add(Duration(days: 1)),
                        firstDate: _borDate.add(Duration(days: 1)),
                        lastDate: _borDate.add(Duration(days: 14)),
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
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text(_returning.toString()),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 20.0),
              inputTextField(_reasonCont, "Reason"),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text("Scan Student ID"),
                    onPressed: () => _scanID(),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                  ),
                  _id == null
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(left: 30),
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          child: Text(_id.toString()),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("Scan Equipment Barcode"),
                onPressed: () => _scanBarcode(),
                style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text("No. of Equipment : ${_barcodes.length}"),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("Submit Request"),
                style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
