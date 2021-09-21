import 'package:flutter/material.dart';
import 'package:inventory_mind/widgets/widgets.dart';

class AcceptedRequests extends StatelessWidget {
  const AcceptedRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar("Accepted Requests"),
    );
  }
}
