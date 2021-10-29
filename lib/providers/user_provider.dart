import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  List tODashboardData = [];

  void addEquipment() {
    tODashboardData[0]["count"] =
        int.parse(tODashboardData[0]["count"].toString()) + 1;
    notifyListeners();
  }

  void removeEquipment() {
    tODashboardData[0]["count"] =
        int.parse(tODashboardData[0]["count"].toString()) - 1;
    tODashboardData[5]["count"] =
        int.parse(tODashboardData[5]["count"].toString()) + 1;
    notifyListeners();
  }
}
