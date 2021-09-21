import 'package:flutter/material.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/widgets.dart';
import 'to_widgets/barcode_generator.dart';
import '../constants.dart';

class AddEquipment extends StatefulWidget {
  const AddEquipment({Key? key}) : super(key: key);

  @override
  _AddEquipmentState createState() => _AddEquipmentState();
}

class _AddEquipmentState extends State<AddEquipment> {
  String? _eqType;
  String? _barcode;
  List<String> _eqTypes = ["a", "b", "c"];
  final TextEditingController _nameCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TONavigationDrawer(),
      appBar: getAppBar("Add Equipment"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              inputTextField(_nameCont, "Name of the Equipment"),
              SizedBox(height: 30.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  value: _eqType,
                  hint: Text("Equipment Type"),
                  items: _eqTypes.map((val) {
                    return DropdownMenuItem(value: val, child: Text(val));
                  }).toList(),
                  onChanged: (val) {
                    setState(() => _eqType = val.toString());
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
                child: Text("Add Equipment"),
                style: ElevatedButton.styleFrom(primary: Colors.blue[800]),
                onPressed: () {
                  setState(() {
                    _barcode = "180652A";
                  });
                },
              ),
              SizedBox(height: 30.0),
              _barcode == null
                  ? Container()
                  : BarcodeGenerator(barcode: _barcode.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
