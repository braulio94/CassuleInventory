

class ProductCount {

  int id;
  String day;
  String productName;
  int prevDay;
  int prevDayAdded;
  int diff;
  int added;
  int sold;
  int missing;
  int remaining;
  bool today;
  bool editDiff;

  ProductCount(
      this.productName,
      this.day,
      this.prevDay,
      this.prevDayAdded,
      this.diff,
      this.sold,
      this.missing,
      this.added,
      this.remaining,
      this.editDiff,
      this.today,
      {this.id}
      );

  ProductCount.fromDb(Map map)
      : id = map['id'],
        productName = map['productName'],
        day = map['day'],
        prevDay = map['prevDay'],
        prevDayAdded = map['prevDayAdded'],
        diff = map['diff'],
        sold = map['sold'],
        missing = map['missing'],
        added = map['added'],
        remaining = map['remaining'],
        editDiff = map['editDiff'] == 1 ? true : false,
        today = map['today'] == 1 ? true : false;


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map["id"] = id;
    }
    map['productName'] = productName;
    map['day'] = day;
    map['prevDay'] = prevDay;
    map['prevDayAdded'] = prevDayAdded;
    map['diff'] = diff;
    map['sold'] = sold;
    map['missing'] = missing;
    map['added'] = added;
    map['remaining'] = remaining;
    map['editDiff'] = editDiff ? 1 : 0;
    map['today'] = today ? 1 : 0;
    return map;
  }
}