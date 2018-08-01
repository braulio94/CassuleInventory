

import 'package:inventory_app/model/edit_product.dart';
import 'package:inventory_app/model/inventory_date.dart';

class ProductCount {

  int id;
  int dateId;
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
  ProductEdit edit;
  InventoryDate date;

  ProductCount(
      this.productName,
      this.prevDay,
      this.prevDayAdded,
      this.diff,
      this.sold,
      this.missing,
      this.added,
      this.remaining,
      this.editDiff,
      this.today,
      {this.id, this.dateId, this.edit}
      );

  ProductCount.fromDb(Map map)
      : id = map['id'],
        productName = map['productName'],
        dateId = map['dateId'],
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
    map['dateId'] = dateId;
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