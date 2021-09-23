class TechOff {
  late String available;
  late String requested;
  late String tempBorrowed;
  late String borrowed;
  late String notUsable;
  late String removed;

  TechOff({required Map map}) {
    this.available = map["msg"]["data"][0]["count"];
    this.requested = map["msg"]["data"][1]["count"];
    this.tempBorrowed = map["msg"]["data"][2]["count"];
    this.borrowed = map["msg"]["data"][3]["count"];
    this.notUsable = map["msg"]["data"][4]["count"];
    this.removed = map["msg"]["data"][5]["count"];
  }
}
