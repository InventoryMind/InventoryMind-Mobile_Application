class Lecturer {
  late String totPending;
  late String totApproved;
  late String totRejected;

  Lecturer({required Map map}) {
    this.totPending = map["msg"]["data"][0]["count"];
    this.totApproved = map["msg"]["data"][1]["count"];
    this.totRejected = map["msg"]["data"][2]["count"];
  }
}

// '{"msg": {"action": true, "data": [{"state": "Pending", "count": 1}, {"state": "Approved", "count": 1}, {"state": "Rejected", "count": 1}]}}'
