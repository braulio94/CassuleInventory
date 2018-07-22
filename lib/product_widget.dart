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
  Color missingColor = Colors.black87;

  _calculateDiff(String value) {
    widget.productCount.prevDay = int.parse(value);
    int _prevDayValue = productCountList.elementAt(productCountList.length - 2).prevDay + productCountList.elementAt(productCountList.length - 2).added;
    _currentDay = _prevDayValue - int.parse(value);
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
        missingColor = Colors.black54;
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

    return Column(
      children: [
        Container(
          height: 50.0,
          width: 400.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.productCount.today ? Colors.red[900].withOpacity(0.1) : null,
            border: Border.all(width: 2.0, color: Colors.black12),
          ),
          child: Text(widget.productCount.day),
        ),
        Row(
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
                true
            ),
            _productValueHolder(
                _calculateMissing,
                '${widget.productCount.sold}',
                true
            ),
            _productValueHolder(
                _calculateDiff,
                '${widget.productCount.prevDay}',
                true
            ),
          ],
        ),
      ],
    );
  }
}
