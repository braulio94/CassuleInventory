import 'package:flutter/material.dart';
import 'package:inventory_app/data.dart';
import 'package:inventory_app/model/product_count.dart';

class ProductCountWidget extends StatefulWidget {

  final ProductCount productCount;

  ProductCountWidget({this.productCount});

  @override
  _ProductCountWidgetState createState() => _ProductCountWidgetState();
}

class _ProductCountWidgetState extends State<ProductCountWidget> {

  String _diff = '';
  int _currentDay;
  Color missingColor = Colors.black;

  _calculateDiff(String value) {
    widget.productCount.remaining = int.parse(value);
    int _prevDayValue = widget.productCount.prevDay + widget.productCount.prevDayAdded;
    if(_prevDayValue == 0){
      _currentDay = 0;
    } else {
      _currentDay = _prevDayValue - int.parse(value);
    }
    setState(() {
      _diff = '$_currentDay';
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
      if(widget.productCount.diff < int.parse(value)){
        missingColor = Colors.black;
      } else if(widget.productCount.diff > int.parse(value)) {
        missingColor = Colors.red;
      }
    }
  }

  _addDiff(String value){
    setState(() {
      widget.productCount.diff = int.parse(value);
      if(widget.productCount.today){
        _diff = widget.productCount.diff.toString();
      }
      widget.productCount.editDiff = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double rowCountWidth = 80.0;
    Widget _productValueHolder(ValueChanged<String> onSubmitted, String text, bool enabled, {TextStyle style}){
      return GestureDetector(
        onDoubleTap: (){
          setState(() {
            widget.productCount.editDiff = !widget.productCount.editDiff;
          });
        },
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
              _addDiff,
              widget.productCount.today ? _diff : '${widget.productCount.diff}',
              widget.productCount.editDiff,
          ),
          _productValueHolder(
              (value){
                setState(() {
                  widget.productCount.editDiff = false;
                });
              },
              '${widget.productCount.missing}',
              widget.productCount.editDiff,
              style: TextStyle(color: missingColor),
          ),
          _productValueHolder(
              (value){
                setState(() {
                  widget.productCount.editDiff = false;
                  widget.productCount.added = int.parse(value);
                });
              },
              '${widget.productCount.added}',
            widget.productCount.today,
          ),
          _productValueHolder(
              _calculateMissing,
              '${widget.productCount.sold}',
            widget.productCount.today,
          ),
          _productValueHolder(
              _calculateDiff,
              '${widget.productCount.remaining}',
            widget.productCount.today,
          ),
        ],
      ),
    );
  }
}
