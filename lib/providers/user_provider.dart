import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  List tODashboardData = [];
  List lecDashboardData = [];
  List lecPending = [];
  List lecApproved = [];
  List lecRejected = [];

  void increaseAvailable(int n) {
    tODashboardData[0]["count"] =
        int.parse(tODashboardData[0]["count"].toString()) + n;
    notifyListeners();
  }

  void decreaseAvailableByOne() {
    tODashboardData[0]["count"] =
        int.parse(tODashboardData[0]["count"].toString()) - 1;
    notifyListeners();
  }

  void removeEquipment() {
    this.decreaseAvailableByOne();
    tODashboardData[5]["count"] =
        int.parse(tODashboardData[5]["count"].toString()) + 1;
    notifyListeners();
  }

  void markAsAvailable() {
    this.increaseAvailable(1);
    tODashboardData[4]["count"] =
        int.parse(tODashboardData[4]["count"].toString()) - 1;
    notifyListeners();
  }

  void markAsNotUsable() {
    this.decreaseAvailableByOne();
    tODashboardData[4]["count"] =
        int.parse(tODashboardData[4]["count"].toString()) + 1;
    notifyListeners();
  }

  void decreasePendingByOne() {
    lecDashboardData[0]["count"] =
        int.parse(lecDashboardData[0]["count"].toString()) - 1;
    notifyListeners();
  }

  void increaseApprovedByOne() {
    lecDashboardData[1]["count"] =
        int.parse(lecDashboardData[1]["count"].toString()) + 1;
    notifyListeners();
  }

  void increaseRejectedByOne() {
    lecDashboardData[2]["count"] =
        int.parse(lecDashboardData[2]["count"].toString()) + 1;
    notifyListeners();
  }

  void approve(String reqId) {
    int? _index;
    for (int i = 0; i < lecPending.length; i++) {
      if (lecPending[i]["requestId"] == reqId) {
        _index = i;
        break;
      }
    }
    lecApproved.add(lecPending[int.parse(_index.toString())]);
    lecPending.removeAt(int.parse(_index.toString()));
    this.increaseApprovedByOne();
    this.decreasePendingByOne();
    notifyListeners();
  }

  void reject(String reqId) {
    int? _index;
    for (int i = 0; i < lecPending.length; i++) {
      if (lecPending[i]["requestId"] == reqId) {
        _index = i;
        break;
      }
    }
    lecRejected.add(lecPending[int.parse(_index.toString())]);
    lecPending.removeAt(int.parse(_index.toString()));
    this.increaseRejectedByOne();
    this.decreasePendingByOne();
    notifyListeners();
  }
}
