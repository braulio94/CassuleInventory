import 'package:flutter/material.dart';
import 'package:inventory_app/data.dart';
import 'package:inventory_app/model/product_count.dart';
import 'package:inventory_app/database/database.dart';

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

  _alterDiffState(){
    setState(() {
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
    final double rowCountWidth = 80.0;
    Widget _productValueHolder(String text, {ValueChanged<String> onSubmitted, bool enabled, TextStyle style}){
      return GestureDetector(
        onDoubleTap: _alterDiffState,
        child: Container(
          height: 50.0,
          width: rowCountWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.black12),
          ),
          child: TextField(
            controller: TextEditingController(text: text),
            enabled: enabled,
            textAlign: TextAlign.center,
            style: style,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onSubmitted: onSubmitted,
          ),
        ),
      );
    }

    return Card(
      margin: EdgeInsets.only(left: 8.0),
      elevation: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _productValueHolder(
            '${widget.productCount.diff}',
            onSubmitted: (value){
              _addDiff(value);
              widget.database.upsertProduct(widget.productCount, widget.productCount.productName);
            },
            enabled: widget.productCount.editDiff,
          ),
          _productValueHolder(
            '${widget.productCount.missing}',
            style: TextStyle(color: widget.productCount.missing.isNegative ? Colors.red : Colors.black),
          ),
          _productValueHolder(
            '${widget.productCount.added}',
            onSubmitted: (value) {
              setState(() {
                widget.productCount.added = int.parse(value);
              });
              widget.database.upsertProduct(widget.productCount, widget.productCount.productName);
            },
            enabled: widget.productCount.today,
          ),
          _productValueHolder(
            '${widget.productCount.sold}',
            onSubmitted: (value){
              _calculateMissing(value);
              widget.database.upsertProduct(widget.productCount, widget.productCount.productName);
            },
            enabled: widget.productCount.today,
          ),
          _productValueHolder(
            '${widget.productCount.remaining}',
            onSubmitted: (value){
              _calculateDiff(value);
              widget.database.upsertProduct(widget.productCount, widget.productCount.productName);
            },
            enabled: widget.productCount.today,
          ),
        ],
      ),
    );
  }
}
