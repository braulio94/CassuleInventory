


import 'package:inventory_app/model/product_count.dart';

int _currentDay;

calculateDiff(ProductCount productCount) {
  int _prevDayValue = productCount.prevDay + productCount.prevDayAdded;
  if(_prevDayValue == 0){
    _currentDay = 0;
  } else {
    _currentDay = _prevDayValue - productCount.remaining;
  }
  productCount.diff = _currentDay;
}

calculateMissing(ProductCount productCount){
  if(productCount.diff != 0){
    int missing =  productCount.sold - productCount.diff;
    productCount.missing = missing;
  }
}
