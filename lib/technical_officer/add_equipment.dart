import 'package:flutter/material.dart';
import 'package:inventory_mind/others/common_methods.dart';
import 'package:inventory_mind/others/urls.dart';
import 'package:inventory_mind/others/user_provider.dart';
import 'package:inventory_mind/technical_officer/to_widgets/to_navigation_drawer.dart';
import 'package:inventory_mind/widgets/loading.dart';
import 'package:inventory_mind/widgets/widget_methods.dart';
import 'package:provider/provider.dart';
import 'to_widgets/barcode_generator.dart';
import '../others/constants.dart';
import 'package:http/http.dart';

class AddEquipment extends StatefulWidget {
  const AddEquipment({Key? key}) : super(key: key);

  @override
  _AddEquipmentState createState() => _AddEquipmentState();
}

class _AddEquipmentState extends State<AddEquipment> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  String? _eqType;
  String? _typeId;
  String? _barcode;
  List? _eqTypes;
  final TextEditingController _nameCont = TextEditingController();

  Future<List> _loadData(BuildContext context) async {
    Map resBody = await getReq(context, Client(), getEqTypesURL);
    return resBody["data"];
  }

  Future<String?> _getBarcode(String name, String typeId) async {
    setState(() => _loading = true);
    Map? resBody;
    try {
      resBody = await postReqWithBody(
          Client(), addEqURL, {"name": name, "typeId": typeId});
    } catch (e) {
      throw Exception("Loading Failed");
    } finally {
      setState(() => _loading = false);
    }
    return resBody["eqId"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: TONavigationDrawer(),
      appBar: getAppBar(context, "Add Equipment"),
      body: _loading
          ? Loading()
          : FutureBuilder(
              future: _loadData(context),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Loading();
                } else {
                  _eqTypes = snapshot.data as List;
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            inputTextFormField(
                                _nameCont, "Name of the Equipment"),
                            SizedBox(height: 30.0),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: DropdownButton(
                                value: _eqType,
                                hint: Text("Equipment Type"),
                                items: _eqTypes!.map((val) {
                                  return DropdownMenuItem(
                                      value: val["name"],
                                      child: Text(val["name"]));
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    _eqType = val.toString();
                                    for (var x in _eqTypes!) {
                                      if (x["name"] == _eqType) {
                                        _typeId = x["typeId"];
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
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Consumer<UserProvider>(
                              builder: (context, userProvider, _) =>
                                  ElevatedButton(
                                child: Text("Add Equipment"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue[800]),
                                onPressed: () async {
                                  if ((_formKey.currentState!.validate()) &&
                                      (_eqType != null)) {
                                    String? _temp = await _getBarcode(
                                      _nameCont.text,
                                      _typeId.toString(),
                                    );
                                    userProvider.increaseAvailable(1);
                                    setState(() {
                                      _barcode = _temp.toString();
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                            _barcode == null
                                ? Container()
                                : BarcodeGenerator(
                                    barcode: _barcode.toString()),
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
