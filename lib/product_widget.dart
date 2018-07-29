import 'package:flutter/material.dart';
import 'package:inventory_app/model/edit_product.dart';
import 'package:inventory_app/model/product_count.dart';
import 'package:inventory_app/database/database.dart';
import 'product_row_value.dart';

class ProductCountWidget extends StatefulWidget {

  final ProductCount productCount;
  final ProductDatabase database;

  ProductCountWidget({this.productCount, this.database});

  @override
  _ProductCountWidgetState createState() => _ProductCountWidgetState();
}

class _ProductCountWidgetState extends State<ProductCountWidget> {

  int _currentDay;

  _calculateDiff(String value) {
    widget.productCount.remaining = int.parse(value);
    int _prevDayValue = widget.productCount.prevDay + widget.productCount.prevDayAdded;
    if(_prevDayValue == 0){
      _currentDay = 0;
    } else {
      _currentDay = _prevDayValue - int.parse(value);
    }
    setState(() {
      widget.productCount.diff = _currentDay;
    });
  }

  _calculateMissing(String value){
    widget.productCount.sold = int.parse(value);
    if(widget.productCount.diff != 0){
      int missing =  int.parse(value) - widget.productCount.diff;
      setState(() {
        widget.productCount.missing = missing;
        widget.productCount.editDiff = false;
      });
    }
  }

  int lastId;

  _alterDiffState(){
    setState(() {
      if(lastId != null){
        widget.productCount.id;
      }

      widget.productCount.editDiff = !widget.productCount.editDiff;
    });
  }

  _addDiff(String value){
    setState(() {
      widget.productCount.diff = int.parse(value);
      widget.productCount.editDiff = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 8.0),
      elevation: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ProductRowValue(
            value: '${widget.productCount.diff}',
            holderName: ProductEdit.Diff,
            product: widget.productCount,
          ),
          ProductRowValue(
            value: '${widget.productCount.missing}',
            holderName: ProductEdit.Missing,
            product: widget.productCount,
            style: TextStyle(color: widget.productCount.missing.isNegative ? Colors.red : Colors.black),
          ),
          ProductRowValue(
            value: '${widget.productCount.added}',
            holderName: ProductEdit.Added,
            product: widget.productCount,
          ),
          ProductRowValue(
            value: '${widget.productCount.sold}',
            holderName: ProductEdit.Sold,
            product: widget.productCount,
          ),
          ProductRowValue(
            value: '${widget.productCount.remaining}',
            holderName: ProductEdit.Remaining,
            product: widget.productCount,
          ),
        ],
      ),
    );
  }
}
