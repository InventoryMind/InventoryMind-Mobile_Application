import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeGenerator extends StatelessWidget {
  final barcode;
  const BarcodeGenerator({Key? key, @required this.barcode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BarcodeWidget(
          barcode: Barcode.code39(),
          data: barcode,
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          drawText: true,
          backgroundColor: Colors.white,
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text("Equipment ID: $barcode"),
          decoration: BoxDecoration(
            // color: kSecondaryColor,
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        SizedBox(height: 20.0),
        Text(
            "Note: Please use the web application to export the barcode as an image."),
      ],
    );
  }
}
