import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeGenerator extends StatefulWidget {
  const BarcodeGenerator(String barcode, {Key? key}) : super(key: key);

  @override
  _BarcodeGeneratorState createState() => _BarcodeGeneratorState();
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BarcodeWidget(
          barcode: Barcode.code39(),
          data: "180652A",
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          drawText: true,
          backgroundColor: Colors.white,
        ),
        SizedBox(height: 20.0),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Text("180652A"),
          decoration: BoxDecoration(
            // color: kSecondaryColor,
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
        )
      ],
    );
  }
}
