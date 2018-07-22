

class ProductCount {

  String day;
  String productName;
  int prevDay;
  int diff;
  int added;
  int sold;
  int missing;
  bool today;
  bool editDiff;

  ProductCount(
      this.productName,
      this.day,
      this.prevDay,
      this.diff,
      this.sold,
      this.missing,
      this.added,
      this.editDiff,
      this.today
      );

}