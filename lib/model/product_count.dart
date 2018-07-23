

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


  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['productName'] = productName;
    map['prevDay'] = prevDay;
    map['diff'] = diff;
    map['added'] = added;
    map['sold'] = sold;
    map['missing'] = missing;
    map['today'] = today;
    map['editDiff'] = editDiff;
    return map;
  }
}